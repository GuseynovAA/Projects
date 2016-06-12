USE Warehouse
GO

INSERT INTO dbo.SourceNumbers DEFAULT VALUES

UPDATE TOP (1) PERCENT dbo.SourceNumbers SET
	Value = DEFAULT

DELETE TOP (1) from dbo.SourceNumbers
GO


DECLARE @Log TABLE (
	Action NVARCHAR(10),
	Id INT
)

MERGE INTO dbo.TargetNumbers AS T
USING dbo.SourceNumbers AS S
ON S.Id = T.Id
WHEN MATCHED AND S.[Version] <> T.[Version] THEN
	UPDATE SET
		Value = S.Value,
		Name = S.Name,
		Version = S.Version
WHEN NOT MATCHED BY TARGET THEN
	INSERT (
		Id,
		Value,
		Name,
		Version
	)
	VALUES (
		S.Id,
		S.Value,
		S.Name,
		S.Version
	)
WHEN NOT MATCHED BY SOURCE THEN
	DELETE
OUTPUT $action, ISNULL(DELETED.Id, INSERTED.Id) INTO @Log(Action, Id)
OUTPUT $action, ISNULL(DELETED.Id, INSERTED.Id)
;
