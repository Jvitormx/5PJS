CREATE TABLE usuario (
    pk_usuario_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha_hash TEXT NOT NULL,
    tipo VARCHAR(50) NOT NULL CHECK (tipo IN ('administrador', 'comprador', 'gerente', 'fornecedor'))
);

CREATE TABLE fornecedor (
    pk_usuario_id INT PRIMARY KEY REFERENCES usuario(pk_usuario_id),
    cnpj VARCHAR(255) NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    descricao TEXT 
);

INSERT INTO usuario (email, senha_hash, tipo) VALUES ('admin@brsupply.com', '1234', 'administrador');

CREATE TABLE requisicao (
    pk_id_requisicao SERIAL PRIMARY KEY,
    data_requisicao TIMESTAMP NOT NULL DEFAULT NOW(),
    descricao TEXT NOT NULL,
    status VARCHAR(50) NOT NULL,
    fk_id_comprador INT REFERENCES usuario(pk_usuario_id)
);

CREATE TABLE item_requisicao (
    pk_item_requisicao SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    quantidade INT NOT NULL,
    fk_id_requisicao INT REFERENCES requisicao(pk_id_requisicao)
);

CREATE TABLE proposta (
    pk_id_proposta SERIAL PRIMARY KEY,
    preco_total DECIMAL(10,2) NOT NULL,
    prazo_entrega DATE NOT NULL,
    descricao_proposta TEXT,
    fk_id_fornecedor INT REFERENCES fornecedor(pk_usuario_id),
    fk_id_requisicao INT REFERENCES requisicao(pk_id_requisicao)
);

CREATE TABLE item_proposta (
    pk_id_item INT REFERENCES item_requisicao(pk_item_requisicao),
    pk_id_item_proposta INT REFERENCES proposta(pk_id_proposta),
    preco_individual DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(pk_id_item, pk_id_item_proposta)
);

CREATE TABLE pedido_compra (
    pk_id_pedido_compra SERIAL PRIMARY KEY,
    status VARCHAR(50) NOT NULL,
    data_assinatura TIMESTAMP NOT NULL DEFAULT NOW(),
    assinatura_hash VARCHAR(255) NOT NULL,
    info TEXT,
    fk_id_gerente INT REFERENCES usuario(pk_usuario_id),
    fk_id_proposta INT REFERENCES proposta(pk_id_proposta)
);

CREATE TABLE info_fatura (
    pk_id_fatura SERIAL PRIMARY KEY,
    data_emissao TIMESTAMP NOT NULL DEFAULT NOW(),
    valor DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    ref_arquivo_fatura VARCHAR(255),
    fk_id_pedido_compra INT REFERENCES pedido_compra(pk_id_pedido_compra)
);
