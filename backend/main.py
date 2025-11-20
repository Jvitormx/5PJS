from typing import Union
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import usuario_routes , login_route, fornecedor_routes, requisicao_routes, proposta_routes, pedido_compra_routes, info_fatura_routes
app = FastAPI()

origins = [
    "http://localhost:5173",    
    "http://127.0.0.1:5173",    
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,      
    allow_credentials=True,
    allow_methods=["*"],       
    allow_headers=["*"],       
)

app.include_router(usuario_routes.router)
app.include_router(login_route.router)
app.include_router(fornecedor_routes.router)
app.include_router(requisicao_routes.router)
app.include_router(proposta_routes.router)
app.include_router(pedido_compra_routes.router)
app.include_router(info_fatura_routes.router)

@app.get("/")
async def read_root():
    return {"teste":"Hello World"}