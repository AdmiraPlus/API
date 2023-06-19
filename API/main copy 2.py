from fastapi import FastAPI, Depends, HTTPException, status
from pydantic import BaseModel
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import jwt, JWTError
from passlib.context import CryptContext
from datetime import datetime, timedelta

#from conexion_db import conexion
import conexion_db


#-- Zona de pruebas -------------
'''
username = "leoncios"
try:
	print("Va a obtener la conexión")
	conexion = conexion_db.get_conexion()
	print("Va a comprobar la conexión")
	if conexion:
		#print("entró a hacer la consulta")
		with conexion.cursor() as cursor:
			inst_sql = "SELECT username, password, client_id, client_secret FROM UserAPI WHERE username = ?"
			cursor.execute(inst_sql, username)
			
			user_db = cursor.fetchone()
			
			print(user_db)
	else:
		print("No hay conexión")
except Exception as	e:
	print("Ocurrió un error al consultar: ")
finally:
	if conexion:
		conexion.close()

'''
#------------------------------------


ALGORITHM = "HS256"
ACCESS_TOKEN_DURATION = 1
# openssl rand -hex 32
SECRET_KEY = "136f597569ee7e47cd6951276718ac3eca203241e123a944ca2d3de45e6f65ec"

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

class UserDB(User):
	password: str

	
class UserAPI(BaseModel):
	username: str
	full_name: str
	email: str
	disabled: bool

class UserAPIDB(UserAPI):
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
	
#-- Datos -----------------

x_users_db = {
	"leoncio": {
		"username": "leoncio",
		"full_name": "Leoncio Barrios",
		"email": "leonciobarriosh@gmail.com",
		"disabled": False,
		"password": "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92"  # 123456
	},
	"fulano": {
		"username": "fulano",
		"full_name": "Fulano de Tal",
		"email": "fulanodetalh@gmail.com",
		"disabled": True,
		"password": "$2a$12$oYSwjKsEJakhlOY95rirJOcoY/1W5VJ/ym8EdJPO09r8ju5xn/e9y"  # 654321
	}
}


# -- Funciones ----------------------------------------------

def buscar_usuario_bd(username: str):
	user_db = None
	try:
		conexion = conexion_db.get_conexion()
		if conexion:
			#print("entró a hacer la consulta")
			with conexion.cursor() as cursor:
				cursor.execute("SELECT * FROM UserAPI WHERE username = ?", username)
				
				user_db = cursor.fetchone()
				
				#print(user_db)
		#else:
		#	print("No hay conexión")
	except Exception as	e:
		print("Ocurrió un error al consultar: ")
	finally:
		if conexion:
			conexion.close()
	return user_db
#----------------------------------------------------------------
'''
def search_user_db(username: str):
	if username in users_db:
		return UserDB(**users_db[username])
'''
def search_user_db(username: str):
	user_db = buscar_usuario_bd(username)
	if user_db:
		#print(f"El usuario encontrado es: {user_db}")
		
		return UserAPIDB(
			username=user_db[1],
			full_name=user_db[2],
			email=user_db[3],
			disabled=user_db[4],
			password=user_db[5],
			client_id=user_db[6],
			client_secret=user_db[7]
		)
 		#return UserDB(**users_db[username])
#----------------------------------------------------------------
'''
def search_user(username: str):
	if username in users_db:
		return User(**users_db[username])
'''
def search_user(username: str):
	user = buscar_usuario_bd(username)
	if user:
		return UserAPI(
			username=user[1],
			full_name=user[2],
			email=user[3],
			disabled=user[4]
		)

#----------------------------------------------------------------
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

async def current_user(user: UserAPI = Depends(auth_user)):   # async def current_user(user: User = Depends(auth_user)):
	if user.disabled:
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="Usuario inactivo"
		)
	
	return user


# -- EndPoints ---------------------------------------------

@app.post("/login")
async def login(form: OAuth2PasswordRequestForm = Depends()):
	# -- Validar si existe el "username".
	user_db = buscar_usuario_bd(form.username)   # user_db = users_db.get(form.username)
	if not user_db:
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="El usuario no es correcto"
		)
	user = search_user_db(form.username)
	
	# -- Validar el password.
	if not crypt.verify(form.password, user.password):
		raise HTTPException(
			status_code=status.HTTP_400_BAD_REQUEST,
			detail="El password no es correcto"
		)
	
	# expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_DURATION)
	
	access_token = {
		"sub": user.username,
		"exp": datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_DURATION)
	}
	
	return {
		"access_token": jwt.encode(access_token, SECRET_KEY, algorithm=ALGORITHM),
		"token_type": "bearer"
	}


@app.get("/users/me")
async def me(user: UserAPI = Depends(current_user)):   # async def me(user: User = Depends(current_user)):
	return user


#================================================================================================================================
@app.post("/Movimientos/GuardarMovimiento")
async def GuardarMovimiento(mov: Movimiento):
	return mov.NumeroCuenta

