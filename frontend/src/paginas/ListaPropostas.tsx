import { useEffect, useState } from "react";
import api from "../services/api";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";

interface Proposta {
  pk_id_proposta: number;
  titulo_requisicao: string;
  preco_total: number;
  status_proposta: string;
}

function Lista() {
  const [propostas, setPropostas] = useState<Proposta[]>([]);
  const [loading, setLoading] = useState(true);

  const usuarioId = localStorage.getItem("usuarioId");

  useEffect(() => {
    const fetchPedidos = async () => {
      try {
        const response = await api.get(
          `/propostas/listar-por-fornecedor/${usuarioId}`
        );
        setPropostas(response.data);
      } catch (error) {
        console.error("Erro ao buscar fornecedores", error);
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
            <th>Email</th>
            <th>Requisição</th>
            <th>Preço total</th>
            <th>Status Proposta</th>
            <th>Ação</th>
          </tr>
        </thead>
        <tbody>
          {propostas.map((proposta) => (
            <tr key={proposta.pk_id_proposta}>
              <th>{proposta.pk_id_proposta}</th>
              <th>{proposta.titulo_requisicao}</th>
              <td>{proposta.preco_total}</td>
              <td>{proposta.status_proposta}</td>
              <td>
                <Link to={`${proposta.pk_id_proposta}`} className="btn btn-sm">
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

export default function ListaPropostas() {
  return (
    <>
      <Lista />
    </>
  );
}
