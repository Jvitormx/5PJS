import { Routes, Route } from "react-router-dom";
import Login from "./paginas/Login";
import DashboardLayout from "./paginas/DashboardLayout";
import PedidoList from "./paginas/PedidoLista";
import PedidoForm from "./paginas/PedidoForm";
import PedidoDetalhes from "./paginas/PedidoDetalhes";
import PedidoFormFornecedor from "./paginas/PedidoFormFornecedor";
import PedidoLista from "./paginas/PedidoListaFornecedor";
import CriarPropostaPage from "./paginas/CriarProposta";
import PedidoListaGerente from "./paginas/PedidoListaGerente";
import PedidoFormGerente from "./paginas/PedidoFormGerente";
import PedidoAssinatura from "./paginas/PedidoAssinatura";

import "./App.css";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Login />} />

      <Route path="/portal" element={<DashboardLayout />}>
        <Route path="pedidos" element={<PedidoList />} />

        <Route path="pedidos/novo" element={<PedidoForm />} />

        <Route path="pedidos/:id" element={<PedidoDetalhes />} />

        <Route path="pedidos_fornecedor" element={<PedidoLista />} />

        <Route
          path="pedidos_fornecedor/:id"
          element={<PedidoFormFornecedor />}
        />

        <Route
          path="pedidos_fornecedor/:id/criar_proposta"
          element={<CriarPropostaPage />}
        />

        <Route path="pedidos_gerente" element={<PedidoListaGerente />} />

        <Route path="pedidos_gerente/:id" element={<PedidoFormGerente />} />

        <Route
          path="pedidos_gerente/:id_requisicao/assinatura/:id_proposta"
          element={<PedidoAssinatura />}
        />

        <Route
          index
          element={
            <div className="p-4">
              Bem vindo ao Módulo de Aquisição da BrasilSupply
            </div>
          }
        />
      </Route>
    </Routes>
  );
}

export default App;
