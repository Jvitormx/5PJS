from app.schemas.requisicao_schema import RequisicaoGet, RequisicaoGetAll, CreateRequisicao, RequisicaoUpdate 
from app.models import Requisicao, ItemRequisicao
from typing import List
from sqlalchemy.orm import Session
from fastapi import HTTPException, Depends

def create_requisicao(requisicao: CreateRequisicao, id: int, db: Session) -> RequisicaoGet:

    nova_requisicao = Requisicao(
        titulo_requisicao = requisicao.titulo_requisicao,
        descricao = requisicao.descricao,
        status = requisicao.status,
        fk_id_comprador = id,
    )

    db.add(nova_requisicao)
    db.commit()
    db.refresh(nova_requisicao)

    for item in requisicao.item_requisicao:
        novo_item = ItemRequisicao(
            descricao = item.descricao,
            quantidade = item.quantidade,
            fk_id_requisicao = nova_requisicao.pk_id_requisicao
        )
        db.add(novo_item)

    db.commit()

    db.refresh(nova_requisicao)
    return nova_requisicao

def update_requisicao(requisicao: RequisicaoUpdate, id: int, db: Session) -> RequisicaoUpdate:
    requisicao_update = db.query(Requisicao).filter(Requisicao.pk_id_requisicao == id).first()
    if not requisicao_update:
        return None
    
    requisicao_update.update(requisicao.model_dump(), synchronize_session=False)

    db.commit()

    return requisicao_update

def retornar_requisicoes(db: Session) -> List[RequisicaoGetAll]:
    requisicoes = db.query(Requisicao).all()
    if not requisicoes:
        return None
    return requisicoes

def retornar_requisicao_items(id: int, db: Session) -> RequisicaoGet:
    requisicao = db.query(Requisicao).filter(Requisicao.pk_id_requisicao == id).first()
    if not requisicao:
        return None
    return requisicao

def returnar_requisicao_itens_selecionados(id_itens: List[int], db: Session) -> List[ItemRequisicao]:
    itens = db.query(ItemRequisicao).filter(ItemRequisicao.pk_id_item_requisicao.in_(id_itens)).all()
    if not itens:
        return None
    return itens
