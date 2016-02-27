DECLARE @Resources TABLE(ResourceId INT)

UPDATE P SET
	ResourceId = R.ResourceId
OUTPUT INSERTED.ResourceId INTO @Resources(ResourceId)
FROM
	(
		SELECT
			P.SourceId [StorageId],
			P.ResourceId,
			ROW_NUMBER() OVER (PARTITION BY P.SourceId ORDER BY NEWID()) [RowNumber]
		FROM
			dbo.Ports AS P
		WHERE
			P.ResourceId IS NULL
	) AS P

	INNER JOIN (
		SELECT
			SR.StorageId,
			SR.ResourceId,
			ROW_NUMBER() OVER (PARTITION BY SR.StorageId ORDER BY NEWID()) [RowNumber]
		FROM
			dbo.StoragesResources AS SR
	) AS R ON
		R.StorageId = P.StorageId AND
		R.RowNumber = P.RowNumber


select * from @Resources



--update dbo.Ports set ResourceId = NULL

