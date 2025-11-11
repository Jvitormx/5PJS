import { useState, useEffect } from 'react';
import { getBackendTeste } from '../services/api';
import LoginForm from '../components/forms/login_form';

function PagLogin() {
    const [mensagemTeste, setTeste] = useState({});

  useEffect(() => {
    const fetchData = async () => {
      const data = await getBackendTeste();
      setTeste(data);
    };

    fetchData(); 
  }, []); 


  console.log(mensagemTeste); 
    return (
        <>
            <LoginForm />
        </>
    )
}

export default PagLogin