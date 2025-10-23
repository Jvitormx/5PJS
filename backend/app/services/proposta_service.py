from app.schemas.proposta_schema import CreateProposta, PropostaGet, PropostaGetFornecedor, PropostaGetAll
from app.schemas.item_requisicao_schema import ItemRequisicaoBase
from app.schemas.item_proposta_schema import ItemPropostaGetNested
from app.models import Proposta, ItemProposta, Fornecedor, Requisicao
from app.models import Pesos
from typing import List
from sqlalchemy.orm import Session, selectinload
from fastapi import HTTPException, Depends

Pesos = Pesos()

def create_proposta(proposta: CreateProposta, id_fornecedor: int, id_requisicao: int, db: Session) -> CreateProposta:

    nova_proposta = Proposta(
        preco_total = proposta.preco_total,
        prazo_entrega = proposta.prazo_entrega,
        descricao_proposta = proposta.descricao_proposta,
        status_proposta = proposta.status_proposta,
        fk_id_fornecedor = id_fornecedor,
        fk_id_requisicao = id_requisicao
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

def calcular_escore(preco_normalizado: float, peso_preco: float, qualidade_fornecedor: float, peso_qualidade: float) -> float:
    escore = (preco_normalizado * peso_preco) + (qualidade_fornecedor * peso_qualidade)
    return escore

def retornar_propostas_requisicao(id: int, db: Session) -> List[PropostaGetAll]:
    propostas = db.query(Proposta, Fornecedor).join(Fornecedor).filter(Proposta.fk_id_requisicao == id).all()
    menor_preco = min(proposta.preco_total for proposta, _ in propostas) if propostas else 0
    propostas_por_escore = []

    for proposta, fornecedor in propostas:
        preco_normalizado = (menor_preco / proposta.preco_total) * 100 if menor_preco > 0 else 0
        escore = calcular_escore(preco_normalizado, Pesos.get_peso_preco(), fornecedor.nota_qualidade, Pesos.get_peso_qualidade())

        proposta_com_escore = PropostaGetAll(
            pk_id_proposta=proposta.pk_id_proposta,
            fornecedor_nome=fornecedor.razao_social,
            preco_total=proposta.preco_total,
            prazo_entrega=proposta.prazo_entrega,
            descricao_proposta=proposta.descricao_proposta,
            escore=escore
        )
        propostas_por_escore.append(proposta_com_escore)

    return propostas_por_escore

def retornar_proposta_fornecedor(id_fornecedor: int, db: Session) -> List[PropostaGetFornecedor]:
    propostas = db.query(Proposta, Requisicao).join(Requisicao).filter(Proposta.fk_id_fornecedor == id_fornecedor).all()
    propostas_retorno = []

    for proposta, requisicao in propostas:
        proposta_dados = PropostaGetFornecedor(
            id_proposta = proposta.pk_id_proposta,
            requisicao_titulo = requisicao.titulo_requisicao,
            preco_total = proposta.preco_total,
            status_proposta = proposta.status_proposta
        )
        propostas_retorno.append(proposta_dados)

    return propostas_retorno

def retornar_proposta_items(id_proposta: int, fornecedor_nome: str, escore: float, db: Session) -> PropostaGet:
    proposta_requisicao = db.query(Proposta, Requisicao).join(Requisicao).options(selectinload(Proposta.item_proposta).selectinload(ItemProposta.item_requisicao))\
    .filter(Proposta.pk_id_proposta == id_proposta).first()

    proposta_orm = proposta_requisicao.Proposta
    requisicao_orm = proposta_requisicao.Requisicao

    itens_retorno = []

    for item in proposta_orm.item_proposta:
        item_requisicao_dados = ItemRequisicaoBase(
            descricao = item.item_requisicao.descricao,
            quantidade = item.item_requisicao.quantidade
        )
        item_proposta_dados = ItemPropostaGetNested(
            preco_individual = item.item_proposta.preco_individual,
            item_requisicao = item_requisicao_dados
        )
        itens_retorno.append(item_proposta_dados)

    proposta_retorno = PropostaGet(
        pk_id_proposta = proposta_orm.pk_id_proposta,
        requisicao_nome = requisicao_orm.titulo_requisicao,
        descricao_proposta = proposta_orm.descricao_proposta,
        preco_total = proposta_orm.preco_total,
        prazo_entrega = proposta_orm.prazo_entrega,
        escore = escore,
        item_proposta = itens_retorno
    )

    return proposta_retorno
        
