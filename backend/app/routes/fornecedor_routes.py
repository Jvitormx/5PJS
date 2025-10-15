from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.fornecedor_schema import CreateFornecedor, UpdateFornecedor, FornecedorGet, Fornecedor_Atribuir_Nota
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import fornecedor_service

router = APIRouter(prefix='/fornecedores', tags=['Fornecedores'])

@router.post('/criar', status_code=status.HTTP_201_CREATED, response_model=CreateFornecedor)
def criar_novo_fornecedor(fornecedor: CreateFornecedor, db: Session = Depends(get_db)):
    novo_usuario = fornecedor_service.create_fornecedor(fornecedor = fornecedor, db = db)
    return novo_usuario

@router.put('/update/{id}', response_model=UpdateFornecedor)
def update_fornecedor(fornecedor: UpdateFornecedor, id: int, db: Session = Depends(get_db)):
    usuario_atualizado = fornecedor_service.update_fornecedor(fornecedor = fornecedor, id = id, db = db)
    if not usuario_atualizado:
        return None
    return usuario_atualizado

@router.put('/atribuir_nota/{id}', response_model=FornecedorGet)
def atribuir_nota(fornecedor: Fornecedor_Atribuir_Nota, id: int, db: Session = Depends(get_db)):
    usuario_atualizado = fornecedor_service.atrubuir_nota_fornecedor(fornecedor = fornecedor, id = id, db = db)
    if not usuario_atualizado:
        return None
    return usuario_atualizado

@router.get('/', response_model=List[FornecedorGet])
def listar_usuarios(db: Session = Depends(get_db)):
    lista_usuarios = fornecedor_service.retornar_fornecedores(db = db)
    return lista_usuarios
             