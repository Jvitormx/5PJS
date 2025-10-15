from typing import Optional
from pydantic import Field, BaseModel
from datetime import datetime

class ItemPropostaBase(BaseModel): 
    pk_id_item: int = Field(..., description = 'relação de valor com item de requisicao')
    preco_individual: int = Field(..., description = 'quantidade requerida de items')
    
    class Config:
        from_attributes = True

class ItemPropostaGet(ItemPropostaBase):
    pk_id_item_requisicao: int = Field(..., description = 'identificador unico de um item de requisicao')
    fk_id_requisicao: int = Field(..., description = 'identificador da requisicao a qual o item pertence')


class UpdateItemProposta(BaseModel):
    preco_individual: int = Field(..., description = 'quantidade requerida de items')

    class Config:
        from_attributes = True