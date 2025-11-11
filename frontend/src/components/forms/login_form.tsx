function LoginForm() {

    return (
        <>
<fieldset className="fieldset bg-base-200 border-base-300 rounded-box w-xs border p-4">
  <legend className="fieldset-legend">Login</legend>

  <label className="label">Email</label>
  <input type="email" className="input" placeholder="Digite seu email" />

  <label className="label">Senha</label>
  <input type="password" className="input" placeholder="Digite sua senha" />

  <button className="btn btn-neutral mt-4">Login</button>
</fieldset>
        </>
    )
}

export default LoginForm