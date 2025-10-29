from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.usuario_schema import UsuarioCreate, UsuarioUpdate, UsuarioGet
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import usuario_service

router = APIRouter(prefix='/usuarios', tags=['Usuarios'])

@router.post('/', status_code=status.HTTP_201_CREATED, response_model=UsuarioCreate)
def criar_novo_usuario(usuario: UsuarioCreate, db: Session = Depends(get_db)):
    novo_usuario = usuario_service.create_usuario(usuario = usuario, db = db)
    return novo_usuario

@router.put('/{id}', response_model=UsuarioUpdate)
def update_usuario(usuario: UsuarioUpdate, id: int, db: Session = Depends(get_db)):
    usuario_atualizado = usuario_service.update_usuario(usuario = usuario, id = id, db = db)
    if not usuario_atualizado:
        return None
    return usuario_atualizado

@router.get('/', response_model=List[UsuarioGet])
def listar_usuarios(db: Session = Depends(get_db)):
    lista_usuarios = usuario_service.retornar_usuarios(db = db)
    return lista_usuarios
             