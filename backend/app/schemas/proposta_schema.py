from typing import List, Optional
from pydantic import Field, BaseModel
from datetime import datetime
from enum import StrEnum
from app.schemas.item_proposta_schema import ItemPropostaBase, ItemPropostaGetNested


class PropostaBase(BaseModel): 
    descricao_proposta: str = Field(..., description = 'descricao de uma proposta')
    preco_total: float = Field(..., description = 'valor total de cada proposta referente a um item')
    prazo_entrega: datetime = Field(..., description = 'prazo para entrega de bem/servico')
    status_proposta: str = Field(default='Pendente', description = 'status atual da proposta')
    item_proposta: List[ItemPropostaBase] = Field(..., description='items a que a proposta se refere')
    
    class Config:
        from_attributes = True

class PropostaGet(PropostaBase):
    pk_id_proposta: int = Field(..., description = 'identificador unico de uma requisicao')
    fornecedor_nome: str = Field(..., description = 'nome do fornecedor que fez a proposta')
    requisicao_nome: str = Field(..., description = 'nome da requisicao a qual a proposta se refere')
    escore: float = Field(..., description='nivelamento da proposta com base em criterios pre-definidos')
    item_proposta: List[ItemPropostaGetNested] = Field(..., description='items a que a proposta se refere')

class PropostaGetAll(BaseModel):
    pk_id_proposta: int = Field(..., description = 'identificador unico de uma proposta')
    fornecedor_nome: str = Field(..., description = 'nome do fornecedor que fez a proposta')
    descricao_proposta: str = Field(..., description = 'descricao de uma proposta')
    preco_total: float = Field(..., description = 'valor total de cada proposta referente a um item')
    prazo_entrega: datetime = Field(..., description = 'prazo para entrega de bem/servico')
    escore: float = Field(..., description='nivelamento da proposta com base em criterios pre-definidos')

    class Config:
        from_attributes = True

class PropostaGetFornecedor(BaseModel):
    id_proposta: int = Field(..., description = 'identificador unico de uma requisicao')
    requisicao_titulo: str = Field(..., description = 'titulo da requisicao a qual a proposta se refere')
    preco_total: float = Field(..., description = 'valor total de cada proposta referente a um item')
    status_proposta: str = Field(..., description = 'status atual da proposta')
    
class CreateProposta(PropostaBase):
    pass

class PropostaUpdateStatus(BaseModel):
    status_proposta: str = Field(default='Selecionado', description = 'status atual da proposta')

    class Config:
        from_attributes = True

class PropostaUpdateStatusRecusar(PropostaUpdateStatus):
    status_proposta: str = Field(default='Recusado', description = 'status atual da proposta')

class PropostaUpdate(BaseModel):
    descricao_proposta: Optional[str] = Field(None, description = 'descricao de uma proposta')
    prazo_entrega: Optional[datetime] = Field(None, description = 'prazo para entrega de bem/servico')

    class Config:
        from_attributes = True

