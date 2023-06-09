from pydantic import BaseModel

class Codmovimiento(BaseModel):
    Codigo: str
    Descripcion: str
    TipoMovimiento: str
    Producto: str