from typing import List, Optional
from pydantic import Field, BaseModel
from datetime import datetime
from enum import StrEnum
from app.schemas.item_requisicao_schema import ItemRequisicaoBase, ItemRequisicaoGet

class Status(StrEnum):
    ABERTO = "aberto"
    CANCELADO = "cancelado"
    CONCLUIDO = "concluido"


class RequisicaoBase(BaseModel): 
    titulo_requisicao: str = Field(..., description = 'definir titulo da requisicao')
    descricao: str = Field(..., description = 'descricao geral e motivacao de uma requisicao')
    status: Status = Field(default=Status.ABERTO, description = 'status de uma requisicao')
    item_requisicao: List[ItemRequisicaoBase] = Field(..., description='items de uma requisicao')

    class Config:
        from_attributes = True

class RequisicaoBaseToGet(BaseModel): 
    titulo_requisicao: str = Field(..., description = 'definir titulo da requisicao')
    descricao: str = Field(..., description = 'descricao geral e motivacao de uma requisicao')
    status: Status = Field(default=Status.ABERTO, description = 'status de uma requisicao')
    item_requisicao: List[ItemRequisicaoGet] = Field(..., description='items de uma requisicao')

    class Config:
        from_attributes = True

class RequisicaoGet(RequisicaoBaseToGet):
    pk_id_requisicao: int = Field(..., description = 'identificador unico de uma requisicao')
    data_requisicao: datetime = Field(..., description = 'data de criacao de uma requisicao')

class RequisicaoGetGerente(RequisicaoGet):
    pk_id_proposta: int = Field(..., description = 'identificador unico de uma proposta')
    fornecedor_nome: str = Field(..., description = 'nome do fornecedor que fez a proposta')
    preco_total: float = Field(..., description = 'valor total de cada proposta referente a um item')
    prazo_entrega: datetime = Field(..., description = 'prazo para entrega de bem/servico')

class RequisicaoGetAll(BaseModel):
    pk_id_requisicao: int = Field(..., description = 'identificador unico de uma requisicao')
    data_requisicao: datetime = Field(..., description = 'data de criacao de uma requisicao')
    titulo_requisicao: str = Field(..., description = 'definir titulo da requisicao')
    descricao: str = Field(..., description = 'descricao geral e motivacao de uma requisicao')
    status: Status = Field(default=Status.ABERTO, description = 'status de uma requisicao')
    fk_id_comprador: int = Field(..., description = 'identificador do comprador que fez a requisicao')

    class Config:
        from_attributes = True

    
class RequisicaoUpdate(BaseModel):
    titulo_requisicao: Optional[str] = Field(None, description = 'definir titulo da requisicao')
    descricao: Optional[str] = Field(None, description = 'descricao geral e motivacao de uma requisicao')
    status: Optional[Status] = Field(None, description = 'status de uma requisicao')
    pk_id_requisicao: int = Field(..., description = 'identificador unico de uma requisicao')

    class Config:
        from_attributes = True

class CreateRequisicao(RequisicaoBase):
    fk_id_comprador: int = Field(..., description = 'identificador do comprador que fez a requisicao')