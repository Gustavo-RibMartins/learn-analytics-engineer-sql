-- Cria o schema no banco de dados
CREATE SCHEMA cap15 AUTHORIZATION "pgAdministrador";

-- Criação da tabela
CREATE TABLE cap15.dsa_campanha_marketing (
    id SERIAL,
    nome_campanha VARCHAR(255),
    data_inicio DATE,
    data_fim DATE,
    orcamento DECIMAL(10, 2),
    publico_alvo VARCHAR(255),
    canais_divulgacao VARCHAR(255), 
    tipo_campanha VARCHAR(255), 
    taxa_conversao DECIMAL(5, 2),
    impressoes BIGINT
);

-- Stored Procedure de carga de dados
CREATE OR REPLACE PROCEDURE cap15.inserir_dados_campanha()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 1;
    randomTarget INT;
    randomConversionRate DECIMAL(5, 2);
    randomImpressions BIGINT;
    randomBudget DECIMAL(10, 2);
    randomChannel VARCHAR(255);
    randomCampaignType VARCHAR(255);
    randomStartDate DATE;
    randomEndDate DATE;
    randomPublicTarget VARCHAR(255);
BEGIN
    LOOP
        EXIT WHEN i > 1000;
        
        -- Gerar valores aleatórios
        randomTarget := 1 + (i % 5);
        randomConversionRate := ROUND((RANDOM() * 30)::numeric, 2);
        randomImpressions := (1 + FLOOR(RANDOM() * 10)) * 1000000;

        -- Valores condicionais
        randomBudget := CASE WHEN RANDOM() < 0.8 THEN ROUND((RANDOM() * 100000)::numeric, 2) ELSE NULL END;

        -- Canais de divulgação
        randomChannel := CASE
            WHEN RANDOM() < 0.8 THEN
                CASE FLOOR(RANDOM() * 3)
                    WHEN 0 THEN 'Google'
                    WHEN 1 THEN 'Redes Sociais'
                    ELSE 'Sites de Notícias'
                END
            ELSE NULL
        END;

        -- Tipo de campanha
        randomCampaignType := CASE
            WHEN RANDOM() < 0.8 THEN
                CASE FLOOR(RANDOM() * 3)
                    WHEN 0 THEN 'Promocional'
                    WHEN 1 THEN 'Divulgação'
                    ELSE 'Mais Seguidores'
                END
            ELSE NULL
        END;

        -- Definir datas aleatórias dos últimos 4 anos
        randomStartDate := CURRENT_DATE - (1 + FLOOR(RANDOM() * 1460)) * INTERVAL '1 day';
        randomEndDate := randomStartDate + (1 + FLOOR(RANDOM() * 30)) * INTERVAL '1 day';

        -- Publico Alvo aleatório com possibilidade de "?"
        randomPublicTarget := CASE WHEN RANDOM() < 0.2 THEN '?' ELSE 'Publico Alvo ' || randomTarget END;

        -- Inserir registro
        INSERT INTO cap15.dsa_campanha_marketing 
        (nome_campanha, data_inicio, data_fim, orcamento, publico_alvo, canais_divulgacao, tipo_campanha, taxa_conversao, impressoes)
        VALUES 
        ('Campanha ' || i, randomStartDate, randomEndDate, randomBudget, randomPublicTarget, randomChannel, randomCampaignType, randomConversionRate, randomImpressions);

        i := i + 1;
    END LOOP;
END;
$$;

-- Executa a SP
call cap15.inserir_dados_campanha();

-- Verifica os dados
SELECT * FROM cap15.dsa_campanha_marketing;

-- 1. Crie uma única query que identifique o total de valores ausentes em todas as colunas.

SELECT
    COUNT(*) - COUNT(id) AS id_missing,
    COUNT(*) - COUNT(nome_campanha) AS nome_campanha_missing,
    COUNT(*) - COUNT(data_inicio) AS data_inicio_missing,
    COUNT(*) - COUNT(data_fim) AS data_fim_missing,
    COUNT(*) - COUNT(orcamento) AS orcamento_missing,
    COUNT(*) - COUNT(publico_alvo) AS publico_alvo_missing,
    COUNT(*) - COUNT(canais_divulgacao) AS canais_divulgacao_missing,
    COUNT(*) - COUNT(tipo_campanha) AS tipo_campanha_missing,
    COUNT(*) - COUNT(taxa_conversao) AS taxa_conversao_missing,
    COUNT(*) - COUNT(impressoes) AS impressoes_missing
FROM 
    cap15.dsa_campanha_marketing;


-- 2. Crie uma query que identifique se em qualquer coluna há o caracter "?". 

SELECT *
FROM cap15.dsa_campanha_marketing
WHERE 
    nome_campanha LIKE '%?%' OR
    CAST(data_inicio AS VARCHAR) LIKE '%?%' OR
    CAST(data_fim AS VARCHAR) LIKE '%?%' OR
    CAST(orcamento AS VARCHAR) LIKE '%?%' OR
    publico_alvo LIKE '%?%' OR
    canais_divulgacao LIKE '%?%' OR
    tipo_campanha LIKE '%?%' OR
    CAST(taxa_conversao AS VARCHAR) LIKE '%?%' OR
    CAST(impressoes AS VARCHAR) LIKE '%?%';


