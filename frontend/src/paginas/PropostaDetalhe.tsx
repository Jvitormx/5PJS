import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../services/api";

interface ItemProposta {
  preco_individual: number;
  item_requisicao: {
    descricao: string;
    quantidade: number;
  };
}

interface PropostaDetalheData {
  descricao_proposta: string;
  preco_total: number;
  prazo_entrega: string;
  status_proposta: string;
  item_proposta: ItemProposta[];
  pk_id_proposta: number;
  requisicao_nome: string;
  fornecedor_nome: string;
}

export default function PropostaDetalhe() {
  const { id: proposta_id } = useParams() as { id: string };
  const navigate = useNavigate();

  const [proposta, setProposta] = useState<PropostaDetalheData | null>(null);

  useEffect(() => {
    const fetchProposta = async () => {
      try {
        const response = await api.get(
          `/propostas/proposta/${proposta_id}?nome_fornecedor=`
        );
        setProposta(response.data);
      } catch (error) {
        console.error("Erro ao buscar proposta:", error);
      }
    };

    if (proposta_id) fetchProposta();
  }, [proposta_id]);

  const retirarProposta = async () => {
    try {
      await api.put(`/propostas/retirar/${proposta_id}?status=Retirada`);
      alert("Proposta retirada com sucesso!");
      navigate(-1);
    } catch (error) {
      console.error("Erro ao retirar proposta:", error);
      alert("Falha ao retirar proposta.");
    }
  };

  if (!proposta) {
    return (
      <p className="p-6 text-center">Carregando detalhes da proposta...</p>
    );
  }

  return (
    <div className="p-6 max-w-3xl mx-auto">
      <div className="mb-6 p-4 border border-base-300 bg-base-100 rounded-xl shadow-sm">
        <h1 className="text-2xl font-bold mb-1">
          Proposta #{proposta.pk_id_proposta}
        </h1>
        <p className="text-sm text-base-content/80">
          Fornecedor: {proposta.fornecedor_nome}
        </p>
        <p className="text-sm text-base-content/70 mt-1">
          Requisição: {proposta.requisicao_nome}
        </p>
        <p className="mt-2 text-sm">{proposta.descricao_proposta}</p>
        <p className="mt-2 text-sm">Status: {proposta.status_proposta}</p>
        <p className="mt-2 text-sm">
          Preço Total: R$ {proposta.preco_total.toFixed(2)}
        </p>
        <p className="mt-2 text-sm">
          Prazo de Entrega:{" "}
          {new Date(proposta.prazo_entrega).toLocaleDateString()}
        </p>

        <button
          onClick={retirarProposta}
          className="btn btn-warning btn-outline mt-4 w-full"
        >
          Retirar Proposta
        </button>
      </div>

      <div className="mb-5 p-4 border border-base-300 rounded-xl bg-base-100 shadow-sm">
        <h3 className="text-lg font-bold mb-3">Itens da Proposta</h3>
        <ul className="space-y-2">
          {proposta.item_proposta.map((item, index) => (
            <li
              key={index}
              className="p-3 bg-base-200 rounded-lg border border-base-300"
            >
              <div className="font-semibold">
                {item.item_requisicao.descricao} (x
                {item.item_requisicao.quantidade})
              </div>
              <div className="text-sm">
                Preço Unitário: R$ {item.preco_individual.toFixed(2)}
              </div>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
