from app.database.connection import Base

from sqlalchemy import DateTime, ForeignKeyConstraint, Integer, PrimaryKeyConstraint, String, Text, text
from sqlalchemy.orm import Mapped, mapped_column, relationship

import datetime
from typing import Optional

class PedidoCompra(Base):
    __tablename__ = 'pedido_compra'
    __table_args__ = (
        ForeignKeyConstraint(['fk_id_gerente'], ['usuario.pk_usuario_id'], name='pedido_compra_fk_id_gerente_fkey'),
        ForeignKeyConstraint(['fk_id_proposta'], ['proposta.pk_id_proposta'], name='pedido_compra_fk_id_proposta_fkey'),
        PrimaryKeyConstraint('pk_id_pedido_compra', name='pedido_compra_pkey')
    )

    pk_id_pedido_compra: Mapped[int] = mapped_column(Integer, primary_key=True)
    status: Mapped[str] = mapped_column(String(50), nullable=False)
    data_assinatura: Mapped[datetime.datetime] = mapped_column(DateTime, nullable=False, server_default=text('now()'))
    assinatura_hash: Mapped[str] = mapped_column(String(255), nullable=False)
    info: Mapped[Optional[str]] = mapped_column(Text)
    fk_id_gerente: Mapped[Optional[int]] = mapped_column(Integer)
    fk_id_proposta: Mapped[Optional[int]] = mapped_column(Integer)

    usuario: Mapped[Optional['Usuario']] = relationship('Usuario', back_populates='pedido_compra') # type: ignore
    proposta: Mapped[Optional['Proposta']] = relationship('Proposta', back_populates='pedido_compra') # type: ignore
    info_fatura: Mapped[list['InfoFatura']] = relationship('InfoFatura', back_populates='pedido_compra') # type: ignore