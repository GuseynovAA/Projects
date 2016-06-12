USE Ion
GO

CREATE PROCEDURE dbo.SP_Factory_Processing
AS
BEGIN

	SET NOCOUNT ON

	UPDATE R SET
		StoreId = P.TargetStoreId
	FROM (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY SourceStoreId ORDER BY NEWID()) [RowNumber] FROM dbo.Pipes
		) AS P

		INNER JOIN (
			SELECT *, ROW_NUMBER() OVER (PARTITION BY StoreId ORDER BY NEWID()) [RowNumber] FROM dbo.StoresResources
		) AS R ON
			R.StoreId = P.SourceStoreId AND
			R.RowNumber = P.RowNumber

END