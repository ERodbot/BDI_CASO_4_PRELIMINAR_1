-----------------------------------------------------------
-- Autor: Eduardo Gutierrez
-- Fecha: 05/01/2023
-- Descripcion: esta description en comentarios queda almacenada
-- Otros detalles de los parametros
-----------------------------------------------------------
CREATE PROCEDURE apply_producer_sponsor_points_SP
	-- procedimiento para aplicar los puntos que dona una empreza a cierto zipcode.
	@zip_code INT,
	@sponsor_points INT
WITH ENCRYPTION
AS 
BEGIN
	
	SET NOCOUNT ON -- no retorne metadatos
	
	DECLARE @ErrorNumber INT, @ErrorSeverity INT, @ErrorState INT, @CustomError INT
	DECLARE @Message VARCHAR(200)
	DECLARE @InicieTransaccion BIT
	DECLARE @producer_id INT
	DECLARE @count INT
	DECLARE @point_reduction INT
	DECLARE @address_id INT
	
	SET @InicieTransaccion = 0
	IF @@TRANCOUNT=0 BEGIN
		SET @InicieTransaccion = 1
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION		
	END
	
	BEGIN TRY
		SET @CustomError = 2001

		SELECT @address_id = address_id
		FROM addresses (UPDLOCK) -- ya no se utiliza un lock exclusivo si no que solo se bloquean los updates para la tabla.
		WHERE zip_code = @zip_code;
		
		WAITFOR DELAY '00:00:10';

		SET @count = (SELECT COUNT(*)
					  FROM producers AS prd WITH (UPDLOCK)
					  JOIN addresses AS addr (UPDLOCK)
					  ON prd.address_id=addr.address_id
					  WHERE zip_code = @zip_code);
		SET @point_reduction = FLOOR(@sponsor_points / @count)
		WAITFOR DELAY '00:00:10';

		UPDATE prd
		SET env_score = env_score - @point_reduction
		FROM producers prd
		JOIN addresses addr ON prd.address_id=addr.address_id
		WHERE zip_code = @zip_code;

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