USE [Mirror]
GO

DECLARE @RC int
DECLARE @ID BIGINT
DECLARE @Budget_ID BIGINT
DECLARE @Account_ID BIGINT
DECLARE @GUSB_ID BIGINT
DECLARE @PSB_ID BIGINT
DECLARE @ALEX_ID BIGINT
DECLARE @JULIA_ID BIGINT
DECLARE @DIMA_ID BIGINT
DECLARE @RUR_ID BIGINT
DECLARE @USD_ID BIGINT

SELECT @GUSB_ID = ID FROM BL.Partners WHERE Code = 'GUS'
SELECT @PSB_ID = ID FROM BL.Partners WHERE Code = 'PSB'
SELECT @ALEX_ID = ID FROM BL.Partners WHERE Code = 'ALEX'
SELECT @JULIA_ID = ID FROM BL.Partners WHERE Code = 'JULIA'
SELECT @DIMA_ID = ID FROM BL.Partners WHERE Code = 'DIMA'

SELECT @RUR_ID = ID from BL.Currencies where Code = 'RUR'
SELECT @USD_ID = ID from BL.Currencies where Code = 'USD'


-- TODO: Set parameter values here.

DECLARE @Budget_Path nvarchar(max) = 'COSTS/SERVICES/BANKS'
DECLARE @Delimiter char(1) = '/'

EXEC FL.SP_Budgets_InsertByPath @Budget_ID OUT, @Budget_Path, @Delimiter
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'BANKS', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID

GO

SELECT
	[ID],
	[Parent_ID],
    [Code],
    [Name],
    [Description]
FROM [Mirror].[BL].[Budgets]
order by id desc


