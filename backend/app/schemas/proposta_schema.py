from typing import List, Optional
from pydantic import Field, BaseModel
from datetime import datetime
from enum import StrEnum
from app.schemas.item_proposta_schema import ItemPropostaBase


class PropostaBase(BaseModel): 
    descricao_proposta: str = Field(..., description = 'descricao de uma proposta')
    preco_total: float = Field(..., description = 'valor total de cada proposta referente a um item')
    prazo_entrega: datetime = Field(..., description = 'prazo para entrega de bem/servico')
    item_proposta: List[ItemPropostaBase] = Field(..., description='items a que a proposta se refere')
    
    class Config:
        from_attributes = True

class PropostaGet(BaseModel):
    pk_id_proposta: int = Field(..., description = 'identificador unico de uma requisicao')
    data_requisicao: datetime = Field(..., description = 'data de criacao de uma requisicao')
    escore: float = Field(..., description='nivelamento da proposta com base em criterios pre-definidos')
    
class PropostaGetAll(BaseModel):
    pk_id_proposta: int = Field(..., description = 'identificador unico de uma requisicao')
    descricao_proposta: str = Field(..., description = 'descricao de uma proposta')
    preco_total: float = Field(..., description = 'valor total de cada proposta referente a um item')
    prazo_entrega: datetime = Field(..., description = 'prazo para entrega de bem/servico')
    escore: float = Field(..., description='nivelamento da proposta com base em criterios pre-definidos')

    class Config:
        from_attributes = True

class CreateProposta(PropostaBase):
    pass