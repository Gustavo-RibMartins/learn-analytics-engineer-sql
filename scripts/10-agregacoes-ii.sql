-- Cria o schema no banco de dados
CREATE SCHEMA cap10 AUTHORIZATION "pgAdministrador";


-- Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS cap10.dsa_clientes (
    id_cli INT PRIMARY KEY,
    nome_cliente VARCHAR(50),
    tipo_cliente VARCHAR(50),
    cidade_cliente VARCHAR(50),
    estado_cliente VARCHAR(50)
);


-- Cria tabela de Produtos
CREATE TABLE IF NOT EXISTS cap10.dsa_produtos (
    id_prod INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    nome_formacao VARCHAR(100)
);


-- Cria tabela de Pedidos
CREATE TABLE IF NOT EXISTS cap10.dsa_pedidos (
    id_pedido INT PRIMARY KEY,
    id_produto INT REFERENCES cap10.dsa_produtos(id_prod),
    data_pedido DATE NULL,
    valor_pedido DECIMAL(10, 2) NULL,
    id_cliente INT REFERENCES cap10.dsa_clientes(id_cli)
);


-- Carrega os dados na tabela de Clientes
INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1001, 'Machado de Assis', 'Diamante', 'Campinas', 'SP');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1002, 'Isaac Asimov', 'Ouro', 'Rio de Janeiro', 'RJ');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1003, 'Mark Twain', 'Prata', 'Rio de Janeiro', 'RJ');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1004, 'Edgar Allan Poe', 'Bronze', 'Porto Alegre', 'RS');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1005, 'Miguel de Cervantes', 'Diamante', 'Fortaleza', 'CE');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1006, 'Charles Dickens', 'Ouro', 'Campinas', 'SP');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1007, 'Virginia Woolf', 'Ouro', 'Natal', 'RN');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1008, 'William Shakespeare', 'Prata', 'Campinas', 'SP');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1009, 'Jane Austen', 'Bronze', 'Fortaleza', 'CE');

INSERT INTO cap10.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1010, 'Fiódor Dostoiévski', 'Bronze', 'Blumenau', 'SC');


-- Carrega os dados na tabela de Produtos
INSERT INTO cap10.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10101, 'SQL Para Análise de Dados e Data Science', 'FADA 4.0');

INSERT INTO cap10.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10102, 'Projetos de Análise de Dados com Linguagem Python', 'FADA 4.0');

INSERT INTO cap10.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10103, 'Modelagem e Análise de Dados com Power BI', 'FADA 4.0');

INSERT INTO cap10.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10104, 'Pipelines de Análise e Engenharia de Dados com Google BigQuery', 'FADA 4.0');

INSERT INTO cap10.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10105, 'Arquitetura de Plataforma de Dados e Modern Data Stack', 'FAD 4.0');

INSERT INTO cap10.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10106, 'Pipelines de ETL e Machine Learning com Apache Spark', 'FAD 4.0');

INSERT INTO cap10.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10107, 'Orquestração de Fluxos de Dados com Apache Airflow', 'FAD 4.0');

INSERT INTO cap10.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10108, 'Projeto e Implementação de Plataforma de Dados com Snowflake', 'FAD 4.0');


-- Carrega os dados na tabela de Pedidos
INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0001, 10105, '2023-11-27', 11224.10, 1002);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0002, 10103, '2023-11-28', 11324.31, 1004);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0005, 10106, '2023-11-28', 12389.49, 1001);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0006, 10102, '2023-11-29', 15783.23, 1007);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0008, 10102, '2023-11-30', 11548.23, 1008);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0009, 10101, '2023-11-30', 18549.24, 1004);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0010, 10108, '2023-11-30', 19549.03, 1005);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0011, 10103, '2023-11-30', 13549.63, 1003);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0012, 10107, '2023-11-30', 14549.13, 1003);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0013, 10107, '2023-11-30', 14549.13, 1002);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0014, 10104, '2023-11-30', 14549.13, 1001);

INSERT INTO cap10.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0015, 10104, '2023-11-30', 14549.13, 1006);

-- Lista os pedidos
SELECT * FROM cap10.dsa_pedidos;


-- Soma (total) do valor dos pedidos
SELECT SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos;


-- Soma (total) do valor dos pedidos por cidade
SELECT cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P, cap10.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY 2;


-- Soma (total) do valor dos pedidos por estado e cidade (com cláusula WHERE)
SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P, cap10.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;


-- Soma (total) do valor dos pedidos por estado e cidade (com cláusula JOIN)
SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P
INNER JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;


-- Soma (total) do valor dos pedidos por estado e cidade. Retornar cidades sem pedidos.
SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P
RIGHT JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;


-- Soma (total) do valor dos pedidos por estado e cidade. Mostrar zero se não houve pedido.
SELECT 
    estado_cliente,
    cidade_cliente,
    CASE 
        WHEN FLOOR(SUM(valor_pedido)) IS NULL THEN 0
        ELSE FLOOR(SUM(valor_pedido))
    end AS total
FROM cap10.dsa_pedidos P 
RIGHT JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;

-- Altera a tabela de produtos e acrescenta uma coluna
ALTER TABLE IF EXISTS cap10.dsa_produtos 
ADD COLUMN custo DECIMAL(10, 2) NULL;


-- Atualiza a coluna
UPDATE cap10.dsa_produtos
SET custo = 43 + (id_prod - 1) * 5.1
WHERE id_prod BETWEEN 10101 AND 10108;


-- Visualiza os dados
SELECT *
FROM cap10.dsa_produtos;


-- Custo total dos pedidos por estado
SELECT 
    cli.estado_cliente,
    SUM(prod.custo) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;


