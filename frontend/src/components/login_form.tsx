import { useState } from "react";
import { useNavigate } from "react-router-dom";
import api from "../services/api";

export default function LoginForm() {
  const navigate = useNavigate();

  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [error, setError] = useState("");

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");

    try {
      const response = await api.post("/login", { email, senha });

      const usuarioData = response.data;
      console.log("Login: ", usuarioData);

      if (usuarioData) {
        localStorage.setItem("usuarioTipo", usuarioData.tipo);
        localStorage.setItem("usuarioId", usuarioData.pk_usuario_id);
        localStorage.setItem("usuarioEmail", usuarioData.email);
      }

      navigate("/portal");
    } catch (error: any) {
      console.error(error);
      if (error.response) {
        setError(error.response.data.detail || "Login falhou.");
      } else {
        setError("Sem conexão com o backend.");
      }
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-base-200">
      <fieldset className="fieldset bg-base-100 border-base-300 rounded-box w-full max-w-xs border p-6 shadow-lg">
        <form onSubmit={handleLogin}>
          <legend className="fieldset-legend text-center mb-2">Login</legend>

          {error && <p className="text-red-500 text-sm mb-2">{error}</p>}

          <label className="label">Email</label>
          <input
            type="email"
            className="input input-bordered w-full"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            placeholder="Email"
          />

          <label className="label mt-3">Password</label>
          <input
            type="password"
            className="input input-bordered w-full"
            value={senha}
            onChange={(e) => setSenha(e.target.value)}
            required
            placeholder="Password"
          />

          <button type="submit" className="btn btn-neutral w-full mt-4">
            Login
          </button>

          <div className="divider my-4">Ou</div>

          <button
            type="button"
            onClick={() => navigate("/cadastro-interno")}
            className="btn btn-primary w-full mb-2"
          >
            Cadastrar como Interno
          </button>

          <button
            type="button"
            onClick={() => navigate("/cadastro-externo")}
            className="btn btn-secondary w-full"
          >
            Cadastrar como Externo
          </button>
        </form>
      </fieldset>
    </div>
  );
}
