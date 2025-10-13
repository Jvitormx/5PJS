from typing import Optional
from pydantic import BaseModel, Field, EmailStr
from enum import StrEnum

class Tipo(StrEnum):
    ADMIN = "administrador"
    COMPRADOR = "comprador"
    GERENTE = "gerente"
    FORNECEDOR = "fornecedor"

class UsuarioBase(BaseModel):
    email : EmailStr = Field(..., min_length=5, max_length=255, description='email de usuario empresa/fornecedor')
    senha_hash: str = Field(..., description = 'hash de senha de usuario')
    tipo: Tipo = Field(default = Tipo.ADMIN, description = 'separa usuarios em diferentes telas no sistema')

    class Config:
        orm_mode = True
        
class Usuario(BaseModel):
    pk_usuario_id: int = Field(..., description = 'identificador unico de usuario')
    email : EmailStr = Field(..., min_length=5, max_length=255, description='email de usuario empresa/fornecedor')
    tipo: Tipo = Field(default = Tipo.ADMIN, description = 'separa usuarios em diferentes telas no sistema')

    class Config:
        orm_mode = True
    
class UsuarioCreate(Usuario):
    pass

class UsuarioLogin(BaseModel):
    email : EmailStr = Field(..., min_length=5, max_length=255, description='email de usuario empresa/fornecedor')
    senha: str = Field(..., description = 'hash de senha de usuario')

    class Config:
        orm_mode = True

class UsuarioUpdate(BaseModel):
    pk_usuario_id: int = Field(..., description = 'identificador unico de usuario')
    email : Optional[EmailStr] = Field(None, min_length=5, max_length=255, description='email de usuario empresa/fornecedor')
    tipo: Optional[Tipo] = Field(None, description = 'separa usuarios em diferentes telas no sistema')
