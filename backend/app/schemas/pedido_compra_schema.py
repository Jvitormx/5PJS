from typing import List, Optional
from pydantic import Field, BaseModel
from datetime import datetime
from enum import StrEnum


class PedidoCompraBase(BaseModel): 
    status: str = Field(default='Pendente', description = 'status atual do pedido de compra')
    data_assinatura: datetime = Field(..., description = 'timestamp de assinatura do pedido de compra')
    info: str = Field(default='esign utilizando Docuseal', description = 'informacoes adicionais do pedido de compra e esign')
    
    class Config:
        from_attributes = True

class PedidoCompraGet(BaseModel):
    pk_id_pedido_compra: int = Field(..., description = 'identificador unico de um pedido de compra')

class PropostaGetFornecedor(BaseModel):
    id_proposta: int = Field(..., description = 'identificador unico de uma requisicao')
    requisicao_titulo: str = Field(..., description = 'titulo da requisicao a qual a proposta se refere')
    preco_total: float = Field(..., description = 'valor total de cada proposta referente a um item')
    status_proposta: str = Field(..., description = 'status atual da proposta')
    
class CreatePedidoCompra(PedidoCompraBase):
    pass

