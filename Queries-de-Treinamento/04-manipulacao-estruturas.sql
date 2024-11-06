-------------------------------------------------

		 -- Manipulação de Estruturas -- 

-------------------------------------------------

CREATE DATABASE EcommerceTest;

-- 1. Criação de Tabelas;

USE EcommerceTest;
CREATE TABLE Customers (
	customer_id  INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	first_name   VARCHAR(100) NOT NULL,
	last_name    VARCHAR(100) NOT NULL,
	email        VARCHAR(100) UNIQUE,
	register_date DATE NOT NULL
);


-- 2. Alterar a Estrutura de uma Tabela;

USE EcommerceTest;
ALTER TABLE Customers
ADD birth_date DATE;


-- 3. Utilizar uma Foreign Key para relacionar tabelas;

USE EcommerceTest;
CREATE TABLE Orders (
	order_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	customer_id INT NOT NULL,
	total_value DECIMAL(10, 2) NOT NULL,
	order_date DATE NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
);


-- 4. Adicionar Restrições de Dados em uma Tabela;

ALTER TABLE Orders
ADD CONSTRAINT check_total_value CHECK (total_value > 0 );


-- 5. Melhorar a Performance de Consulta através da Criação de um índice;

CREATE INDEX idx_email ON Customers(email);