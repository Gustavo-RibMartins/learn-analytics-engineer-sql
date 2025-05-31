-- Cria schema do capitulo 04 do curso
DROP SCHEMA IF EXISTS "cap04" ;

CREATE SCHEMA IF NOT EXISTS "cap04"
    AUTHORIZATION "pgAdministrador";

-- Criando a tabela 'estudantes'
CREATE TABLE cap04.estudantes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    nota_exame1 DECIMAL(5, 2),
    nota_exame2 DECIMAL(5, 2),
    tipo_sistema_operacional VARCHAR(20)
);

-- Inserindo 30 registros fictícios na tabela 'estudantes'
INSERT INTO cap04.estudantes (nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional) VALUES
('Xavier', 'Murphy', 86.0, 89.0, 'Linux'),
('Yara', 'Bailey', 80.5, 81.0, 'Windows'),
('Alice', 'Smith', 80.5, 85.0, 'Windows'),
('Quincy', 'Roberts', 86.5, 90.0, 'Mac'),
('Bob', 'Johnson', 75.0, 88.0, 'Linux'),
('Carol', 'Williams', 90.0, 90.5, 'Mac'),
('Grace', 'Miller', 95.5, 93.0, 'Windows'),
('Nina', 'Carter', 80.5, 81.0, 'Windows'),
('Ursula', 'Kim', 80.0, 82.5, 'Linux'),
('Eve', 'Jones', 90.0, 88.0, 'Mac'),
('Frank', 'Garcia', 79.0, 82.0, 'Linux'),
('Helen', 'Davis', 90.0, 89.5, 'Mac'),
('Grace', 'Rodriguez', 89.0, 88.0, 'Windows'),
('Jack', 'Martinez', 90.0, 80.0, 'Linux'),
('Karen', 'Hernandez', 93.5, 91.0, 'Windows'),
('Leo', 'Lewis', 82.0, 85.5, 'Mac'),
('Mallory', 'Nelson', 91.0, 89.0, 'Linux'),
('Oscar', 'Mitchell', 88.0, 87.5, 'Linux'),
('Paul', 'Perez', 94.0, 92.0, 'Windows'),
('Rita', 'Gomez', 77.0, 80.0, 'Linux'),
('Steve', 'Freeman', 89.5, 88.5, 'Windows'),
('Troy', 'Reed', 90.0, 92.0, 'Mac'),
('Victor', 'Morgan', 90.0, 85.0, 'Windows'),
('Oscar', 'Bell', 85.5, 87.0, 'Mac'),
('Zane', 'Rivera', 89.0, 90.5, 'Mac'),
('Aria', 'Wright', 75.0, 76.5, 'Linux'),
('Bruce', 'Cooper', 90.0, 84.0, 'Windows'),
('Karen', 'Peterson', 90.0, 92.5, 'Mac'),
('Dave', 'Brown', 88.5, 89.0, 'Windows'),
('Derek', 'Wood', 86.0, 87.5, 'Linux');

# SQL Para Análise de Dados e Data Science - Capítulo 04


-- FILTROS DE COLUNA

-- Selecione todas as linhas e colunas da tabela
SELECT * 
FROM cap04.estudantes;

-- Selecione nome e sobrenome de todos os estudantes
SELECT nome, sobrenome
FROM cap04.estudantes;

-- Selecione tipo de sistema operacional, nota no exame 1 e nota no exame 2 de todos os estudantes
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2
FROM cap04.estudantes;

-- Selecione tipo de sistema operacional, nota no exame 1, nota no exame 2, nome e sobrenome de todos os estudantes.
-- Nome e sobrenome devem estar em uma única coluna no resultado mostrando o nome completo.
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2, nome || ' ' || sobrenome
FROM cap04.estudantes;

-- Selecione tipo de sistema operacional, nota no exame 1, nota no exame 2, nome e sobrenome de todos os estudantes.
-- Nome e sobrenome devem estar em uma única coluna no resultado mostrando o nome completo.
-- Crie um alias para a nova coluna de nome completo
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2, nome || ' ' || sobrenome AS nome_completo
FROM cap04.estudantes;


