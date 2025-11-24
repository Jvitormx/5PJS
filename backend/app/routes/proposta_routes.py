from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.proposta_schema import CreateProposta, PropostaGet, PropostaGetAll, PropostaGetFornecedor, PropostaUpdateStatus, PropostaUpdate
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import proposta_service

router = APIRouter(prefix='/propostas', tags=['Propostas'])

@router.post('/', status_code=status.HTTP_201_CREATED, response_model=CreateProposta)
def criar_nova_proposta(proposta: CreateProposta, db: Session = Depends(get_db)):
    nova_proposta = proposta_service.create_proposta(proposta = proposta, db = db)
    return nova_proposta

@router.get('/listar-por-requisicao/{fk_id_requisicao}', response_model=List[PropostaGetAll])
def listar_propostas_requisicao(fk_id_requisicao: int, db: Session = Depends(get_db)):
    listar_propostas = proposta_service.retornar_propostas_requisicao(fk_id_requisicao = fk_id_requisicao, db = db)
    return listar_propostas

@router.get('/proposta/{id_proposta}', response_model=PropostaGet)
def listar_proposta_itens(id_proposta: int, nome_fornecedor: str, db: Session = Depends(get_db)):
    listar_proposta = proposta_service.retornar_proposta_items(id_proposta = id_proposta, fornecedor_nome = nome_fornecedor, db = db)
    return listar_proposta

@router.get('/listar-por-fornecedor/{id_fornecedor}', response_model=List[PropostaGetFornecedor])
def listar_propostas_fornecedor(id_fornecedor: int, db: Session = Depends(get_db)):
    propostas_fornecedor = proposta_service.retornar_proposta_fornecedor(id_fornecedor = id_fornecedor, db = db)
    return propostas_fornecedor

@router.put('update/{id_proposta}', response_model=PropostaUpdateStatus)
def update_status(proposta: PropostaUpdateStatus, id_proposta: int, db: Session = Depends(get_db)):
    proposta_confirmada = proposta_service.alterar_proposta_status(proposta = proposta, id_proposta = id_proposta, db = db)
    if not proposta_confirmada:
        return None
    return proposta_confirmada

@router.put('/atualizar-status/{id_proposta}', response_model=PropostaUpdate)
def update_proposta(proposta: PropostaUpdate, id_proposta: int, db: Session = Depends(get_db)):
    proposta_atualizada = proposta_service.update_proposta(proposta = proposta, id = id_proposta, db = db)
    if not proposta_atualizada:
        return None
    return proposta_atualizada

@router.put('/rejeitar/{id_proposta}')
def update_proposta(status: str, id_proposta: int, db: Session = Depends(get_db)):
    proposta_atualizada = proposta_service.rejeitar_proposta(status = status, id_proposta = id_proposta, db = db)
    if not proposta_atualizada:
        return None
    return proposta_atualizada

@router.put('/retirar/{id_proposta}')
def update_proposta(status: str, id_proposta: int, db: Session = Depends(get_db)):
    proposta_atualizada = proposta_service.fechar_proposta(status = status, id_proposta = id_proposta, db = db)
    if not proposta_atualizada:
        return None
    return proposta_atualizada



