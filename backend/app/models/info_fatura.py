from database.connection import Base

from pedido_compra import PedidoCompra

from sqlalchemy import DateTime, ForeignKeyConstraint, Integer, Numeric, PrimaryKeyConstraint, String, Text, text
from sqlalchemy.orm import Mapped, mapped_column, relationship

import datetime
import decimal
from typing import Optional

class InfoFatura(Base):
    __tablename__ = 'info_fatura'
    __table_args__ = (
        ForeignKeyConstraint(['fk_id_pedido_compra'], ['pedido_compra.pk_id_pedido_compra'], name='info_fatura_fk_id_pedido_compra_fkey'),
        PrimaryKeyConstraint('pk_id_fatura', name='info_fatura_pkey')
    )

    pk_id_fatura: Mapped[int] = mapped_column(Integer, primary_key=True)
    data_emissao: Mapped[datetime.datetime] = mapped_column(DateTime, nullable=False, server_default=text('now()'))
    valor: Mapped[decimal.Decimal] = mapped_column(Numeric(10, 2), nullable=False)
    status: Mapped[str] = mapped_column(String(50), nullable=False)
    ref_arquivo_fatura: Mapped[Optional[str]] = mapped_column(String(255))
    fk_id_pedido_compra: Mapped[Optional[int]] = mapped_column(Integer)

    pedido_compra: Mapped[Optional['PedidoCompra']] = relationship('PedidoCompra', back_populates='info_fatura')
