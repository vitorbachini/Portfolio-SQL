# Queries de Treinamento

Nesta seção foram realizadas diversas consultas SQL, com o objetivo de praticar e aprofundar os conhecimentos nesta linguagem. 

### Databases Utilizadas
Foram utilizadas duas Databases para a realização das consultas: 
 - AdventureWorks: Database pública que pode ser encontrada [aqui](https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/adventure-works);
 - ECommerce: Database fictícia criada para simular um comércio eletrônico.

## Sobre as Consultas

### Consultas Básicas

- Script SQL utilizado: [01-consultas-basicas.sql](./01-consultas-basicas.sql)

Neste script foram utilizados alguns conceitos básicos da linguagem SQL, como seleção de dados com o uso do `SELECT`, ordenação com o `ORDER BY`, filtragem de dados com o uso das cláusulas `WHERE e HAVING`, funções de agregação como `SUM(), COUNT() e AVG()`, agrupamento de dados utilizando a cláusula `GROUP BY`, além do uso de funções de data como `YEAR(), MONTH() e DAY()`.

### Consultas Avançadas

- Script SQL utilizado: [02-consultas-avancadas.sql](./02-consultas-avancadas.sql)

Aqui o principal foco foi o uso das cláusulas `JOIN`, que servem para combinar linhas de duas ou mais tabelas. Em conjunto com o JOIN foram utilizados os conceitos de agregação, agrupamento e filtragem. Além de conceitos de Subquery e Window Functions com o `DENSE_RANK()` e o uso de CTEs(Common Table Expression) para facilitar e resumir grandes consultas.

### Manipulação de Dados

- Script SQL utilizado: [03-manipulacao-dados.sql](./03-manipulacao-dados.sql)

O objetivo deste script é de manipular os dados de forma cuidadosa, se atentando ao uso de tabelas temporárias - criadas temporariamente para armazenar dados intermediários durante a manipulação - como forma de segurança e proteção. A inserção dos dados se dá através da cláusula `INSERT`, passando os valores desejados,  o uso do `UPDATE` permite atualizar os dados de uma tabela e o `DELETE` exclui os dados. A cláusula `MERGE` permite atualizar dados de forma condicional.  

### Manipulação de Estruturas

- Script SQL utilizado: [04-manipulacao-estruturas.sql](./04-manipulacao-estruturas.sql)

Na parte de manipulação de estruturas foi realizada a criação de uma Database com a cláusula `CREATE DATABASE`, para a criação de tabelas dentro da nossa nova Database utilizamos o `CREATE TABLE` definindo tipos de dados e restrições como `PRIMARY KEY`,
a cláusula `ALTER TABLE` serve para alterar a estrutura de uma tabela, para criar um relacionamento entre tabelas foi utilizado a `FOREIGN KEY`, o uso do `CREATE INDEX` ajuda a melhorar a performance de consultas.