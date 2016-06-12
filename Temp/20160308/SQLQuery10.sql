USE Ion
GO

--SP_Factory_Processing

BEGIN

	SET NOCOUNT ON

	SELECT
		P.TargetStoreId,
		SR.ResourceId
	FROM
		dbo.Pipes AS P

		INNER JOIN dbo.StoresResources AS SR ON
			SR.StoreId = P.SourceStoreId


	
		--SELECT
		--	SR.Id,
		--	SR.StoreId,
		--	SR.ResourceId,
		--	ROW_NUMBER() OVER (PARTITION BY SR.StoreId ORDER BY NEWID()) [RowNumber]
		--FROM
		--	dbo.StoresResources AS SR
	


END