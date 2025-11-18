import { useState } from 'react';
import { useNavigate } from 'react-router-dom'; 
import api from '../services/api';

function FormRequisicao({titulo, setTitulo, descricao, setDescricao}: any){

    return(
        <>
<fieldset className="fieldset bg-base-200 border-base-300 rounded-box w-xs border p-4">
  <legend className="fieldset-legend">Dados da Requisição</legend>

  <label className="label">Título da Requisição</label>
  <input type="text" value={titulo} onChange={(e) => setTitulo(e.target.value)} className="input" placeholder="My awesome page" />

  <label className="label">Descrição Geral</label>
  <textarea className="input" value={descricao} onChange={(e) => setDescricao(e.target.value)} placeholder="my-awesome-page" />
</fieldset>
        </>
    )
}

function FormItem({onAddItem}: any){

    const [descItem, setDescItem] = useState('')
    const [quantidade, setQuantidade] = useState(0)

    const HandleAdd = (e: any) => {
        e.preventDefault()

        const newItem = {descricao: descItem, quantidade: Number(quantidade)}

        onAddItem(newItem)

        setDescItem('')
        setQuantidade(0)
    }

    return(
        <>
<fieldset className="fieldset bg-base-200 border-base-300 rounded-box w-xs border p-4">
  <legend className="fieldset-legend">Definir Itens</legend>

  <label className="label">Descrição Item</label>
  <input type="text" className="input" value={descItem} onChange={(e) => setDescItem(e.target.value)} placeholder="my-awesome-page" />

  <label className="label">Quantidade</label>
  <input type="number" className="input" value={quantidade} onChange={(e) => setQuantidade(Number(e.target.value))} placeholder="my-awesome-page" />

  <button className="btn btn-sm" onClick={HandleAdd}>Adicionar Item +</button>
</fieldset>
        </>
    )
}

function RequisicaoStatus({items}: any){
    return(
        <>
        <div className="card bg-base-100 shadow p-4">
       <h3 className="font-bold mb-2">Itens Adicionados: {items.length}</h3>
       <ul className="list-disc pl-5">
         {items.map((item: any, index: number) => (
           <li key={index}>
             {item.quantidade}x - {item.descricao}
           </li>
         ))}
       </ul>
    </div>
        </>
    )
}

export default function PedidoForm() {

    const navigate = useNavigate()

    const [titulo, setTitulo] = useState('');
    const [descricao, setDescricao] = useState('')
    const [items, setItems] = useState<any[]>([])

    const handleAddItem = (newItem: any) => {
        setItems([...items, newItem])
    };

    const handleFinalSubmit = async () => {
        const comprador_id = localStorage.getItem('usuarioId')

        const payload = {
            titulo_requisicao: titulo,
            descricao: descricao,
            item_requisicao: items,
            fk_id_comprador: comprador_id
        };

        console.log("Enviando: ", payload);

        try {
            await api.post('/requisicoes/', payload)
            alert("Requisição criada com sucesso.")
            navigate('/portal/pedidos')
        } catch (error) {
      console.error("Erro", error);
      alert("Erro ao criar");
    }
    };

    return(
        <>
        <FormRequisicao titulo={titulo} setTitulo={setTitulo} descricao={descricao} setDescricao={setDescricao}/>
        <FormItem onAddItem={handleAddItem}/>
        <RequisicaoStatus items={items}/>
        <button onClick={handleFinalSubmit} />
        </>
    )
}