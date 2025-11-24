import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
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
}

interface Proposta {
  pk_id_proposta: number;
  fornecedor_nome: string;
  descricao_proposta: string;
  preco_total: number;
  prazo_entrega: string;
  escore: number;
}

function ItensDescricao({ pedidoDetalhe }: { pedidoDetalhe: Pedido }) {
  return (
    <div className="mb-5 p-4 border border-base-300 rounded-xl bg-base-100 shadow-sm">
      <h3 className="text-lg font-bold mb-2">
        Itens da Requisição ({pedidoDetalhe.item_requisicao.length})
      </h3>
      <ul className="space-y-1">
        {pedidoDetalhe.item_requisicao.map((item, index) => (
          <li key={index} className="text-sm">
            <strong>{item.descricao}</strong> — Quantidade: {item.quantidade}
          </li>
        ))}
      </ul>
    </div>
  );
}

function Propostas({ propostaSelecionar }: { propostaSelecionar: Proposta[] }) {
  const navigate = useNavigate();
  const [selectedPropostaId, setSelectedPropostaId] = useState<number | null>(
    null
  );

  const handleCheckboxChange = (id: number) => {
    setSelectedPropostaId((prev) => (prev === id ? null : id));
  };

  const handleSubmit = async () => {
    if (!selectedPropostaId) {
      alert("Selecione uma proposta para confirmar.");
      return;
    }

    try {
      const endpoint = `/propostasupdate/${selectedPropostaId}`;
      const payload = { status_proposta: "Selecionado" };

      await api.put(endpoint, payload);

      alert("Proposta Confirmada com Sucesso!");
      navigate("/portal/pedidos");
    } catch (error) {
      console.error("Erro ao confirmar proposta", error);
      alert("Falha na confirmação da proposta.");
    }
  };

  return (
    <div className="p-4 border border-base-300 rounded-xl bg-base-100 shadow-sm">
      <h3 className="text-lg font-bold mb-4">
        Confirmar Proposta (Selecione 1)
      </h3>

      {propostaSelecionar.length === 0 ? (
        <p className="text-sm">Nenhuma proposta recebida ainda.</p>
      ) : (
        <div className="flex flex-col gap-4">
          {propostaSelecionar.map((proposta) => (
            <div
              key={proposta.pk_id_proposta}
              className={`p-4 border rounded-xl bg-base-200 flex gap-4 items-start cursor-pointer transition-all hover:bg-base-300 ${
                selectedPropostaId === proposta.pk_id_proposta
                  ? "border-primary bg-primary/20"
                  : "border-base-300"
              }`}
              onClick={() => handleCheckboxChange(proposta.pk_id_proposta)}
            >
              <input
                type="checkbox"
                checked={selectedPropostaId === proposta.pk_id_proposta}
                onChange={() => handleCheckboxChange(proposta.pk_id_proposta)}
                className="checkbox checkbox-primary mt-1"
              />

              <div className="text-sm">
                <div className="font-semibold">{proposta.fornecedor_nome}</div>
                <div>Preço: R$ {proposta.preco_total.toFixed(2)}</div>
                <div>
                  Entrega:{" "}
                  {new Date(proposta.prazo_entrega).toLocaleDateString()}
                </div>
                <div>
                  Score: {proposta.escore ? proposta.escore.toFixed(1) : "N/A"}
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      <div className="mt-5">
        <button
          onClick={handleSubmit}
          disabled={!selectedPropostaId}
          className="btn btn-primary w-full"
        >
          Confirmar Proposta Selecionada
        </button>
      </div>
    </div>
  );
}

export default function PedidoDetalhes() {
  const { id: requisicao_id } = useParams() as { id: string };
  const navigate = useNavigate();

  const [pedido, setPedido] = useState<Pedido | undefined>(undefined);
  const [propostas, setPropostas] = useState<Proposta[]>([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const responseRequisicao = await api.get(
          `/requisicoes/requisicao/${requisicao_id}`
        );
        const pedidoData = responseRequisicao.data;
        setPedido(pedidoData);

        if (pedidoData && pedidoData.pk_id_requisicao) {
          try {
            const responsePropostas = await api.get(
              `/propostas/listar-por-requisicao/${pedidoData.pk_id_requisicao}`
            );
            setPropostas(responsePropostas.data);
          } catch (propError) {
            console.error("Erro ao buscar propostas:", propError);
          }
        }
      } catch (error) {
        console.error("Erro ao buscar detalhes:", error);
      }
    };

    if (requisicao_id) {
      fetchData();
    }
  }, [requisicao_id]);

  const fecharRequisicao = async () => {
    if (!pedido) return;

    try {
      await api.put(`/requisicoes/fechar/${pedido.pk_id_requisicao}`, {
        status: "Fechada",
      });

      alert("Requisição fechada com sucesso!");
      navigate("/portal/pedidos");
    } catch (error) {
      console.error("Erro ao fechar requisição:", error);
      alert("Falha ao fechar requisição.");
    }
  };

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

        <button
          onClick={fecharRequisicao}
          className="btn btn-error btn-outline mt-4 w-full"
        >
          Fechar Requisição
        </button>
      </div>

      <ItensDescricao pedidoDetalhe={pedido} />
      <Propostas propostaSelecionar={propostas} />
    </div>
  );
}
