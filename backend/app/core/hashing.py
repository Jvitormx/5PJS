from passlib.context import CryptContext

bcrypt_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

class Hash():
    def hash_senha(senha: str) -> str:
        return bcrypt_context.hash(senha)
    
    def hash_verificar_senha(senha: str, senha_hash: str):
        return bcrypt_context.verify(senha, senha_hash)
    

    