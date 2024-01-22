
#Selecionar todas as colunas tabela categoria
SELECT *
FROM lab."TB_CATEGORIA";

#Filtra os dados no nível de linha. Selecionar todas as colunas onde o ID_CATEGORIA for maior do que 2
SELECT *
FROM lab."TB_CATEGORIA"
WHERE "ID_Categoria" > 2;

#Filtra os dados no nível de coluna
SELECT "Nome_Categoria", "Codigo_Categoria"
FROM lab."TB_CATEGORIA"
WHERE "ID_Categoria" > 2;

#Tomar cuidado, pq o Like pode causar problema de performance. Retorne 2 colunas da tabela Categoria onde o nome Categoria começar com a letra C e tiver qualquer coisa após a letra C.
SELECT "Nome_Categoria", "Codigo_Categoria"
FROM lab."TB_CATEGORIA"
WHERE "Nome_Categoria" LIKE 'C%';

#Todas as linhas da tabela de categoria onde o nome que começar com a letra C e o codigo_categoria for menor do que 1003 (as duas expressões tem que ser verdadeira para retornar o registro)
SELECT "Nome_Categoria", "Codigo_Categoria"
FROM lab."TB_CATEGORIA"
WHERE "Nome_Categoria" LIKE 'C%' AND "Codigo_Categoria" < 1003;

#Todas as linhas da tabela de categoria onde o nome que começar com a letra C OU o codigo_categoria for menor do que 1003 (apenas uma das cond precisa ser verdadeira)
SELECT "Nome_Categoria", "Codigo_Categoria"
FROM lab."TB_CATEGORIA"
WHERE "Nome_Categoria" LIKE 'C%' OR "Codigo_Categoria" < 1003;

#Current_timestamp: horário corrente no SGBD. É bom para verificar quanto tempo está levando a linha para retornar e se demorar demais se está com problemas.
SELECT "Nome_Categoria", "Codigo_Categoria", CURRENT_TIMESTAMP AS "Hora_Consulta"
FROM lab."TB_CATEGORIA"
WHERE "Nome_Categoria" LIKE 'C%' OR "Codigo_Categoria" < 1003;

SELECT *
FROM lab."TB_PRODUTO";

#Tabela produto onde Peso_produto não for nulo
SELECT *
FROM lab."TB_PRODUTO"
WHERE "Peso_Produto" IS NOT NULL;

#Contar na tabela onde não tiver nulo
SELECT COUNT(*)
FROM lab."TB_PRODUTO"
WHERE "Peso_Produto" IS NOT NULL;

#Preço máximo e mínimo
SELECT MAX("Preco_Produto"), MIN("Preco_Produto")
FROM lab."TB_PRODUTO"
WHERE "Peso_Produto" IS NOT NULL;

#Duas colunas de duas tabelas diferentes, From (tabelas de onde quer retornar os dados). Quero os dados de produtos que tem subcategoria associada (INNER JOIN)
SELECT "Nome_Subcategoria", "Peso_Produto"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"

#Duas colunas de duas tabelas diferentes, From (tabelas de onde quer retornar os dados). Quero os dados de produtos que tem subcategoria associada, porém peso produto não pode ser nulo
SELECT "Nome_Subcategoria", "Peso_Produto"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND "Peso_Produto" IS NOT NULL;

#media de peso produto por subcategoria, como quer agrupamento, tem que incluir group by
SELECT "Nome_Subcategoria", AVG("Peso_Produto")
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Subcategoria";

#ordenar o resultado (as media_peso_produto = criar apelido)
SELECT "Nome_Subcategoria", AVG("Peso_Produto") AS "Media_Peso_Produto"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Subcategoria"
ORDER BY "Nome_Subcategoria";

#arredondar a média. em outros SGBD colocar apenas round. CAST = converte para tipo numérico.
SELECT "Nome_Subcategoria", ROUND(CAST(AVG("Peso_Produto") as numeric), 2) AS "Media_Peso_Produto"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Subcategoria"
ORDER BY "Nome_Subcategoria";

#having ocorre depois de where e group by. Daí usa a média como filtro.O having é uma espécie de where após o group by
SELECT "Nome_Subcategoria", ROUND(CAST(AVG("Peso_Produto") as numeric), 2) AS "Media_Peso_Produto"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Subcategoria"
HAVING AVG("Peso_Produto") >= 100
ORDER BY "Nome_Subcategoria";

#Tem uma tabela a mais do que na query anterior
SELECT "Nome_Categoria", ROUND(CAST(AVG("Peso_Produto") as numeric), 2) AS "Media_Peso_Produto"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA", lab."TB_CATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND lab."TB_SUBCATEGORIA"."ID_Categoria" = lab."TB_CATEGORIA"."ID_Categoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Categoria"
HAVING AVG("Peso_Produto") >= 20
ORDER BY "Nome_Categoria";

#usar apelido para deixar a query mais limpa
SELECT "Nome_Categoria", 
       ROUND(CAST(AVG("Peso_Produto") as numeric), 2) AS "Media_Peso_Produto"
FROM lab."TB_PRODUTO" TAB_A, 
     lab."TB_SUBCATEGORIA" TAB_B, 
     lab."TB_CATEGORIA" TAB_C
WHERE TAB_A."ID_Subcategoria" = TAB_B."ID_Subcategoria"
  AND TAB_B."ID_Categoria" = TAB_C."ID_Categoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Categoria"
HAVING AVG("Peso_Produto") >= 20
ORDER BY "Nome_Categoria";
