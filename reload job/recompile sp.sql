DECLARE @sql NVARCHAR(MAX);

SET @sql = '';

SELECT @sql = @sql + 'EXEC sp_recompile ''' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name) + ''';' + CHAR(13)
FROM sys.procedures;

EXEC sp_executesql @sql;