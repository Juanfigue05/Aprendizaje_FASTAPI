
from typing import Optional
from pydantic import BaseModel, EmailStr, Field

class ProgramaBase(BaseModel):
    version: str = Field(min_length=1, max_length=5)
    nombre: str = Field(min_length=3, max_length=255)
    nivel: str = Field(min_length=3, max_length=70)
    id_red: int
    tiempo_duracion: int
    unidad_medida: str = Field(min_length=1, max_length=50)
    estado: bool = True
    url_pdf: str = Field(min_length=1, max_length=180,default="")

class RetornoPrograma(ProgramaBase):
    cod_programa: int
