from database.connection import Base

from fornecedor import Fornecedor
from requisicao import Requisicao
from item_proposta import ItemProposta
from pedido_compra import PedidoCompra

from sqlalchemy import Date, ForeignKeyConstraint, Integer, Numeric, PrimaryKeyConstraint, String, Text, text
from sqlalchemy.orm import Mapped, mapped_column, relationship

import datetime
import decimal
from typing import Optional

class Proposta(Base):
    __tablename__ = 'proposta'
    __table_args__ = (
        ForeignKeyConstraint(['fk_id_fornecedor'], ['fornecedor.pk_usuario_id'], name='proposta_fk_id_fornecedor_fkey'),
        ForeignKeyConstraint(['fk_id_requisicao'], ['requisicao.pk_id_requisicao'], name='proposta_fk_id_requisicao_fkey'),
        PrimaryKeyConstraint('pk_id_proposta', name='proposta_pkey')
    )

    pk_id_proposta: Mapped[int] = mapped_column(Integer, primary_key=True)
    preco_total: Mapped[decimal.Decimal] = mapped_column(Numeric(10, 2), nullable=False)
    prazo_entrega: Mapped[datetime.date] = mapped_column(Date, nullable=False)
    descricao_proposta: Mapped[Optional[str]] = mapped_column(Text)
    fk_id_fornecedor: Mapped[Optional[int]] = mapped_column(Integer)
    fk_id_requisicao: Mapped[Optional[int]] = mapped_column(Integer)

    fornecedor: Mapped[Optional['Fornecedor']] = relationship('Fornecedor', back_populates='proposta')
    requisicao: Mapped[Optional['Requisicao']] = relationship('Requisicao', back_populates='proposta')
    item_proposta: Mapped[list['ItemProposta']] = relationship('ItemProposta', back_populates='proposta')
    pedido_compra: Mapped[list['PedidoCompra']] = relationship('PedidoCompra', back_populates='proposta')

