import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../services/api";

interface Fatura {
  data_emissao: string;
  valor: number;
  status: string;
  ref_arquivo_fatura: string;
  pk_id_fatura: number;
}

export default function PedidoCompraDetalhe() {
  const { id: pedido_compra_id } = useParams() as { id: string };
  const navigate = useNavigate();

  const [fatura, setFatura] = useState<Fatura | undefined>(undefined);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const responseFatura = await api.get(
          `/info_fatura/${pedido_compra_id}`
        );
        setFatura(responseFatura.data);
      } catch (error) {
        console.error("Erro ao buscar fatura:", error);
      }
    };

    fetchData();
  }, [pedido_compra_id]);

  const confirmarFatura = async () => {
    if (!fatura) return;

    setLoading(true);
    try {
      await api.put(`/fatura_update/${fatura.pk_id_fatura}`, {
        status: "Confirmado",
      });
      alert("Fatura confirmada com sucesso.");
      navigate("/portal/pedidos");
    } catch (error) {
      console.error("Erro ao confirmar fatura:", error);
      alert("Falha ao confirmar a fatura.");
    } finally {
      setLoading(false);
    }
  };

  const recusarFatura = async () => {
    if (!fatura) return;

    setLoading(true);
    try {
      await api.put(`/fatura_update/${fatura.pk_id_fatura}`, {
        status: "Recusado",
      });
      alert("Fatura marcada como recusada.");
      navigate("/portal/pedidos");
    } catch (error) {
      console.error("Erro ao recusar fatura:", error);
      alert("Falha ao recusar a fatura.");
    } finally {
      setLoading(false);
    }
  };

  if (!fatura) {
    return (
      <p className="p-6 text-center text-base-content/70 animate-pulse">
        Carregando detalhes da fatura...
      </p>
    );
  }

  return (
    <div className="p-6 max-w-xl mx-auto">
      <div className="card bg-base-100 shadow-lg border border-base-300 p-6">
        <h1 className="text-xl font-bold mb-2">
          Fatura #{fatura.pk_id_fatura}
        </h1>

        <p className="text-base-content/70 text-sm">
          Emissão: {fatura.data_emissao}
        </p>
        <p className="text-base-content/70 text-sm">
          Status atual: {fatura.status}
        </p>

        <p className="mt-3 font-semibold">
          Valor: R$ {fatura.valor.toFixed(2)}
        </p>

        <a
          href={fatura.ref_arquivo_fatura}
          target="_blank"
          rel="noopener noreferrer"
          className="btn btn-outline btn-primary mt-6 w-full"
        >
          Visualizar Fatura (PDF)
        </a>

        <div className="mt-6 flex gap-3">
          <button
            className="btn btn-primary w-full"
            onClick={confirmarFatura}
            disabled={loading}
          >
            {loading ? "Processando..." : "Confirmar Pagamento"}
          </button>

          <button
            className="btn btn-error w-full"
            onClick={recusarFatura}
            disabled={loading}
          >
            {loading ? "Aguarde..." : "Recusar"}
          </button>
        </div>
      </div>
    </div>
  );
}
