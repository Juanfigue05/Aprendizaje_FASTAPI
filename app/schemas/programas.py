
from typing import Optional
from pydantic import BaseModel, EmailStr, Field

class ProgramaBase(BaseModel):
    version: str = Field(min_length=1, max_length=10)
    nombre: str = Field(min_length=3, max_length=255)
    nivel: str = Field(min_length=3, max_length=50)
    id_red: int
    tiempo_duracion: int
    unidad_medida: str = Field(min_length=1, max_length=20)
    estado: bool = True
    url_pdf: str = Field(default="")

class RetornoPrograma(ProgramaBase):
    cod_programa: int
