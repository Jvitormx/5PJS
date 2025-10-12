from typing import Optional
from pydantic import Field
from usuario_schema import UsuarioBase, UsuarioUpdate

class FornecedorBase(UsuarioBase): 
    cnpj: str = Field(..., description = 'identificar cnpj de fornecedor')
    razao_social: str = Field(..., description = 'identificar razao social do fornecedor')
    descricao: str = Field(..., description = 'descricao de fornecedor')

class Fornecedor(FornecedorBase):
    fornecedor_id: int = Field(..., description = 'identificador de fornecedor no sistema')

class CreateFornecedor(FornecedorBase):
    pass

class UpdateFornecedor(UsuarioUpdate):
    cnpj: Optional[str] = Field(None, description = 'identificar cnpj de fornecedor')
    razao_social: Optional[str] = Field(None, description = 'identificar razao social do fornecedor')
    descricao: Optional[str] = Field(None, description = 'descricao de fornecedor')
