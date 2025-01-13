-- Cria o schema
CREATE SCHEMA cap21 AUTHORIZATION "pgAdministrador";


-- Cria tabela
CREATE TABLE cap21.autores (
    AutorID SERIAL,
    Nome VARCHAR(100) NOT NULL,
    Nacionalidade VARCHAR(50)
);


-- Cria tabela
CREATE TABLE cap21.livros (
    LivroID SERIAL,
    Titulo VARCHAR(100) NOT NULL,
    AnoPublicacao INT,
    Genero VARCHAR(50)
);


-- Cria tabela
CREATE TABLE cap21.autoreslivros (
    AutorID INT,
    LivroID INT
);


-- Altera a tabela criada
ALTER TABLE cap21.autoreslivros
ADD Preco DECIMAL(10,2),
ADD DataLancamento DATE;


-- Stored Procedure para carregar os dados
CREATE OR REPLACE PROCEDURE cap21.carrega_dados()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Inserindo dados na tabela Autores
    FOR i IN 1..100 LOOP
        INSERT INTO cap21.autores (Nome, Nacionalidade)
        VALUES ('Autor ' || i, 'Nacionalidade ' || i);
    END LOOP;

    -- Inserindo dados na tabela Livros
    FOR i IN 1..300 LOOP
        INSERT INTO cap21.livros (Titulo, AnoPublicacao, Genero)
        VALUES ('Livro ' || i, 2000 + (i % 20), 'Genero ' || (i % 5));
    END LOOP;

    -- Associando autores e livros de maneira simplificada, com preço e data de lançamento
    FOR i IN 1..1500000 LOOP
        BEGIN
            INSERT INTO cap21.autoreslivros (AutorID, LivroID, Preco, DataLancamento)
            VALUES (
                (SELECT AutorID FROM cap21.autores ORDER BY RANDOM() LIMIT 1), -- Seleciona um AutorID aleatório
                (SELECT LivroID FROM cap21.livros ORDER BY RANDOM() LIMIT 1), -- Seleciona um LivroID aleatório
                ROUND((RANDOM() * 200)::numeric, 2), -- Gera um preço aleatório entre 0 e 200
                ('2010-01-01'::date + (RANDOM() * (3650))::int * '1 day'::interval)::date -- Gera uma data de lançamento aleatória no intervalo de 10 anos
            );
        EXCEPTION WHEN unique_violation THEN
            -- Ignora a violação de chave primária e continua. Nosso objetivo é apenas criar dados fictícios de exemplo.
        END;
    END LOOP;
END;
$$;


-- Executa a SP
CALL cap21.carrega_dados();

-- Exemplo de query SQL muito ruim
SELECT a.*, l.*, al.*
FROM cap21.autores a
CROSS JOIN cap21.livros l
LEFT JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID AND l.LivroID = al.LivroID
WHERE a.AutorID IN (SELECT AutorID FROM cap21.autores)
AND l.LivroID IN (SELECT LivroID FROM cap21.livros)
ORDER BY a.Nome, l.Titulo, al.DataLancamento;


# Por que essa query é ruim?
# Veja os detalhes no videobook no Capítulo 21 do curso.

# Como Melhorar a query acima?
# Veja os detalhes no videobook no Capítulo 21 do curso.


-- Versão melhorada da query anterior
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

-- Versão melhorada da query anterior
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

# Estratégia 1 - Indexação

# Para otimizar a performance da query acima, que envolve joins entre as tabelas autores, autoreslivros e livros, 
# além de uma ordenação baseada em múltiplas colunas, os seguintes índices são recomendados:

# Índices nas Chaves Estrangeiras:

# Na tabela autoreslivros, crie índices nas colunas AutorID e LivroID, já que estas colunas são usadas para o 
# join com as tabelas autores e livros, respectivamente. Isso facilita a busca rápida das linhas correspondentes 
# durante a operação de join.

CREATE INDEX idx_autoreslivros_autorid ON cap21.autoreslivros(AutorID);
CREATE INDEX idx_autoreslivros_livroid ON cap21.autoreslivros(LivroID);

# Índice na Coluna Usada para Ordenação:

-- Índice composto para autores baseado no nome
CREATE INDEX idx_autores_nome ON cap21.autores(Nome);

-- Índice composto para livros baseado no título
CREATE INDEX idx_livros_titulo ON cap21.livros(Titulo);

# Para a coluna al.DataLancamento, um índice pode ser útil se você frequentemente realiza consultas filtrando 
# ou ordenando por essa coluna:

CREATE INDEX idx_autoreslivros_datalancamento ON cap21.autoreslivros(DataLancamento);

# Estratégia 2 - Particionamento

# Para otimizar a tabela autoreslivros que contém 1.500.000 de registros, o particionamento é uma 
# estratégia eficaz, pois permite dividir uma grande tabela em partes mais gerenciáveis, baseadas em 
# regras específicas que se alinham com as consultas mais frequentes ou críticas para a aplicação. 
# A escolha da chave de particionamento deve refletir os padrões de acesso aos dados, com o objetivo de 
# melhorar o desempenho das consultas e facilitar a manutenção.

# O problema é que muitos SGBDs só permitem criar tabelas particionadas no momento da criação da tabela.

# Mas podemos resolver isso facilmente!

-- Cria nova tabela ativando o particionamento
CREATE TABLE cap21.autoreslivros_part (
    AutorID INT,
    LivroID INT,
    Preco DECIMAL(10,2),
    DataLancamento DATE
) PARTITION BY RANGE (DataLancamento);

-- Cria as partições
CREATE TABLE cap21.autoreslivros_p1 PARTITION OF cap21.autoreslivros_part
    FOR VALUES FROM ('2010-01-01') TO ('2016-01-01');

CREATE TABLE cap21.autoreslivros_p2 PARTITION OF cap21.autoreslivros_part
    FOR VALUES FROM ('2016-01-01') TO ('2021-01-01');

-- Copia os registros da tabela original para a nova tabela
INSERT INTO cap21.autoreslivros_part (AutorID, LivroID, Preco, DataLancamento)
SELECT AutorID, LivroID, Preco, DataLancamento FROM cap21.autoreslivros;

-- Altera o nome da tabela original
ALTER TABLE IF EXISTS cap21.autoreslivros RENAME TO autoreslivros_old;

-- Altera o nome da nova tabela
ALTER TABLE cap21.autoreslivros_part RENAME TO autoreslivros;

-- Versão melhorada da query
-- Precisamos usar como filtro a chave de partição
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento >= '2016-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

EXPLAIN SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento >= '2016-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

-- Versão melhorada da query
-- Precisamos usar como filtro a chave de partição
SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento = '2016-01-01' OR al.DataLancamento <=  '2012-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;

EXPLAIN SELECT a.Nome AS AutorNome, l.Titulo AS LivroTitulo, l.Genero AS LivroGenero, al.Preco, al.DataLancamento
FROM cap21.autores a
JOIN cap21.autoreslivros al ON a.AutorID = al.AutorID
JOIN cap21.livros l ON al.LivroID = l.LivroID
WHERE al.DataLancamento = '2016-01-01' OR al.DataLancamento <=  '2012-01-01'
ORDER BY a.Nome, l.Titulo, al.DataLancamento;
