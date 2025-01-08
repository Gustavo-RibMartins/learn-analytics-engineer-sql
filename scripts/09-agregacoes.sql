-- Cria o schema no banco de dados
CREATE SCHEMA cap09 AUTHORIZATION "pgAdministrador";


-- Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS cap09.dsa_clientes (
    id_cli INT PRIMARY KEY,
    nome_cliente VARCHAR(50),
    tipo_cliente VARCHAR(50),
    cidade_cliente VARCHAR(50),
    estado_cliente VARCHAR(50)
);


-- Cria tabela de Produtos
CREATE TABLE IF NOT EXISTS cap09.dsa_produtos (
    id_prod INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    nome_formacao VARCHAR(100)
);


-- Cria tabela de Pedidos
CREATE TABLE IF NOT EXISTS cap09.dsa_pedidos (
    id_pedido INT PRIMARY KEY,
    id_produto INT REFERENCES cap09.dsa_produtos(id_prod),
    data_pedido DATE NULL,
    valor_pedido DECIMAL(10, 2) NULL,
    id_cliente INT REFERENCES cap09.dsa_clientes(id_cli)
);


-- Carrega os dados na tabela de Clientes
INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1001, 'Machado de Assis', 'Diamante', 'Campinas', 'SP');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1002, 'Isaac Asimov', 'Ouro', 'Rio de Janeiro', 'RJ');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1003, 'Mark Twain', 'Prata', 'Rio de Janeiro', 'RJ');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1004, 'Edgar Allan Poe', 'Bronze', 'Porto Alegre', 'RS');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1005, 'Miguel de Cervantes', 'Diamante', 'Fortaleza', 'CE');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1006, 'Charles Dickens', 'Ouro', 'Campinas', 'SP');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1007, 'Virginia Woolf', 'Ouro', 'Natal', 'RN');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1008, 'William Shakespeare', 'Prata', 'Campinas', 'SP');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1009, 'Jane Austen', 'Bronze', 'Fortaleza', 'CE');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1010, 'Fiódor Dostoiévski', 'Bronze', 'Blumenau', 'SC');


-- Carrega os dados na tabela de Produtos
INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10101, 'SQL Para Análise de Dados e Data Science', 'FADA 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10102, 'Projetos de Análise de Dados com Linguagem Python', 'FADA 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10103, 'Modelagem e Análise de Dados com Power BI', 'FADA 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10104, 'Pipelines de Análise e Engenharia de Dados com Google BigQuery', 'FADA 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10105, 'Arquitetura de Plataforma de Dados e Modern Data Stack', 'FAD 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10106, 'Pipelines de ETL e Machine Learning com Apache Spark', 'FAD 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10107, 'Orquestração de Fluxos de Dados com Apache Airflow', 'FAD 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10108, 'Projeto e Implementação de Plataforma de Dados com Snowflake', 'FAD 4.0');


-- Carrega os dados na tabela de Pedidos
INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0001, 10105, '2023-10-27', 1224.10, 1002);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0002, 10103, '2023-10-28', 1324.31, 1004);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0005, 10106, '2023-10-28', 1389.49, 1001);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0006, 10102, '2023-10-29', 1783.23, 1007);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0008, 10102, '2023-10-30', 1549.23, 1008);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0009, 10101, '2023-10-30', 1549.23, 1004);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0010, 10108, '2023-10-30', 1549.23, 1005);

-- Retorna todos os clientes
SELECT * 
FROM cap09.dsa_clientes;


-- Contagem de clientes
SELECT COUNT(*) 
FROM cap09.dsa_clientes;


-- Contagem de clientes 
SELECT COUNT(id_cli)
FROM cap09.dsa_clientes;


-- Contagem de clientes por cidade (query incorreta)
SELECT cidade_cliente, COUNT(id_cli)
FROM cap09.dsa_clientes;


-- Contagem de clientes por cidade (query correta)
SELECT cidade_cliente, COUNT(id_cli)
FROM cap09.dsa_clientes
GROUP BY cidade_cliente;


-- Contagem de clientes por cidade ordenado pela contagem
SELECT COUNT(id_cli), cidade_cliente
FROM cap09.dsa_clientes
GROUP BY cidade_cliente
ORDER BY COUNT(id_cli) DESC;

SELECT cidade_cliente, COUNT(id_cli)
FROM cap09.dsa_clientes
GROUP BY cidade_cliente
ORDER BY 2 DESC;

SELECT cidade_cliente, COUNT(id_cli) AS contagem
FROM cap09.dsa_clientes
GROUP BY cidade_cliente
ORDER BY contagem DESC;


-- Número de clientes únicos que fizeram pedidos (será?)
SELECT COUNT(id_cliente) 
FROM cap09.dsa_pedidos;


-- Visualizar os dados
SELECT * FROM cap09.dsa_clientes;
SELECT * FROM cap09.dsa_pedidos;

-- Número de clientes que fizeram pedidos
SELECT COUNT(DISTINCT id_cliente) 
FROM cap09.dsa_pedidos;


-- Contagem de pedidos de clientes do estado do RJ ou SP (esta query está correta?)
SELECT estado_cliente, COUNT(*) AS total_pedidos
FROM cap09.dsa_pedidos AS P, cap09.dsa_clientes AS C
WHERE P.id_cliente = C.id_cli
AND estado_cliente = 'RJ' OR estado_cliente = 'SP'
GROUP BY estado_cliente;


