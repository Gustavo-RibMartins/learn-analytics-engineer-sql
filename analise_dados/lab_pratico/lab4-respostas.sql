-- 1. Qual o Número Total de Vendas e Média de Quantidade Vendida?

select
	count(*) as total_vendas,
	round(avg(quantidade), 2) as media_qtde_vendida
from
	lab4.vendas

-- 2. Qual o Número Total de Produtos Únicos Vendidos?

select
	count(distinct id_produto) as total_produtos_unicos
from
	lab4.vendas

-- 3. Quantas Vendas Ocorreram Por Produto? Mostre o Resultado em Ordem Decrescente.

select
	p.nome as nome_produto,
	count(v.id_produto) as qtde_vendas
from
	lab4.vendas as v
	left join
	lab4.produtos as p
on
	v.id_produto = p.id_produto
group by
	p.nome
order by
	qtde_vendas desc

-- 4. Quais os 5 Produtos com Maior Número de Vendas?

select
	p.nome as nome_produto,
	count(v.id_produto) as qtde_vendas
from
	lab4.vendas as v
	left join
	lab4.produtos as p
on
	v.id_produto = p.id_produto
group by
	p.nome
order by
	qtde_vendas desc
limit 5

-- 5. Quais Clientes Fizeram 6 ou Mais Transações de Compra?

select
	c.nome as nome_cliente,
	count(*) as qtde_transacoes_vendas
from
	lab4.vendas as v
	left join
	lab4.clientes as c
on
	v.id_cliente = c.id_cliente
group by
	c.nome
having
	count(*) >= 6
order by
	qtde_transacoes_vendas desc

-- 6. Qual o Total de Transações Comerciais Por Mês no Ano de 2024? Apresente os Nomes dos Meses no Resultado, Que Deve Ser Ordenado Por Mês.

select
	to_char(data_venda, 'Month') as mes_venda_2024,
	count(*) as qtde_transacoes
from
	lab4.vendas
where
	extract(year from data_venda) = 2024
group by
	to_char(data_venda, 'Month'),
	extract(month from data_venda)
order by
	extract(month from data_venda)

-- 7. Quantas Vendas de Notebooks Ocorreram em Junho e Julho de 2023?

select
	count(*) as qtde_vendas_notebook
from
	lab4.vendas as v
	left join
	lab4.produtos as p
on
	v.id_produto = p.id_produto
where
	p.nome = 'Notebook' and
	extract(year from v.data_venda) = 2023 and
	extract(month from v.data_venda) in (6, 7)

-- 8. Qual o Total de Vendas Por Mês e Por Ano ao Longo do Tempo?

select
	coalesce(
		cast(extract(year from data_venda) as varchar(4)),
		'Total Geral'
	) as ano,
	coalesce(
		cast(extract(month from data_venda) as varchar(2)),
		'Total Ano'
	) as mes,
	count(*)
from
	lab4.vendas
group by
	rollup(extract(year from data_venda), extract(month from data_venda))
order by
	ano, extract(month from data_venda)

-- 9. Quais Produtos Tiveram Menos de 100 Transações de Venda?

select
	p.nome as nome_produto,
	count(v.id_produto) as qtde_vendas
from
	lab4.vendas as v
	left join
	lab4.produtos as p
on
	v.id_produto = p.id_produto
group by
	p.nome
having
	count(v.id_produto) < 100
order by
	qtde_vendas desc

-- 10. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch?

with cliente_produto as (
select
	c.nome as nome_cliente,
	string_agg(p.nome, ',') as nome_produtos
from
	lab4.vendas as v
	inner join
	lab4.produtos as p
on
	v.id_produto = p.id_produto
	inner join
	lab4.clientes as c
on
	v.id_cliente = c.id_cliente
group by
	c.nome
)

select
	nome_cliente,
	nome_produtos
from
	cliente_produto
where
	nome_produtos like '%Smartphone%' and
	nome_produtos like '%Smartwatch%'
order by
	nome_cliente

-- 11. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook?

with cliente_produto as (
select
	c.nome as nome_cliente,
	string_agg(p.nome, ',') as nome_produtos
from
	lab4.vendas as v
	inner join
	lab4.produtos as p
on
	v.id_produto = p.id_produto
	inner join
	lab4.clientes as c
on
	v.id_cliente = c.id_cliente
group by
	c.nome
)

select
	nome_cliente,
	nome_produtos
from
	cliente_produto
where
	nome_produtos like '%Smartphone%' and
	nome_produtos like '%Smartwatch%' and
	nome_produtos not like '%Notebook%'
order by
	nome_cliente

-- 12. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook em Maio/2024?

with cliente_produto as (
select
	v.id_cliente,
	c.nome as nome_cliente,
	string_agg(p.nome, ',') as nome_produtos
from
	lab4.vendas as v
	inner join
	lab4.produtos as p
on
	v.id_produto = p.id_produto
	inner join
	lab4.clientes as c
on
	v.id_cliente = c.id_cliente
group by
	v.id_cliente,
	c.nome
)

, vendas_notebook_202405 as (
select
	v.id_cliente
from
	lab4.vendas as v
	inner join
	lab4.produtos as p
on
	v.id_produto = p.id_produto
where
	p.nome = 'Notebook' and
	extract(year from v.data_venda) = 2024 and
	extract(month from v.data_venda) = 5
)

select
	id_cliente,
	nome_cliente,
	nome_produtos
from
	cliente_produto
where
	nome_produtos like '%Smartphone%' and
	nome_produtos like '%Smartwatch%' and
	id_cliente not in (
		select id_cliente
		from vendas_notebook_202405
	)
order by
	nome_cliente

-- 13.  Qual  a  Média  Móvel  de  Quantidade  de  Unidades  Vendidas  ao  Longo  do  Tempo? Considere Janela de 7 Dias.

select
	data_venda,
	quantidade,
	round(avg(quantidade) over (
		order by data_venda
		rows between 3 preceding and 3 following
	),2) as media_movel_7d_qtde_vendida
from
	lab4.vendas

-- 14. Qual a Média Móvel e Desvio Padrão Móvel de Quantidade de Unidades Vendidas ao Longo do Tempo? Considere Janela de 7 Dias.

select
	data_venda,
	quantidade,
	round(avg(quantidade) over (
		order by data_venda
		rows between 3 preceding and 3 following
	),2) as media_movel_7d_qtde_vendida,
	round(stddev(quantidade) over (
		order by data_venda
		rows between 3 preceding and 3 following
	),2) as desvpad_movel_7d_qtde_vendida
from
	lab4.vendas

-- 15. Quais Clientes Estão Cadastrados, Mas Ainda Não Fizeram Transação?

select
	c.nome as nome_cliente_sem_transacao
from
	lab4.clientes as c
	left join
	lab4.vendas as v
on
	c.id_cliente = v.id_cliente
where
	v.id_cliente is null
order by
	c.nome