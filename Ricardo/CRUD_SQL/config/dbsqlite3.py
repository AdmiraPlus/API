import sqlite3

try:
    # Conexión a la base de datos
    # Si la base de datos GestionAdmin no existe, se crea
    miconex = sqlite3.connect("config/database/GestionAdmin.db")
    
    # cursor() es un objeto que se utiliza para realizar 
    # la conexión y ejecutar consultas SQL. 
    # Actúa como un middleware entre la conexión 
    # de la base de datos y la consulta SQL
    cursor = miconex.cursor()
    
    # Creamos una tabla
    cursor.execute("CREATE TABLE cliente (id PRIMARY KEY AUTOINCREMENT, codigo VARCHAR(15), cliente VARCHAR(60), email_01 VARCHAR(80))")
    
    
    
    
    # Cierre de la conexión a la base de datos
    cursor.close()
    
except Exception as exc:
    print("Error de conexión de datos")

