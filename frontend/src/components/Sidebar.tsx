import { Link, useNavigate } from 'react-router-dom';

export default function Sidebar() {
  const navigate = useNavigate();
  
  const usuarioTipo = localStorage.getItem('usuarioTipo'); 
  const usuarioNome = localStorage.getItem('usuarioEmail') || 'Usuário';

  const handleLogout = () => {
    localStorage.clear(); 
    navigate('/')
  };

  return (
    <div className="flex h-screen flex-col justify-between border-e border-gray-100 bg-white w-64">
      <div className="px-4 py-6">
        <span className="grid h-10 w-32 place-content-center rounded-lg bg-gray-100 text-xs text-gray-600 font-bold">
          BrasilSupply
        </span>

        <ul className="mt-6 space-y-1">
          
          <li>
            <Link
              to="/portal"
              className="block rounded-lg bg-gray-100 px-4 py-2 text-sm font-medium text-gray-700"
            >
              Portal
            </Link>
          </li>

          {usuarioTipo === 'comprador' && (
            <li>
              <details className="group [&_summary::-webkit-details-marker]:hidden" open>
                <summary className="flex cursor-pointer items-center justify-between rounded-lg px-4 py-2 text-gray-500 hover:bg-gray-100 hover:text-gray-700">
                  <span className="text-sm font-medium"> Compras </span>
                  <span className="shrink-0 transition duration-300 group-open:-rotate-180">
                    <svg xmlns="http://www.w3.org/2000/svg" className="size-5" viewBox="0 0 20 20" fill="currentColor">
                      <path fillRule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clipRule="evenodd" />
                    </svg>
                  </span>
                </summary>

                <ul className="mt-2 space-y-1 px-4">
                  <li>
                    <Link
                      to="/portal/pedidos"
                      className="block rounded-lg px-4 py-2 text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-700"
                    >
                      Meus Pedidos de Aquisição (PAs)
                    </Link>
                  </li>
                  <li>
                    <Link
                      to="/portal/fornecedores"
                      className="block rounded-lg px-4 py-2 text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-700"
                    >
                      Fornecedores
                    </Link>
                  </li>
                </ul>
              </details>
            </li>
          )}

          {usuarioTipo === 'fornecedor' && (
            <li>
               <Link
                to="/portal/propostas"
                className="block rounded-lg px-4 py-2 text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-700"
              >
                Minhas Propostas
              </Link>
            </li>
          )}

          <li>
            <details className="group [&_summary::-webkit-details-marker]:hidden">
              <summary className="flex cursor-pointer items-center justify-between rounded-lg px-4 py-2 text-gray-500 hover:bg-gray-100 hover:text-gray-700">
                <span className="text-sm font-medium"> Account </span>
                <span className="shrink-0 transition duration-300 group-open:-rotate-180">
                  <svg xmlns="http://www.w3.org/2000/svg" className="size-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fillRule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clipRule="evenodd" />
                  </svg>
                </span>
              </summary>
              <ul className="mt-2 space-y-1 px-4">
                <li>
                  <button
                    onClick={handleLogout}
                    className="w-full rounded-lg px-4 py-2 text-left text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-700"
                  >
                    Logout
                  </button>
                </li>
              </ul>
            </details>
          </li>
        </ul>
      </div>

      <div className="sticky inset-x-0 bottom-0 border-t border-gray-100">
        <div className="flex items-center gap-2 bg-white p-4 hover:bg-gray-50">
          <div>
            <p className="text-xs">
              <strong className="block font-medium">{usuarioNome}</strong>
              <span className="capitalize"> {usuarioTipo} </span>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}