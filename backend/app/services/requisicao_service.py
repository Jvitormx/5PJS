from app.schemas.requisicao_schema import RequisicaoGet, RequisicaoGetAll, CreateRequisicao, RequisicaoUpdate, RequisicaoGetGerente
from app.models import Requisicao, ItemRequisicao, Proposta, Fornecedor
from typing import List
from sqlalchemy.orm import Session
from fastapi import HTTPException, Depends

def create_requisicao(requisicao: CreateRequisicao, db: Session) -> dict:

    nova_requisicao = Requisicao(
        titulo_requisicao = requisicao.titulo_requisicao,
        descricao = requisicao.descricao,
        status = requisicao.status,
        fk_id_comprador = requisicao.fk_id_comprador,
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
    return {"mensagem":"Requisicao criada com sucesso"}

def update_requisicao(requisicao: RequisicaoUpdate, db: Session) -> RequisicaoUpdate:
    requisicao_update = db.query(Requisicao).filter(Requisicao.pk_id_requisicao == requisicao.pk_id_requisicao).first()
    if not requisicao_update:
        return None
    
    requisicao_update.update(requisicao.model_dump(), synchronize_session=False)

    db.commit()

    return requisicao_update

def retornar_requisicoes_gerente(db: Session) -> List[RequisicaoGetAll]:
    requisicoes = db.query(Requisicao).join(Proposta).filter(Proposta.status == 'Confirmado').all()
    if not requisicoes:
        return None
    return requisicoes

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

def retornar_requisicao_gerente(id: int, db: Session) -> RequisicaoGetGerente:
    proposta_requisicao = db.query(Proposta, Requisicao, Fornecedor).join(Requisicao).join(Fornecedor).filter(Requisicao.pk_id_requisicao == id, Proposta.status_proposta == 'Confirmado').first()

    if proposta_requisicao:
        proposta_confirmada, requisicao, fornecedor = proposta_requisicao

        requisicao_retorno = RequisicaoGetGerente(
            pk_id_requisicao = requisicao.pk_id_requisicao,
            titulo_requisicao = requisicao.titulo_requisicao,
            descricao = requisicao.descricao,
            status = requisicao.status,
            data_requisicao = requisicao.data_requisicao,
            pk_id_proposta = proposta_confirmada.pk_id_proposta,
            fornecedor_nome = fornecedor.razao_social,
            preco_total = proposta_confirmada.preco_total,
            prazo_entrega = proposta_confirmada.prazo_entrega,
            escore = proposta_confirmada.escore
        )

        return requisicao_retorno

def returnar_requisicao_itens_selecionados(id_itens: List[int], db: Session) -> List[ItemRequisicao]:
    itens = db.query(ItemRequisicao).filter(ItemRequisicao.pk_id_item_requisicao.in_(id_itens)).all()
    if not itens:
        return None
    return itens
