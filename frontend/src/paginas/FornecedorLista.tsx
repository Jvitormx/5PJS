import { useEffect, useState } from "react";
import api from "../services/api";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";

interface Fornecedor {
  pk_usuario_id: number;
  email: string;
  tipo: string;
  cnpj: string;
  razao_social: string;
  nota_qualidade: number;
  descricao: string;
}

function Lista() {
  const [fornecedores, setFornecedores] = useState<Fornecedor[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchPedidos = async () => {
      try {
        const response = await api.get("/fornecedores/listar-fornecedores");
        setFornecedores(response.data);
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
            <th>Cnpj</th>
            <th>Razão Social</th>
            <th>Nota de qualidade</th>
            <th>Descrição</th>
            <th>Ação</th>
          </tr>
        </thead>
        <tbody>
          {fornecedores.map((fornecedor) => (
            <tr key={fornecedor.pk_usuario_id}>
              <th>{fornecedor.pk_usuario_id}</th>
              <th>{fornecedor.email}</th>
              <td>{fornecedor.cnpj}</td>
              <td>{fornecedor.razao_social}</td>
              <td>{fornecedor.nota_qualidade}</td>
              <td>{fornecedor.descricao}</td>
              <td>
                <Link to={`${fornecedor.pk_usuario_id}`} className="btn btn-sm">
                  Atribuir nota
                </Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default function FornecedorLista() {
  return (
    <>
      <Lista />
    </>
  );
}
