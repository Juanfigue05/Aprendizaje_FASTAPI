from typing import List
from fastapi import APIRouter, Depends, UploadFile, File, HTTPException
from app.schemas.programas import RetornoPrograma
from app.utils.utils import save_uploaded_document
from sqlalchemy.orm import Session
from app.router.dependencias import get_current_user
from app.schemas.usuarios import RetornoUsuario
from core.database import get_db
from sqlalchemy.exc import SQLAlchemyError
from app.crud.programas import get_program_by_code, upload_url_pdf ,get_all_programs


router = APIRouter(
    prefix="/programas",
    tags=["Programas"]
)

@router.post("/Subir-pdf/")
def upload_document(
    codigo:int,
    file: UploadFile = File(...),
    db: Session = Depends(get_db)):
    """
    Sube un archivo PDF, Word o Excel al servidor y devuelve su ruta de almacenamiento.
    """
    try:
        #filtro para buscar programa
        programa = get_program_by_code(db, codigo)

        if programa is None:
            raise HTTPException(status_code=404, detail="Programa no encontrado.")

        file_path = save_uploaded_document(file)

        save_url = upload_url_pdf(db,codigo, file_path)

        return {
            "message": "Archivo subido correctamente",
            "filename": file.filename,
            "ruta_servidor": file_path
        }
    except HTTPException as e:
        # Retorna los errores personalizados definidos en la función
        raise e
    except Exception as e:
        # Captura cualquier otro error inesperado
        raise HTTPException(status_code=500, detail=f"Error interno aqui: {str(e)}")



@router.get("/obtener-todos-programas}", response_model=List[RetornoPrograma])
def get_all(db: Session = Depends(get_db)):
    try:
        users = get_all_programs(db)
        if users is None:
            raise HTTPException(status_code=404, detail="Usuarios no encontrados")
        return users
    except SQLAlchemyError as e:
        raise HTTPException(status_code=500, detail=str(e))