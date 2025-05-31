-- Cria o schema no banco de dados
CREATE SCHEMA exe02 AUTHORIZATION "pgAdministrador";

-- Criação da tabela 
CREATE TABLE exe02.vendas (
    ID INT PRIMARY KEY,
    DataVenda DATE,
    Produto VARCHAR(50),
    Quantidade INT,
    ValorUnitario DECIMAL(10, 2),
    Vendedor VARCHAR(50)
);


-- Insert
INSERT INTO exe02.vendas (ID, DataVenda, Produto, Quantidade, ValorUnitario, Vendedor) VALUES
(1, '2023-11-01', 'Produto A', 10, 100.00, 'Zico'),
(2, '2023-11-01', 'Produto B', 5, 200.00, 'Romário'),
(3, '2023-11-02', 'Produto A', 7, 100.00, 'Ronaldo'),
(4, '2023-11-02', 'Produto C', 3, 150.00, 'Bebeto'),
(5, '2023-11-03', 'Produto B', 8, 200.00, 'Romário'),
(6, '2023-11-03', 'Produto A', 5, 100.00, 'Zico'),
(7, '2023-11-04', 'Produto C', 10, 150.00, 'Bebeto'),
(8, '2023-11-04', 'Produto A', 2, 100.00, 'Ronaldo'),
(9, '2023-11-05', 'Produto B', 6, 200.00, 'Romário'),
(10, '2023-11-05', 'Produto C', 4, 150.00, 'Bebeto');


-- Pergunta 1: Qual o total de vendas por produto?
SELECT
    Produto,
    SUM(Quantidade * ValorUnitario) as TotalVendas
FROM exe02.vendas
GROUP BY Produto
ORDER BY TotalVendas DESC


-- Pergunta 2: Qual o total de vendas por vendedor?
SELECT
    Vendedor,
    SUM(Quantidade * ValorUnitario) as TotalVendas
FROM exe02.vendas
GROUP BY Vendedor
ORDER BY TotalVendas DESC


-- Pergunta 3: Qual o total de vendas por dia?
SELECT
    DataVenda,
    SUM(Quantidade * ValorUnitario) as TotalVendas
FROM exe02.vendas
GROUP BY DataVenda
ORDER BY TotalVendas DESC


-- Pergunta 4: Como as vendas se acumulam por dia e por produto (incluindo subtotais diários)?
SELECT
    COALESCE(CAST(DataVenda AS CHAR(10)), 'Total Geral') AS DataVenda,
    COALESCE(Produto, 'Todos os Produtos') AS Produto,
    SUM(Quantidade * ValorUnitario) as TotalVendas
FROM
    exe02.vendas
GROUP BY
    ROLLUP(DataVenda, Produto)
ORDER BY
    GROUPING(Produto), DataVenda, Produto


-- Pergunta 5: Qual a combinação de vendedor e produto gerou mais vendas (incluindo todos os subtotais possíveis)?
SELECT
    CASE
        WHEN GROUPING(Vendedor) = 1
        THEN 'Total de Vendedores'
        ELSE Vendedor
    END AS Vendedor,
    CASE
        WHEN GROUPING(Produto) = 1
        THEN 'Total de Produtos'
        ELSE Produto
    END AS Produto,
    SUM(Quantidade * ValorUnitario) as TotalVendas
FROM
    exe02.vendas
GROUP BY
    CUBE(Vendedor, Produto)
ORDER BY
    GROUPING(Vendedor, Produto), TotalVendas DESC
LIMIT 1

-- Imagine que você queira analisar as vendas totais por Produto, por Vendedor e também o total geral de todas as vendas. 
-- Como seria a Query SQL?
SELECT
    CASE
        WHEN GROUPING(Produto) = 1
        THEN 'Total de Produtos'
        ELSE Produto
    END AS Produto,
    CASE
        WHEN GROUPING(Vendedor) = 1
        THEN 'Total de Vendedores'
        ELSE Vendedor
    END AS Vendedor,
    SUM(Quantidade * ValorUnitario) as TotalVendas
FROM
    exe02.vendas
GROUP BY
    CUBE(Produto, Vendedor)
HAVING
	GROUPING(Produto) = 1 OR GROUPING(Vendedor) = 1
ORDER BY
    GROUPING(Produto, Vendedor) DESC, Produto, Vendedor


-- SOLUÇÃO DO INSTRUTOR
SELECT 
    COALESCE(Produto, 'Todos') AS Produto, 
    COALESCE(Vendedor, 'Todos') AS Vendedor, 
    SUM(Quantidade * ValorUnitario) AS TotalVendas
FROM 
    exe02.vendas
GROUP BY GROUPING SETS (
    (Produto), 
    (Vendedor), 
    ()
);