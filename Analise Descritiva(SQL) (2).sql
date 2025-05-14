-- Databricks notebook source
-- MAGIC %md
-- MAGIC **## Sobre o Conjunto de Dados**
-- MAGIC - Quais Fatores Afetam os Preços de Computadores Portáteis (Laptops)?
-- MAGIC Diversos fatores diferentes podem afetar os preços dos computadores portáteis. Esses fatores incluem a marca do computador e o número de opções e acessórios incluídos no pacote. Além disso, a quantidade de memória e a velocidade do processador também podem influenciar no preço. Embora menos comum, alguns consumidores gastam mais dinheiro com base na aparência e no design geral do sistema.
-- MAGIC  
-- MAGIC - Em muitos casos, computadores de marcas conhecidas são mais caros do que versões genéricas. Esse aumento de preço costuma estar mais relacionado ao reconhecimento da marca do que à superioridade real do produto. Uma das principais diferenças entre sistemas de marcas conhecidas e versões genéricas é que, na maioria dos casos, os computadores de marca oferecem garantias melhores. Ter a opção de devolver um computador com defeito muitas vezes é um incentivo suficiente para que muitos consumidores gastem mais.
-- MAGIC
-- MAGIC - A funcionalidade é um fator importante na determinação dos preços dos laptops. Um computador com mais memória geralmente tem um desempenho melhor e por mais tempo do que um com menos memória. Além disso, o espaço no disco rígido também é crucial, e o tamanho do HD costuma impactar o preço. Muitos consumidores também procuram por drivers de vídeo digital e outros dispositivos de gravação que podem influenciar nos preços dos laptops.
-- MAGIC
-- MAGIC - A maioria dos computadores vem com alguns softwares pré-instalados. Na maioria dos casos, quanto mais programas instalados, mais caro é o computador. Isso é especialmente verdadeiro se os programas forem de desenvolvedores reconhecidos. Aqueles que estão pensando em comprar um novo laptop devem estar atentos ao fato de que muitos dos programas pré-instalados são apenas versões de teste, que expiram após um determinado período. Para manter os programas, será necessário comprar um código para baixar a versão completa.
-- MAGIC - 
-- MAGIC - Muitos consumidores que estão comprando um novo computador estão adquirindo um pacote completo. Além do próprio computador, esses sistemas normalmente incluem monitor, teclado e mouse. Alguns pacotes podem até incluir uma impressora ou câmera digital. O número de itens extras incluídos no pacote geralmente afeta o preço do laptop.
-- MAGIC - 
-- MAGIC - Alguns líderes da indústria de computadores destacam o design moderno e a variedade de cores como diferencial de venda. Também podem oferecer projetos de sistema incomuns ou contemporâneos. Embora isso seja menos importante para muitos consumidores, para aqueles que valorizam a “aparência”, esse tipo de sistema pode valer o custo extra.
-- MAGIC
-- MAGIC - De onde eu obtive esses dados?
-- MAGIC Raspei esses dados do site flipkart.com usando uma extensão automatizada do Chrome chamada Instant Data Scraper.
-- MAGIC Recomendo fortemente o uso dessa ferramenta incrível para obter dados de qualquer lugar da web. É muito fácil de usar e não exige conhecimento de programação.
-- MAGIC
-- MAGIC ## **O que você pode fazer?**
-- MAGIC - Visualize os dados e crie gráficos de alta qualidade sempre que possível.
-- MAGIC
-- MAGIC - Construa um modelo para prever o preço.
-- MAGIC
-- MAGIC - Descrição das colunas: por favor, consulte a seção de colunas dos dados.

-- COMMAND ----------

-- MAGIC %md 
-- MAGIC ##ANALISE DESCRITIVIA (SQL) 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Média de Preços das Marcas

-- COMMAND ----------

create view vw_notebook_vendidos 
as 
select * from notebook_vendidos

-- COMMAND ----------

alter view vw_notebook_vendidos
as
select *, (preco_atual * 0.066) as preco_atual_real, (preco_anterior * 0.066)  as preco_anterior_real,
(desconto / 100) as desconto_formatado
from notebook_vendidos

-- COMMAND ----------

select * from vw_notebook_vendidos

-- COMMAND ----------

--- MEDIA DE PREÇO POR MARCAS !
select 
case when marca = 'lenovo' then'Lenovo'
       else marca 
  end as marca_ajustada,
  avg(preco_atual_real) as media_preco

from vw_notebook_vendidos

group by 
case when marca = 'lenovo' then'Lenovo'
       else marca 
end
order by 2 desc


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Participação das Memórias(DDR3,DDR4 e DDR5)

-- COMMAND ----------

--- MEDIA DE PREÇO POR MEMORIA !
select 
case when ram_type = 'LPDDR3' then 'DDR3'
     when ram_type IN('LPDDR4','LPDDR4X') then 'DDR4' else ram_type end 
     as ram_type_ajustada,

sum(preco_atual_real) as soma_preco_atual

from vw_notebook_vendidos

group by 
case when ram_type = 'LPDDR3' then 'DDR3'
     when ram_type IN('LPDDR4','LPDDR4X') then 'DDR4' else ram_type end 
order by 2 desc


-- COMMAND ----------

--- Qual Modelo tiveram a melhor nota!
select distinct marca, modelo,nota

from vw_notebook_vendidos
WHERE nota = 5.0
order by nota desc;


-- COMMAND ----------

