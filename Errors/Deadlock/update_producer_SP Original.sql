-----------------------------------------------------------
-- Autor: Eduardo Gutierrez
-- Fecha: 05/01/2023
-- Descripcion: esta description en comentarios queda almacenada
-- Otros detalles de los parametros
-----------------------------------------------------------
CREATE PROCEDURE update_producer_SP
	-- duncion para actualizar la información de un productor
	@og_name VARCHAR(30),
	@new_name VARCHAR(30),
	@new_env_score INT,
	@new_zip_code INT
WITH ENCRYPTION
AS 
BEGIN
	
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT
	DECLARE @new_address INT
	DECLARE @producer_id INT
	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		SELECT @producer_id = producer_id
		FROM producers with (TABLOCKX) -- se bloquea de forma exclusiva la tabla.
		WHERE name = @og_name;

		WAITFOR DELAY '00:00:10';  -- error se da durante este delay.

		SELECT @new_address = address_id
		FROM addresses with (TABLOCKX) -- se bloquea de forma exclusiva la tabla.
		WHERE name = @og_name;
		WHERE zip_code = @new_zip_code;

		UPDATE producers
		SET name = @new_name,
			env_score = @new_env_score,
			address_id = @new_address
		WHERE producer_id = @producer_id;

		IF @InicieTransaccion=1 BEGIN
			COMMIT
		END
	END TRY
	BEGIN CATCH
		SET @ErrorNumber = ERROR_NUMBER()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState = ERROR_STATE()
		SET @Message = ERROR_MESSAGE()
		
		IF @InicieTransaccion=1 BEGIN
			ROLLBACK
		END
		RAISERROR('%s - Error Number: %i', 
			@ErrorSeverity, @ErrorState, @Message, @CustomError)
	END CATCH	
END
RETURN 0
GO