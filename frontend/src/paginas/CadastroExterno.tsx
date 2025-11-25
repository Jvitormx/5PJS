import { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../services/api";

export default function CadastroExterno() {
  const navigate = useNavigate();

  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [cnpj, setCnpj] = useState("");
  const [razaoSocial, setRazaoSocial] = useState("");
  const [descricao, setDescricao] = useState("");

  const [erro, setErro] = useState("");
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setErro("");
    setLoading(true);

    const payload = {
      email,
      senha_hash: senha,
      tipo: "fornecedor",
      cnpj,
      razao_social: razaoSocial,
      descricao,
      nota_qualidade: 0.6,
    };

    try {
      await api.post("/fornecedores/", payload);
      alert("Fornecedor cadastrado com sucesso!");
      navigate("/");
    } catch (error) {
      console.error(error);
      setErro("Erro ao cadastrar fornecedor.");
    }

    setLoading(false);
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-base-200 p-4">
      <form
        onSubmit={handleSubmit}
        className="bg-base-100 shadow-xl rounded-xl p-8 w-full max-w-md"
      >
        <h1 className="text-2xl font-semibold mb-6 text-center">
          Cadastro de Fornecedor
        </h1>

        <label className="form-control w-full mb-4">
          <span className="label-text font-medium">Email</span>
          <input
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="input input-bordered w-full"
          />
        </label>

        <label className="form-control w-full mb-4">
          <span className="label-text font-medium">Senha</span>
          <input
            type="password"
            required
            value={senha}
            onChange={(e) => setSenha(e.target.value)}
            className="input input-bordered w-full"
          />
        </label>

        <label className="form-control w-full mb-4">
          <span className="label-text font-medium">CNPJ</span>
          <input
            type="text"
            required
            value={cnpj}
            onChange={(e) => setCnpj(e.target.value)}
            className="input input-bordered w-full"
            placeholder="00.000.000/0000-00"
          />
        </label>

        <label className="form-control w-full mb-4">
          <span className="label-text font-medium">Razão Social</span>
          <input
            type="text"
            required
            value={razaoSocial}
            onChange={(e) => setRazaoSocial(e.target.value)}
            className="input input-bordered w-full"
            placeholder="Nome da empresa"
          />
        </label>

        <label className="form-control w-full mb-6">
          <span className="label-text font-medium">Descrição</span>
          <textarea
            className="textarea textarea-bordered h-24"
            value={descricao}
            onChange={(e) => setDescricao(e.target.value)}
            placeholder="Fale brevemente sobre o fornecedor..."
          />
        </label>

        {erro && (
          <p className="text-red-500 text-sm mb-4 text-center">{erro}</p>
        )}

        <button
          type="submit"
          disabled={loading}
          className="btn btn-primary w-full"
        >
          {loading ? "Cadastrando..." : "Cadastrar Fornecedor"}
        </button>
      </form>
    </div>
  );
}
