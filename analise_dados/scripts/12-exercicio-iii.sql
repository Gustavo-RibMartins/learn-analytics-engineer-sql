CREATE SCHEMA exe03 AUTHORIZATION "pgAdministrador";

-- Cria a tabela
CREATE TABLE exe03.vendas_temporais (
    id SERIAL PRIMARY KEY,
    data_venda DATE NOT NULL,
    valor_venda DECIMAL(10,2) NOT NULL,
    funcionario_id INT NOT NULL
);


-- Insere os registros
INSERT INTO exe03.vendas_temporais (data_venda, valor_venda, funcionario_id) VALUES
('2025-01-01', 175.00, 1001),
('2025-01-02', 155.00, 1001),
('2025-01-03', 321.00, 1002),
('2025-01-04', 254.00, 1001),
('2025-01-05', 189.00, 1002),
('2025-01-05', 182.00, 1002),
('2025-01-05', 183.00, 1002),
('2025-01-06', 190.00, 1003),
('2025-01-07', 190.00, 1003),
('2025-01-08', 245.00, 1004),
('2025-01-09', 456.00, 1005),
('2025-01-09', 230.00, 1005),
('2025-01-09', 150.00, 1003),
('2025-01-10', 157.00, 1002),
('2025-01-10', 188.00, 1001);


-- 1. Crie uma query para comparar em um relatório os dados de vendas diárias com a média móvel
-- Considere janela de 3 dias para a média móvel
WITH total_venda as (
SELECT
	data_venda,
	SUM(valor_venda) as total_venda_dia
FROM
	exe03.vendas_temporais
GROUP BY
	data_venda
)

SELECT
	data_venda,
	total_venda_dia,
	round(AVG(total_venda_dia) OVER(
		ORDER BY data_venda ASC
		ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
	), 2) as media_movel_3_dias
FROM
	total_venda
ORDER BY
	data_venda;


-- 2. Crie uma query para comparar em um relatório os dados de vendas diárias com a média móvel
-- Considere janela de 7 dias para a média móvel
WITH total_venda as (
SELECT
	data_venda,
	SUM(valor_venda) as total_venda_dia
FROM
	exe03.vendas_temporais
GROUP BY
	data_venda
)

SELECT
	data_venda,
	total_venda_dia,
	round(AVG(total_venda_dia) OVER(
		ORDER BY data_venda ASC
		ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING
	), 2) as media_movel_7_dias
FROM
	total_venda
ORDER BY
	data_venda;


-- 3. Crie uma query que mostre o crescimento das vendas diárias em relação ao dia anterior
-- Por exemplo: De um dia para outro a venda aumento em 23 ou diminuiu em 57
WITH total_venda as (
SELECT
	data_venda,
	SUM(valor_venda) as total_venda_dia
FROM
	exe03.vendas_temporais
GROUP BY
	data_venda
)
, venda_anterior as (
SELECT
	data_venda,
	total_venda_dia,
	LAG(total_venda_dia) OVER(
		ORDER BY data_venda
	) as total_venda_dia_ante
FROM
	total_venda
)

SELECT
	data_venda,
	total_venda_dia,
	total_venda_dia_ante,
	CASE
		WHEN total_venda_dia_ante is null
		THEN '1ª venda'
		WHEN total_venda_dia > total_venda_dia_ante
		THEN 'aumento de ' || cast(total_venda_dia - total_venda_dia_ante as varchar(10)) || ' nas vendas'
		ELSE 'diminuição de ' || cast(total_venda_dia_ante - total_venda_dia as varchar(10)) || ' nas vendas'
		END AS crescimento_vendas
FROM
	venda_anterior
ORDER BY
	data_venda;


-- 4. Crie uma query que mostre a soma acumulada de vendas dia a dia
WITH vendas_diarias as (
SELECT
	data_venda,
	SUM(valor_venda) as total_venda_dia
FROM
	exe03.vendas_temporais
GROUP BY
	data_venda
)

SELECT
	data_venda,
	total_venda_dia,
	SUM(total_venda_dia) OVER(
		ORDER BY data_venda
	) as total_venda_acum
FROM
	vendas_diarias
ORDER BY
	data_venda;


-- 5. [Desafio] Crie um ranking de vendas por funcionário considerando o valor total de vendas por dia e de cada funcionário
WITH vendas_diarias as (
SELECT
	data_venda,
	funcionario_id,
	SUM(valor_venda) as total_venda_dia
FROM
	exe03.vendas_temporais
GROUP BY
	data_venda,
	funcionario_id
)

SELECT
	data_venda,
	funcionario_id,
	total_venda_dia,
	DENSE_RANK() OVER(
		PARTITION BY funcionario_id
		ORDER BY total_venda_dia desc
	) as rank_funcionario
FROM
	vendas_diarias
ORDER BY
	funcionario_id,
	rank_funcionario;
