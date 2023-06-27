import pyodbc

class Conexion:
	
	__SERVER = "LEONCIOPC"
	__DATA_BASE = "BICAMutual"
	__USER = ""
	__PASS = ""
	
	@classmethod
	def get_connection_user(self):
		return pyodbc.connect(
			'Driver={ODBC Driver 17 for SQL Server};'
			f'Server={self.__SERVER};'
			f'Database={self.__DATA_BASE};'
			f'UID={self.__USER};'
			f'PWD={self.__PASS};'
		)
	
	@classmethod
	def get_connection_trusted(self):
		return pyodbc.connect(
			'Driver={ODBC Driver 17 for SQL Server};'
			f'Server={self.__SERVER};'
			f'Database={self.__DATA_BASE};'
			'Trusted_Connection=yes;'
		)