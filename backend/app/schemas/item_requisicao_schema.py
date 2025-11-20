from typing import Optional
from pydantic import Field, BaseModel
from datetime import datetime

class ItemRequisicaoBase(BaseModel): 
    descricao: str = Field(..., description = 'descricao de um item')
    quantidade: int = Field(..., description = 'quantidade requerida de items')

    class Config:
        from_attributes = True

class ItemRequisicaoGet(ItemRequisicaoBase):
    pk_item_requisicao : int = Field(..., description = 'identificador unico de um item de requisicao')
    fk_id_requisicao: int = Field(..., description = 'identificador da requisicao a qual o item pertence')

class UpdateRequisicao(BaseModel):
    descricao: Optional[str] = Field(None, description = 'descricao de um item')
    quantidade: Optional[int] = Field(None, description = 'quantidade requerida de items')

    class Config:
        from_attributes = True