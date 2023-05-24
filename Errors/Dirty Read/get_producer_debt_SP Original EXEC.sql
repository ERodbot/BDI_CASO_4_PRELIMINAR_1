USE [Esencial Verde]
-- EXEC de pruba ejecutar de 2°
DECLARE @producerId INT, @envScore INT, @corporationN VARCHAR(30), @zipCode INT, @debtN DECIMAL(12,2);
EXEC get_producer_debt_SP @name = 'Pedro Pascal',
	@amount = 10000.00,
	@producer_id = @producerId OUTPUT,
	@env_score = @envScore OUTPUT,
	@corporation = @corporationN OUTPUT,
	@zip_code = @zipCode OUTPUT,
	@debt = @debtN OUTPUT;
SELECT producer_id=@producerId, env_score=@envScore, corporation=@corporationN, zip_code=@zipCode, debt=@debtN;