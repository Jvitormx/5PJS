from database.connection import Base

from requisicao import Requisicao
from item_proposta import ItemProposta

from sqlalchemy import ForeignKeyConstraint, Integer, PrimaryKeyConstraint, String, Text, text
from sqlalchemy.orm import Mapped, mapped_column, relationship

from typing import Optional

class ItemRequisicao(Base):
    __tablename__ = 'item_requisicao'
    __table_args__ = (
        ForeignKeyConstraint(['fk_id_requisicao'], ['requisicao.pk_id_requisicao'], name='item_requisicao_fk_id_requisicao_fkey'),
        PrimaryKeyConstraint('pk_item_requisicao', name='item_requisicao_pkey')
    )

    pk_item_requisicao: Mapped[int] = mapped_column(Integer, primary_key=True)
    descricao: Mapped[str] = mapped_column(Text, nullable=False)
    quantidade: Mapped[int] = mapped_column(Integer, nullable=False)
    fk_id_requisicao: Mapped[Optional[int]] = mapped_column(Integer)

    requisicao: Mapped[Optional['Requisicao']] = relationship('Requisicao', back_populates='item_requisicao')
    item_proposta: Mapped[list['ItemProposta']] = relationship('ItemProposta', back_populates='item_requisicao')
