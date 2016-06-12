USE Ion
GO

SELECT
	StoreId,
	COUNT(ResourceId) [ResourceCount]
FROM
	dbo.StoresResources (NOLOCK)
GROUP BY
	StoreId
ORDER BY
	StoreId