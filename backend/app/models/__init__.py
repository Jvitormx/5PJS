# /app/models/__init__.py

# Import the base class first
from .usuario import Usuario

from .fornecedor import Fornecedor
from .tipos import Administrador_Tipo, Comprador_Tipo, Gerente_Tipo, Fornecedor_Tipo

from .requisicao import Requisicao
from .item_requisicao import ItemRequisicao
from .proposta import Proposta
from .item_proposta import ItemProposta
from .pedido_compra import PedidoCompra
from .info_fatura import InfoFatura
