from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.requisicao_schema import CreateRequisicao, RequisicaoUpdate, RequisicaoGetAll, RequisicaoGet, RequisicaoGetGerente
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import requisicao_service

router = APIRouter(prefix='/requisicoes', tags=['Requisicoes'])

@router.post('/{id}', status_code=status.HTTP_201_CREATED, response_model=RequisicaoGet)
def criar_nova_requisicao(requisicao: CreateRequisicao, id: int, db: Session = Depends(get_db)):
    nova_requisicao = requisicao_service.create_requisicao(requisicao = requisicao, id = id, db = db)
    return nova_requisicao

@router.put('/{id}', response_model=RequisicaoUpdate)
def update_requisicao(requisicao: RequisicaoUpdate, id: int, db: Session = Depends(get_db)):
    requisicao_atualizada = requisicao_service.update_requisicao(requisicao = requisicao, id = id, db = db)
    if not requisicao_atualizada:
        return None
    return requisicao_atualizada

@router.get('/', response_model=List[RequisicaoGetAll])
def listar_requisicoes(db: Session = Depends(get_db)):
    listar_requisicoes = requisicao_service.retornar_requisicoes(db = db)
    return listar_requisicoes

@router.get('/itens/{id}', response_model=RequisicaoGet)
def listar_requisicao_items(id = id, db: Session = Depends(get_db)):
    listar_requisicao = requisicao_service.retornar_requisicao_items(id = id, db = db)
    return listar_requisicao

@router.get('/{id}', response_model=RequisicaoGetGerente)
def listar_requisicao_gerente(id = id, db: Session = Depends(get_db)):
    listar_requisicao = requisicao_service.retornar_requisicao_gerente(id = id, db = db)
    return listar_requisicao
             