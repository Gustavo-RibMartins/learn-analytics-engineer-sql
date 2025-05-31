-- Cria o schema
CREATE SCHEMA cap19 AUTHORIZATION "pgAdministrador";


-- Cria a tabela 'clientes'
CREATE TABLE cap19.clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    cidade VARCHAR(255)
);

-- Cria a tabela 'interacoes'
CREATE TABLE cap19.interacoes (
    interacao_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    tipo_interacao VARCHAR(50),
    descricao TEXT,
    data_hora DATE,
    FOREIGN KEY (cliente_id) REFERENCES cap19.clientes(cliente_id)
);

-- Cria a tabela 'vendas'
CREATE TABLE cap19.vendas (
    venda_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_venda DECIMAL(10, 2) NOT NULL,
    data_venda DATE,
    FOREIGN KEY (cliente_id) REFERENCES cap19.clientes(cliente_id)
);

-- Crie uma Stored Procedure (SP) que gere dados aleatórios de clientes e carregue os dados na tabela de clientes
-- A SP deve permitir cadastrar qualquer número de clientes
CREATE OR REPLACE PROCEDURE cap19.inserir_clientes_aleatorios(num_clientes INT)
LANGUAGE plpgsql
AS $$
DECLARE
    
    i INT;
    
    nome_aleatorio VARCHAR(255);
    endereco_aleatorio VARCHAR(255);
    cidade_aleatoria VARCHAR(255);

    lista_cidades TEXT[] := ARRAY['São Paulo', 
                                  'Rio de Janeiro', 
                                  'Belo Horizonte', 
                                  'Vitória', 
                                  'Porto Alegre', 
                                  'Salvador', 
                                  'Blumenau', 
                                  'Curitiba', 
                                  'Fortaleza', 
                                  'Manaus', 
                                  'Recife', 
                                  'Goiânia'
    ];
BEGIN
    FOR i IN 1..num_clientes LOOP
        
        -- Gera um nome aleatório no formato: Cliente_i_LETRA
        nome_aleatorio := 'Cliente_' || i || '_' || chr(trunc(65 + random()*25)::int);

        -- Na linha acima nós temos:
        -- random(): Gera um número aleatório entre 0 (inclusive) e 1 (exclusivo).
        -- random()*25: Multiplica o número aleatório por 25. O resultado está no intervalo de 0 a 24.999... .
        -- 65 + random()*25: Adiciona 65 ao resultado anterior. Agora, o resultado está no intervalo de 65 a 89.999... . Os números 65 a 90 correspondem aos códigos ASCII das letras maiúsculas A-Z.
        -- trunc(...): A função trunc remove a parte fracionária do número, resultando em um inteiro entre 65 e 89.
        -- ::int: É uma cast para o tipo inteiro, embora trunc já retorne um inteiro, garantindo que o resultado seja um número inteiro.
        -- chr(...): Converte o número inteiro de volta em um caractere, de acordo com a tabela ASCII. Isso resultará em uma letra maiúscula aleatória entre A e Z.

        -- Gera um endereço aleatório no formato: Rua LETRA, numero
        endereco_aleatorio := 'Rua ' || chr(trunc(65 + random()*25)::int) || ', ' || trunc(random()*1000)::text;

        -- Seleciona uma cidade aleatória
        SELECT INTO cidade_aleatoria 
            lista_cidades[trunc(random() * array_upper(lista_cidades, 1)) + 1] AS cidade;

        -- Na linha acima nós temos:
        -- random() gera um número aleatório entre 0 (inclusive) e 1 (exclusivo).
        -- array_upper(lista_cidades, 1) retorna o maior índice válido do array lista_cidades (ou seja, o tamanho do array).
        -- Multiplicar random() pelo tamanho do array resulta em um número no intervalo de 0 até o tamanho do array (mas não incluindo o limite superior).
        -- A função trunc é usada para arredondar o número para baixo para o inteiro mais próximo, resultando em um índice entre 0 e o tamanho do array menos 1.
        -- Adicionar 1 ajusta o índice para o intervalo de 1 até o tamanho do array, que são índices válidos em PostgreSQL (os arrays começam em 1, não em 0).

        -- Insere os dados na tabela 'clientes'
        INSERT INTO cap19.clientes (nome, endereco, cidade) VALUES
        (nome_aleatorio, endereco_aleatorio, cidade_aleatoria);

    END LOOP;
END;
$$;

-- Para executar a Stored Procedure e inserir um número específico de clientes, use:
CALL cap19.inserir_clientes_aleatorios(1000);


-- Cria a Stored Procedure 
CREATE OR REPLACE PROCEDURE cap19.inserir_interacoes_exemplo()
LANGUAGE plpgsql
AS $$
DECLARE

    -- Variáveis
    cliente RECORD;
    data_aleatoria DATE;
    
