USE [Esencial Verde]

DECLARE @new_producers producersTVP;

INSERT INTO @new_producers (name, env_score, corporation_id, address_id)
VALUES ('Abejorro Gigante', 100, 1, 10298);
EXEC insert_producersTVP @producers = @new_producers;
