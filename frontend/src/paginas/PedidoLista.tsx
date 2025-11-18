import { useEffect, useState } from 'react'
import api from '../services/api';
import { useNavigate } from 'react-router-dom';

interface Pedido {
  pk_id_requisicao: number;
  data_requisicao: string;
  titulo_requisicao: string;
  status: string;
}

function Lista(){

    const [pedidos, setPedidos] = useState<Pedido[]>([])
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        const fetchPedidos = async () => {
            try {
                const comprador_id = localStorage.getItem('usuarioId');

                const response = await api.get(`/requisicoes/listar/${comprador_id}`);
                setPedidos(response.data);
            } catch (error) {
                console.error("Erro ao buscar pedidos", error);
            } finally {
                setLoading(false);
            }
        };

        fetchPedidos();
    }, []);

    if (loading) return <p>Carregando. . .</p>

    return(
  <div className="overflow-x-auto">
  <table className="table">
    {/* head */}
    <thead>
      <tr>
        <th>ID</th>
        <th>Data de requisição</th>
        <th>Título</th>
        <th>Status</th>
        <th>Ação</th>
      </tr>
    </thead>
    <tbody>
        {pedidos.map(pedido => (
      <tr key={pedido.pk_id_requisicao}>
        <th>{pedido.pk_id_requisicao}</th>
        <td>{pedido.data_requisicao}</td>
        <td>{pedido.titulo_requisicao}</td>
        <td>{pedido.status}</td>
        <td></td>
      </tr>
        ))}
    </tbody>
  </table>
</div>
    )
}


function BotaoCriarPA(){
  const navigate = useNavigate()
    return(
        <button className="btn btn-wide" onClick={() => navigate('novo')}>Criar Pedido de Aquisição</button>
    )
}

export default function PedidoLista(){

    return(
        <>
        <BotaoCriarPA />
        <Lista />
        </>
    )
}