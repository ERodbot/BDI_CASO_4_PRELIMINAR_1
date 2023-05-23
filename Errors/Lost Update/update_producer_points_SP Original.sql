-----------------------------------------------------------
-- Autor: Eduardo Gutierrez
-- Fecha: 05/01/2023
-- Descripcion: esta description en comentarios queda almacenada
-- Otros detalles de los parametros
-----------------------------------------------------------
CREATE PROCEDURE update_producer_points_SP
	@og_name VARCHAR(30),
	@alter_points INT
WITH ENCRYPTION
AS 
BEGIN
	
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT
	DECLARE @producer_id INT
	DECLARE @env_pointsN INT

	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		SELECT @producer_id = producer_id
		FROM producers
		WHERE name = @og_name;

		-- SELECT de los puntaje se realiza fuera del update, lo que cause que se haga primero una lecutra y no haya ningun lock
		SELECT @env_pointsN = env_score + @alter_points
		FROM producers
		WHERE producer_id = @producer_id

		WAITFOR DELAY '00:00:10';
		UPDATE producers
		SET env_score = @env_pointsN
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