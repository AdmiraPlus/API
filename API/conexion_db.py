import pyodbc

def get_conexion():
	server_name = "LEONCIOPC"
	db_name = "BICAMutual"
	#username = "sa"
	#password = "AdmiraPlus2015"

	conexion = None
	try:
		""" conexion = pyodbc.connect(
			'Driver={ODBC Driver 17 for SQL Server};'
			f'Server={server_name};'
			f'Database={db_name};'
			f'UID={username};'
			f'PWD={password};'
		)"""
		
		conexion = pyodbc.connect(
			'Driver={ODBC Driver 17 for SQL Server};'
			f'Server={server_name};'
			f'Database={db_name};'
			'Trusted_Connection=yes;'
		)
		
	except Exception as e:
		# Atrapar error
		print("Ocurrió un error al conectar a SQL Server: ")
	
	return conexion
