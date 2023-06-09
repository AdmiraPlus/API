import pyodbc


server = 'LEONCIOPC'
data_base = 'BICAMutual'
user = 'sa'
password = 'AdmiraPlus2015'

print("Empezamos")

try:
	conexion = pyodbc.connect(
		'Driver={ODBC Driver 17 for SQL Server};'
		f'Server={server};'
		f'Database={data_base};'
		f'UID={user};'
		f'PWD={password};'
	)
	
	#    conexion = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER=' +
	#                              direccion_servidor+';DATABASE='+nombre_bd+';UID='+nombre_usuario+';PWD=' + password)
	
	# OK! conexión exitosa
	print("Conexión exitosa***!!!")
	
except Exception as e:
	# Atrapar error
	print("Ocurrió un error al conectar a SQL Server: ", e)
