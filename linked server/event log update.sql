-- Insert into event_types table
INSERT INTO [Esencial Verde Linked Copy].[dbo].[event_types] (event_type_name)
SELECT event_type_name
FROM [thisisnotapc].[Esencial Verde].[dbo].[event_types]
WHERE event_type_id NOT IN (SELECT event_type_id FROM [Esencial Verde Linked Copy].[dbo].[event_types]);

-- Insert into levels table
INSERT INTO [Esencial Verde Linked Copy].[dbo].[levels] (level_name)
SELECT level_name
FROM [thisisnotapc].[Esencial Verde].[dbo].[levels]
WHERE level_id NOT IN (SELECT level_id FROM [Esencial Verde Linked Copy].[dbo].[levels]);

-- Insert into sources table
INSERT INTO [Esencial Verde Linked Copy].[dbo].[sources] (source_name)
SELECT source_name
FROM [thisisnotapc].[Esencial Verde].[dbo].[sources]
WHERE source_id NOT IN (SELECT source_id FROM [Esencial Verde Linked Copy].[dbo].[sources]);

-- Insert into object_types table
INSERT INTO [Esencial Verde Linked Copy].[dbo].[object_types] (object_type_name)
SELECT object_type_name
FROM [thisisnotapc].[Esencial Verde].[dbo].[object_types]
WHERE object_type_id NOT IN (SELECT object_type_id FROM [Esencial Verde Linked Copy].[dbo].[object_types]);

-- Insert into event_logs table
INSERT INTO [Esencial Verde Linked Copy].[dbo].[event_logs] (description, reference_id1, reference_id2, value1, value2, event_type_id, object_type_id, level_id, source_id, created_at, updated_at, computer, username, checksum)
SELECT description, reference_id1, reference_id2, value1, value2, event_type_id, object_type_id, level_id, source_id, created_at, updated_at, computer, username, checksum
FROM [thisisnotapc].[Esencial Verde].[dbo].[event_logs]
WHERE event_log_id NOT IN (SELECT event_log_id FROM [Esencial Verde Linked Copy].[dbo].[event_logs]);


DELETE FROM [THISISNOTAPC].[Esencial Verde].[dbo].[event_logs]
WHERE event_log_id NOT IN (
    SELECT MAX(event_log_id)
    FROM [THISISNOTAPC].[Esencial Verde].[dbo].[event_logs]
);