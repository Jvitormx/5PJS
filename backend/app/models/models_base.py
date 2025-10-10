'''
from typing import Optional
import datetime
import decimal

from sqlalchemy import CheckConstraint, Date, DateTime, ForeignKeyConstraint, Integer, Numeric, PrimaryKeyConstraint, String, Text, UniqueConstraint, text
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship

class Base(DeclarativeBase):
    pass


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


class Fornecedor(Usuario):
    __tablename__ = 'fornecedor'
    __table_args__ = (
        ForeignKeyConstraint(['pk_usuario_id'], ['usuario.pk_usuario_id'], name='fornecedor_pk_usuario_id_fkey'),
        PrimaryKeyConstraint('pk_usuario_id', name='fornecedor_pkey')
    )

    pk_usuario_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    cnpj: Mapped[str] = mapped_column(String(255), nullable=False)
    razao_social: Mapped[str] = mapped_column(String(255), nullable=False)
    descricao: Mapped[Optional[str]] = mapped_column(Text)

    __mapper_args__ = {
        "polymorphic_identity": "fornecedor"
    }

    proposta: Mapped[list['Proposta']] = relationship('Proposta', back_populates='fornecedor')


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

    usuario: Mapped[Optional['Usuario']] = relationship('Usuario', back_populates='requisicao')
    item_requisicao: Mapped[list['ItemRequisicao']] = relationship('ItemRequisicao', back_populates='requisicao')
    proposta: Mapped[list['Proposta']] = relationship('Proposta', back_populates='requisicao')


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

    item_requisicao: Mapped['ItemRequisicao'] = relationship('ItemRequisicao', back_populates='item_proposta')
    proposta: Mapped['Proposta'] = relationship('Proposta', back_populates='item_proposta')


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

    usuario: Mapped[Optional['Usuario']] = relationship('Usuario', back_populates='pedido_compra')
    proposta: Mapped[Optional['Proposta']] = relationship('Proposta', back_populates='pedido_compra')
    info_fatura: Mapped[list['InfoFatura']] = relationship('InfoFatura', back_populates='pedido_compra')


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
'''