import { useEffect, useState } from "react";
import api from "../services/api";
import { Link } from "react-router-dom";

interface PedidoCompra {
  pk_id_pedido_compra: number;
  status: string;
  data_assinatura: string;
  info: string;
  esign_id: string;
  titulo_requisicao: string;
  razao_social: string;
  preco_total: number;
}

function Lista() {
  const [pedidosCompra, setPedidos] = useState<PedidoCompra[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchPedidos = async () => {
      try {
        const response = await api.get("/pedido_compra/pedido_compra_gerente");
        setPedidos(response.data);
      } catch (error) {
        console.error("Erro ao buscar pedidos compra", error);
      } finally {
        setLoading(false);
      }
    };

    fetchPedidos();
  }, []);

  if (loading) return <p>Carregando. . .</p>;

  return (
    <div className="overflow-x-auto">
      <table className="table">
        <thead>
          <tr>
            <th>ID</th>
            <th>Data de assinatura</th>
            <th>ID de assinatura</th>
            <th>Requisicao</th>
            <th>Fornecedor</th>
            <th>Preço Total</th>
            <th>Status</th>
            <th>Ação</th>
          </tr>
        </thead>
        <tbody>
          {pedidosCompra.map((pedido) => (
            <tr key={pedido.pk_id_pedido_compra}>
              <th>{pedido.pk_id_pedido_compra}</th>
              <th>{pedido.data_assinatura}</th>
              <td>{pedido.esign_id}</td>
              <td>{pedido.titulo_requisicao}</td>
              <td>{pedido.razao_social}</td>
              <td>{pedido.preco_total}</td>
              <td>{pedido.status}</td>
              <td>
                <Link
                  to={`${pedido.pk_id_pedido_compra}`}
                  className="btn btn-sm"
                >
                  Acessar
                </Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default function PedidoCompraLista() {
  return (
    <>
      <Lista />
    </>
  );
}
