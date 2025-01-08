-- Cria o schema no banco de dados
CREATE SCHEMA cap05 AUTHORIZATION "pgAdministrador";


-- Cria a tabela
CREATE TABLE cap05.dsa_vendas (
    ID_Venda SERIAL PRIMARY KEY,
    Data_Venda DATE NOT NULL,
    Nome_Produto VARCHAR(255) NOT NULL,
    Categoria_Produto VARCHAR(255) NOT NULL,
    Unidades_Vendidas INT NOT NULL,
    Valor_Unitario_Venda DECIMAL(10, 2) NOT NULL
);


-- Carrega os dados
INSERT INTO cap05.dsa_vendas (Data_Venda, Nome_Produto, Categoria_Produto, Unidades_Vendidas, Valor_Unitario_Venda) VALUES
('2023-08-01', 'Produto A', 'Categoria 1', 5, 10.50),
('2023-08-01', 'Produto B', 'Categoria 1', 3, 15.00),
('2023-09-01', 'Produto C', 'Categoria 2', 4, 12.75),
('2023-09-02', 'Produto D', 'Categoria 3', 2, 20.00),
('2023-09-02', 'Produto E', 'Categoria 3', 6, 18.50),
('2023-09-10', 'Produto A', 'Categoria 1', 7, 10.50),
('2023-10-01', 'Produto B', 'Categoria 1', 2, 15.00),
('2023-10-03', 'Produto C', 'Categoria 2', 5, 12.75),
('2023-10-04', 'Produto D', 'Categoria 3', 3, 20.00),
('2023-11-01', 'Produto C', 'Categoria 3', 3, 21.00),
('2023-11-07', 'Produto D', 'Categoria 3', 3, 20.00),
('2023-11-11', 'Produto A', 'Categoria 2', 1, 17.50),
('2023-11-12', 'Produto B', 'Categoria 1', 5, 19.50),
('2023-11-14', 'Produto A', 'Categoria 2', 5, 12.50),
('2023-11-16', 'Produto E', 'Categoria 3', 7, 14.50);

# SQL Para Análise de Dados e Data Science - Capítulo 05


-- Query SQL para retornar a média de Valor_Unitario_Venda.
SELECT AVG(Valor_Unitario_Venda) AS Media_Valor_Unitario
FROM cap05.dsa_vendas;


-- Query SQL para retornar a média de Valor_Unitario_Venda com duas casas decimais.
SELECT ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas;


-- Query SQL para retornar a contagem, valor mínimo, valor máximo e soma (total) de Valor_Unitario_Venda.
SELECT 
    COUNT(Valor_Unitario_Venda) AS Contagem,
    MIN(Valor_Unitario_Venda) AS Valor_Minimo,
    MAX(Valor_Unitario_Venda) AS Valor_Maximo,
    SUM(Valor_Unitario_Venda) AS Soma_Total
FROM cap05.dsa_vendas;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por categoria de produto.
SELECT 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;

SELECT 
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;

SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por categoria de produto, 
-- ordenado pela média em ordem decrescente.
SELECT 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto
ORDER BY Media_Valor_Unitario DESC;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por produto. 
SELECT 
    Nome_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por produto e categoria. (Leia a mensagem de erro ao executar)
SELECT 
    Nome_Produto,
    Categoria_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por produto e categoria, ordenado por produto e categoria.
SELECT 
    Nome_Produto,
    Categoria_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto, Categoria_Produto
ORDER BY Nome_Produto, Categoria_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por categoria e produto, ordenado por categoria e produto.
SELECT 
    Categoria_Produto,
    Nome_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto, Nome_Produto
ORDER BY Categoria_Produto, Nome_Produto;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por produto, 
-- somente se a média for maior ou igual a 16. 

-- Errado:
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE Media_Valor_Unitario >= 16
GROUP BY Nome_Produto;

-- Correto:
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) >= 16;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por produto e categoria, 
-- somente se a média for maior ou igual a 16 e unidades vendidas maior do que 4, ordenado por nome de produto.

SELECT * FROM cap05.dsa_vendas;

SELECT 
    Nome_Produto, 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE unidades_vendidas > 4
GROUP BY Nome_Produto, Categoria_Produto
HAVING AVG(Valor_Unitario_Venda) >= 16
ORDER BY Nome_Produto;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por produto e categoria, 
-- somente se a média for maior ou igual a 16 e o produto for B ou C, ordenado por categoria.
SELECT 
    Nome_Produto, 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE Nome_Produto IN ('Produto B', 'Produto C')
GROUP BY Nome_Produto, Categoria_Produto
HAVING AVG(Valor_Unitario_Venda) >= 16
ORDER BY Categoria_Produto;


-- Subqueries (ou sub-consultas) são usadas em SQL quando uma consulta é aninhada dentro de outra consulta. 
-- Elas podem ser muito úteis em vários cenários, como:

