-- Cria o schema
CREATE SCHEMA lab4 AUTHORIZATION "pgAdministrador";

-- Cria as tabelas:

CREATE TABLE lab4.clientes (
    Id_Cliente UUID PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE lab4.produtos (
    Id_Produto UUID PRIMARY KEY,
    nome VARCHAR(255),
    preco DECIMAL
);

CREATE TABLE lab4.vendas (
    Id_Vendas UUID PRIMARY KEY,
    Id_Cliente UUID REFERENCES cap17.clientes(Id_Cliente),
    Id_Produto UUID REFERENCES cap17.produtos(Id_Produto),
    Quantidade INTEGER,
    Data_Venda DATE
);