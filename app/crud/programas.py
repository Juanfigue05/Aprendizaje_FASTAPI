from fastapi import HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError
from typing import Optional
import logging


logger = logging.getLogger(__name__)

def get_program_by_code(db: Session, cod:int):
    try:
        query = text(""" SELECT * FROM programas_formacion  
                     WHERE cod_programa = :codigo """)
        
        result=db.execute(query,{'codigo':cod}).mappings().first()
        return result
    
    except SQLAlchemyError as e:
        logger.error(f"Error al buscar programa por id: {e}")
        raise Exception("Error de base de datos al buscar el programa")

def upload_url_pdf(db: Session, cod: int, url:str) -> bool:
    try:
        
        query = text(f""" UPDATE programas_formacion SET url_pdf = :url_pdf
                        WHERE cod_programa = :codigo """)
        db.execute(query, {'url_pdf':url, 'codigo':cod})
        db.commit()
        return True
    except SQLAlchemyError as e:
        db.rollback()
        logger.error(f"Error al actualizar usuario: {e}")
        raise Exception("Error de base de datos al actualizar el usuario")


def get_all_programs(db: Session):
    try:
        query = text("""
            SELECT programas_formacion.cod_programa, programas_formacion.version, 
                     programas_formacion.nombre, programas_formacion.nivel, programas_formacion.id_red,
                     programas_formacion.tiempo_duracion,programas_formacion.unidad_medida,programas_formacion.estado,programas_formacion.url_pdf
            FROM programas_formacion
        """)

        result = db.execute(query).mappings().all()
        return result
    
    except SQLAlchemyError as e:
        logger.error(f"Error al bucar programas por id: {e}")
        raise Exception("Error de base de datos al buscar el usuario")