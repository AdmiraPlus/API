from fastapi import FastAPI, Depends, HTTPException, status, Request
from pydantic import BaseModel
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import jwt, JWTError
from passlib.context import CryptContext
from datetime import datetime, timedelta

from conexion_db_c import Conexion


ALGORITHM = "HS256"
ACCESS_TOKEN_DURATION = 1
SECRET_KEY = "136f597569ee7e47cd6951276718ac3eca203241e123a944ca2d3de45e6f65ec"   # openssl rand -hex 32

app = FastAPI()
app.title = 'Mi FastAPI'

oauth2 = OAuth2PasswordBearer(tokenUrl="login")

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

def buscar_usuario_bd(username: str):
	user_db = None
	#conexion = None
	try:
		with Conexion.get_connection_trusted() as conexion:
			with conexion.cursor() as cursor:
				sentenciaSQL = """
					SELECT u.username, u.full_name, u.email,  u.disabled, u.password, c.client_id, c.client_secret
						FROM UserAPI u
						JOIN ClientCredentials c
							ON u.credentials_id = c.id
						WHERE username = ?
				"""
				cursor.execute(sentenciaSQL, username)
				user_db = cursor.fetchone()
				
	except Exception as	e:
		print("Ocurrió un error al consultar:\n" + str(e) )
	
	return user_db

def search_user_db(username: str):
	user_db = buscar_usuario_bd(username)
	if user_db:
		return User(
			username=user_db[0],
			full_name=user_db[1],
			email=user_db[2],
			disabled=user_db[3],
			password=user_db[4],
			client_id=user_db[5],
			client_secret=user_db[6]
		)

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
	
	return search_user_db(username)

async def current_user(user: User = Depends(auth_user)):
	if user.disabled:
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="Usuario inactivo"
		)
	
	return user


# -- EndPoints ---------------------------------------------

@app.post("/login")
async def login(form: OAuth2PasswordRequestForm = Depends()):
	#-- Validar si existe el "username".
	user = buscar_usuario_bd(form.username)
	
	if not user:
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="El usuario no es correcto"
		)
	
	#-- Validar el password.
	if not crypt.verify(form.password, user.password):
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="El password no es correcto"
		)
	
	#-- Generar el token.
	
	# expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_DURATION)
	
	access_token = {
		"sub": user.username,
		"exp": datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_DURATION)
	}
	
	return {
		"access_token": jwt.encode(access_token, SECRET_KEY, algorithm=ALGORITHM),
		"token_type": "bearer"
	}

#================================================================================================================================
@app.post("/Movimientos/GuardarMovimiento")
async def GuardarMovimiento(mov: Movimiento, token: str = Depends(current_user)):
	status = False
	mensaje = ""
	conexion = None
	
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
	
	try:
		#conexion = conexion_db.get_conexion()
		with Conexion.get_connection_trusted() as conexion:
			
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
					mensaje = "Hubo una Excepción! No se pudo registrar el movimiento\n" + str(e)
					conexion.rollback()
					
	except Exception as	e:
		status = False
		mensaje = "Ocurrió un error al establecer la conexión a la BBDD.\n" + str(e)
	finally:
		if conexion:
			conexion.close()
	
	resp = {
		"status": status,
		"mensaje": mensaje
	}
	
	return resp

