UPDATE SR SET
	SR.StoreId = SC.TargetStoreId
FROM
	(
		SELECT
			StoreId,
			ResourceId,
			ROW_NUMBER() OVER (PARTITION BY StoreId ORDER BY NEWID()) [RowNumber]
		FROM
			dbo.StoresResources
	) AS SR

	INNER JOIN (
		SELECT
			SourceStoreId,
			TargetStoreId,
			ROW_NUMBER() OVER (PARTITION BY SourceStoreId ORDER BY NEWID()) [RowNumber]
		FROM
			dbo.StoresConnections
	) AS SC ON
		SC.SourceStoreId = SR.StoreId AND
		SC.RowNumber = SR.RowNumber


--update dbo.StoresResources set StoreId = 1

--select StoreId, COUNT(*) from dbo.StoresResources group by StoreId HAVING COUNT(*) > 0