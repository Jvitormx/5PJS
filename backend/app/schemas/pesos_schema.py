from typing import List, Optional
from pydantic import Field, BaseModel
from datetime import datetime
from enum import StrEnum
from app.schemas.item_proposta_schema import ItemPropostaBase


class PesoBase(BaseModel): 
    peso_preco: float = Field(..., description = 'peso do valor de uma proposta para nivelamento')
    peso_qualidade: float = Field(..., description = 'peso da qualidade do fornecedor de uma proposta para nivelamento')

class PesoGet(PesoBase):
    pass