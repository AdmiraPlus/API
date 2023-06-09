from sqlalchemy import Table, Column
from sqlalchemy.sql.sqltypes import Integer, String
from config.db import meta, engine

codigomovimientos = Table("CodMovimientos", meta, 
                          Column('Codigo', String(40), nullable=False, primary_key=True), 
                          Column('Descripcion', String(50), nullable=False), 
                          Column('TipoMovimiento', String(1), nullable=False), 
                          Column('Producto', String(2), nullable=False))

meta.create_all(engine)
