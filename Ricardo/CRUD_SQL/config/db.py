from sqlalchemy import URL, create_engine, MetaData

# Parámetros de la conexión al servidor
server_name = "localhost"
db_name = "BICAMutual"
username = "sa"
password = "boby"

# Cadena de conexión
connection_string = ('Driver={ODBC Driver 17 for SQL Server};'
                    f'Server={server_name};'
                    f'Database={db_name};'
                    f'UID={username};'
                    f'PWD={password};'
                    )

# Especificar la ubicación y los detalles de conexión a una base de datos SQLAlchemy
connection_url = URL.create("mssql+pyodbc", query={"odbc_connect": connection_string})

engine = create_engine(connection_url)

meta = MetaData()

conn = engine.connect()

