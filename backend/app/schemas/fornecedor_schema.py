from typing import Optional
from pydantic import Field, BaseModel
from app.schemas.usuario_schema import UsuarioBase, UsuarioGet, UsuarioUpdate, Tipo

class FornecedorBase(UsuarioBase):
    cnpj: str = Field(..., description = 'identificar cnpj de fornecedor')
    razao_social: str = Field(..., description = 'identificar razao social do fornecedor')
    descricao: str = Field(..., description = 'descricao de fornecedor')
    tipo: Tipo = Field(default = Tipo.FORNECEDOR, description = 'separa usuarios em diferentes telas no sistema')
    nota_qualidade: float = Field(default = 0.6, description = 'nota de qualidade atribuída a un fornecedor')

class FornecedorGet(UsuarioGet):
    cnpj: str = Field(..., description = 'identificar cnpj de fornecedor')
    razao_social: str = Field(..., description = 'identificar razao social do fornecedor')
    nota_qualidade: float = Field(Default = 0.6, description = 'nota de qualidade atribuída a um fornecedor')
    descricao: str = Field(..., description = 'descricao de fornecedor')

class Fornecedor_Atribuir_Nota(BaseModel):
    nota_qualidade: float = Field(Default = 0.6, ge = 0.1, le = 0.9, description = 'nota de qualidade atribuída a um fornecedor')

    class Config:
        from_attributes = True

class CreateFornecedor(FornecedorBase):
    pass

class UpdateFornecedor(BaseModel):
    cnpj: Optional[str] = Field(None, description = 'identificar cnpj de fornecedor')
    razao_social: Optional[str] = Field(None, description = 'identificar razao social do fornecedor')
    descricao: Optional[str] = Field(None, description = 'descricao de fornecedor')

    class Config:
        from_attributes = True
