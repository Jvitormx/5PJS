from app.schemas.proposta_schema import CreateProposta, PropostaGet, PropostaGetAll
from app.models import Proposta, ItemProposta
from typing import List
from sqlalchemy.orm import Session
from fastapi import HTTPException, Depends

def create_proposta(proposta: CreateProposta, id_fornecedor: int, id_requisicao: int, db: Session) -> CreateProposta:

    nova_proposta = Proposta(
        preco_total = proposta.preco_total,
        prazo_entrega = proposta.prazo_entrega,
        descricao_proposta = proposta.descricao_proposta,
    )

    db.add(nova_proposta)
    db.commit()
    db.refresh(nova_proposta)

    for item in proposta.item_proposta:
        novo_item = ItemProposta(
            pk_id_item = item.pk_id_item,
            pk_id_item_proposta = nova_proposta.pk_id_proposta,
            preco_individual = item.preco_individual,
        )
        db.add(novo_item)

    db.commit()

    db.refresh(nova_proposta)
    return nova_proposta

def calcular_escore(propostas: List[Proposta], menor_preco: float) -> float:
    for proposta in propostas:
        preco_normalizado = (menor_preco/proposta.preco_total) * 100

def retornar_propostas(id: int, db: Session) -> List[PropostaGetAll]:
    propostas = db.query(Proposta).filter(Proposta.fk_id_requisicao == id).all()
    menor_preco = min(proposta.preco_total for proposta in propostas) if propostas else 0

def retornar_requisicao_items(id: int, escore: float, db: Session) -> PropostaGet:
    proposta = db.query(Proposta).filter(Proposta.pk_id_proposta == id).first()
