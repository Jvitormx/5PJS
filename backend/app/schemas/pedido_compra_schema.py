from typing import List, Optional
from pydantic import Field, BaseModel
from datetime import datetime
from enum import StrEnum


class PedidoCompraBase(BaseModel): 
    status: str = Field(default='Pendente', description = 'status atual do pedido de compra')
    data_assinatura: datetime = Field(..., description = 'timestamp de assinatura do pedido de compra')
    info: str = Field(default='esign utilizando Docuseal', description = 'informacoes adicionais do pedido de compra e esign')
    esign_id: str = Field(default='Pendente', description = 'identificador do contrato entre a empresa e fornecedor')
    
    class Config:
        from_attributes = True

class PedidoCompraGet(PedidoCompraBase):
    pk_id_pedido_compra: int = Field(..., description = 'identificador unico de um pedido de compra')
    titulo_requisicao: str = Field(..., description = 'titulo de uma requisicao')
    razao_social: str = Field(..., description = 'razao social de um fornecedor')
    preco_total: int = Field(..., description = 'preco total da proposta')

class CreatePedidoCompra(PedidoCompraBase):
    fk_id_gerente: int = Field(..., description = 'identificador unico do gerente associado ao pedido de compra')
    fk_id_proposta: int = Field(..., description = 'identificador unico da proposta associada ao pedido de compra')

class PedidoCompraFinalizar(BaseModel):
    pk_id_pedido_compra: int = Field(..., description = 'identificador unico do pedido de compra')
    status: str = Field(default='Finalizado', description = 'novo status do pedido de compra')