USE Warehouse
GO

IF OBJECT_ID('Dashboard.SP_MoneyManagement_CashFlow_BudgetSubgroups') iS NOT NULL
	DROP PROCEDURE Dashboard.SP_MoneyManagement_CashFlow_BudgetSubgroups
GO

CREATE PROCEDURE Dashboard.SP_MoneyManagement_CashFlow_BudgetSubgroups
AS
BEGIN

	SET NOCOUNT ON

	SELECT DISTINCT BudgetSubgroupCode [Code], BudgetGroupCode [ParentCode]
	FROM MoneyBook.TransactionsFact
	WHERE BudgetGroupCode IS NOT NULL AND BudgetGroupCode IS NOT NULL

END