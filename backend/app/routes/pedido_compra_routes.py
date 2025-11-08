from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.pedido_compra_schema import CreatePedidoCompra, PedidoCompraGet
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import pedido_compra_service

router = APIRouter(prefix='/pedido_compra', tags=['Pedido de Compra'])

@router.post('/', status_code=status.HTTP_201_CREATED)
def criar_novo_pedido_compra(pedido_compra: CreatePedidoCompra, id_gerente: int, id_proposta: int, db: Session = Depends(get_db)):
    novo_pedido_compra = pedido_compra_service.create_pedido_compra(pedido_compra = pedido_compra, id_gerente = id_gerente, id_proposta = id_proposta, db = db)
    return novo_pedido_compra