import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API || 'http://localhost:8000',
});

api.interceptors.request.use((config) => {
  const userId = localStorage.getItem('usuarioId');
  
  if (userId) {
    config.headers['x-user-id'] = userId; 
  }
  
  return config;
});

export default api;