BEGIN

    -- Itera sobre cada cliente na tabela 'clientes'
    FOR cliente IN SELECT cliente_id FROM cap19.clientes LOOP
    
        -- Gera uma data aleatória entre 2021 e 2025
        data_aleatoria := '2021-01-01'::DATE + (trunc(random() * (365 * 5))::INT);

        -- Insere uma interação de exemplo para cada cliente com data aleatória
        INSERT INTO cap19.interacoes (cliente_id, tipo_interacao, descricao, data_hora) VALUES
        (cliente.cliente_id, 'Email', 'Email enviado com informações do produto', data_aleatoria),
        (cliente.cliente_id, 'Telefone', 'Chamada telefônica para acompanhamento', data_aleatoria),
        (cliente.cliente_id, 'Reunião', 'Reunião agendada para discussão de detalhes', data_aleatoria);

    END LOOP;
END;
$$;

-- Para executar a Stored Procedure, use:
CALL cap19.inserir_interacoes_exemplo();


-- Cria a Stored Procedure 
CREATE OR REPLACE PROCEDURE cap19.inserir_vendas_exemplo()
LANGUAGE plpgsql
AS $$
DECLARE

    -- Variáveis
    cliente RECORD;
    numero_vendas INT;
    quantidade_venda INT;
    valor_venda DECIMAL(10, 2);
    data_venda_aleatoria DATE;
    
BEGIN

    -- Itera sobre cada cliente na tabela 'clientes'
    FOR cliente IN SELECT cliente_id FROM cap19.clientes LOOP
    
        -- Gera entre 1 a 5 vendas para cada cliente
        numero_vendas := trunc(random() * 5 + 1)::INT; 

        -- Insere vendas aleatórias para o cliente
        FOR i IN 1..numero_vendas LOOP
        
            -- Gera um valor aleatório para a venda (Valores entre 500 e 10500)
            valor_venda := trunc(random() * 10000 + 500)::DECIMAL; 

            -- Gera uma quantidade aleatória para a venda
            quantidade_venda := trunc(random() * 10 + 1)::INT;

            -- Gera uma data de venda aleatória entre 2021 e 2025
            data_venda_aleatoria := '2021-01-01'::DATE + (trunc(random() * (365 * 5))::INT);

            -- Insere a venda na tabela 'vendas'
            INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda) VALUES
            (cliente.cliente_id, quantidade_venda, valor_venda, data_venda_aleatoria);
            
        END LOOP;
    END LOOP;
END;
$$;

-- Para executar a Stored Procedure, use:
CALL cap19.inserir_vendas_exemplo();

SELECT * 
FROM cap19.clientes
ORDER BY cliente_id ASC;


SELECT * 
FROM cap19.interacoes
ORDER BY interacao_id ASC;


SELECT * 
FROM cap19.vendas
ORDER BY venda_id ASC;


-- Retorne id, nome e cidade dos clientes que tiveram interação por e-mail e que moram na RUA A
SELECT c.cliente_id, c.nome, c.cidade
FROM cap19.clientes c
INNER JOIN cap19.interacoes i ON c.cliente_id = i.cliente_id
WHERE c.endereco LIKE 'Rua A%' AND i.tipo_interacao = 'Email';


-- Armazena a query no banco de dados criando uma View
CREATE VIEW cap19.clientes_interacao_email_rua_a AS
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade
FROM 
    cap19.clientes c
INNER JOIN 
    cap19.interacoes i ON c.cliente_id = i.cliente_id
WHERE 
    c.endereco LIKE 'Rua A%' AND
    i.tipo_interacao = 'Email';


-- Consulta a View
SELECT * FROM cap19.clientes_interacao_email_rua_a;


-- Consulta a View
SELECT * FROM cap19.clientes_interacao_email_rua_a WHERE cliente_id > 280;


-- Nome, rua e cidade do cliente com a data da última interação por e-mail
CREATE VIEW cap19.clientes_interacoes_resumo AS
SELECT 
    c.nome,
    c.endereco,
    c.cidade,
    MAX(i.data_hora) AS ultima_interacao
FROM 
    cap19.clientes c
LEFT JOIN 
    cap19.interacoes i ON c.cliente_id = i.cliente_id
WHERE 
	i.tipo_interacao = 'Email'
GROUP BY 
    c.nome, c.endereco, c.cidade
ORDER BY ultima_interacao DESC;


-- Consulta a View
SELECT * FROM cap19.clientes_interacoes_resumo;


