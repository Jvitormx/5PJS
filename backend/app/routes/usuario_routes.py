from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.usuario_schema import UsuarioCreate, UsuarioLogin, Usuario
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import usuario_service

router = APIRouter(prefix='/usuarios', tags=['Usuarios'])

@router.post('/', status_code=status.HTTP_201_CREATED, response_model=UsuarioCreate)
def criar_novo_usuario(usuario: UsuarioCreate, db: Session = Depends(get_db)):
    novo_usuario = usuario_service.create_usuario(usuario = usuario, db = db)
    return novo_usuario
             