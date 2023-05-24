USE [Esencial Verde]
-- EXEC para ingresar datos de prueba ejecutar de 1°
DECLARE @new_producers producersTVP;

INSERT INTO @new_producers (name, env_score, corporation_id, address_id)
VALUES ('Manasses Martine', 80, 1, 10298),
       ('Zenobia Thais', 70, 1, 10298),
       ('Jone Leela', 45, 1, 10298),
	   ('Toyin Kris', 70, 1, 10298),
       ('Asherah Ignác', 45, 1, 10298);
EXEC insert_producersTVP @producers = @new_producers;

SELECT * FROM producers