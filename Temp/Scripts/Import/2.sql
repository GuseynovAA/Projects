USE Mirror
go

declare @IDs table (ID BIGINT)
declare @Value bigint

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
/*
TRUNCATE TABLE BL.MoneyAccounts

--  ������ ������ GUS  --
EXEC FL.SP_MoneyAccounts_Insert NULL, 'ALEX', NULL, NULL, @RUR_ID, @GUSB_ID, @ALEX_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'JULIA', NULL, NULL, @RUR_ID, @GUSB_ID, @JULIA_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'DIMA', NULL, NULL, @RUR_ID, @GUSB_ID, @DIMA_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'STASH', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 0, NULL

--  ������ ������ PSB
EXEC FL.SP_MoneyAccounts_Insert NULL, 'RATED RUR', NULL, NULL, @RUR_ID, @PSB_ID, @ALEX_ID, 0, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'RATED USD', NULL, NULL, @USD_ID, @PSB_ID, @ALEX_ID, 0, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'ALEX VISACARD', NULL, NULL, @RUR_ID, @PSB_ID, @ALEX_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'JULIA MASTERCARD', NULL, NULL, @RUR_ID, @PSB_ID, @JULIA_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'DIMA MASTERCARD', NULL, NULL, @RUR_ID, @PSB_ID, @DIMA_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'STASH', NULL, NULL, @RUR_ID, @PSB_ID, @ALEX_ID, 0, NULL


TRUNCATE TABLE BL.Budgets
TRUNCATE TABLE BL.BudgetsAccounts

--  ������������ �������� ��������
EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID out, @ID, 'WORK', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'EP', '��������', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'SALARY', '��������', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'SALARY', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, '��������'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID

EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'WORK', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'EP', '��������', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'PREMIUM', '������', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'PREMIUM', NULL, NULL, @RUR_ID, @GUSB_ID, @ALEX_ID, 1, '������'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID


EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID out, @ID, 'WORK', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'SM', '�� �������', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'SALARY', '��������', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'SALARY', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, '��������'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID

EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'WORK', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'SM', '�� �������', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'PREMIUM', '������', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'PREMIUM', NULL, NULL, @RUR_ID, @GUSB_ID, @ALEX_ID, 1, '������'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID


EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID out, @ID, 'LEASING', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'REALTY', '������������', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'REALTY', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, '������������'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID

EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @ID out, @ID, 'LEASING', '������', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'MONEY', '�������� ��������', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'MONEY', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, '�������� ��������'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID
*/

--  ������������ ��������� ��������

/*
--  ������ �������� ������ GUS --
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/WORK/EP' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SALARY', '', '��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/WORK/EP' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'PREMIUM', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/WORK/SM' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SALARY', '', '��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/WORK/SM' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'PREMIUM', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/LEASING' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'REALTY', '', '������ �����������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/LEASING' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'DEPOSITS', '', '������ ��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
*/
;
/*
--  ������ ��������� ������ GUS --
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/SERVICES' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'WORK', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/SERVICES' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'PARTS', '', '��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'TAXES', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/INSURANCE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'KASKO', '', '�����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/INSURANCE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'OSAGO', '', '�����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/INSURANCE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'DOOSAGO', '', '�������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FLAT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'RENT', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FLAT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SERVICES', '', '������ ���', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FLAT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CONCIERGE', '', '��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FLAT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'REPAIR', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GIFTS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FAMILY', '', '��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GIFTS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FRIENDS', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GIFTS' select @Budget_ID = ID from @IDs delete from @IDs	
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'WORK', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CLOTHES', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SHOES', '', '�����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'COSMETICS', '', '���������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'JEWELLERY', '', '��������� ���������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'HOMETECHS', '', '������� �������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'COMPUTERS', '', '����������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FURNITURE', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'COMPLEX', '', '��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'MEAT', '', '����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FRUITS', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FISH', '', '����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'OTHER', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/HEALTH/SPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'VOLEYBALL', '', '��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/HEALTH/SPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FITNESS', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/HEALTH/SPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'BOXING', '', '����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LEARN' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'BOOKS', '', '�����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LEARN' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FOOD', '', '�������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LEARN' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'DUES', '', '�����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LEARN' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'OTHER', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/TRANSPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'GROUND', '', '�������� ���������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/TRANSPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SUBWAY', '', '�����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/TRANSPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FUEL', '', '�������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LINK' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'MOBILE', '', '��������� �����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LINK' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'MOBILE', '', '��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/MEDICINE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SERVICES', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/MEDICINE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'MEDICAMENTS', '', '�����������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/MEDICINE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'ANALYSIS', '', '�������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'TOYS', '', '�������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'VACAITION', '', '�����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'TRAVELS', '', '�����������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CAFE', '', '����&��������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CINEMA', '', '���������&�����', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CINEMA', '', '', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'OTHER', '', '������', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------


INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = '' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', '', '', '', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
*/
