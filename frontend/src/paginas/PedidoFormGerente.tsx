import { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import api from "../services/api";

interface ItemRequisicao {
  descricao: string;
  quantidade: number;
}

interface Pedido {
  titulo_requisicao: string;
  descricao: string;
  status: string;
  item_requisicao: ItemRequisicao[];
  pk_id_requisicao: number;
  data_requisicao: string;
  pk_id_proposta: number;
  fornecedor_nome: string;
  preco_total: number;
  prazo_entrega: string;
}

function ItensDescricao({ pedidoDetalhe }: { pedidoDetalhe: Pedido }) {
  return (
    <div className="mb-5 p-4 border border-base-300 rounded-xl bg-base-100 shadow-sm">
      <h3 className="text-lg font-bold mb-2">
        Itens da Requisição ({pedidoDetalhe.item_requisicao.length})
      </h3>

      <ul className="space-y-1 text-sm">
        {pedidoDetalhe.item_requisicao.map((item, index) => (
          <li key={index}>
            <strong>{item.descricao}</strong> — Quantidade: {item.quantidade}
          </li>
        ))}
      </ul>
    </div>
  );
}

function PropostaDescricao({ pedidoDetalhe }: { pedidoDetalhe: Pedido }) {
  const [loading, setLoading] = useState(false);

  const rejeitarProposta = async () => {
    const confirmacao = confirm(
      "Tem certeza que deseja rejeitar esta proposta?"
    );
    if (!confirmacao) return;

    try {
      setLoading(true);

      await api.put(
        `/propostas/rejeitar/${pedidoDetalhe.pk_id_proposta}?status=Rejeitada`
      );

      alert("Proposta rejeitada com sucesso!");

      window.location.reload();
    } catch (error) {
      console.error("Erro ao rejeitar proposta:", error);
      alert("Erro ao rejeitar proposta.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="mb-5 p-4 border border-base-300 rounded-xl bg-base-100 shadow-sm">
      <h3 className="text-lg font-bold mb-2">Proposta Selecionada</h3>

      <ul className="space-y-2 text-sm">
        <li className="border-b border-base-300 pb-2">
          {pedidoDetalhe.pk_id_proposta} | {pedidoDetalhe.fornecedor_nome} | R${" "}
          {pedidoDetalhe.preco_total.toFixed(2)} |{" "}
          {new Date(pedidoDetalhe.prazo_entrega).toLocaleDateString()}
        </li>

        <li className="flex gap-3">
          <Link
            to={`assinatura/${pedidoDetalhe.pk_id_proposta}`}
            state={{ nome_fornecedor: pedidoDetalhe.fornecedor_nome }}
            className="btn btn-primary"
          >
            Continuar
          </Link>

          <button
            onClick={rejeitarProposta}
            className="btn btn-error"
            disabled={loading}
          >
            {loading ? "Rejeitando..." : "Rejeitar Proposta"}
          </button>
        </li>
      </ul>
    </div>
  );
}

export default function PedidoFormGerente() {
  const { id: requisicao_id } = useParams() as { id: string };
  const [pedido, setPedido] = useState<Pedido | undefined>(undefined);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const responseRequisicao = await api.get(
          `/requisicoes/requisicao-gerente/${requisicao_id}`
        );
        const pedidoData = responseRequisicao.data;
        setPedido(pedidoData);
      } catch (error) {
        console.error("Erro ao buscar detalhes:", error);
      }
    };

    if (requisicao_id) fetchData();
  }, [requisicao_id]);

  if (!pedido) {
    return <p className="p-6 text-center">Carregando detalhes do pedido...</p>;
  }

  return (
    <div className="p-6 max-w-3xl mx-auto">
      <div className="mb-6 p-4 border border-base-300 bg-base-100 rounded-xl shadow-sm">
        <h1 className="text-2xl font-bold mb-1">
          Detalhes do Pedido #{pedido.pk_id_requisicao}
        </h1>

        <p className="text-sm text-base-content/80">
          {pedido.titulo_requisicao}
        </p>

        <p className="text-sm text-base-content/70 mt-1">
          {pedido.status} | {pedido.data_requisicao}
        </p>

        <p className="mt-2 text-sm">{pedido.descricao}</p>
      </div>

      <ItensDescricao pedidoDetalhe={pedido} />
      <PropostaDescricao pedidoDetalhe={pedido} />
    </div>
  );
}
