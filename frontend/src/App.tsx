import { Routes, Route } from 'react-router-dom';
import Login from './paginas/login';
import Teste from './paginas/teste';
import './App.css';

function App() {

  return (
    <Routes>
     <Route path="/" element={<Login />} />
     <Route path="/teste" element={<Teste />} />
    </Routes>
  );
}

export default App;