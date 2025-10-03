# Procurement Module - Gerenciamento de processos de aquisição de bens e serviços

Este projeto é um sistema de gerenciamento de requisições, propostas, pedidos de compra e faturas, desenvolvido como parte da disciplina de Projetos de Sistema (5PJS).  
A stack foi escolhida para unir tecnologias modernas de frontend e backend, além de banco de dados robusto.

---

## Tecnologias Utilizadas

- **Frontend:** [Vite](https://vitejs.dev/) + [React](https://react.dev/) + [TailwindCSS](https://tailwindcss.com/)
- **Backend:** [FastAPI](https://fastapi.tiangolo.com/) (Python)
- **Banco de Dados:** [PostgreSQL](https://www.postgresql.org/)
- **Gerenciador do Banco:** [pgAdmin4](https://www.pgadmin.org/)
- **Containerização:** [Docker](https://www.docker.com/) + [Docker Compose](https://docs.docker.com/compose/)

---

## Estrutura do Projeto
frontend/ # Código do frontend (Vite + React)
backend/ # Código do backend (FastAPI + Python)
db/ # Scripts SQL para inicialização do banco
docker-compose.yml
README.md

---

## Como Rodar o Projeto

### 1. Clonar o repositório
```bash
git clone https://github.com/seu-usuario/seu-repo.git
cd seu-repo
```

### 2. Criar arquiv .env
Crie um arquivo .env na raiz com as variáveis de ambiente:

```bash
POSTGRES_USER=usuario
POSTGRES_PASSWORD=1234
POSTGRES_DB=db_5pjs
DATABASE_URL=postgresql+psycopg2://usuario:1234@db:5432/db_5pjs
PGADMIN_DEFAULT_EMAIL=admin@admin.com
PGADMIN_DEFAULT_PASSWORD=admin
```

### 3. Subir os containers
```bash
docker-compose up --build
```

### 4. Acessar os serviços
Frontend (React + Vite): http://localhost:5173
Backend (FastAPI): http://localhost:8000/docs
Banco (Postgres): localhost:5432
PgAdmin: http://localhost:5050



