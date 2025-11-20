import { useState, useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import api from "../services/api";

interface ItemPropostaData {
  pk_item_requisicao: number;
  descricao: string;
  quantidade: number;
}

export default function CriarPropostaPage() {
  const navigate = useNavigate();
  const location = useLocation();

  const { selectedItems, requisicaoId } = location.state || {
    selectedItems: [],
    requisicaoId: 0,
  };

  const [descricao, setDescricao] = useState("");
  const [prazo, setPrazo] = useState("");
  const [prices, setPrices] = useState<{ [key: number]: number }>({});
  const [totalPrice, setTotalPrice] = useState(0);

  useEffect(() => {
    let total = 0;
    selectedItems.forEach((item: ItemPropostaData) => {
      const price = prices[item.pk_item_requisicao] || 0;
      total += price * item.quantidade;
    });
    setTotalPrice(total);
  }, [prices, selectedItems]);

  const handlePriceChange = (itemId: number, val: string) => {
    setPrices((prev) => ({ ...prev, [itemId]: Number(val) }));
  };

  const handleSubmit = async () => {
    const fornecedorId = localStorage.getItem("usuarioId");

    const payload = {
      descricao_proposta: descricao,
      preco_total: totalPrice,
      prazo_entrega: prazo
        ? new Date(prazo).toISOString()
        : new Date().toISOString(),
      status_proposta: "Pendente",
      item_proposta: selectedItems.map((item: ItemPropostaData) => ({
        pk_id_item: item.pk_item_requisicao,
        preco_individual: prices[item.pk_item_requisicao] || 0,
      })),
      fk_id_fornecedor: Number(fornecedorId),
      fk_id_requisicao: Number(requisicaoId),
    };

    try {
      await api.post("/propostas/", payload);
      alert("Proposta enviada com sucesso!");
      navigate("/portal");
    } catch (error: any) {
      console.error("Error:", error);
      alert("Erro ao enviar proposta.");
    }
  };

  if (!selectedItems || selectedItems.length === 0) {
    return (
      <div className="p-6">
        <p className="mb-4">Nenhum item selecionado.</p>
        <button onClick={() => navigate(-1)} className="btn btn-primary">
          Voltar e selecionar itens
        </button>
      </div>
    );
  }

  return (
    <div className="w-full p-6">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 items-start">
        <div className="md:col-span-2 space-y-6">
          <div className="card bg-base-100 shadow border border-base-300 p-6 rounded-xl">
            <h2 className="font-bold mb-4 text-lg">Detalhes da Proposta</h2>
            <textarea
              className="textarea textarea-bordered w-full mb-4"
              placeholder="Descrição da proposta..."
              value={descricao}
              onChange={(e) => setDescricao(e.target.value)}
            />
            <label className="label font-semibold">Prazo de Entrega</label>
            <input
              type="date"
              className="input input-bordered w-full"
              value={prazo}
              onChange={(e) => setPrazo(e.target.value)}
            />
          </div>

          <div className="card bg-base-100 shadow border border-base-300 p-6 rounded-xl">
            <h2 className="font-bold mb-4 text-lg">Definir Preços Unitários</h2>
            {selectedItems.map((item: ItemPropostaData) => (
              <div
                key={item.pk_item_requisicao}
                className="flex items-end gap-4 mb-4 border-b border-base-300 pb-4"
              >
                <div className="flex-1">
                  <label className="label font-bold text-base-content">
                    {item.descricao}
                  </label>
                  <span className="text-xs text-base-content/60">
                    | Quantidade solicitada: {item.quantidade}
                  </span>
                </div>
                <div className="w-32">
                  <label className="label text-xs font-semibold">
                    Preço Unitário (R$)
                  </label>
                  <input
                    type="number"
                    className="input input-bordered w-full"
                    placeholder="0.00"
                    onChange={(e) =>
                      handlePriceChange(item.pk_item_requisicao, e.target.value)
                    }
                  />
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="md:col-span-1 card bg-base-100 shadow border border-base-300 p-6 rounded-xl sticky top-4">
          <h2 className="text-xl font-bold mb-4 text-center">Resumo</h2>
          <ul className="space-y-2 text-sm mb-6">
            {selectedItems.map((item: ItemPropostaData) => {
              const price = prices[item.pk_item_requisicao] || 0;
              const subtotal = price * item.quantidade;

              return (
                <li
                  key={item.pk_item_requisicao}
                  className="flex justify-between border-b border-base-300 pb-2"
                >
                  <div className="flex flex-col">
                    <span>{item.descricao}</span>
                    <span className="text-xs text-base-content/60">
                      {item.quantidade} x R${price}
                    </span>
                  </div>
                  <span className="font-bold">R$ {subtotal.toFixed(2)}</span>
                </li>
              );
            })}
          </ul>

          <div className="text-lg font-bold text-right mb-6">
            Preço Total: R$ {totalPrice.toFixed(2)}
          </div>

          <button
            onClick={handleSubmit}
            className="btn btn-neutral w-full mb-2"
          >
            Finalizar Proposta
          </button>
          <button onClick={() => navigate(-1)} className="btn btn-ghost w-full">
            Cancelar
          </button>
        </div>
      </div>
    </div>
  );
}
