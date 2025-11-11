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

@router.post('/webhook', status_code=status.HTTP_200_OK)
def receber_webhook_pedido_compra(payload: dict, db: Session = Depends(get_db)):
    return {"mensagem": "Webhook processado com sucesso."}