from app.schemas.usuario_schema import Usuario, UsuarioCreate, UsuarioLogin, UsuarioUpdate
from app.models import Usuario
from app.core.hashing import Hash
from sqlalchemy.orm import Session
from app.database.connection import get_db
from fastapi import HTTPException, Depends

def create_usuario(usuario: UsuarioCreate, db: Session) -> Usuario:
    senha_pos_hash = Hash.hash_senha(usuario.senha_hash)

    novo_usuario = Usuario(
        email = usuario.email,
        senha_hash = senha_pos_hash,
        tipo = usuario.tipo
    )

    db.add(novo_usuario)
    db.commit()
    db.refresh(novo_usuario)

    return novo_usuario

def login_usuario(usuario: UsuarioLogin, db: Session) -> Usuario:
    usuario_login = db.query(Usuario).filter(Usuario.email == usuario.email).first()
    if not usuario_login:
        return None
    if not Hash.hash_verificar_senha(usuario.senha, usuario_login.senha_hash):
        return None
    return usuario_login

def update_usuario(usuario: UsuarioUpdate, id: int, db: Session = Depends(get_db)):
    usuario_update = db.query(Usuario).filter(Usuario.pk_usuario_id == id)
    usuario_update.update(
        {'email':usuario.email,
         'tipo': usuario.tipo}
    )

  


