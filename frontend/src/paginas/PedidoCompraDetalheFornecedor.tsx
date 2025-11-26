import { useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../services/api";

export default function PedidoCompraDetalheFornecedor() {
  const { id_pedido_compra } = useParams() as { id_pedido_compra: string };
  const navigate = useNavigate();

  const [valor, setValor] = useState("");
  const [pdfLink, setPdfLink] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async () => {
    if (!valor || !pdfLink) {
      alert("Preencha todos os campos!");
      return;
    }

    setLoading(true);

    const payload = {
      valor: Number(valor),
      status: "Pendente",
      ref_arquivo_fatura: pdfLink,
      fk_id_pedido_compra: Number(id_pedido_compra),
    };

    try {
      await api.post("/info_fatura/", payload);

      alert("Fatura enviada com sucesso!");
      navigate("/portal");
    } catch (error) {
      console.error("Erro ao criar fatura:", error);
      alert("Falha ao enviar a fatura.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-6 max-w-lg mx-auto">
      <div className="card bg-base-100 shadow-xl border border-base-300 p-6">
        <h2 className="text-xl font-bold mb-4">
          Enviar Fatura – Pedido #{id_pedido_compra}
        </h2>

        <div className="form-control mb-4">
          <label className="label">
            <span className="label-text">Valor da Fatura</span>
          </label>
          <input
            type="number"
            className="input input-bordered"
            placeholder="Ex: 1500.00"
            value={valor}
            onChange={(e) => setValor(e.target.value)}
          />
        </div>

        <div className="form-control mb-4">
          <label className="label">
            <span className="label-text">Link do PDF da Fatura</span>
          </label>
          <input
            type="text"
            className="input input-bordered"
            placeholder="https://meu-arquivo.com/fatura.pdf"
            value={pdfLink}
            onChange={(e) => setPdfLink(e.target.value)}
          />
        </div>

        <button
          onClick={handleSubmit}
          disabled={loading}
          className="btn btn-primary w-full"
        >
          {loading ? "Enviando..." : "Enviar Fatura"}
        </button>
      </div>
    </div>
  );
}
