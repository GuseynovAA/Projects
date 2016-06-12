USE Ion
GO

ALTER PROCEDURE dbo.SP_Processing_ResourcePipes
AS
BEGIN

	SET NOCOUNT OFF

	UPDATE R SET
		StoreId = P.TargetStoreId
	FROM (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY SourceStoreId ORDER BY NEWID()) [RowNumber]
			FROM dbo.Pipes
			WHERE
				TypeId = 2 AND
				Rating >= RAND()
		) AS P

		INNER JOIN (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY StoreId, ResourceId ORDER BY NEWID()) [RowNumber]
			FROM dbo.StoresResources
		) AS R ON
			R.StoreId = P.SourceStoreId AND
			R.ResourceId = P.ResourceId AND
			R.RowNumber = P.RowNumber
	

END