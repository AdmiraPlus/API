from fastapi import FastAPI, Depends, HTTPException, status, Request
from typing import Annotated
from pydantic import BaseModel
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm, HTTPBasic, HTTPBasicCredentials
from jose import jwt, JWTError
from passlib.context import CryptContext
from datetime import datetime, timedelta

from dotenv import load_dotenv

import base64, os

from conexion_db_c import Conexion

#-- Cargar las variables de entorno.
load_dotenv()

ALGORITHM = "HS256"
ACCESS_TOKEN_DURATION = 1
SECRET_KEY = os.environ.get('SECRET_KEY')

app = FastAPI()

oauth2 = OAuth2PasswordBearer(tokenUrl="/oauth2/token")
security = HTTPBasic()  # Esquema Auth Basic (client_id|client_secret)

crypt = CryptContext(schemes=["bcrypt"])


#-- Modelos ---------------

class User(BaseModel):
	username: str
	full_name: str
	email: str
	disabled: bool
	password: str
	client_id: str
	client_secret: str

class Movimiento(BaseModel):
	CuitMutual: int
	NumeroCuenta: int
	CodigoMovimiento: str
	TipoMovimiento: str
	NumeroMovimiento: int
	FechaMovimiento: datetime
	Importe: float


# -- Funciones ----------------------------------------------

def search_user(username: str):
	user_db = None
	#conexion = None
	try:
		with Conexion.get_connection() as conexion:
			with conexion.cursor() as cursor:
				sentenciaSQL = """
					SELECT u.username, u.full_name, u.email,  u.disabled, u.password, c.client_id, c.client_secret
						FROM UserAPI u
						JOIN ClientCredentials c
							ON u.credentials_id = c.id
						WHERE username = ?
				"""
				cursor.execute(sentenciaSQL, username)
				user = cursor.fetchone()
				
				if user:
					user_db = User(
						username=user[0],
						full_name=user[1],
						email=user[2],
						disabled=user[3],
						password=user[4],
						client_id=user[5],
						client_secret=user[6]
					)
	except Exception as e:
		raise HTTPException(
			status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
			detail="No se pudo establecer la conexión con el servidor!"
		)
					
	return user_db

async def auth_user(token: str = Depends(oauth2)):
	exception = HTTPException(
		status_code=status.HTTP_401_UNAUTHORIZED,
		detail="Credenciales de autenticación inválidas",
		headers={"WWW-Authenticate": "Bearer"}
	)
	
	try:
		username = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM]).get('sub')
		if username is None:
			raise exception
	
	except JWTError:
		raise exception
	
	return search_user(username)

async def current_user(user: User = Depends(auth_user)):
	if user.disabled:
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="Usuario inactivo"
		)
	
	return user


# -- EndPoints ---------------------------------------------

@app.post("/oauth2/token", status_code=200)
async def login(request: Request, form: OAuth2PasswordRequestForm = Depends(), credentials: HTTPBasicCredentials = Depends(security)):
	
	#-- Obtener los header de la solicitud(Request).
	headers = request.headers
	
	#-- Obtener el header específico (Authorization).
	authorization_header = headers.get("Authorization")
	
	#-- Extraer solo el dato codificado base64.
	authorization_credentials = authorization_header.replace("Basic ", "")
	
	#-- Decodificar la cadena.
	decoded_credentials = base64.b64decode(authorization_credentials).decode("utf-8")
	
	#-- Pasar a variables los datos separados por los dos puntos (:).
	client_id, client_secret = decoded_credentials.split(":")
	
	#####################################################################
	user = search_user(form.username)
	
	#-- Validad si existe el usuario.
	if not user:
		raise HTTPException(
			#status_code=status.HTTP_400_BAD_REQUEST,
			status_code=status.HTTP_401_UNAUTHORIZED,
			detail="El usuario no es correcto"
		)
	
	#-- Validar el password.
	if not crypt.verify(form.password, user.password):
		raise HTTPException(
			status_code=status.HTTP_401_UNAUTHORIZED,
			detail="El password no es correcto"
		)
	
	#-- Validar el client_id.
	if client_id != user.client_id:
		raise HTTPException(
			status_code=status.HTTP_401_UNAUTHORIZED,
			detail="El client_id no es correcto",
			headers={"WWW-Authenticate": "Basic"}
		)
	
	#-- Validar el client_crecret.
	if client_secret != user.client_secret:
		raise HTTPException(
			status_code=status.HTTP_401_UNAUTHORIZED,
			detail="El client_secret no es correcto",
			headers={"WWW-Authenticate": "Basic"}
		)
	
	#-- Generar el token.
	
	expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_DURATION)
	
	difference = expire - datetime.utcnow()
	expire_in_seconds = difference.total_seconds()
	
	access_token = {
		"sub": user.username,
		"exp": expire
	}
	
	return {
		"access_token": jwt.encode(access_token, SECRET_KEY, algorithm=ALGORITHM),
		"token_type": "bearer",
		"expires_in": expire_in_seconds
	}

@app.post("/Movimientos/GuardarMovimiento", status_code=201)
async def GuardarMovimiento(mov: Movimiento, token: str = Depends(current_user)):
	status = False
	mensaje = ""
	
	#- Hacer validaciones básicas. --------------------------------
	if not mov:
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="No se ha recibido ningún movimiento para guardar"
		)
	
	if not mov.NumeroCuenta:
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="No hay número de cuenta"
		)
	
	#- Si validación=OK, invocar SP con sus parámetros. ------------
	with Conexion.get_connection() as conexion:
		
		conexion.autocommit = False
		with conexion.cursor() as cursor:
			
			comandoSQL ="exec GuardarMovimiento @cuit=?, @Cuenta=?, @CodMov=?, @TipoMov=?, @Numero=?, @Fecha=?, @Importe=?"
			param = (mov.CuitMutual, mov.NumeroCuenta, mov.CodigoMovimiento, mov.TipoMovimiento, mov.NumeroMovimiento, 
					 mov.FechaMovimiento, mov.Importe )
			
			try:
				cursor.execute(comandoSQL, param)
				
				conexion.commit()
				
				status = True
				mensaje = "OK"
				
			except Exception as e:
				status = False
				mensaje = "Hubo una Excepción! No se pudo registrar el movimiento: " + str(e)
				conexion.rollback()
				
	resp = {
		"status": status,
		"mensaje": mensaje
	}
	
	return resp


