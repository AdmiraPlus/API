from fastapi import FastAPI

# Importamos la ruta codmovimiento desde routes.codmovimiento
from routes.codmovimiento import codmovimiento

# Creamos la aplicación
app = FastAPI()

# En la aplicación incluimos la ruta codmovimiento
app.include_router(codmovimiento)