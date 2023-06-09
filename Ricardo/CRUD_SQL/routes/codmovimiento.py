from fastapi import APIRouter
from config.db import conn
from models.codigomovimientos import codigomovimientos
from schemas.codmovimiento import Codmovimiento

codmovimiento = APIRouter()

@codmovimiento.get("/codmovimientos")
def get_codigomovimientos():
    print(conn.execute(codigomovimientos.select()).fetchall())
    return conn.execute(codigomovimientos.select()).fetchall()
    ## return "Hola Programadores!"
    
@codmovimiento.post("/codmovimientos")
def create_codigomovimientos(codmovimiento: Codmovimiento):
    new_codigomovimiento = {"Codigo":codmovimiento.Codigo, "Descripcion":codmovimiento.Descripcion, "TipoMovimiento":codmovimiento.TipoMovimiento, "Producto":codmovimiento.Producto}
    print(new_codigomovimiento)
    return "Hola Programadores!!!"
    
    