-- Você foi informado que a tabela de dados está desatualizada e os produtos vendidos para os clientes do estado de SP
-- tiveram aumento de custo de 10%.
-- Demonstre isso no relatório sem modificar os dados na tabela.
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;


-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
SELECT 
    cli.estado_cliente,
    SUM(prod.custo) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;


-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total for menor do que 120000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) < 120000
ORDER BY 
    custo_total DESC;


-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total estiver entre 150000 e 250000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) BETWEEN 150000 AND 250000
ORDER BY 
    custo_total DESC;


-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total estiver entre 150000 e 250000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP 
-- Inclua no relatório uma coluna chamada status_aumento com o texto 'Com Aumento de Custo' se o estado for SP e o texto
-- 'Sem Aumento de Custo' se for qualquer outro estado
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total,
    CASE 
        WHEN cli.estado_cliente = 'SP' THEN 'Com Aumento de Custo'
        ELSE 'Sem Aumento de Custo'
    END AS status_aumento
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) BETWEEN 150000 AND 250000
ORDER BY 
    custo_total DESC;

-- Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS cap10.dsa_vendas (
    ano INT NULL,
    pais VARCHAR(50) NULL,
    produto VARCHAR(50) NULL,
    faturamento INT NULL
);


-- Insere registros
INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Brasil', 'Geladeira', 1130);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Brasil', 'TV', 980);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Argentina', 'Geladeira', 2180);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Argentina', 'TV', 2240);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Portugal', 'Smartphone', 2310);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Portugal', 'TV', 1900);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Inglaterra', 'Notebook', 1800);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Brasil', 'Geladeira', 1400);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Brasil', 'TV', 1345);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Argentina', 'Geladeira', 2180);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Argentina', 'TV', 1390);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Portugal', 'Smartphone', 2480);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Portugal', 'TV', 1980);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Inglaterra', 'Notebook', 2300);


-- Lista os dados
SELECT * 
FROM cap10.dsa_vendas;


-- Faturamento total por ano
SELECT ano, SUM(faturamento) AS faturamento_total
FROM cap10.dsa_vendas
GROUP BY ano;


-- Faturamento total por ano e total geral
SELECT 
    ano,
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano);


-- Faturamento total por ano e total geral
SELECT 
    COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano);


-- Faturamento total por ano e total geral, ordenado por ano
SELECT 
    COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano)
ORDER BY
  ano;


-- Faturamento total por ano e pais e total geral (ROLLUP)
SELECT 
    COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    COALESCE(pais, 'Total') AS pais,
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, pais)
ORDER BY
  ano, pais;


-- Faturamento total por ano e pais e 
-- total geral do ano e do pais (CUBE)
SELECT 
    COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    COALESCE(pais, 'Total') AS pais,
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    CUBE(ano, pais)
ORDER BY 
    ano, pais;


-- Faturamento total por ano e produto e total geral
SELECT 
    CASE 
        WHEN ano IS NULL THEN 'Total Geral' 
        ELSE CAST(ano AS VARCHAR)
    END AS ano, 
    CASE 
        WHEN produto IS NULL THEN 'Todos os Produtos' 
        ELSE produto
    END AS produto, 
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, produto);


-- Faturamento total por ano e produto e total geral, 
-- ordenado por produto, ano e faturamento_total
SELECT 
    CASE 
        WHEN ano IS NULL THEN 'Total Geral' 
        ELSE CAST(ano AS VARCHAR)
    END AS ano, 
    CASE 
        WHEN produto IS NULL THEN 'Todos os Produtos' 
        ELSE produto
    END AS produto, 
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, produto)
ORDER BY 
    produto, ano, faturamento_total;


-- Faturamento total por ano e produto e total geral, 
-- ordenado pelo agrupamento de produto
-- A função GROUPING em SQL é usada para determinar se uma coluna ou expressão em uma consulta 
-- está sendo agrupada ou se está em uma linha de subtotal ou total
-- Podemos usar a função GROUPING para fazer a ordenação do resultado
SELECT 
    CASE 
        WHEN ano IS NULL THEN 'Total Geral' 
        ELSE CAST(ano AS VARCHAR)
    END AS ano, 
    CASE 
        WHEN produto IS NULL THEN 'Todos os Produtos' 
        ELSE produto
    END AS produto, 
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, produto)
ORDER BY 
    GROUPING(produto), ano, faturamento_total;


-- A função GROUPING em SQL é usada para determinar se uma coluna ou expressão em uma consulta 
-- está sendo agrupada ou se está em uma linha de subtotal ou total
-- Faturamento total por ano e país e total geral com agrupamento do resultado
SELECT
    CASE 
        WHEN GROUPING(ano) = 1 THEN 'Total de Todos os Anos'
        ELSE CAST(ano AS VARCHAR)
    END AS ano,
    CASE 
        WHEN GROUPING(pais) = 1 THEN 'Total de Todos os Países'
        ELSE pais
    END AS pais,
    CASE 
        WHEN GROUPING(produto) = 1 THEN 'Total de Todos os Produtos'
        ELSE produto
    END AS produto,
    SUM(faturamento) AS faturamento_total 
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, pais, produto)
ORDER BY 
    GROUPING(produto, ano, pais), faturamento_total;


-- STRING_AGG
-- Faturamento total por país em 2024 mostrando todos os produtos vendidos como uma lista
SELECT 
    pais,
    STRING_AGG(produto, ', ') AS produtos_vendidos,
    SUM(faturamento) AS faturamento_total 
FROM 
    cap10.dsa_vendas
WHERE ano = 2024
GROUP BY 
    pais;
