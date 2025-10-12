from typing import Union
from fastapi import FastAPI
from app.routes import usuario_routes , login_route
app = FastAPI()

app.include_router(usuario_routes.router)
app.include_router(login_route.router)

@app.get("/")
async def read_root():
    return {"message":"Hello World"}

@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message":f"Hello {name}"}