-- FILTROS DE LINHA

-- Selecione os 10 primeiros estudantes da tabela
SELECT *
FROM cap04.estudantes
LIMIT 10;

-- Selecione todos os estudantes que conseguiram nota igual a 90 em nota_exame1
SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 = 90;

-- Selecione todos os estudantes que conseguiram nota maior do que 90 em nota_exame1
SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 > 90;

-- Selecione somente os nomes dos estudantes que conseguiram nota maior do que 90 em nota_exame1
SELECT nome
FROM cap04.estudantes
WHERE nota_exame1 > 90;

-- Selecione somente os nomes dos estudantes que conseguiram nota menor do que 90 em nota_exame1
-- Ordene o resultado
SELECT nome
FROM cap04.estudantes
WHERE nota_exame1 < 90
ORDER BY nome;

-- Observe no resultado anterior que um mesmo nome aparece mais de uma vez
-- Retorne somente um nome se houver duplicidade de nome
SELECT DISTINCT nome
FROM cap04.estudantes
WHERE nota_exame1 < 90
ORDER BY nome;

-- Agora queremos valores distintos por nome e sobrenome, ordenado por nome
-- Observe a diferença
SELECT DISTINCT nome, sobrenome
FROM cap04.estudantes
WHERE nota_exame1 < 90
ORDER BY nome;

# SQL Para Análise de Dados e Data Science - Capítulo 04

-- OPERADORES RELACIONAIS

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 = 90;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 > 90;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 >= 90;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame2 <= 76.5;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 != 90;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 <> 90;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 = 90;

SELECT * 
FROM cap04.estudantes
WHERE 90 = nota_exame1;

SELECT * 
FROM cap04.estudantes
WHERE 90 = 90;

SELECT * 
FROM cap04.estudantes
WHERE nome = Xavier;

SELECT * 
FROM cap04.estudantes
WHERE nome = 'xavier';

SELECT * 
FROM cap04.estudantes
WHERE nome = 'Xavier';


-- OPERADORES LÓGICOS

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 > 90 AND nota_exame2 > 90;

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 > 90 OR nota_exame2 > 90;

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE NOT nota_exame1 > 90;

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 > 90 AND nota_exame2 > 90 AND tipo_sistema_operacional = 'Windows';

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional = 'Linux';

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional != 'Linux';

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional != 'Linux'
  AND NOT nome IN ('Carol', 'Grace');


-- OUTROS OPERADORES RELACIONAIS

-- OPERADOR IN

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap04.estudantes
WHERE tipo_sistema_operacional IN ('Linux', 'Mac');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap04.estudantes
WHERE tipo_sistema_operacional IN ('Linux', 'FreeBSD');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap04.estudantes
WHERE tipo_sistema_operacional IN ('Unix');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap04.estudantes
WHERE tipo_sistema_operacional NOT IN ('Linux', 'Mac');


-- OPERADOR LIKE

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome LIKE 'A%'
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome LIKE 'A%' OR nome LIKE 'B%' 
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome NOT LIKE 'A%'
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome NOT LIKE 'A%' AND NOT LIKE 'B%'
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome NOT LIKE 'A%' AND nome NOT LIKE 'B%'
ORDER BY nome_completo;


-- OPERADOR BETWEEN

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 BETWEEN 88 AND 90
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 NOT BETWEEN 88 AND 90
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2,
	   'Aprovado' AS status
FROM cap04.estudantes
WHERE nota_exame1 BETWEEN 88 AND 90
  AND tipo_sistema_operacional IN ('Linux', 'Mac')
  AND nome LIKE 'C%' OR nome LIKE 'H%' OR nome LIKE 'J%'
  AND nota_exame2 != 80
ORDER BY nome_completo;


-- LIMPAR A TABELA (USE COM CUIDADO)
TRUNCATE TABLE cap04.estudantes;
