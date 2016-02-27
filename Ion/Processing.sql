SET NOCOUNT ON

DECLARE @Time INT = 1

WHILE 1 = 1
BEGIN

	UPDATE SR SET
		SR.StoreId = SR.TargetStoreId,
		SR.TimeId = @Time,
		SR.TimeCounter = SR.TimeCounter + 1
		--SR.RoutePath = CONCAT(SR.RoutePath, '->', SR.TargetStoreId)
	--SELECT
	--	SR.Id,
	--	SR.StoreId,
	--	SR.TargetStoreId,
	--	SR.TimeId,
	--	CONCAT(SR.RoutePath, '->', SR.TargetStoreId)
	FROM
		(
			SELECT
				SR.Id,
				SR.StoreId,
				SC.TargetStoreId,
				SR.TimeId,
				SR.TimeCounter,
				SR.RoutePath,
				ISNULL(S.Limit, 2147483647) [Limit],
				ISNULL(SL.Amount, 0) [Amount],
				ROW_NUMBER() OVER (PARTITION BY SC.TargetStoreId ORDER BY SC.TargetStoreId) [Number]
			FROM
				(
					SELECT
						SR.Id,
						SR.StoreId,
						SR.ResourceId,
						SR.TimeId,
						SR.TimeCounter,
						SR.RoutePath,
						ROW_NUMBER() OVER (PARTITION BY SR.StoreId ORDER BY NEWID()) [RowNumber]
					FROM
						dbo.StoresResources AS SR

						--INNER JOIN dbo.Stores AS S ON
						--	S.Id = SR.StoreId AND
						--	S.StorehouseId = 2
				) AS SR

				INNER JOIN (
					SELECT
						SourceStoreId,
						TargetStoreId,
						ROW_NUMBER() OVER (PARTITION BY SourceStoreId ORDER BY NEWID()) [RowNumber]
					FROM
						dbo.StoresLines
					WHERE IsEnable = 1
				) AS SC ON
					SC.SourceStoreId = SR.StoreId AND
					SC.RowNumber = SR.RowNumber

				LEFT JOIN dbo.Stores AS S ON
					S.Id = SC.TargetStoreId

				LEFT JOIN (
					SELECT
						SR.StoreId,
						COUNT(*) [Amount]
					FROM
						dbo.StoresResources AS SR
					GROUP BY
						SR.StoreId
				) AS SL ON
					SL.StoreId = S.Id
		) AS SR

		OUTER APPLY ( SELECT IIF(SR.Limit - SR.Amount - SR.Number >= 0, 0, 1) [IsLimitExceeded]) AS CALC
		
	WHERE
		CALC.IsLimitExceeded = 0

	SET @Time = @Time + 1

END