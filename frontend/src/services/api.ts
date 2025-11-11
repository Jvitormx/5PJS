const BASE_URL = import.meta.env.VITE_API || 'http://localhost:8000';

export const getBackendTeste = async () => {
  try {
    const response = await fetch(`${BASE_URL}/fornecedores/`);
    
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    const data = await response.json();
    return data;

  } catch (error) {
    console.error("Failed to fetch from backend:", error);
    return { error: "Could not connect to backend." };
  }
};