# postgresql

Sobre o projeto: Criação de um Banco de Dados utilizando postgreSQL. (Projeto Data Warehouse - Data Science Academy)

![modelo](https://github.com/misoliv/postgresql/blob/main/img/modelo.png)

Recursos utilizados no projeto:

    - Docker
    - PostgreSQL
    - Pgadmin4

Infraestrutura:

Baixar através do dockerhub a imagem que será utilizada : https://hub.docker.com/_/postgres 
   docker pull postgres
   
Instalar o engine do docker na máquina: https://docs.docker.com/engine/install/

Criar o container docker através do seguinte comando:    
docker run --name dbmi -p 5432:5432 -e POSTGRES_USER=xxxx -e POSTGRES_PASSWORD=xxxxx -e POSTGRES_DB=postgresDB -d postgres

Comandos:

docker run: criar o container
-- name: nome do container docker
-p: porta de acesso do postgreSQL e da máquina local (a porta 5432 é a porta padrão do PostgreSQL) 
-e: usuário do banco de dados postgreSQL
-e: senha de acesso ao banco de dados
-e: nome do banco de dados
-d: nome da imagem

![instalacao](https://github.com/misoliv/postgresql/blob/main/img/instalacao.jpg)

Instruções para criação do Banco de Dados e Análise de dados:

1) Instalar o pgadmin4: https://www.pgadmin.org/download/

2) Fazer o acesso no pgadmin4 utilizando usuário e senha cadastrados;

3) Criar schema;

4) Criar tabelas do banco de dados;

5) Carregar as planilhas em cada tabela. Os arquivos devem ser convertidos para .csv;

6) Como não foram criadas restrições, as tabelas podem ser carregadas sem uma ordem sequencial;

7) Caso alguma planilha seja carregada de maneira incorreta, clicar com o botão direito no nome da tabela, selecionar TRUNCATE: TRUNCATE. Os dados são apagados e poderão ser carregados novamente. Caso queira deletar a tabela toda, clicar com o botão direito no nome da tabela DELETE; 

8) Criar as constraints (PK e FK). Ao ativar as restrições, utilizar a seguinte ordem de tabelas: categoria, subcategoria, produtos e vendas. Os comandos para criação de constraints estão na pasta scripts do projeto;

9) Após todas as restrições criadas, é possível criar a modelagem dos dados através da ferramenta ERD tool. Esse tipo de modelo é importante para a documentação do projeto.

10) Com o banco de dados carregado, foi possível começar as análises dos dados. O arquivo com as instruções SQL está na pasta scripts.
