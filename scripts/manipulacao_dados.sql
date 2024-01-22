SELECT *
FROM lab."TB_CATEGORIA";

#inserir 5 para ID_categoria, 1005 para cotdigo_categoria e eletronicos para nome_Categoria
INSERT INTO lab."TB_CATEGORIA"("ID_Categoria", "Codigo_Categoria", "Nome_Categoria")
VALUES (5, 1005, 'Eletronicos');

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#alterar valores em uma tabela
UPDATE lab."TB_CATEGORIA"
SET "Codigo_Categoria" = 5000
WHERE "ID_Categoria" = 5;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#deletar linha
DELETE FROM lab."TB_CATEGORIA"
WHERE "ID_Categoria" = 5;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Criar tabela com uma maior performance. Colocar INTO TABLE para que seja criada a nova tabela: 
SELECT "Nome_Subcategoria", ROUND(CAST(AVG("Peso_Produto") as numeric), 2) AS "Media_Peso_Produto"
INTO TABLE lab."TB_REPORT1"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Subcategoria"
HAVING AVG("Peso_Produto") >= 100
ORDER BY "Nome_Subcategoria";

SELECT * 
FROM lab."TB_REPORT1";

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Criar uma visão para uma tabela. Ela não armazena os dados, serve como consulta aos dados:
CREATE VIEW lab."VW_REPORT2" AS 
SELECT "Nome_Subcategoria", ROUND(CAST(AVG("Peso_Produto") as numeric), 2) AS "Media_Peso_Produto"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Subcategoria"
HAVING AVG("Peso_Produto") >= 100
ORDER BY "Nome_Subcategoria";

SELECT * 
FROM lab."VW_REPORT2";

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#Armazena fisicamente os resultados da consulta em uma tabela temporária:
CREATE MATERIALIZED VIEW lab."MV_REPORT3" AS 
SELECT "Nome_Subcategoria", ROUND(CAST(AVG("Peso_Produto") as numeric), 2) AS "Media_Peso_Produto"
FROM lab."TB_PRODUTO", lab."TB_SUBCATEGORIA"
WHERE lab."TB_PRODUTO"."ID_Subcategoria" = lab."TB_SUBCATEGORIA"."ID_Subcategoria"
  AND "Peso_Produto" IS NOT NULL
GROUP BY "Nome_Subcategoria"
HAVING AVG("Peso_Produto") >= 100
ORDER BY "Nome_Subcategoria";

SELECT * 
FROM lab."MV_REPORT3";




