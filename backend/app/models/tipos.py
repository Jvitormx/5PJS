from sqlalchemy.orm import Mapped
from app.models.usuario import Usuario

class Administrador_Tipo(Usuario):
     __mapper_args__ = {
        "polymorphic_identity": "administrador",
    }

class Comprador_Tipo(Usuario):
      __mapper_args__ = {
        "polymorphic_identity": "comprador",
    }
    
class Gerente_Tipo(Usuario):
       __mapper_args__ = {
        "polymorphic_identity": "gerente",
    }
    
class Fornecedor_Tipo(Usuario):
      pass