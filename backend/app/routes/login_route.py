from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.usuario_schema import UsuarioCreate, UsuarioLogin, UsuarioGet
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import usuario_service

router = APIRouter(prefix='/login', tags=['Login'])

@router.post('/', status_code=status.HTTP_200_OK, response_model=UsuarioGet)
def login_usuario(usuario: UsuarioLogin, db: Session = Depends(get_db)):
    usuario_login = usuario_service.login_usuario(usuario = usuario, db = db)
    if not usuario_login:
        return None
    return usuario_login