USE [Mirror]
GO

DECLARE @RC int
DECLARE @Date datetime = '2013-10-31'
DECLARE @Source_Account_Path nvarchar(255)
DECLARE @Source_Amount decimal(19,2)
DECLARE @Source_Currency_Code nvarchar(100)
DECLARE @Target_Account_Path nvarchar(255) = ''
DECLARE @Target_Amount decimal(19,2) = 100000
DECLARE @Target_Currency_Code nvarchar(100) = 'RUR'
DECLARE @Budget_Path nvarchar(255) = 'INCOMES/WORK/EP/SALARY'
DECLARE @Description nvarchar(1000) = 'День зарплаты'

-- TODO: Set parameter values here.

EXECUTE @RC = [IS].[SP_MoneyTransactions_Insert] 
   @Date
  ,@Source_Account_Path
  ,@Source_Amount
  ,@Source_Currency_Code
  ,@Target_Account_Path
  ,@Target_Amount
  ,@Target_Currency_Code
  ,@Budget_Path
  ,@Description
GO


