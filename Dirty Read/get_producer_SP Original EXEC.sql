USE [Esencial Verde]

DECLARE @producerId INT, @envScore INT, @corporationN VARCHAR(30), @zipCode INT;
EXEC get_producer_SP @name = 'Pedro Pascal',
	@producer_id = @producerId OUTPUT,
	@env_score = @envScore OUTPUT,
	@corporation = @corporationN OUTPUT,
	@zip_code = @zipCode OUTPUT;
SELECT producer_id=@producerId, env_score=@envScore, corporation=@corporationN, zip_code=@zipCode;