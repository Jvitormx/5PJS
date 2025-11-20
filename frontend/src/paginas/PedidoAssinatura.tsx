import { useState, useEffect } from "react";
import { useParams, useLocation } from "react-router-dom";
import api from "../services/api";

interface Proposta {
  descricao_proposta: string;
  preco_total: number;
  prazo_entrega: string;
  status_proposta: string;
  item_proposta: ItemProposta[];
  pk_id_proposta: number;
  requisicao_nome: string;
  fornecedor_nome: string;
}

interface ItemProposta {
  preco_individual: number;
  item_requisicao: ItemRequisicao;
}

interface ItemRequisicao {
  descricao: string;
  quantidade: number;
}

function ItensPropostaDescricao({
  propostaDetalhe,
}: {
  propostaDetalhe: Proposta;
}) {
  return (
    <div className="mb-6 p-4 border border-base-300 rounded-xl bg-base-100 shadow-sm">
      <h3 className="text-lg font-semibold mb-3">
        Proposta para ({propostaDetalhe.item_proposta.length}) itens
      </h3>

      <ul className="space-y-2">
        {propostaDetalhe.item_proposta.map((item, index) => (
          <li
            key={index}
            className="p-3 rounded-lg bg-base-200 text-base-content"
          >
            {item.item_requisicao.descricao} | {item.item_requisicao.quantidade}{" "}
            | R$ {item.preco_individual}
          </li>
        ))}
      </ul>
    </div>
  );
}

function FinalizarPedidoCompra() {
  const { id_proposta } = useParams() as { id_proposta: string };

  const [signatureSlug, setSignatureSlug] = useState<string>("");
  const [loading, setLoading] = useState(false);

  const handleGenerateAndSave = async () => {
    setLoading(true);

    const idGerente = localStorage.getItem("usuarioId");

    if (!idGerente || !id_proposta) {
      alert("Erro: IDs de Gerente ou Proposta faltando.");
      setLoading(false);
      return;
    }

    const now = new Date().toISOString();

    const bodyPayload = {
      status: "Pendente",
      data_assinatura: now,
      info: "Assinatura DocuSeal iniciada via sistema",
      esign_id: "PENDING",
      fk_id_gerente: Number(idGerente),
      fk_id_proposta: Number(id_proposta),
    };

    try {
      const response = await api.post("/pedido_compra/", bodyPayload, {
        params: {
          id_gerente: idGerente,
          id_proposta: id_proposta,
        },
      });

      if (response.data && response.data.slug) {
        setSignatureSlug(response.data.slug);
      } else {
        console.error("Backend did not return slug.");
        alert("Erro: O sistema de assinatura não retornou o link (slug).");
      }
    } catch (error) {
      console.error("Erro:", error);
      alert("Falha ao gerar o Pedido de Compra.");
    } finally {
      setLoading(false);
    }
  };

  if (signatureSlug) {
    return (
      <div className="p-6 min-h-screen w-full">
        <h2 className="text-2xl font-bold mb-4">Assinar Documento</h2>
        <button
          className="btn"
          onClick={() =>
            window.open(`http://localhost:3000/s/${signatureSlug}`, "_blank")
          }
        >
          Acessar contrato
        </button>
      </div>
    );
  }

  return (
    <div className="p-6 flex flex-col items-center justify-center">
      <div className="card bg-base-100 shadow-xl border border-base-200 p-8 max-w-md w-full text-center">
        <h2 className="text-2xl font-bold mb-4">Gerar Pedido de Compra</h2>

        <p className="text-base-content/70 mb-6">
          Confirme para salvar o pedido e iniciar o processo de assinatura
          eletrônica.
        </p>

        <button
          onClick={handleGenerateAndSave}
          className="btn btn-primary w-full"
          disabled={loading}
        >
          {loading ? "Processando..." : "Gerar e Assinar"}
        </button>
      </div>
    </div>
  );
}

export default function PedidoAssinatura() {
  const [proposta, setProposta] = useState<Proposta | undefined>(undefined);

  const { id_proposta } = useParams();
  const location = useLocation();
  const { nome_fornecedor } = location.state || { nome_fornecedor: "" };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const responseProposta = await api.get(
          `/propostas/proposta/${id_proposta}`,
          {
            params: {
              nome_fornecedor: nome_fornecedor,
            },
          }
        );

        setProposta(responseProposta.data);
      } catch (error) {
        console.error("Erro ao buscar detalhes:", error);
      }
    };

    if (id_proposta) fetchData();
  }, [id_proposta, nome_fornecedor]);

  if (!proposta) {
    return (
      <p className="p-6 text-base-content/70 animate-pulse">
        Carregando detalhes do pedido...
      </p>
    );
  }

  return (
    <div className="p-6 max-w-4xl mx-auto">
      <div className="mb-6 card bg-base-100 shadow-md border border-base-300 p-6">
        <h1 className="text-2xl font-bold mb-2">
          Detalhes da Proposta #{proposta.pk_id_proposta}
        </h1>

        <p className="text-base-content/70">
          {proposta.fornecedor_nome} | {proposta.status_proposta}
        </p>

        <p className="mt-2 font-medium">
          R$ {proposta.preco_total} — Entrega: {proposta.prazo_entrega}
        </p>

        <p className="mt-2">{proposta.descricao_proposta}</p>
      </div>

      <ItensPropostaDescricao propostaDetalhe={proposta} />

      <FinalizarPedidoCompra />
    </div>
  );
}
