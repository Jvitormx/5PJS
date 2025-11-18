import { Routes, Route } from 'react-router-dom';
import Login from './paginas/Login';
import DashboardLayout from './paginas/DashboardLayout'; 
import PedidoList from './paginas/PedidoLista'; 
import PedidoForm from './paginas/PedidoForm';
//import PedidoDetalhe from './paginas/PedidoDetalhes'; 

import './App.css';

function App() {
  return (
    <Routes>
     <Route path="/" element={<Login />} />
     
     <Route path="/portal" element={<DashboardLayout />}>
        
        <Route path="pedidos" element={<PedidoList />} />
        
        <Route path="pedidos/novo" element={<PedidoForm />} />
        
        {/*<Route path="pedidos/:id" element={<PedidoDetail />} />*/}

        <Route index element={<div className="p-4">Bem vindo ao Sistema</div>} />
      </Route>
    </Routes>
  );
}

export default App;