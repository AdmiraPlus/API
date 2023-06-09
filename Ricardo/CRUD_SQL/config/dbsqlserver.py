import pyodbc

# Parámetros de la conexión al servidor
server_name = "localhost"
db_name = "BICAMutual"
username = "sa"
password = "boby"

try:
    # connection = pyodbc.connect("DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;
    # DATABASE=GestionAdmin;UID=sa;PWD=boby")
    
    conn = pyodbc.connect(
                      'Driver={ODBC Driver 17 for SQL Server};'
                      f'Server={server_name};'
                      f'Database={db_name};'
                      f'UID={username};'
                      f'PWD={password};'
                      'Mars_Connection=Yes;'
                    )
    
    print("Conexión exitosa")
    
    # Creación del objeto cursor
    cursor = conn.cursor()
    
    # Consulta de la version
    cursor.execute("SELECT @@version")
    row = cursor.fetchone()
    print("versión de SQL Server:", row)

    # cursor() es un objeto que se utiliza para realizar 
    # la conexión y ejecutar consultas SQL. 
    # Actúa como un middleware entre la conexión 
    # de la base de datos y la consulta SQL
    cursor.execute("SELECT TOP(5) * FROM CodMovimientos")
    rows =cursor.fetchall()
    print("Tipo de Objeto rows: ", type(rows))
    print("Tamaño del Objeto rows: ", len(rows))

    for registro in rows:
        print(registro)
        
    conn.close()
    print("Conexión Cerrada")
    
except Exception as ex:
    print("Error de conexión:")
    print(ex)







    

                                
                
                                
                                

