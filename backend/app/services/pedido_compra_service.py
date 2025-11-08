from app.schemas.pedido_compra_schema import CreatePedidoCompra, PedidoCompraGet
from app.models import PedidoCompra, Proposta, Requisicao, Fornecedor, Usuario
from typing import List
from sqlalchemy.orm import Session, selectinload
from fastapi import HTTPException, Depends
from sqlalchemy import select, selectinload
from datetime import datetime
from app.services.docuseal_assinatura_service import criar_template_assinatura

def create_pedido_compra(pedido_compra: CreatePedidoCompra, db: Session) -> dict:
    
    id_gerente = pedido_compra.fk_id_gerente
    id_proposta = pedido_compra.fk_id_proposta

    statemant = (select(Proposta, Requisicao, Fornecedor).join(Requisicao, Proposta.fk_id_requisicao == Requisicao.pk_id_requisicao).
                 join(Fornecedor, Fornecedor.pk_usuario_id == Proposta.fk_id_fornecedor).where(Proposta.pk_id_proposta == id_proposta))
    
    proposta, requisicao, fornecedor = db.execute(statemant).first()

    statemant = (select(Usuario).where(Usuario.pk_id_usuario == id_gerente))
    gerente = db.execute(statemant).first()

    data_assin = datetime.now().strftime("%d/%m/%Y")
    prazo_entrega = proposta.prazo_entrega.strftime("%d/%m/%Y")
    total = str(proposta.total)
    n_proposta = str(proposta.pk_id_proposta)
    n_requisicao = str(requisicao.pk_id_requisicao)

    novo_pedido_compra = PedidoCompra(
        status = pedido_compra.status,
        data_assinatura = pedido_compra.data_assinatura,
        info = pedido_compra.info,
        fk_id_gerente = id_gerente,
        fk_id_proposta = id_proposta
    )

    db.add(novo_pedido_compra)
    db.commit()
    db.refresh(novo_pedido_compra)

    return criar_template_assinatura(
        email_gerente = gerente.Usuario.email,
        email_fornecedor = fornecedor.email,
        razao_social = fornecedor.razao_social,
        cnpj = fornecedor.cnpj,
        prazo_entrega = prazo_entrega,
        total = total,
        data_assin = data_assin,
        n_proposta = n_proposta,
        n_requisicao = n_requisicao
    )