-- Esta View apresentará o total de vendas e o valor total de vendas por cidade.
CREATE VIEW cap19.vendas_por_cidade AS
SELECT 
    c.cidade,
    COUNT(v.venda_id) AS total_unidades_vendidas,
    SUM(v.valor_venda) AS valor_total_vendas
FROM 
    cap19.vendas v
JOIN 
    cap19.clientes c ON v.cliente_id = c.cliente_id
GROUP BY 
    c.cidade;


-- Consulta a View
SELECT * FROM cap19.vendas_por_cidade;


-- Esta View listará clientes que realizaram compras nos últimos 12 meses e tiveram mais de uma interação no mesmo período.
CREATE VIEW cap19.clientes_ativos AS
SELECT 
    c.cliente_id,
    c.nome,
    c.endereco,
    c.cidade
FROM 
    cap19.clientes c
WHERE 
    c.cliente_id IN (SELECT v.cliente_id FROM cap19.vendas v WHERE v.data_venda >= CURRENT_DATE - INTERVAL '1 year')
    AND c.cliente_id IN (SELECT i.cliente_id FROM cap19.interacoes i WHERE i.data_hora >= CURRENT_DATE - INTERVAL '1 year' GROUP BY i.cliente_id HAVING COUNT(i.interacao_id) > 1);


-- Consulta a View
SELECT * FROM cap19.clientes_ativos;

-- Cria a MView
CREATE MATERIALIZED VIEW cap19.mv_ultima_interacao_email AS
SELECT 
    c.nome,
    c.endereco,
    c.cidade,
    MAX(i.data_hora) AS ultima_interacao
FROM 
    cap19.clientes c
LEFT JOIN 
    cap19.interacoes i ON c.cliente_id = i.cliente_id
WHERE 
    i.tipo_interacao = 'Email'
GROUP BY 
    c.nome, c.endereco, c.cidade
ORDER BY 
    ultima_interacao DESC;


-- Consulta a MView
SELECT * FROM cap19.mv_ultima_interacao_email;


-- Refresh da MView
REFRESH MATERIALIZED VIEW cap19.mv_ultima_interacao_email;


-- Cria a MView
CREATE MATERIALIZED VIEW cap19.mv_clientes_ativos AS
SELECT * FROM cap19.clientes_ativos;


-- Consulta a MView
SELECT * FROM cap19.mv_clientes_ativos;


-- Refresh da MView
REFRESH MATERIALIZED VIEW cap19.mv_clientes_ativos;

-- Isso aqui não funciona:
SELECT * FROM cap19.inserir_vendas_exemplo;
SELECT * FROM cap19.inserir_vendas_exemplo();


-- Vamos criar um relatório que calcula o valor total de vendas para um cliente específico. 
-- Se não houve venda, o relatório deve retornar zero.
CREATE OR REPLACE FUNCTION cap19.calcular_total_vendas_cliente(cliente_id_param INT)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    total_vendas DECIMAL(10, 2);
BEGIN
    SELECT SUM(valor_venda) INTO total_vendas
    FROM cap19.vendas
    WHERE cliente_id = cliente_id_param;

    IF total_vendas IS NULL THEN
        RETURN 0;
    ELSE
        RETURN total_vendas;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Substitua 10 pelo cliente_id desejado
SELECT cap19.calcular_total_vendas_cliente(10); 


-- Retorna o cliente de id 10
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade
FROM 
    cap19.clientes c
WHERE 
    c.cliente_id = 10;


-- Retorna o cliente de id 10 com o total de vendas
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade,
    cap19.calcular_total_vendas_cliente(10) AS total_vendas
FROM 
    cap19.clientes c
WHERE 
    c.cliente_id = 10;


-- Cria a View
CREATE VIEW cap19.retorna_vendas_cliente_10 AS
SELECT 
    c.cliente_id,
    c.nome,
    c.cidade,
    cap19.calcular_total_vendas_cliente(10) AS total_vendas
FROM 
    cap19.clientes c
WHERE 
    c.cliente_id = 10;


-- Executa a View
SELECT * FROM cap19.retorna_vendas_cliente_10


-- O uso de funções é ainda mais interessante quando associamos com triggers.

-- Altera a tabela e insere mais um campo
ALTER TABLE cap19.clientes
ADD COLUMN ultima_compra DATE;


-- Esta function será chamada quando uma nova venda for inserida na tabela vendas. 
-- Ela atualizará a coluna ultima_compra na tabela clientes.
CREATE OR REPLACE FUNCTION cap19.atualizar_ultima_compra()
RETURNS TRIGGER AS $$
BEGIN
    -- Atualiza a coluna 'ultima_compra' na tabela 'clientes'
    UPDATE cap19.clientes
    SET ultima_compra = NEW.data_venda
    WHERE cliente_id = NEW.cliente_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- Cria a trigger
