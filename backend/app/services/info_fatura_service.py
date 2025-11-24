from app.schemas.info_fatura_schema import CreateInfoFatura, InfoFaturaGet
from app.models import InfoFatura, PedidoCompra
from typing import List
from sqlalchemy.orm import Session
from fastapi import HTTPException, Depends
from sqlalchemy import select
from datetime import datetime

def create_info_fatura(info_fatura: CreateInfoFatura, db: Session) -> dict:

    novo_info_fatura = InfoFatura(
        data_emissao = info_fatura.data_emissao,
        valor = info_fatura.valor,
        status = info_fatura.status,
        ref_arquivo_fatura = info_fatura.ref_arquivo_fatura,
        fk_id_pedido_compra = info_fatura.fk_id_pedido_compra
    )

    db.add(novo_info_fatura)
    db.commit()
    db.refresh(novo_info_fatura)

    return {"mensagem": "Informação da fatura registrada com sucesso."}


def get_info_fatura(pk_id_pedido_compra: int, db: Session) -> InfoFaturaGet:

    statemant = (select(InfoFatura).where(InfoFatura.fk_id_pedido_compra == pk_id_pedido_compra))
    info_fatura_db = db.execute(statemant).scalar_one_or_none()

    if not info_fatura_db:
        raise HTTPException(status_code=404, detail="Informação da fatura não encontrada.")

    return info_fatura_db

def update_info_fatura_status(pk_id_info_fatura: int, db: Session) -> dict:

    statement = (
        select(InfoFatura, PedidoCompra)
        .join(PedidoCompra, InfoFatura.fk_id_pedido_compra == PedidoCompra.pk_id_pedido_compra)
        .where(InfoFatura.pk_id_fatura == pk_id_info_fatura)
    )

    info_fatura_db = db.execute(statement).first()

    if not info_fatura_db:
        raise HTTPException(status_code=404, detail="Informação da fatura não encontrada.")

    fatura, pedido_compra = info_fatura_db

    fatura.status = "Aprovada"
    pedido_compra.status = "Finalizado"

    db.commit()

    return {"mensagem": "processo finalizado"}
