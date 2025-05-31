-- Cria o schema no banco de dados
CREATE SCHEMA cap07 AUTHORIZATION "pgAdministrador";


-- Criação da tabela Clientes
CREATE TABLE cap07.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    tipo VARCHAR(20) CHECK (tipo IN ('pessoa física', 'pessoa jurídica')) NOT NULL
);


-- Criação da tabela Produtos
CREATE TABLE cap07.produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);


-- Criação da tabela Pedidos com Integridade Referencial
CREATE TABLE cap07.pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    data_pedido DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cap07.clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES cap07.produtos(id_produto)
);


-- Criação da tabela Pedidos sem Integridade Referencial
CREATE TABLE cap07.pedidos_sem_ir (
    id_pedido SERIAL PRIMARY KEY,
    id_produto INT,
    id_cliente INT,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    data_pedido DATE NOT NULL
);


-- Inserindo registros na tabela de clientes
INSERT INTO cap07.clientes (nome, sobrenome, estado, tipo) VALUES
('João', 'Silva', 'SP', 'pessoa física'),
('Maria', 'Oliveira', 'RJ', 'pessoa física'),
('Empresa A', 'Ltda', 'MG', 'pessoa jurídica'),
('Empresa B', 'S.A.', 'SP', 'pessoa jurídica'),
('Lucas', 'Pereira', 'RJ', 'pessoa física'),
('Ana', 'Mendes', 'MG', 'pessoa física'),
('Carla', 'Dias', 'SC', 'pessoa física'),
('Roberto', 'Almeida', 'MT', 'pessoa física'),
('Empresa C', 'Inc.', 'SP', 'pessoa jurídica'),
('Felipe', 'Costa', 'BA', 'pessoa física');


-- Inserindo registros na tabela de produtos
INSERT INTO cap07.produtos (nome, categoria, preco) VALUES
('Produto A', 'Categoria 1', 10.99),
('Produto B', 'Categoria 1', 5.50),
('Produto C', 'Categoria 2', 7.80),
('Produto D', 'Categoria 3', 8.90),
('Produto E', 'Categoria 2', 6.40),
('Produto F', 'Categoria 1', 9.60),
('Produto G', 'Categoria 3', 11.30),
('Produto H', 'Categoria 2', 4.70),
('Produto I', 'Categoria 3', 3.20),
('Produto J', 'Categoria 1', 12.10);


-- Inserindo registros na tabela de pedidos com integridade referencial
-- (Para simplificar, estou supondo que os IDs gerados para os clientes e produtos são sequenciais a partir de 1)
INSERT INTO cap07.pedidos (id_produto, id_cliente, quantidade, data_pedido) VALUES
(1, 1, 20, '2023-10-01'),
(1, 2, 12, '2023-10-02'),
(3, 2, 15, '2023-10-03'),
(4, 4, 44, '2023-10-04'),
(3, 1, 34, '2023-10-05'),
(3, 6, 16, '2023-10-06'),
(6, 7, 21, '2023-10-07'),
(8, 7, 42, '2023-10-08'),
(1, 9, 35, '2023-10-09'),
(9, 7, 59, '2023-10-10');


-- Inserindo registros na tabela de pedidos sem integridade referencial
INSERT INTO cap07.pedidos_sem_ir (id_produto, id_cliente, quantidade, data_pedido) VALUES
(1, 1, 20, '2023-10-01'),
(1, 2, 12, '2023-10-02'),
(null, null, 15, '2023-10-03'),
(4, 4, 44, '2023-10-04'),
(null, 1, 34, '2023-10-05'),
(3, null, 16, '2023-10-06'),
(6, 7, 21, '2023-10-07'),
(8, 7, 42, '2023-10-08'),
(123, 9, 35, '2023-10-09'),
(9, 7, 59, '2023-10-10');

-- Estrutura básica de junções

SELECT * FROM cap07.clientes
SELECT * FROM cap07.pedidos

SELECT nome, quantidade
FROM cap07.clientes, cap07.pedidos
WHERE cap07.clientes.id_cliente = cap07.pedidos.id_cliente;

SELECT nome, quantidade
FROM cap07.clientes
INNER JOIN cap07.pedidos ON cap07.clientes.id_cliente = cap07.pedidos.id_cliente;

SELECT id_cliente, id_cliente
FROM cap07.clientes
INNER JOIN cap07.pedidos ON cap07.clientes.id_cliente = cap07.pedidos.id_cliente;

SELECT c.nome, c.id_cliente, p.quantidade, p.id_cliente
FROM cap07.clientes c
INNER JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente;


-- Retorne id, nome e estado do cliente, id e quantidade do pedido de todos os clientes que fizeram pedido
-- Orderne pelo id do cliente
-- Por que usamos INNER JOIN?
SELECT c.id_cliente, c.nome, c.estado, p.quantidade, p.id_pedido
FROM cap07.clientes c
INNER JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;


-- Retorne id, nome e estado do cliente, id e quantidade do pedido de todos os clientes, 
-- independente de ter feito ou não pedido
-- Orderne pelo id do cliente
-- Por que usamos LEFT JOIN?
SELECT c.id_cliente, c.nome, c.estado, p.quantidade, p.id_pedido
FROM cap07.clientes c
LEFT JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;


-- Preenchendo o campo nulo na query anterior
SELECT 
    c.id_cliente, 
    c.nome, 
    c.estado, 
    CASE 
        WHEN p.quantidade IS NULL THEN 'sem pedido' 
        ELSE CAST(p.quantidade AS VARCHAR) 
    END AS quantidade,
    CASE 
        WHEN p.id_pedido IS NULL THEN 'sem pedido' 
        ELSE CAST(p.id_pedido AS VARCHAR) 
    END AS id_pedido
FROM cap07.clientes c
LEFT JOIN cap07.pedidos p ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;


-- O que aconteceu aqui?
SELECT c.id_cliente, c.nome, c.estado, p.quantidade, p.id_pedido
FROM cap07.pedidos p 
LEFT JOIN cap07.clientes c ON c.id_cliente = p.id_cliente
ORDER BY c.id_cliente;
