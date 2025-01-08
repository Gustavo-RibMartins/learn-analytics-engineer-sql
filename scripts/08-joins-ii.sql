-- Cria o schema no banco de dados
CREATE SCHEMA cap08 AUTHORIZATION "pgAdministrador";


-- Criação da tabela Clientes
CREATE TABLE cap08.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    tipo VARCHAR(20) CHECK (tipo IN ('pessoa física', 'pessoa jurídica')) NOT NULL
);


-- Criação da tabela Produtos
CREATE TABLE cap08.produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);


-- Criação da tabela Pedidos com Integridade Referencial
CREATE TABLE cap08.pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    data_pedido DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cap08.clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES cap08.produtos(id_produto)
);


-- Criação da tabela Pedidos sem Integridade Referencial
CREATE TABLE cap08.pedidos_sem_ir (
    id_pedido SERIAL PRIMARY KEY,
    id_produto INT,
    id_cliente INT,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    data_pedido DATE NOT NULL
);


-- Inserindo registros na tabela de clientes
INSERT INTO cap08.clientes (nome, sobrenome, estado, tipo) VALUES
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
INSERT INTO cap08.produtos (nome, categoria, preco) VALUES
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
INSERT INTO cap08.pedidos (id_produto, id_cliente, quantidade, data_pedido) VALUES
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
INSERT INTO cap08.pedidos_sem_ir (id_produto, id_cliente, quantidade, data_pedido) VALUES
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

-- Quais produtos não têm pedido associado?
-- Retorne id do produto, nome do produto, preço do produto, id do cliente associado ao pedido, quantidade e id do pedido
-- Ordene por nome do produto
SELECT pr.id_produto, pr.nome, pr.preco, p.id_cliente, p.quantidade, p.id_pedido
FROM cap08.pedidos p
RIGHT JOIN cap08.produtos pr ON pr.id_produto = p.id_produto
ORDER BY pr.nome;


-- Mostre somente os produtos sem pedido associado.
SELECT pr.id_produto, pr.nome, pr.preco, p.id_cliente, p.quantidade, p.id_pedido
FROM cap08.pedidos p
RIGHT JOIN cap08.produtos pr ON pr.id_produto = p.id_produto
WHERE p.id_pedido IS NULL
ORDER BY pr.nome;


-- Sem modificar a ordem das tabelas retorne somente os produtos que tiveram pedido.
SELECT pr.id_produto, pr.nome, pr.preco, p.id_cliente, p.quantidade, p.id_pedido
FROM cap08.pedidos p
RIGHT JOIN cap08.produtos pr ON pr.id_produto = p.id_produto
WHERE p.id_pedido IS NOT NULL
ORDER BY pr.nome;


SELECT pr.id_produto, pr.nome, pr.preco, p.id_cliente, p.quantidade, p.id_pedido
FROM cap08.pedidos p
LEFT JOIN cap08.produtos pr ON pr.id_produto = p.id_produto
ORDER BY pr.nome;


-- Observe o que acontece sem integridade referencial:

-- Retorne todos os pedidos com ou sem produto associado
-- Retorne id do produto, nome do produto, preço do produto, id do cliente associado ao pedido, quantidade e id do pedido
-- Ordene por nome do produto


-- Resposta com tabelas onde a IR foi implementada
SELECT pr.id_produto, pr.nome, pr.preco, p.id_cliente, p.quantidade, p.id_pedido
FROM cap08.produtos pr
RIGHT JOIN cap08.pedidos p ON pr.id_produto = p.id_produto
ORDER BY pr.nome;


-- Resposta com tabelas onde a IR NÃO foi implementada
SELECT pr.id_produto, pr.nome, pr.preco, p.id_cliente, p.quantidade, p.id_pedido
FROM cap08.produtos pr
RIGHT JOIN cap08.pedidos_sem_ir p ON pr.id_produto = p.id_produto
ORDER BY pr.nome;


-- FULL JOIN
-- Retorna todos os registros havendo ou não correspondência entre as tabelas

SELECT * 
FROM cap08.produtos pr
FULL JOIN cap08.pedidos p ON pr.id_produto = p.id_produto;

SELECT * 
FROM cap08.produtos pr
FULL OUTER JOIN cap08.pedidos p ON pr.id_produto = p.id_produto;


