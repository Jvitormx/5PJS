from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.proposta_schema import CreateProposta, PropostaGet, PropostaGetAll, PropostaGetFornecedor, PropostaUpdateStatus, PropostaUpdate, PropostaUpdateStatusRecusar
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import proposta_service

router = APIRouter(prefix='/propostas', tags=['Propostas'])

@router.post('/{id_fornecedor}/{id_requisicao}', status_code=status.HTTP_201_CREATED, response_model=CreateProposta)
def criar_nova_proposta(proposta: CreateProposta, id_fornecedor: int, id_requisicao: int, db: Session = Depends(get_db)):
    nova_proposta = proposta_service.create_proposta(proposta = proposta, id_fornecedor = id_fornecedor, id_requisicao = id_requisicao, db = db)
    return nova_proposta

@router.get('/{id}', response_model=List[PropostaGetAll])
def listar_propostas_requisicao(id: int, db: Session = Depends(get_db)):
    listar_propostas = proposta_service.retornar_propostas_requisicao(id = id, db = db)
    return listar_propostas

@router.get('/{id}/{nome_fornecedor}/{score}', response_model=PropostaGet)
def listar_proposta_itens(id: int, nome_fornecedor: str, score: float, db: Session = Depends(get_db)):
    listar_proposta = proposta_service.retornar_proposta_items(id_proposta = id, fornecedor_nome = nome_fornecedor, score = score, db = db)
    return listar_proposta

@router.get('/{id_fornecedor}', response_model=List[PropostaGetFornecedor])
def listar_propostas_fornecedor(id_fornecedor: int, db: Session = Depends(get_db)):
    propostas_fornecedor = proposta_service.retornar_proposta_fornecedor(id_fornecedor = id_fornecedor, db = db)
    return propostas_fornecedor

@router.put('/{id}', response_model=PropostaUpdateStatus)
def confirmar_proposta(proposta: PropostaUpdateStatus, id: int, db: Session = Depends(get_db)):
    proposta_confirmada = proposta_service.confirmar_proposta_por_id(proposta = proposta, id = id, db = db)
    if not proposta_confirmada:
        return None
    return proposta_confirmada

@router.put('/{id}', response_model=PropostaUpdateStatusRecusar)
def recusar_proposta(proposta: PropostaUpdateStatus, id: int, db: Session = Depends(get_db)):
    proposta_confirmada = proposta_service.confirmar_proposta_por_id(proposta = proposta, id = id, db = db)
    if not proposta_confirmada:
        return None
    return proposta_confirmada

@router.put('/{id}', response_model=PropostaUpdate)
def update_proposta(proposta: PropostaUpdate, id: int, db: Session = Depends(get_db)):
    proposta_atualizada = proposta_service.update_proposta(proposta = proposta, id = id, db = db)
    if not proposta_atualizada:
        return None
    return proposta_atualizada