-- Para Obter Valores para Filtrar
-- Operações de Agregação em Filtragem
-- Existência de Registros
-- Seleção de Colunas


-- Sem usar subquery
-- Query SQL para retornar a média de Valor_Unitario_Venda por produto, 
-- somente se a média for maior do que 5 e categoria de produtos for 1 ou 2. 
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE Categoria_Produto IN ('Categoria 1', 'Categoria 2')
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 5;


-- Usando subquery
-- Query SQL para retornar a média de Valor_Unitario_Venda por produto, 
-- somente se a média for maior do que 5 e categoria de produtos for 1 ou 2. 
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM (
    SELECT Nome_Produto, Valor_Unitario_Venda
    FROM cap05.dsa_vendas
    WHERE Categoria_Produto IN ('Categoria 1', 'Categoria 2')
) AS sub_query
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 5;


-- Query SQL que retorne somente registros cuja média de unidades vendidas seja maior do que 2. 
-- Desse resultado, retorne os produtos cuja média de vendas foi maior do que 15.
-- Somente registros se categoria de produtos for 1 ou 2. 

SELECT Nome_Produto, Valor_Unitario_Venda
FROM cap05.dsa_vendas
GROUP BY Nome_Produto, Valor_Unitario_Venda
HAVING AVG(Unidades_Vendidas) > 2;


SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM (
    SELECT Nome_Produto, Valor_Unitario_Venda
    FROM cap05.dsa_vendas
    GROUP BY Nome_Produto, Valor_Unitario_Venda
    HAVING AVG(Unidades_Vendidas) > 2
) AS sub_query
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 15;


SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM (
    SELECT Nome_Produto, Valor_Unitario_Venda
    FROM cap05.dsa_vendas
    GROUP BY Nome_Produto, Valor_Unitario_Venda
    HAVING AVG(Unidades_Vendidas) > 2
) AS sub_query
WHERE Categoria_Produto IN ('Categoria 1', 'Categoria 2')
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 15;


SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM (
    SELECT Nome_Produto, Valor_Unitario_Venda
    FROM cap05.dsa_vendas
    WHERE Categoria_Produto IN ('Categoria 1', 'Categoria 2')
    GROUP BY Nome_Produto, Valor_Unitario_Venda
    HAVING AVG(Unidades_Vendidas) > 2
) AS sub_query
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 15;

-- Query SQL para retornar o valor total final de vendas por dia.

SELECT * FROM cap05.dsa_vendas;

SELECT 
    Data_Venda,
    SUM(Valor_Unitario_Venda * Unidades_Vendidas) AS Valor_Total_Final_Venda
FROM cap05.dsa_vendas
GROUP BY Data_Venda
ORDER BY Data_Venda;


-- Query SQL para retornar a média do valor total final de vendas por mês.
SELECT 
    EXTRACT(YEAR FROM Data_Venda) AS Ano,
    EXTRACT(MONTH FROM Data_Venda) AS Mes,
    ROUND(AVG(Valor_Unitario_Venda * Unidades_Vendidas), 2) AS Media_Valor_Final_Venda
FROM cap05.dsa_vendas
GROUP BY EXTRACT(YEAR FROM Data_Venda), EXTRACT(MONTH FROM Data_Venda)
ORDER BY Ano, Mes;

SELECT 
    EXTRACT(YEAR FROM Data_Venda) AS Ano,
    EXTRACT(MONTH FROM Data_Venda) AS Mes,
    ROUND(AVG(Valor_Unitario_Venda * Unidades_Vendidas), 2) AS Media_Valor_Final_Venda
FROM cap05.dsa_vendas
GROUP BY Ano, Mes
ORDER BY Ano, Mes;


-- Query SQL para retornar a média do valor total final de venda no dia 1 de cada mês.
SELECT 
    EXTRACT(YEAR FROM Data_Venda) AS Ano,
    EXTRACT(MONTH FROM Data_Venda) AS Mes,
    ROUND(AVG(Valor_Unitario_Venda * Unidades_Vendidas), 2) AS Media_Valor_Final_Venda
FROM cap05.dsa_vendas
WHERE EXTRACT(DAY FROM Data_Venda) = 1
GROUP BY Ano, Mes
ORDER BY Ano, Mes;


-- Query SQL para retornar a média do valor total final de venda entre os dias 10 e 20 de cada mês.
SELECT 
    EXTRACT(YEAR FROM Data_Venda) AS Ano,
    EXTRACT(MONTH FROM Data_Venda) AS Mes,
    ROUND(AVG(Valor_Unitario_Venda * Unidades_Vendidas), 2) AS Media_Valor_Final_Venda
FROM cap05.dsa_vendas
WHERE EXTRACT(DAY FROM Data_Venda) BETWEEN 10 AND 20
GROUP BY Ano, Mes
ORDER BY Ano, Mes;