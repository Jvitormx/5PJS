from app.database.connection import Base

from sqlalchemy import DateTime, ForeignKeyConstraint, Integer, PrimaryKeyConstraint, String, Text, text
from sqlalchemy.orm import Mapped, mapped_column, relationship

import datetime
from typing import Optional

class Requisicao(Base):
    __tablename__ = 'requisicao'
    __table_args__ = (
        ForeignKeyConstraint(['fk_id_comprador'], ['usuario.pk_usuario_id'], name='requisicao_fk_id_comprador_fkey'),
        PrimaryKeyConstraint('pk_id_requisicao', name='requisicao_pkey')
    )

    pk_id_requisicao: Mapped[int] = mapped_column(Integer, primary_key=True)
    data_requisicao: Mapped[datetime.datetime] = mapped_column(DateTime, nullable=False, server_default=text('now()'))
    descricao: Mapped[str] = mapped_column(Text, nullable=False)
    status: Mapped[str] = mapped_column(String(50), nullable=False)
    fk_id_comprador: Mapped[Optional[int]] = mapped_column(Integer)

    usuario: Mapped[Optional['Usuario']] = relationship('Usuario', back_populates='requisicao') # type: ignore
    item_requisicao: Mapped[list['ItemRequisicao']] = relationship('ItemRequisicao', back_populates='requisicao') # type: ignore
    proposta: Mapped[list['Proposta']] = relationship('Proposta', back_populates='requisicao') # type: ignore
