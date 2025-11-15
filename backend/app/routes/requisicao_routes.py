from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.requisicao_schema import CreateRequisicao, RequisicaoUpdate, RequisicaoGetAll, RequisicaoGet, RequisicaoGetGerente
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import requisicao_service

router = APIRouter(prefix='/requisicoes', tags=['Requisicoes'])

@router.post('/', status_code=status.HTTP_201_CREATED)
def criar_nova_requisicao(requisicao: CreateRequisicao, db: Session = Depends(get_db)):
    nova_requisicao = requisicao_service.create_requisicao(requisicao = requisicao, db = db)
    return nova_requisicao

@router.put('/update-requisicoes', response_model=RequisicaoUpdate)
def update_requisicao(requisicao: RequisicaoUpdate, db: Session = Depends(get_db)):
    requisicao_atualizada = requisicao_service.update_requisicao(requisicao = requisicao, db = db)
    if not requisicao_atualizada:
        return None
    return requisicao_atualizada

@router.get('/listar', response_model=List[RequisicaoGetAll])
def listar_requisicoes(db: Session = Depends(get_db)):
    listar_requisicoes = requisicao_service.retornar_requisicoes(db = db)
    return listar_requisicoes
    
@router.get('/requisicao/{id_requisicao}', response_model=RequisicaoGet)
def listar_requisicao_items(id = id, db: Session = Depends(get_db)):
    listar_requisicao = requisicao_service.retornar_requisicao_items(id = id, db = db)
    return listar_requisicao

@router.get('/listar-requisicoes-gerente', response_model=List[RequisicaoGetAll])
def listar_requisicoes(db: Session = Depends(get_db)):
    listar_requisicoes = requisicao_service.retornar_requisicoes_gerente(db = db)
    return listar_requisicoes

@router.get('/requisicao-gerente/{id_requisicao}', response_model=RequisicaoGetGerente)
def listar_requisicao_gerente(id_requisicao: int, db: Session = Depends(get_db)):
    listar_requisicao = requisicao_service.retornar_requisicao_gerente(id_requisicao = id_requisicao, db = db)
    return listar_requisicao
             