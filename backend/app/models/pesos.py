class Pesos:
    def __init__(self):
        self.peso_preco = 0.6
        self.peso_qualidade = 0.6

    def set_peso_preco(self, peso_preco: float):
        self.peso_preco = peso_preco

    def set_peso_qualidade(self, peso_qualidade: float):
        self.peso_qualidade = peso_qualidade

    def get_peso_preco(self) -> float:
        return self.peso_preco
    
    def get_peso_qualidade(self) -> float:
        return self.peso_qualidade