-- Visualizar os dados
SELECT * 
FROM cap09.dsa_clientes
ORDER BY estado_cliente;

SELECT * 
FROM cap09.dsa_pedidos
ORDER BY id_cliente;


-- Contagem de pedidos de clientes do estado do RJ ou SP (agora sim!)
SELECT estado_cliente, COUNT(*) AS total_pedidos
FROM cap09.dsa_pedidos AS P, cap09.dsa_clientes AS C
WHERE P.id_cliente = C.id_cli
AND (estado_cliente = 'RJ' OR estado_cliente = 'SP')
GROUP BY estado_cliente


-- Contagem de pedidos de clientes do estado do RJ ou SP (alternativa)
SELECT C.estado_cliente, COUNT(P.id_pedido) AS total_pedidos
FROM cap09.dsa_clientes C
INNER JOIN cap09.dsa_pedidos P ON C.id_cli = P.id_cliente
WHERE C.estado_cliente IN ('RJ', 'SP')
GROUP BY C.estado_cliente;


-- Contagem de pedidos de clientes do estado do RJ ou SP por nome de cliente
SELECT nome_cliente, estado_cliente, COUNT(*) AS total_pedidos
FROM cap09.dsa_pedidos AS P, cap09.dsa_clientes AS C
WHERE P.id_cliente = C.id_cli
AND (estado_cliente = 'RJ' OR estado_cliente = 'SP')
GROUP BY nome_cliente, estado_cliente;


-- Maior valor 
SELECT MAX(valor_pedido) AS maximo
FROM cap09.dsa_pedidos;


-- Menor valor 
SELECT MIN(valor_pedido) AS minimo
FROM cap09.dsa_pedidos;

-- Lista os pedidos
SELECT * FROM cap09.dsa_pedidos;


-- Média do valor dos pedidos
SELECT AVG(valor_pedido) AS media
FROM cap09.dsa_pedidos;


-- Média do valor dos pedidos
SELECT ROUND(AVG(valor_pedido), 2) AS media
FROM cap09.dsa_pedidos;


-- Média do valor dos pedidos por cidade
SELECT cidade_cliente, ROUND(AVG(valor_pedido), 2) AS media
FROM cap09.dsa_pedidos P, cap09.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente;


-- Média do valor dos pedidos por cidade ordenado pela media
SELECT cidade_cliente, ROUND(AVG(valor_pedido), 2) AS media
FROM cap09.dsa_pedidos P, cap09.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;


-- Média do valor dos pedidos por cidade com INNER JOIN
SELECT cidade_cliente, ROUND(AVG(valor_pedido),2) AS media
FROM cap09.dsa_pedidos P 
INNER JOIN cap09.dsa_clientes C ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;


-- Insere um novo registro na tabela de Clientes
INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1011, 'Agatha Christie', 'Ouro', 'Belo Horizonte', 'MG');


-- Média do valor dos pedidos por cidade com INNER JOIN
SELECT cidade_cliente, ROUND(AVG(valor_pedido),2) AS media
FROM cap09.dsa_pedidos P 
INNER JOIN cap09.dsa_clientes C ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;


-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos)
SELECT cidade_cliente,ROUND(AVG(valor_pedido),2) AS media
FROM cap09.dsa_pedidos P 
RIGHT JOIN cap09.dsa_clientes C ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;


-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos) - erro
SELECT cidade_cliente, COALESCE(ROUND(AVG(valor_pedido),2), 'Não Houve Pedido') AS media
FROM cap09.dsa_pedidos P 
RIGHT JOIN cap09.dsa_clientes C ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;


-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos)
SELECT 
    cidade_cliente, 
    CASE 
        WHEN AVG(valor_pedido) IS NULL THEN 'Não Houve Pedido' 
        ELSE CAST(ROUND(AVG(valor_pedido), 2) AS VARCHAR)
    END AS media
FROM 
    cap09.dsa_clientes C
    LEFT JOIN cap09.dsa_pedidos P ON C.id_cli = P.id_cliente
GROUP BY 
    cidade_cliente
ORDER BY media DESC;


-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos)
SELECT 
    cidade_cliente, 
    CASE 
        WHEN AVG(valor_pedido) IS NULL THEN 'Não Houve Pedido' 
        ELSE CAST(ROUND(AVG(valor_pedido), 2) AS VARCHAR)
    END AS media
FROM 
    cap09.dsa_clientes C
    LEFT JOIN cap09.dsa_pedidos P ON C.id_cli = P.id_cliente
GROUP BY 
    cidade_cliente
ORDER BY 
    CASE 
        WHEN AVG(valor_pedido) IS NULL THEN 1 
        ELSE 0 
    END, 
    media DESC;


-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos e com valor 0)
SELECT  
    cidade_cliente,
    CASE 
        WHEN ROUND(AVG(valor_pedido),2) IS NULL THEN 0
        ELSE ROUND(AVG(valor_pedido),2)
    end AS media
FROM cap09.dsa_pedidos P 
RIGHT JOIN cap09.dsa_clientes C ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;
