from app.models.usuario import Usuario

from sqlalchemy import ForeignKeyConstraint, Integer, PrimaryKeyConstraint, Float, String, Text, text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from typing import Optional

class Fornecedor(Usuario):
    __tablename__ = 'fornecedor'
    __table_args__ = (
        ForeignKeyConstraint(['pk_usuario_id'], ['usuario.pk_usuario_id'], name='fornecedor_pk_usuario_id_fkey'),
        PrimaryKeyConstraint('pk_usuario_id', name='fornecedor_pkey')
    )

    pk_usuario_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    cnpj: Mapped[str] = mapped_column(String(255), nullable=False)
    razao_social: Mapped[str] = mapped_column(String(255), nullable=False)
    nota_qualidade: Mapped[float] = mapped_column(Float, nullable=False)
    descricao: Mapped[Optional[str]] = mapped_column(Text)

    __mapper_args__ = {
        "polymorphic_identity": "fornecedor"
    }

    proposta: Mapped[list['Proposta']] = relationship('Proposta', back_populates='fornecedor') # type: ignore
