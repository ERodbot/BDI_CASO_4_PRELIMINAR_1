USE [Esencial Verde]
-- T�po para el TVP
CREATE TYPE producersTVP AS TABLE
(
    name varchar(30),
    env_score int,
    corporation_id int,
	address_id int
);