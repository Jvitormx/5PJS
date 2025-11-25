from app.schemas.fornecedor_schema import FornecedorGet, CreateFornecedor, UpdateFornecedor, Fornecedor_Atribuir_Nota
from app.models import Fornecedor, Usuario
from typing import List
from app.core.hashing import Hash
from sqlalchemy.orm import Session
from fastapi import HTTPException, Depends

def create_fornecedor(fornecedor: CreateFornecedor, db: Session) -> FornecedorGet:
    senha_pos_hash = Hash.hash_senha(fornecedor.senha_hash)

    novo_usuario = Fornecedor(
        email = fornecedor.email,
        senha_hash = senha_pos_hash,
        tipo = fornecedor.tipo,
        cnpj = fornecedor.cnpj,
        razao_social = fornecedor.razao_social,
        nota_qualidade = fornecedor.nota_qualidade,
        descricao = fornecedor.descricao
    )

    db.add(novo_usuario)
    db.commit()
    db.refresh(novo_usuario)

    return novo_usuario

def update_fornecedor(fornecedor: UpdateFornecedor, id: int, db: Session) -> UpdateFornecedor:
    usuario_update = db.query(Fornecedor).filter(Fornecedor.pk_usuario_id == id).first()
    if not usuario_update:
        return None

    update_data = usuario_update.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(usuario_update, key, value)

    db.commit()
    db.refresh(usuario_update)
    usuario_update.update(fornecedor.model_dump(), synchronize_session=False)
    db.commit()

    return usuario_update.first()

def atrubuir_nota_fornecedor(fornecedor: Fornecedor_Atribuir_Nota, id_fornecedor: int, db: Session) -> FornecedorGet:
    fornecedor_nova_nota = db.query(Fornecedor).filter(Fornecedor.pk_usuario_id == id_fornecedor).first()

    if not fornecedor_nova_nota:
        return None

    fornecedor_nova_nota.nota_qualidade = fornecedor.nota_qualidade

    db.commit()
    db.refresh(fornecedor_nova_nota)

    return fornecedor_nova_nota

def retornar_fornecedores(db: Session) -> List[FornecedorGet]:
    usuarios = db.query(Usuario).join(Fornecedor).all()
    return usuarios
