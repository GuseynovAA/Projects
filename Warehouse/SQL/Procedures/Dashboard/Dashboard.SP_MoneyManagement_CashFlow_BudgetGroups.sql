USE Warehouse
GO

IF OBJECT_ID('Dashboard.SP_MoneyManagement_CashFlow_BudgetGroups') iS NOT NULL
	DROP PROCEDURE Dashboard.SP_MoneyManagement_CashFlow_BudgetGroups
GO

CREATE PROCEDURE Dashboard.SP_MoneyManagement_CashFlow_BudgetGroups
AS
BEGIN

	SET NOCOUNT ON

	SELECT DISTINCT BudgetGroupCode [Code]
	FROM MoneyBook.TransactionsFact
	WHERE BudgetGroupCode IS NOT NULL

END