-- CROSS JOIN
-- Produto cartesiano, ou seja, retorna todas as combinações possíveis entre as tabelas
SELECT * 
FROM cap08.produtos pr
CROSS JOIN cap08.pedidos p;


-- SELF JOIN
-- Queremos listar os pares de pedidos feitos pelo mesmo cliente.
-- Ou seja, queremos todas as combinações de 2 pedidos diferentes para cada cliente.

SELECT * 
FROM cap08.pedidos
ORDER BY id_cliente; 

SELECT p1.id_pedido AS Pedido1_ID, p2.id_pedido AS Pedido2_ID, p1.id_cliente 
FROM cap08.pedidos p1
JOIN cap08.pedidos p2 
ON p1.id_cliente = p2.id_cliente;

SELECT p1.id_pedido AS Pedido1_ID, p2.id_pedido AS Pedido2_ID, p1.id_cliente 
FROM cap08.pedidos p1
JOIN cap08.pedidos p2 
ON p1.id_cliente = p2.id_cliente AND p1.id_pedido != p2.id_pedido;

SELECT p1.id_pedido AS Pedido1_ID, p2.id_pedido AS Pedido2_ID, p1.id_cliente 
FROM cap08.pedidos p1
JOIN cap08.pedidos p2 
ON p1.id_cliente = p2.id_cliente AND p1.id_pedido < p2.id_pedido;

-- Cria a tabela
CREATE TABLE cap08.estudantes_ensino_medio (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);


-- Insere registros na tabela
INSERT INTO cap08.estudantes_ensino_medio (nome) VALUES ('Alice');
INSERT INTO cap08.estudantes_ensino_medio (nome) VALUES ('Bob');
INSERT INTO cap08.estudantes_ensino_medio (nome) VALUES ('Carla');


-- Cria a tabela
CREATE TABLE cap08.estudantes_universidade  (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    especialidade VARCHAR(255) NOT NULL
);


-- Insere registros na tabela
INSERT INTO cap08.estudantes_universidade (nome, especialidade) VALUES ('Bob', 'Direito');
INSERT INTO cap08.estudantes_universidade (nome, especialidade) VALUES ('Maria', 'Medicina');
INSERT INTO cap08.estudantes_universidade (nome, especialidade) VALUES ('José', 'Engenharia');


-- UNION: Este operador é usado para combinar os resultados de duas ou mais consultas SELECT em um único conjunto de resultados. 
-- Ele elimina duplicatas por padrão.
-- Se queremos obter uma lista de todos os estudantes, sem repetições:
SELECT nome FROM cap08.estudantes_ensino_medio
UNION
SELECT nome FROM cap08.estudantes_universidade;


-- UNION ALL: Semelhante ao UNION, ele combina os resultados de duas ou mais consultas SELECT em um único conjunto de resultados. 
-- No entanto, ele não remove duplicatas.
-- Se quisermos obter uma lista de todos os estudantes, incluindo repetições:
SELECT nome FROM cap08.estudantes_ensino_medio
UNION ALL
SELECT nome FROM cap08.estudantes_universidade;


-- E o que fazer quando não há correspondência de colunas?
SELECT nome, 'Não se aplica' AS especilidade FROM cap08.estudantes_ensino_medio
UNION ALL
SELECT nome, especialidade FROM cap08.estudantes_universidade;

-- A cláusula ON especifica a condição de junção entre duas tabelas.
SELECT p.id_pedido, c.nome AS nome_cliente, pr.nome AS nome_produto, p.quantidade, p.data_pedido
FROM cap08.pedidos p
JOIN cap08.clientes c ON p.id_cliente = c.id_cliente
JOIN cap08.produtos pr ON p.id_produto = pr.id_produto;


-- A cláusula ON pode ser usada normalmente com outras cláusulas SQL
SELECT pr.nome AS nome_produto, ps.quantidade
FROM cap08.pedidos ps
LEFT JOIN cap08.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN cap08.produtos pr ON ps.id_produto = pr.id_produto
ORDER BY nome_produto;


-- A integridade referencial é ainda mais importante na junção de múltiplas tabelas
SELECT c.nome AS nome_cliente, pr.nome AS nome_produto, ps.quantidade
FROM cap08.pedidos ps
LEFT JOIN cap08.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN cap08.produtos pr ON ps.id_produto = pr.id_produto
ORDER BY nome_produto;


