DECLARE @DateFrom DATE
DECLARE @DateTo DATE

SET @DateFrom = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 01)
SET @DateTo = DATEADD(DD, -1, DATEADD(MONTH, 1, @DateFrom))

SET @DateFrom = '2014-08-01'
SET @DateTo = '2014-08-31'

SELECT
		*
FROM [Warehouse].[MoneyBook].[TransactionsFact]
WHERE
	[Date] >= @DateFrom AND
	[Date] < DATEADD(DD, 1, @DateTo) AND
	[BudgetGroupCode] = 'COSTS' AND
	[BudgetSubgroupCode] = 'COMMUNAL' --AND
	--[BudgetItemCode] = 'WORK'

ORDER BY
	[BudgetGroupCode],
	[BudgetSubgroupCode],
	[BudgetItemCode],
	[CurrencyCode]

/*
BEGIN

	SET NOCOUNT ON

	SELECT
		[BudgetGroupCode],
		[BudgetSubgroupCode],
		[BudgetItemCode],
		SUM(Direction * Amount) [Amount],
		[CurrencyCode]
	FROM [Warehouse].[MoneyBook].[TransactionsFact]
	WHERE
		[Date] >= @DateFrom AND
		[Date] < DATEADD(DD, 1, @DateTo) AND
		[BudgetGroupCode] IS NOT NULL
	GROUP BY
		[BudgetGroupCode],
		[BudgetSubgroupCode],
		[BudgetItemCode],
		[CurrencyCode]
	ORDER BY
		[BudgetGroupCode],
		[BudgetSubgroupCode],
		[BudgetItemCode],
		[CurrencyCode]

END
*/

/*
SELECT DISTINCT
	[BudgetGroupCode],
	[BudgetSubgroupCode],
	[BudgetItemCode]
FROM [Warehouse].[MoneyBook].[Transactions]
*/

