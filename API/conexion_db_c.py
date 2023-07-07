import pyodbc, os
from dotenv import load_dotenv

#-- Cargar las variables de entorno.
load_dotenv()

class Conexion:
	
	__SERVER = os.environ.get('SERVER')
	__DATA_BASE = os.environ.get('DATA_BASE')
	__USER = os.environ.get('USER_DB')
	__PASS = os.environ.get('PASS_UDB')
	
	@classmethod
	def get_connection(self):
		return pyodbc.connect(
			'Driver={ODBC Driver 17 for SQL Server};'
			f'Server={self.__SERVER};'
			f'Database={self.__DATA_BASE};'
			f'UID={self.__USER};'
			f'PWD={self.__PASS};'
		)