-- A integridade referencial é ainda mais importante na junção de múltiplas tabelas
SELECT c.nome AS nome_cliente, pr.nome AS nome_produto, ps.quantidade
FROM cap08.pedidos_sem_ir ps
LEFT JOIN cap08.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN cap08.produtos pr ON ps.id_produto = pr.id_produto
ORDER BY nome_produto;


-- Podemos usar filtros condicionais na junção de múltiplas tabelas
SELECT pr.nome AS nome_produto, ps.quantidade
FROM cap08.pedidos ps
LEFT JOIN cap08.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN cap08.produtos pr ON ps.id_produto = pr.id_produto
WHERE pr.nome IN ('Produto D', 'Produto H')
ORDER BY nome_produto;


-- Podemos usar agregações na junção de múltiplas tabelas
SELECT pr.nome AS nome_produto, ROUND(AVG(ps.quantidade), 2) AS media_quantidade
FROM cap08.pedidos ps
LEFT JOIN cap08.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN cap08.produtos pr ON ps.id_produto = pr.id_produto
WHERE pr.nome IN ('Produto D', 'Produto H')
GROUP BY nome_produto
ORDER BY nome_produto;

SELECT pr.nome AS nome_produto, ROUND(AVG(ps.quantidade), 2) AS media_quantidade
FROM cap08.pedidos ps
LEFT JOIN cap08.clientes c ON ps.id_cliente = c.id_cliente
LEFT JOIN cap08.produtos pr ON ps.id_produto = pr.id_produto
WHERE pr.nome IN ('Produto D', 'Produto H')
GROUP BY nome_produto
HAVING ROUND(AVG(ps.quantidade), 2) > 42
ORDER BY nome_produto;


-- A cláusula ON especifica a condição de junção entre duas tabelas.
SELECT p.id_pedido, c.nome AS nome_cliente, pr.nome AS nome_produto, p.quantidade, p.data_pedido
FROM cap08.pedidos p
JOIN cap08.clientes c ON p.id_cliente = c.id_cliente
JOIN cap08.produtos pr ON p.id_produto = pr.id_produto;


-- A cláusula USING é útil quando as colunas de junção em ambas as tabelas têm o mesmo nome. 
-- Ela simplifica a sintaxe ao evitar que você tenha que especificar a tabela para cada coluna.
SELECT p.id_pedido, cli.nome AS nome_cliente, prod.nome AS nome_produto, p.quantidade, p.data_pedido
FROM cap08.pedidos p
JOIN cap08.clientes cli USING (id_cliente)
JOIN cap08.produtos prod USING (id_produto);


-- Também podemos empregar USING com outras cláusulas SQL
SELECT cli.nome AS nome_cliente, prod.nome AS nome_produto, ROUND(AVG(p.quantidade), 2) AS media_quantidade
FROM cap08.pedidos p
JOIN cap08.clientes cli USING (id_cliente)
JOIN cap08.produtos prod USING (id_produto)
WHERE prod.nome IN ('Produto D', 'Produto H')
GROUP BY cli.nome, nome_produto
HAVING ROUND(AVG(p.quantidade), 2) > 42
ORDER BY nome_produto;


-- Imagine que você quer encontrar os produtos mais vendidos e para cada um desses produtos, deseja obter 
-- os detalhes do cliente que fez o maior pedido em termos de quantidade para esse produto.
WITH ProdutosMaisVendidos AS (
    SELECT id_produto, SUM(quantidade) AS total_quantidade
    FROM cap08.pedidos
    GROUP BY id_produto
    ORDER BY total_quantidade DESC
    LIMIT 5
)
SELECT prod.nome AS produto, prod.categoria, cli.nome AS nome_cliente, cli.sobrenome, p.quantidade
FROM ProdutosMaisVendidos pmv
JOIN cap08.pedidos p ON pmv.id_produto = p.id_produto
JOIN cap08.produtos prod ON p.id_produto = prod.id_produto
JOIN cap08.clientes cli ON p.id_cliente = cli.id_cliente
WHERE p.quantidade = (SELECT MAX(quantidade) FROM cap08.pedidos WHERE id_produto = pmv.id_produto);

-- A subquery ProdutosMaisVendidos identifica os 5 produtos mais vendidos.
-- Em seguida, juntamos essa subquery com as tabelas pedidos, produtos e clientes para obter os detalhes 
-- do cliente que fez o maior pedido para cada um dos produtos mais vendidos.