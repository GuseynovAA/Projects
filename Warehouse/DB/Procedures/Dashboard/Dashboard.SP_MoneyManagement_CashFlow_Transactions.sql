USE Warehouse
GO

DECLARE @CurrencyCode NVARCHAR(100) = NULL

IF OBJECT_ID('Dashboard.SP_MoneyManagement_CashFlow_Transactions') iS NOT NULL
	DROP PROCEDURE Dashboard.SP_MoneyManagement_CashFlow_Transactions
GO

CREATE PROCEDURE Dashboard.SP_MoneyManagement_CashFlow_Transactions
(
	@CurrencyCode NVARCHAR(100) = NULL
)
AS
BEGIN

	SET NOCOUNT ON

	;
	WITH Transactions AS
	(
		SELECT
			[Date],

			BudgetGroupCode,
			BudgetSubgroupCode,
			BudgetItemCode,

			AccountCode,
			Direction * Amount [TotalAmount],
			CurrencyCode,
			[Description]
		FROM MoneyBook.TransactionsFact
	)
	SELECT * FROM Transactions
	WHERE
		(
			@CurrencyCode IS NULL OR
			CurrencyCode = @CurrencyCode
		)
	ORDER BY
		[Date]

END

