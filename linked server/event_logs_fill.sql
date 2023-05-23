USE [Esencial Verde];




-- insert into event_types  --
WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 10
)
INSERT INTO event_types (event_type_name)
SELECT CONCAT('event', CEILING(RAND(CHECKSUM(NEWID())) * 10))
FROM number_sequence
OPTION (MAXRECURSION 32767);




-- insert into levels --
WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 10 
)
INSERT INTO levels (level_name)
SELECT CONCAT('level', CEILING(RAND(CHECKSUM(NEWID())) * 10))
FROM number_sequence
OPTION (MAXRECURSION 32767);




-- insert into object types --
WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 10 
)
INSERT INTO object_types (object_type_name)
SELECT CONCAT('level', CEILING(RAND(CHECKSUM(NEWID())) * 10))
FROM number_sequence
OPTION (MAXRECURSION 32767);



-- sources fill --
WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 10 
)
INSERT INTO sources (source_name)
SELECT CONCAT('sources', CEILING(RAND(CHECKSUM(NEWID())) * 10))
FROM number_sequence
OPTION (MAXRECURSION 32767);


-- event logs fill --
WITH number_sequence AS (
  SELECT 1 as n
  UNION ALL
  SELECT n+1
  FROM number_sequence
  WHERE n < 1000 
)
INSERT INTO event_logs (description, reference_id1, reference_id2, value1,value2, 
						event_type_id, object_type_id, level_id, source_id, created_at, 
						updated_at, computer, username, checksum)
SELECT CONCAT('product', CEILING(RAND(CHECKSUM(NEWID())) * 1000)),
	   CEILING(RAND(CHECKSUM(NEWID())) * 1000),
	   CEILING(RAND(CHECKSUM(NEWID())) * 1000),
	   'value1',
	   'value2',
	   CEILING(RAND(CHECKSUM(NEWID())) * 10),
	   CEILING(RAND(CHECKSUM(NEWID())) * 10),
	   CEILING(RAND(CHECKSUM(NEWID())) * 10),
	   CEILING(RAND(CHECKSUM(NEWID())) * 10),
	   GETDATE(),
	   GETDATE(),
	   'me',
	   'me',
	   CHECKSUM(GETDATE(), 'me', 'me', '12345password')	
FROM number_sequence
OPTION (MAXRECURSION 32767);





