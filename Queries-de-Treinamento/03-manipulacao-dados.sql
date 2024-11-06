-------------------------------------------------

		 -- Manipulação de Dados -- 

-------------------------------------------------

USE Ecommerce;
-- 1. Inserindo Dados em uma Tabela;

--- 1.1 Criar uma tabela temporária com os dados da tabela original;

SELECT *
INTO ##customer_table
FROM Clientes;

--- 1.2 Inserir os dados na tabela temporária e depois confirmar se estão certos;

INSERT INTO ##customer_table
	(id, created_at, first_name, last_name, email, cell_phone, country, state, street, number, additionals)
VALUES
	(100, GETDATE(), 'Maria Lúcia', 'Silva' , 'maria_email@email.com', '9 9991-1232' , 'Brasil', 'São Paulo', 'Avenida 23 do Estado São Paulo', '654', 'Bloco 2');

--- 1.3 Inserir os dados na tabela original;

INSERT INTO Clientes
	(id, created_at, first_name, last_name, email, cell_phone, country, state, street, number, additionals)
VALUES
	(100, GETDATE(), 'Maria Lúcia', 'Silva' , 'maria_email@email.com', '9 9991-1232' , 'Brasil', 'São Paulo', 'Avenida 23 do Estado São Paulo', '654', 'Bloco 2');


-- 2. Atualizar Dados em uma Tabela (usar uma tabela temporária também);

UPDATE Clientes
SET cell_phone = '9 9876-1234'
WHERE id = 54;


-- 3. Excluir Dados em uma Tabela (usar uma tabela temporária também);

DELETE FROM Clientes
WHERE id = 101;


-- 4. Inserir ou Atualizar Dados Condicionalmente;

-- A consulta irá procurar por um id específico. Caso este id exista as informações são atualizadas, caso contrário, um novo registro é criado.

MERGE INTO Categoria AS c

	USING (VALUES (10, 'Construção'))
	AS new(id, name)
	ON c.id = new.id
	WHEN MATCHED THEN
		UPDATE SET 
			name = new.name
	WHEN NOT MATCHED THEN
		INSERT (id, name)
		VALUES (new.id, new.name);