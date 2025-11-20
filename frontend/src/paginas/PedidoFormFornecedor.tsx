import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../services/api";

interface ItemRequisicao {
  pk_item_requisicao: number;
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

export default function PedidoFormFornecedor() {
  const navigate = useNavigate();
  const { id: requisicao_id } = useParams() as { id: string };

  const [pedido, setPedido] = useState<Pedido | undefined>(undefined);
  const [selectedItemIds, setSelectedItemIds] = useState<number[]>([]);

  useEffect(() => {
    const fetchPedido = async () => {
      try {
        const response = await api.get(
          `/requisicoes/requisicao/${requisicao_id}`
        );
        setPedido(response.data);
      } catch (error) {
        console.error("Erro:", error);
      }
    };
    if (requisicao_id) fetchPedido();
  }, [requisicao_id]);

  const handleToggleItem = (id: number) => {
    if (selectedItemIds.includes(id)) {
      setSelectedItemIds(selectedItemIds.filter((itemId) => itemId !== id));
    } else {
      setSelectedItemIds([...selectedItemIds, id]);
    }
  };

  const handleNextStep = () => {
    const selectedItemsData = pedido?.item_requisicao.filter((item) =>
      selectedItemIds.includes(item.pk_item_requisicao)
    );

    navigate("criar_proposta", {
      state: {
        selectedItems: selectedItemsData,
        requisicaoId: pedido?.pk_id_requisicao,
      },
    });
  };

  if (!pedido) return <p>Carregando...</p>;

  return (
    <div className="p-6 max-w-2xl mx-auto">
      <h1 className="text-2xl font-bold mb-2">{pedido.titulo_requisicao}</h1>
      <p className="text-base-content/70 mb-6">{pedido.descricao}</p>

      <div className="card bg-base-100 shadow-md border border-base-300 rounded-xl">
        <div className="card-body">
          <h2 className="card-title text-sm mb-4">
            Seleção de Itens para Proposta
          </h2>

          <div className="overflow-x-auto rounded-lg border border-base-300">
            <table className="table">
              <thead className="bg-base-200">
                <tr>
                  <th>Selecionar</th>
                  <th>Descrição</th>
                  <th>Quantidade Solicitada</th>
                </tr>
              </thead>

              <tbody>
                {pedido.item_requisicao.map((item, index) => (
                  <tr key={index} className="hover:bg-base-200 transition">
                    <td>
                      <input
                        type="checkbox"
                        className="checkbox checkbox-primary"
                        checked={selectedItemIds.includes(
                          item.pk_item_requisicao
                        )}
                        onChange={() =>
                          handleToggleItem(item.pk_item_requisicao)
                        }
                      />
                    </td>
                    <td className="font-medium">{item.descricao}</td>
                    <td>{item.quantidade}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          <div className="card-actions justify-end mt-4">
            <button
              className="btn btn-primary"
              disabled={selectedItemIds.length === 0}
              onClick={handleNextStep}
            >
              Criar Proposta ({selectedItemIds.length})
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
