USE Ion
GO

CREATE TABLE #Outputs([ID] INT, Temp_ID INT IDENTITY)

DECLARE @GUSB_ID BIGINT
DECLARE @Costs_Node_ID BIGINT

SELECT @GUSB_ID = ID FROM ML.Partners WHERE Code = 'GUSB'

insert into ML.Objects(Type_UID, Code, Name)
select 'Object.Type.Budget', 'COSTS', 'Расходы'

--	Автомобиль  --
declare @Car_Node_ID bigint
declare @Car_Services_Node_ID bigint
declare @Car_Taxes_Node_ID bigint
declare @Car_Insurance_Node_ID bigint

declare @Car_Services_Works_Account_ID bigint
declare @Car_Services_Parts_Account_ID bigint
declare @Car_Services_TransTaxes_Account_ID bigint
declare @Car_Insurance_KASKO_Account_ID bigint
declare @Car_Insurance_OSAGO_Account_ID bigint
declare @Car_Insurance_DOOSAGO_Account_ID bigint

insert into ML.Objects(Type_UID, Code, Name)
select 'Object.Type.Budget', 'CAR', 'Автомобиль' union all
select 'Object.Type.Budget', 'SERVICES', 'Обслуживание' union all
select 'Object.Type.Budget', 'TAXES', 'Налоги' union all
select 'Object.Type.Budget', 'INSURANCES'

select @Car_Node_ID = ID FROM #Outputs WHERE Temp_ID = 1
select @Car_Services_Node_ID = ID FROM #Outputs WHERE Temp_ID = 2
select @Car_Taxes_Node_ID = ID FROM #Outputs WHERE Temp_ID = 3
select @Car_Insurance_Node_ID = ID FROM #Outputs WHERE Temp_ID = 4

INSERT INTO ML.Accounts(Type_UID, Code, Number, Name, Owner_ID)	 
select 'Object.Cell.Account', 'WORKS', 'Работа' union all
select 'Object.Cell.Account', 'PARTS', 'Запасные части' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
select 'Object.Cell.Account', '', '' union all
