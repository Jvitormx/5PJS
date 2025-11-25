import { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../services/api";

export default function CadastroExterno() {
  const navigate = useNavigate();

  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [tipo, setTipo] = useState("comprador");
  const [loading, setLoading] = useState(false);
  const [erro, setErro] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErro("");
    setLoading(true);

    try {
      const payload = {
        email,
        senha_hash: senha,
        tipo,
      };

      await api.post("/usuarios/", payload);

      navigate("/");
    } catch (error) {
      console.error(error);
      setErro("Erro ao criar usuário.");
    }

    setLoading(false);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-base-200 p-4">
      <form
        onSubmit={handleSubmit}
        className="bg-base-100 shadow-xl rounded-xl p-8 w-full max-w-md"
      >
        <h1 className="text-2xl font-semibold mb-6 text-center">
          Cadastro Externo
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

        <label className="form-control w-full mb-6">
          <span className="label-text font-medium">Tipo de Usuário</span>
          <select
            value={tipo}
            onChange={(e) => setTipo(e.target.value)}
            className="select select-bordered w-full"
          >
            <option value="comprador">comprador</option>
            <option value="gerente">gerente</option>
          </select>
        </label>

        {erro && (
          <p className="text-red-500 text-sm mb-4 text-center">{erro}</p>
        )}

        <button
          type="submit"
          disabled={loading}
          className="btn btn-primary w-full"
        >
          {loading ? "Cadastrando..." : "Cadastrar"}
        </button>
      </form>
    </div>
  );
}