-- 3. Crie uma query que identifique duplicatas (sem considerar a coluna id).

SELECT 
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    tipo_campanha,
    taxa_conversao,
    impressoes,
    COUNT(*) as duplicatas
FROM 
    cap15.dsa_campanha_marketing
GROUP BY 
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    tipo_campanha,
    taxa_conversao,
    impressoes
HAVING 
    COUNT(*) > 1;


-- 4. Crie uma query que identifique duplicatas considerando as colunas (nome_campanha, data_inicio, publico_alvo, canais_divulgacao).

SELECT *
FROM cap15.dsa_campanha_marketing
WHERE 
    (nome_campanha, data_inicio, publico_alvo, canais_divulgacao) IN (
        SELECT 
            nome_campanha, 
            data_inicio, 
            publico_alvo, 
            canais_divulgacao
        FROM 
            cap15.dsa_campanha_marketing
        GROUP BY 
            nome_campanha, 
            data_inicio, 
            publico_alvo, 
            canais_divulgacao
        HAVING 
            COUNT(*) > 1
    );


-- 5. Crie uma query que identifique outliers nas 3 colunas numéricas.   
-- Considere como outliers valores que estejam acima ou abaixo das seguintes regras: 
-- media + 1.5 * desvio_padrão
-- media - 1.5 * desvio_padrão

WITH stats AS (
    SELECT
        AVG(orcamento) AS avg_orcamento,
        STDDEV(orcamento) AS stddev_orcamento,
        AVG(taxa_conversao) AS avg_taxa_conversao,
        STDDEV(taxa_conversao) AS stddev_taxa_conversao,
        AVG(impressoes) AS avg_impressoes,
        STDDEV(impressoes) AS stddev_impressoes
    FROM
        cap15.dsa_campanha_marketing
)
SELECT
    id,
    nome_campanha,
    data_inicio,
    data_fim,
    orcamento,
    publico_alvo,
    canais_divulgacao,
    taxa_conversao,
    impressoes
FROM
    cap15.dsa_campanha_marketing,
    stats
WHERE
    orcamento < (avg_orcamento - 1.5 * stddev_orcamento) OR 
    orcamento > (avg_orcamento + 1.5 * stddev_orcamento) OR
    taxa_conversao < (avg_taxa_conversao - 1.5 * stddev_taxa_conversao) OR 
    taxa_conversao > (avg_taxa_conversao + 1.5 * stddev_taxa_conversao) OR
    impressoes < (avg_impressoes - 1.5 * stddev_impressoes) OR 
    impressoes > (avg_impressoes + 1.5 * stddev_impressoes);

-- Verifica os dados

SELECT * FROM cap15.dsa_campanha_marketing;


-- 1. Crie uma query que identifique os valores únicos da coluna publico_alvo.

SELECT DISTINCT publico_alvo
FROM cap15.dsa_campanha_marketing;


-- 2. Crie uma query com update que substitua o caracter "?" na coluna publico_alvo pelo valor "Outros".

UPDATE cap15.dsa_campanha_marketing
SET publico_alvo = 'Outros'
WHERE publico_alvo = '?';


-- 3. Crie uma query que identifique o total de registros de cada valor da coluna canais_divulgacao.

SELECT canais_divulgacao, COUNT(*) as total_registros
FROM cap15.dsa_campanha_marketing
GROUP BY canais_divulgacao;


-- 4. Crie uma query com update que substitua os valores ausentes pela moda da coluna canais_divulgacao.

-- Primeiro encontramos a moda da coluna canais_divulgacao e depois usamos para fazer o update:

SELECT canais_divulgacao
FROM cap15.dsa_campanha_marketing
WHERE canais_divulgacao IS NOT NULL
GROUP BY canais_divulgacao
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Agora o update
UPDATE cap15.dsa_campanha_marketing
SET canais_divulgacao = 'Redes Sociais'
WHERE canais_divulgacao IS NULL;


-- 5. Crie uma query que identifique o total de registros de cada valor da coluna tipo_campanha.

SELECT tipo_campanha, COUNT(*) as total_registros
FROM cap15.dsa_campanha_marketing
GROUP BY tipo_campanha;


-- 6. Considere que os valores ausentes na coluna tipo_campanha sejam erros de coleta de dados. 
-- Crie uma query com delete que remova os registros onde tipo_campanha tiver valor nulo.

DELETE FROM cap15.dsa_campanha_marketing
WHERE tipo_campanha IS NULL;


-- Valores ausentes restantes:

SELECT
    COUNT(*) - COUNT(id) AS id_missing,
    COUNT(*) - COUNT(nome_campanha) AS nome_campanha_missing,
    COUNT(*) - COUNT(data_inicio) AS data_inicio_missing,
    COUNT(*) - COUNT(data_fim) AS data_fim_missing,
    COUNT(*) - COUNT(orcamento) AS orcamento_missing,
    COUNT(*) - COUNT(publico_alvo) AS publico_alvo_missing,
    COUNT(*) - COUNT(canais_divulgacao) AS canais_divulgacao_missing,
    COUNT(*) - COUNT(tipo_campanha) AS tipo_campanha_missing,
    COUNT(*) - COUNT(taxa_conversao) AS taxa_conversao_missing,
    COUNT(*) - COUNT(impressoes) AS impressoes_missing
FROM 
    cap15.dsa_campanha_marketing;