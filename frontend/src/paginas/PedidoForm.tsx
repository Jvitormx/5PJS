import { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../services/api";

function FormRequisicao({ titulo, setTitulo, descricao, setDescricao }: any) {
  return (
    <div className="card bg-base-100 w-full shadow-sm border border-base-300 mb-4">
      <div className="card-body">
        <h2 className="card-title text-lg mb-2">Dados da Requisição</h2>

        <div className="form-control w-full">
          <label className="label">
            <span className="label-text font-semibold">
              Título da Requisição
            </span>
          </label>
          <input
            type="text"
            value={titulo}
            onChange={(e) => setTitulo(e.target.value)}
            className="input input-bordered w-full"
            placeholder="Ex: Compra de Periféricos"
          />
        </div>

        <div className="form-control w-full mt-2 flex flex-col">
          <label className="label">
            <span className="label-text font-semibold">Descrição Geral</span>
          </label>
          <textarea
            className="textarea textarea-bordered h-24"
            value={descricao}
            onChange={(e) => setDescricao(e.target.value)}
            placeholder="Descreva o motivo da requisição..."
          ></textarea>
        </div>
      </div>
    </div>
  );
}

function FormItem({ onAddItem }: any) {
  const [descItem, setDescItem] = useState("");
  const [quantidade, setQuantidade] = useState(0);

  const HandleAdd = (e: any) => {
    e.preventDefault();

    const newItem = { descricao: descItem, quantidade: Number(quantidade) };

    onAddItem(newItem);

    setDescItem("");
    setQuantidade(0);
  };

  return (
    <div className="card bg-base-100 w-full shadow-sm border border-base-300 mb-4">
      <div className="card-body">
        <h2 className="card-title text-lg mb-2">Definir Itens</h2>

        <div className="flex flex-col md:flex-row gap-4">
          <div className="form-control w-full md:w-3/4">
            <label className="label">
              <span className="label-text">Descrição do Item</span>
            </label>
            <input
              type="text"
              className="input input-bordered w-full"
              value={descItem}
              onChange={(e) => setDescItem(e.target.value)}
              placeholder="Ex: Teclado Mecânico"
            />
          </div>

          <div className="form-control w-full md:w-1/4">
            <label className="label">
              <span className="label-text">Quantidade</span>
            </label>
            <input
              type="number"
              className="input input-bordered w-full"
              value={quantidade}
              onChange={(e) => setQuantidade(Number(e.target.value))}
              placeholder="0"
            />
          </div>
        </div>

        <div className="card-actions justify-end mt-4">
          <button className="btn btn-secondary btn-sm" onClick={HandleAdd}>
            Adicionar Item +
          </button>
        </div>
      </div>
    </div>
  );
}

function RequisicaoStatus({ items }: any) {
  return (
    <div className="card bg-base-200 w-full shadow-inner mb-6">
      <div className="card-body p-4">
        <h3 className="font-bold text-sm uppercase opacity-70 mb-2">
          Itens Adicionados: {items.length}
        </h3>
        {items.length > 0 ? (
          <div className="overflow-x-auto rounded-lg border border-base-300">
            <table className="table table-sm bg-base-100 w-full">
              <thead>
                <tr className="bg-base-200">
                  <th className="w-24">Qtd</th>
                  <th>Descrição</th>
                </tr>
              </thead>
              <tbody>
                {items.map((item: any, index: number) => (
                  <tr key={index} className="hover:bg-base-200/50">
                    <td className="font-bold">{item.quantidade}</td>
                    <td>{item.descricao}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : (
          <p className="text-sm text-base-content/60 italic">
            Nenhum item adicionado.
          </p>
        )}
      </div>
    </div>
  );
}

export default function PedidoForm() {
  const navigate = useNavigate();

  const [titulo, setTitulo] = useState("");
  const [descricao, setDescricao] = useState("");
  const [items, setItems] = useState<any[]>([]);

  const handleAddItem = (newItem: any) => {
    setItems([...items, newItem]);
  };

  const handleFinalSubmit = async () => {
    const comprador_id = localStorage.getItem("usuarioId");

    const payload = {
      titulo_requisicao: titulo,
      descricao: descricao,
      item_requisicao: items,
      fk_id_comprador: Number(comprador_id),
    };

    console.log("Enviando: ", payload);

    try {
      await api.post("/requisicoes/", payload);
      alert("Requisição criada com sucesso.");
      navigate("/portal/pedidos");
    } catch (error) {
      console.error("Erro", error);
      alert("Erro ao criar");
    }
  };

  return (
    <div className="container mx-auto max-w-3xl p-6">
      <h1 className="text-3xl font-bold mb-6">Nova Requisição</h1>

      <FormRequisicao
        titulo={titulo}
        setTitulo={setTitulo}
        descricao={descricao}
        setDescricao={setDescricao}
      />

      <FormItem onAddItem={handleAddItem} />

      <RequisicaoStatus items={items} />

      <div className="flex justify-end">
        <button
          onClick={handleFinalSubmit}
          className="btn btn-primary btn-wide"
        >
          Confirmar Pedido
        </button>
      </div>
    </div>
  );
}
