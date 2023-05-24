-----------------------------------------------------------
-- Autor: Eduardo Gutierrez
-- Fecha: 05/01/2023
-- Descripcion: esta description en comentarios queda almacenada
-- Otros detalles de los parametros
-----------------------------------------------------------
CREATE PROCEDURE insert_producersTVP
	@producers producersTVP READONLY
AS 
BEGIN
	
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT
	DECLARE @date datetime
	DECLARE @computer VARCHAR(50)
	DECLARE @username VARCHAR(50)
	DECLARE @checksum VARBINARY(150)

	SET @date = GETDATE()
	SET @computer = 'me'
	SET @username = 'root'
	SET @checksum = CHECKSUM(@date, @computer, @username, '12345password')

	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		INSERT INTO producers (name, env_score, corporation_id, address_id, computer, username, checksum, created_at, updated_at)
		SELECT name, env_score, corporation_id, address_id, @computer, @username, @checksum, @date, @date
		FROM @producers;
		
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