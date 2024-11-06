-------------------------------------------------

		 -- Manipula��o de Dados -- 

-------------------------------------------------

USE Ecommerce;
-- 1. Inserindo Dados em uma Tabela;

--- 1.1 Criar uma tabela tempor�ria com os dados da tabela original;

SELECT *
INTO ##customer_table
FROM Clientes;

--- 1.2 Inserir os dados na tabela tempor�ria e depois confirmar se est�o certos;

INSERT INTO ##customer_table
	(id, created_at, first_name, last_name, email, cell_phone, country, state, street, number, additionals)
VALUES
	(100, GETDATE(), 'Maria L�cia', 'Silva' , 'maria_email@email.com', '9 9991-1232' , 'Brasil', 'S�o Paulo', 'Avenida 23 do Estado S�o Paulo', '654', 'Bloco 2');

--- 1.3 Inserir os dados na tabela original;

INSERT INTO Clientes
	(id, created_at, first_name, last_name, email, cell_phone, country, state, street, number, additionals)
VALUES
	(100, GETDATE(), 'Maria L�cia', 'Silva' , 'maria_email@email.com', '9 9991-1232' , 'Brasil', 'S�o Paulo', 'Avenida 23 do Estado S�o Paulo', '654', 'Bloco 2');


-- 2. Atualizar Dados em uma Tabela (usar uma tabela tempor�ria tamb�m);

UPDATE Clientes
SET cell_phone = '9 9876-1234'
WHERE id = 54;


-- 3. Excluir Dados em uma Tabela (usar uma tabela tempor�ria tamb�m);

DELETE FROM Clientes
WHERE id = 101;


-- 4. Inserir ou Atualizar Dados Condicionalmente;

-- A consulta ir� procurar por um id espec�fico. Caso este id exista as informa��es s�o atualizadas, caso contr�rio, um novo registro � criado.

MERGE INTO Categoria AS c

	USING (VALUES (10, 'Constru��o'))
	AS new(id, name)
	ON c.id = new.id
	WHEN MATCHED THEN
		UPDATE SET 
			name = new.name
	WHEN NOT MATCHED THEN
		INSERT (id, name)
		VALUES (new.id, new.name);