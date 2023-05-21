USE [Esencial V];


ALTER TABLE balances
ADD alt_collector_id INT,
    isEsencial BIT;


ALTER TABLE balances ALTER COLUMN
    producer_id INT NULL;


