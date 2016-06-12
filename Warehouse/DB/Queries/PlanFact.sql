USE Warehouse
GO

/*
DECLARE @DateFrom DATE
DECLARE @DateTo DATE

DECLARE @BudgetGroupCode BIT = 1
DECLARE @BudgetSubgroupCode BIT = 1
DECLARE @BudgetItemCode BIT = 0
*/

IF OBJECT_ID('Report.SP_Budget_PlanFact') IS NOT NULL
	DROP PROCEDURE Report.SP_Budget_PlanFact
GO

CREATE PROCEDURE Report.SP_Budget_PlanFact
(
	@DateFrom DATE,
	@DateTo DATE,

	@BudgetGroupCode BIT = 1,
	@BudgetSubgroupCode BIT = 1,
	@BudgetItemCode BIT = 0
)
AS
BEGIN

	SET NOCOUNT ON

	SET @DateFrom = ISNULL(@DateFrom, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 01))
	SET @DateTo = ISNULL(@DateTo, DATEADD(DD, -1, DATEADD(MONTH, 1, @DateFrom)))

	SELECT
		ISNULL(P.BudgetGroupCode, F.BudgetGroupCode) [BudgetGroupCode],
		ISNULL(P.BudgetSubgroupCode, F.BudgetSubgroupCode) [BudgetSubgroupCode],
		ISNULL(P.BudgetItemCode, F.BudgetItemCode) [BudgetItemCode],
		ISNULL(P.Amount, 0) [AmountPlan],
		ISNULL(F.Amount, 0) [AmountFact],
		ISNULL(P.Amount, 0) - ISNULL(F.Amount, 0) [AmountDiff],
		CAST(IIF(ISNULL(P.Amount, 0) = 0, 0, ISNULL(F.Amount, 0) / ISNULL(P.Amount, 0) * 100.0) AS DECIMAL(10,2)) [AmountDiffPercents],
		ISNULL(P.CurrencyCode, F.CurrencyCode) [CurrencyCode]
	FROM
		(
			SELECT
				CALC.BudgetGroupCode,
				CALC.BudgetSubgroupCode,
				CALC.BudgetItemCode,
				SUM(Direction * Amount) [Amount],
				CurrencyCode
			FROM
				MoneyBook.TransactionsPlan AS TP

				OUTER APPLY (
					SELECT
						IIF(@BudgetGroupCode = 1, BudgetGroupCode, NULL) [BudgetGroupCode],
						IIF(@BudgetSubgroupCode = 1, BudgetSubgroupCode, NULL) [BudgetSubgroupCode],
						IIF(@BudgetItemCode = 1, BudgetItemCode, NULL) [BudgetItemCode]
				) AS CALC

			WHERE
				[Date] >= @DateFrom AND
				[Date] < DATEADD(DD, 1, @DateTo) AND
				COALESCE(TP.BudgetGroupCode, TP.BudgetSubgroupCode, TP.BudgetItemCode) IS NOT NULL

			GROUP BY
				CALC.BudgetGroupCode,
				CALC.BudgetSubgroupCode,
				CALC.BudgetItemCode,
				CurrencyCode
		) AS P

		FULL JOIN
		(
			SELECT
				CALC.BudgetGroupCode,
				CALC.BudgetSubgroupCode,
				CALC.BudgetItemCode,
				SUM(Direction * Amount) [Amount],
				CurrencyCode
			FROM
				MoneyBook.TransactionsFact AS TF

				OUTER APPLY (
					SELECT
						IIF(@BudgetGroupCode = 1, BudgetGroupCode, NULL) [BudgetGroupCode],
						IIF(@BudgetSubgroupCode = 1, BudgetSubgroupCode, NULL) [BudgetSubgroupCode],
						IIF(@BudgetItemCode = 1, BudgetItemCode, NULL) [BudgetItemCode]
				) AS CALC

			WHERE
				[Date] >= @DateFrom AND
				[Date] < DATEADD(DD, 1, @DateTo) AND
				COALESCE(TF.BudgetGroupCode, TF.BudgetSubgroupCode, TF.BudgetItemCode) IS NOT NULL

			GROUP BY
				CALC.BudgetGroupCode,
				CALC.BudgetSubgroupCode,
				CALC.BudgetItemCode,
				CurrencyCode
		) AS F ON
			(@BudgetGroupCode = 0 OR F.BudgetGroupCode = P.BudgetGroupCode) AND
			(@BudgetItemCode = 0 OR F.BudgetItemCode = P.BudgetItemCode) AND
			(@BudgetSubgroupCode = 0 OR F.BudgetSubgroupCode = P.BudgetSubgroupCode) AND
			F.CurrencyCode = P.CurrencyCode
	
	ORDER BY 1,2,3

END