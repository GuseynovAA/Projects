--CREATE PROCEDURE FL.SP_MoneyTransactions_Import
declare
	@Date date = getdate(),
	@Source_MoneyAccount_Path nvarchar(max) = 'PSB/ALEX',
	@Source_Amount decimal(19,2) = 1000,
	@Source_Currency_ID bigint = 1,
	@Target_MoneyAccount_Path nvarchar(max) = 'GUSB/ALEX',
	@Target_Amount decimal(19,2) = 1000,
	@Target_Currency_ID bigint = 1,
	@Budget_MoneyAccount_Path nvarchar(max) = null,
	@Separator char(1) = '/'

begin
	
	set nocount on




end