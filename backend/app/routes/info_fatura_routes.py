from typing import List
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from starlette import status
from app.schemas.info_fatura_schema import CreateInfoFatura, InfoFaturaGet
from fastapi import APIRouter
from app.database.connection import get_db
from app.services import info_fatura_service

router = APIRouter(prefix='/info_fatura', tags=['Info Fatura'])

@router.post('/', status_code=status.HTTP_201_CREATED)
def criar_info_fatura(info_fatura: CreateInfoFatura, db: Session = Depends(get_db)):
    nova_info_fatura = info_fatura_service.create_info_fatura(info_fatura = info_fatura, db = db)
    return nova_info_fatura

@router.get('/{id_pedido_compra}', response_model=InfoFaturaGet)
def retornar_info_fatura(id_pedido_compra: int, db: Session = Depends(get_db)):
    info_fatura = info_fatura_service.get_info_fatura(id_pedido_compra = id_pedido_compra, db = db)
    return info_fatura