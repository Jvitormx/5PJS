from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.pedido_compra_schema import CreatePedidoCompra, PedidoCompraGet
from app.schemas.webhook_schema import WebhookPayload
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import pedido_compra_service

router = APIRouter(prefix='/pedido_compra', tags=['Pedido de Compra'])

@router.post('/', status_code=status.HTTP_201_CREATED)
def criar_novo_pedido_compra(pedido_compra: CreatePedidoCompra, id_gerente: int, id_proposta: int, db: Session = Depends(get_db)):
    novo_pedido_compra = pedido_compra_service.create_pedido_compra(pedido_compra = pedido_compra, id_gerente = id_gerente, id_proposta = id_proposta, db = db)
    return novo_pedido_compra


@router.get('/pedido_compra_fornecedor/{id_fornecedor}', response_model=List[PedidoCompraGet])
def retornar_pedido_compra_fornecedor(id_fornecedor: int, db: Session = Depends(get_db)):
    novo_pedido_compra = pedido_compra_service.retornar_pedido_compra_fornecedor(id_fornecedor = id_fornecedor, db = db)
    return novo_pedido_compra

@router.get('/pedido_compra_gerente', response_model=List[PedidoCompraGet])
def retornar_pedido_compra_gerente(db: Session = Depends(get_db)):
    novo_pedido_compra = pedido_compra_service.retornar_pedido_compra_gerente(db = db)
    return novo_pedido_compra


@router.put('/cancelar/{id_pedido_compra}')
def pedido_compra_cancelar(status: str, id_pedido_compra: int, db: Session = Depends(get_db)):
    pedido_compra_atualizado = pedido_compra_service.cancelar_pedido_compra(status = status, id_pedido_compra = id_pedido_compra, db = db)
    if not pedido_compra_atualizado:
        return None
    return pedido_compra_atualizado