from typing import Union
from fastapi import FastAPI
from app.routes import usuario_routes , login_route, fornecedor_routes, requisicao_routes, proposta_routes
app = FastAPI()

app.include_router(usuario_routes.router)
app.include_router(login_route.router)
app.include_router(fornecedor_routes.router)
app.include_router(requisicao_routes.router)
app.include_router(proposta_routes.router)

@app.get("/")
async def read_root():
    return {"teste":"Hello World"}