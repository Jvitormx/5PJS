import { useState } from 'react';
import { useNavigate } from 'react-router-dom'; 
import api from '../services/api';

export default function LoginForm() {

  const navigate = useNavigate();

  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [error, setError] = useState('');

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');

  try {
    const response = await api.post('/login', {email, senha});

    const usuarioData = response.data;
    console.log("Login: ", usuarioData)

    if(usuarioData) {
    localStorage.setItem('usuarioTipo', usuarioData.tipo); 
    localStorage.setItem('usuarioId', usuarioData.pk_usuario_id);
    localStorage.setItem('usuarioEmail', usuarioData.email);
    }
  
    navigate('/portal');
    
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
<fieldset className="fieldset bg-base-200 border-base-300 rounded-box w-xs border p-4">
  <form onSubmit={handleLogin}>
  <legend className="fieldset-legend">Login</legend>

  {error && <p className="text-red-500 text-sm mb-2">{error}</p>}

  <label className="label">Email</label>
  <input type="email" className="input" value={email} onChange={(e) => setEmail(e.target.value)} required placeholder="Email" />

  <label className="label">Password</label>
  <input type="password" className="input" value={senha} onChange={(e) => setSenha(e.target.value)} required placeholder="Password" />

  <button type="submit" className="btn btn-neutral mt-4">Login</button>
  </form>
</fieldset>
    )
}