from typing import List, Optional
from pydantic import Field, BaseModel
from datetime import datetime
from enum import StrEnum


class InfoFaturaBase(BaseModel): 
    data_emissao: datetime = Field(default=datetime.now().strftime("%d/%m/%Y"), description = 'data de upload da fatura')
    valor: float = Field(..., description = 'validação do valor total da fatura')
    status: str = Field(default='Pendente', description = 'status de aprovacao de uma fatura')
    ref_arquivo_fatura: str = Field(..., description = 'referencia do arquivo da fatura')

    class Config:
        from_attributes = True

class InfoFaturaGet(InfoFaturaBase):
    pk_id_fatura: int = Field(..., description = 'identificador unico de uma fatura')
    
class CreateInfoFatura(InfoFaturaBase):
    fk_id_pedido_compra: int = Field(..., description = 'identificador unico do pedido de compra associado a fatura')
