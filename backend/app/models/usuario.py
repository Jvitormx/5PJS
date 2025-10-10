from database.connection import Base

from requisicao import Requisicao
from pedido_compra import PedidoCompra

from sqlalchemy import CheckConstraint, Integer, PrimaryKeyConstraint, String, Text, UniqueConstraint, text
from sqlalchemy.orm import Mapped, mapped_column, relationship


class Usuario(Base):
    __tablename__ = 'usuario'
    __table_args__ = (
        CheckConstraint("tipo::text = ANY (ARRAY['administrador'::character varying, 'comprador'::character varying, 'gerente'::character varying, 'fornecedor'::character varying]::text[])", name='usuario_tipo_check'),
        PrimaryKeyConstraint('pk_usuario_id', name='usuario_pkey'),
        UniqueConstraint('email', name='usuario_email_key')
    )

    pk_usuario_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    email: Mapped[str] = mapped_column(String(255), nullable=False)
    senha_hash: Mapped[str] = mapped_column(Text, nullable=False)
    tipo: Mapped[str] = mapped_column(String(50), nullable=False)

    __mapper_args__ = {
        "polymorphic_on": tipo,
        "polymorphic_identity": "usuario"
    }

    requisicao: Mapped[list['Requisicao']] = relationship('Requisicao', back_populates='usuario')
    pedido_compra: Mapped[list['PedidoCompra']] = relationship('PedidoCompra', back_populates='usuario')


