from typing import Optional
from pydantic import Field, BaseModel
from datetime import datetime
from app.schemas.item_requisicao_schema import ItemRequisicaoBase

class ItemPropostaBase(BaseModel): 
    pk_id_item: int = Field(..., description = 'relação de valor com item de requisicao')
    preco_individual: float = Field(..., description = 'quantidade requerida de items')
    
    class Config:
        from_attributes = True

class ItemPropostaGet(ItemPropostaBase):
    pk_id_item_requisicao: int = Field(..., description = 'identificador unico de um item de requisicao')
    fk_id_requisicao: int = Field(..., description = 'identificador da requisicao a qual o item pertence')

class ItemPropostaGetNested(BaseModel):
    preco_individual: float = Field(..., description = 'preco individual do item da proposta')
    item_requisicao: ItemRequisicaoBase = Field(..., description = 'item da requisicao a que a proposta se refere')

    class Config:
        from_attributes = True
        
class UpdateItemProposta(BaseModel):
    preco_individual: int = Field(..., description = 'quantidade requerida de items')

    class Config:
        from_attributes = True