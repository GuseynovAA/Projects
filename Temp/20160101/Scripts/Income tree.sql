CREATE TABLE #Outputs([ID] INT, Temp_ID INT IDENTITY)

DECLARE @GUSB_ID BIGINT

DECLARE
	@Incomes_Node_ID BIGINT,
	@Work_Node_ID BIGINT,
	@Alex_Node_ID BIGINT,
	@Julia_Node_ID BIGINT,
	@Realty_Node_ID BIGINT,
	@Depositis_Node_ID BIGINT

DECLARE
	@Alex_Salary_Account_ID BIGINT,
	@Alex_Premium_Account_ID BIGINT,
	@Julia_Salary_Account_ID BIGINT,
	@Julia_Premium_Account_ID BIGINT,
	@Rent_Account_ID BIGINT,
	@Percents_Account_ID BIGINT

SELECT @GUSB_ID = ID FROM ML.Partners WHERE Code = 'GUSB'

BEGIN TRANSACTION

	INSERT INTO ML.Objects(Type_UID, Code, Name)
	SELECT 'Object.Type.Budget', 'INCOMES', 'Доходы' UNION ALL
	SELECT 'Object.Type.Budget', 'WORK', 'Работа' UNION ALL
	SELECT 'Object.Type.Budget', 'ALEX', 'Европлан' UNION ALL
	SELECT 'Object.Type.Budget', 'JULIA', 'СМ-Клиника' UNION ALL
	SELECT 'Object.Type.Budget', 'REALTY', 'Недвижимость' UNION ALL
	SELECT 'Object.Type.Budget', 'DEPOSITS', 'Депозиты'

	SELECT @Incomes_Node_ID = ID FROM #Outputs WHERE Temp_ID = 1
	SELECT @Work_Node_ID = ID FROM #Outputs WHERE Temp_ID = 2
	SELECT @Alex_Node_ID = ID FROM #Outputs WHERE Temp_ID = 3
	SELECT @Julia_Node_ID = ID FROM #Outputs WHERE Temp_ID = 4
	SELECT @Realty_Node_ID = ID FROM #Outputs WHERE Temp_ID = 5
	SELECT @Depositis_Node_ID = ID FROM #Outputs WHERE Temp_ID = 6


	INSERT INTO ML.Accounts(Type_UID, Code, Number, Name, Owner_ID)
	SELECT 'Object.Cell.Account', 'SALARY', null, 'Зарплата', @GUSB_ID UNION ALL
	SELECT 'Object.Cell.Account', 'PREMIUM', null, 'Премия', @GUSB_ID UNION ALL
	SELECT 'Object.Cell.Account', 'SALARY', null, 'Зарплата', @GUSB_ID UNION ALL
	SELECT 'Object.Cell.Account', 'PREMIUM', null, 'Премия', @GUSB_ID UNION ALL
	SELECT 'Object.Cell.Account', 'RENT', null, 'Аренда', @GUSB_ID UNION ALL
	SELECT 'Object.Cell.Account', 'PERCENTS', null, 'Проценты', @GUSB_ID

	SELECT @Alex_Salary_Account_ID = ID FROM #Outputs WHERE Temp_ID = 7
	SELECT @Alex_Premium_Account_ID = ID FROM #Outputs WHERE Temp_ID = 8
	SELECT @Julia_Salary_Account_ID = ID FROM #Outputs WHERE Temp_ID = 9
	SELECT @Julia_Premium_Account_ID = ID FROM #Outputs WHERE Temp_ID = 10
	SELECT @Rent_Account_ID = ID FROM #Outputs WHERE Temp_ID = 11
	SELECT @Percents_Account_ID = ID FROM #Outputs WHERE Temp_ID = 12


	INSERT INTO BL.Objects_Relations(Parent_Object_ID, Child_Object_ID, Type_UID)
	SELECT @Incomes_Node_ID, @Work_Node_ID, 'BudgetTree' UNION ALL
	SELECT @Incomes_Node_ID, @Realty_Node_ID, 'BudgetTree' UNION ALL
	SELECT @Incomes_Node_ID, @Depositis_Node_ID, 'BudgetTree' UNION ALL
	SELECT @Work_Node_ID, @Alex_Node_ID, 'BudgetTree' UNION ALL
	SELECT @Work_Node_ID, @Julia_Node_ID, 'BudgetTree' UNION ALL
	SELECT @Alex_Node_ID, @Alex_Salary_Account_ID, 'BudgetTree' UNION ALL
	SELECT @Alex_Node_ID, @Alex_Premium_Account_ID, 'BudgetTree' UNION ALL
	SELECT @Julia_Node_ID, @Julia_Salary_Account_ID, 'BudgetTree' UNION ALL
	SELECT @Julia_Node_ID, @Julia_Premium_Account_ID, 'BudgetTree' UNION ALL
	SELECT @Realty_Node_ID, @Rent_Account_ID, 'BudgetTree' UNION ALL
	SELECT @Depositis_Node_ID, @Percents_Account_ID, 'BudgetTree'

COMMIT TRANSACTION

DROP TABLE #Outputs