CREATE TRIGGER atualiza_data_venda
AFTER INSERT ON cap19.vendas
FOR EACH ROW
EXECUTE FUNCTION cap19.atualizar_ultima_compra();


-- Transação no banco de dados para inserir uma venda

BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 10
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (10, 1, 120.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


-- Transação no banco de dados para inserir uma venda

BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 10
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (10, 3, 439.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


-- Transação no banco de dados para inserir uma transação completa em todas as tabelas

BEGIN; -- Inicia a transação

-- Insere um novo cliente e captura o cliente_id gerado
WITH novo_cliente AS (
    INSERT INTO cap19.clientes (nome, endereco, cidade) 
    VALUES ('Novo Cliente DSA', '123 Rua Principal', 'São Paulo') 
    RETURNING cliente_id
)
-- Insere uma nova interação com o cliente_id obtido
, nova_interacao AS (
    INSERT INTO cap19.interacoes (cliente_id, tipo_interacao, descricao, data_hora)
    SELECT cliente_id, 'Email', 'Email de boas-vindas enviado', CURRENT_DATE
    FROM novo_cliente
    RETURNING interacao_id
)
-- Insere uma nova venda com o cliente_id obtido
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
SELECT cliente_id, 1, 100.00, CURRENT_DATE
FROM novo_cliente;

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


-- Verifica os clientes que fizeram as compras mais recentes
SELECT * FROM cap19.clientes
WHERE ultima_compra IS NOT NULL;


-- Função para inserir clientes no banco de dados fazendo validações
CREATE OR REPLACE FUNCTION cap19.inserir_novo_cliente(nome_cliente VARCHAR, endereco_cliente VARCHAR, cidade_cliente VARCHAR)
RETURNS VOID AS $$
BEGIN
    -- Tenta inserir um novo cliente
    INSERT INTO cap19.clientes (nome, endereco, cidade)
    VALUES (nome_cliente, endereco_cliente, cidade_cliente);

    -- Se tudo ocorrer bem, a função termina aqui

    -- Se der erro, retorna conforme abaixo
    EXCEPTION
        WHEN unique_violation THEN
            RAISE NOTICE 'Erro: o cliente já existe.';
        WHEN check_violation THEN
            RAISE NOTICE 'Erro: violação de restrição de verificação.';
        WHEN others THEN
            RAISE NOTICE 'Erro inesperado: %', SQLERRM;
            -- Reverte as alterações feitas na transação atual
            ROLLBACK;
END;
$$ LANGUAGE plpgsql;


-- Executa a função
SELECT cap19.inserir_novo_cliente('DSA Novo Cliente 1', '80 Rua Z', 'Blumenau');
SELECT cap19.inserir_novo_cliente('DSA Novo Cliente 2', '90 Rua Y', 'Natal');
SELECT cap19.inserir_novo_cliente('DSA Novo Cliente 3', '100 Rua X', 'Palmas');


-- Vamos cadastrar vendas para os clientes

BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1001
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1002, 2, 453.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1001
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1003, 2, 670.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


BEGIN; -- Inicia a transação

-- Insere uma nova venda para o cliente de id 1001
INSERT INTO cap19.vendas (cliente_id, quantidade, valor_venda, data_venda)
VALUES (1004, 2, 345.00, CURRENT_DATE);

-- Se tudo ocorreu bem, confirma as alterações
COMMIT;


-- Cria function para gerar relatório de vendas
CREATE OR REPLACE FUNCTION cap19.relatorio_vendas_clientes()
RETURNS TABLE (nome_cliente VARCHAR, valor_total_vendas DECIMAL, data_ultima_compra DATE) AS $$
DECLARE

    -- Variáveis
    cliente_record RECORD;
    cursor_clientes CURSOR FOR SELECT * FROM cap19.clientes WHERE ultima_compra IS NOT NULL;
BEGIN

    -- Abre o cursor
    OPEN cursor_clientes;

    -- Loop em cada registro do cursor para gerar os valores de saída
    LOOP
        FETCH cursor_clientes INTO cliente_record;
        EXIT WHEN NOT FOUND;

        -- Nome vem do cursor
        nome_cliente := cliente_record.nome; 
        
        -- Total de vendas vem da outra função
        SELECT INTO valor_total_vendas cap19.calcular_total_vendas_cliente(cliente_record.cliente_id); 

        -- Data vem do cursor
        data_ultima_compra := cliente_record.ultima_compra; 

        RETURN NEXT; 

    END LOOP;
    CLOSE cursor_clientes;
END;
$$ LANGUAGE plpgsql;


-- Executa a function
SELECT * FROM cap19.relatorio_vendas_clientes();
