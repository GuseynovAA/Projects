USE Warehouse
GO

DECLARE @Command NVARCHAR(MAX)

SELECT @Command = 
'
CREATE TABLE #Ids (Id INT)

INSERT INTO #Ids (Id)
'

SELECT
	@Command = @Command + ( select CONCAT('SELECT ', T.id, ' UNION ALL ')
	from (SELECT TOP 100000 Id FROM SAFO.Projects_Team) as T FOR XML PATH('')
)

SET @Command = LEFT(@Command, LEN(@Command) - LEN(' UNION ALL ')) +
'
'

EXEC SP_EXECUTESQL @Command
GO
