import { useEffect, useState } from "react";
import api from "../services/api";
import { Link } from "react-router-dom";

interface Pedido {
  pk_id_requisicao: number;
  data_requisicao: string;
  titulo_requisicao: string;
  status: string;
}

function Lista() {
  const [pedidos, setPedidos] = useState<Pedido[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchPedidos = async () => {
      try {
        const response = await api.get("/requisicoes/listar_fornecedor");
        setPedidos(response.data);
      } catch (error) {
        console.error("Erro ao buscar pedidos", error);
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
            <th>Data de requisição</th>
            <th>Título</th>
            <th>Status</th>
            <th>Ação</th>
          </tr>
        </thead>
        <tbody>
          {pedidos.map((pedido) => (
            <tr key={pedido.pk_id_requisicao}>
              <th>{pedido.pk_id_requisicao}</th>
              <td>{pedido.data_requisicao}</td>
              <td>{pedido.titulo_requisicao}</td>
              <td>{pedido.status}</td>
              <td>
                <Link to={`${pedido.pk_id_requisicao}`} className="btn btn-sm">
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

export default function PedidoLista() {
  return (
    <>
      <Lista />
    </>
  );
}
