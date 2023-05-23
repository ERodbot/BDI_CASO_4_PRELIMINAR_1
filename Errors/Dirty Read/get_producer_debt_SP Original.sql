-----------------------------------------------------------
-- Autor: Eduardo Gutierrez
-- Fecha: 05/01/2023
-- Descripcion: esta description en comentarios queda almacenada
-- Otros detalles de los parametros
-----------------------------------------------------------
CREATE PROCEDURE get_producer_debt_SP
	@name VARCHAR(30),
	@amount DECIMAL(12,2),
	@producer_id INT OUTPUT,
	@env_score INT OUTPUT,
	@corporation VARCHAR(30) OUTPUT,
	@zip_code INT OUTPUT,
	@debt DECIMAL(12,2) OUTPUT
WITH ENCRYPTION
AS 
BEGIN
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT
	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		SELECT @producer_id = producer_id, @env_score = env_score, @corporation = corp.name, @zip_code = addr.zip_code, @debt = @env_score * @amount
		FROM producers prd
		JOIN corporations corp ON prd.corporation_id = corp.corporation_id
		JOIN addresses addr ON prd.address_id = addr.address_id
		WHERE prd.name = @name;
		

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