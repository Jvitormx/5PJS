import { useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import api from "../services/api";

export default function FornecedorNota() {
  const { id } = useParams();
  const navigate = useNavigate();

  const [nota, setNota] = useState("");
  const [erro, setErro] = useState("");
  const [sucesso, setSucesso] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: any) => {
    e.preventDefault();

    if (!id) {
      setErro("ID inválido.");
      return;
    }

    setErro("");
    setSucesso("");
    setLoading(true);

    try {
      const resposta = await api.put(`/fornecedores/atribuir_nota/${id}`, {
        nota_qualidade: Number(nota),
      });

      if (resposta.status === 200) {
        setSucesso("Nota atribuída com sucesso!");
        setTimeout(() => navigate("/portal/fornecedores"), 1200);
      }
    } catch (error: any) {
      console.error(error);

      if (error.response?.data?.detail) {
        setErro(error.response.data.detail);
      } else {
        setErro("Erro ao conectar ao servidor.");
      }
    }

    setLoading(false);
  };

  return (
    <div className="container mx-auto max-w-xl p-6">
      <h1 className="text-3xl font-bold mb-6">Atribuir Nota</h1>

      <form
        onSubmit={handleSubmit}
        className="card bg-base-100 w-full shadow-md border border-base-300"
      >
        <div className="card-body">
          <h2 className="card-title text-lg mb-2">Informações do Fornecedor</h2>

          <div className="form-control w-full mb-4">
            <label className="label">
              <span className="label-text font-semibold">ID do Fornecedor</span>
            </label>
            <input
              type="text"
              disabled
              value={id}
              className="input input-bordered w-full bg-base-200 cursor-not-allowed"
            />
          </div>

          <div className="form-control w-full">
            <label className="label">
              <span className="label-text font-semibold">
                Nota de Qualidade (0.1 a 0.9)
              </span>
            </label>
            <input
              type="number"
              step="0.1"
              min="0.1"
              max="0.9"
              required
              value={nota}
              onChange={(e) => setNota(e.target.value)}
              className="input input-bordered w-full"
              placeholder="Ex: 0.5"
            />
          </div>

          {erro && (
            <p className="text-red-500 text-sm text-center mt-3">{erro}</p>
          )}
          {sucesso && (
            <p className="text-green-500 text-sm text-center mt-3">{sucesso}</p>
          )}

          <div className="card-actions justify-end mt-6">
            <button
              type="submit"
              className="btn btn-primary"
              disabled={loading}
            >
              {loading ? "Enviando..." : "Confirmar Nota"}
            </button>
          </div>
        </div>
      </form>
    </div>
  );
}
