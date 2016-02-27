USE Warehouse
GO

IF OBJECT_ID('Dashboard.SP_MoneyManagement_CashFlow_BudgetItems') iS NOT NULL
	DROP PROCEDURE Dashboard.SP_MoneyManagement_CashFlow_BudgetItems
GO

CREATE PROCEDURE Dashboard.SP_MoneyManagement_CashFlow_BudgetItems
AS
BEGIN

	SET NOCOUNT ON

	SELECT DISTINCT BudgetItemCode [Code], BudgetSubgroupCode [ParentCode]
	FROM MoneyBook.TransactionsFact
	WHERE BudgetItemCode IS NOT NULL AND BudgetSubgroupCode IS NOT NULL

END