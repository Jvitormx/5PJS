from app.database.connection import Base

from sqlalchemy import ForeignKeyConstraint, Integer, Numeric, PrimaryKeyConstraint, String, Text, text
from sqlalchemy.orm import Mapped, mapped_column, relationship

import decimal

class ItemProposta(Base):
    __tablename__ = 'item_proposta'
    __table_args__ = (
        ForeignKeyConstraint(['pk_id_item'], ['item_requisicao.pk_item_requisicao'], name='item_proposta_pk_id_item_fkey'),
        ForeignKeyConstraint(['pk_id_item_proposta'], ['proposta.pk_id_proposta'], name='item_proposta_pk_id_item_proposta_fkey'),
        PrimaryKeyConstraint('pk_id_item', 'pk_id_item_proposta', name='item_proposta_pkey')
    )

    pk_id_item: Mapped[int] = mapped_column(Integer, primary_key=True)
    pk_id_item_proposta: Mapped[int] = mapped_column(Integer, primary_key=True)
    preco_individual: Mapped[decimal.Decimal] = mapped_column(Numeric(10, 2), nullable=False)

    item_requisicao: Mapped['ItemRequisicao'] = relationship('ItemRequisicao', back_populates='item_proposta') # type: ignore
    proposta: Mapped['Proposta'] = relationship('Proposta', back_populates='item_proposta') # type: ignore
