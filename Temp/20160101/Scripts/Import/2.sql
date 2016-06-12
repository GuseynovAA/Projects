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

--  Импорт счетов GUS  --
EXEC FL.SP_MoneyAccounts_Insert NULL, 'ALEX', NULL, NULL, @RUR_ID, @GUSB_ID, @ALEX_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'JULIA', NULL, NULL, @RUR_ID, @GUSB_ID, @JULIA_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'DIMA', NULL, NULL, @RUR_ID, @GUSB_ID, @DIMA_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'STASH', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 0, NULL

--  Импорт счетов PSB
EXEC FL.SP_MoneyAccounts_Insert NULL, 'RATED RUR', NULL, NULL, @RUR_ID, @PSB_ID, @ALEX_ID, 0, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'RATED USD', NULL, NULL, @USD_ID, @PSB_ID, @ALEX_ID, 0, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'ALEX VISACARD', NULL, NULL, @RUR_ID, @PSB_ID, @ALEX_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'JULIA MASTERCARD', NULL, NULL, @RUR_ID, @PSB_ID, @JULIA_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'DIMA MASTERCARD', NULL, NULL, @RUR_ID, @PSB_ID, @DIMA_ID, 1, NULL
EXEC FL.SP_MoneyAccounts_Insert NULL, 'STASH', NULL, NULL, @RUR_ID, @PSB_ID, @ALEX_ID, 0, NULL


TRUNCATE TABLE BL.Budgets
TRUNCATE TABLE BL.BudgetsAccounts

--  Формирование доходных бюджетов
EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', 'Доходы', NULL
EXEC [FL].[SP_Budgets_Insert] @ID out, @ID, 'WORK', 'Работа', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'EP', 'Европлан', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'SALARY', 'Зарплата', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'SALARY', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, 'Зарплата'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID

EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', 'Доходы', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'WORK', 'Работа', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'EP', 'Европлан', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'PREMIUM', 'Премия', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'PREMIUM', NULL, NULL, @RUR_ID, @GUSB_ID, @ALEX_ID, 1, 'Премия'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID


EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', 'Доходы', NULL
EXEC [FL].[SP_Budgets_Insert] @ID out, @ID, 'WORK', 'Работа', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'SM', 'СМ Клиника', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'SALARY', 'Зарплата', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'SALARY', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, 'Зарплата'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID

EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', 'Доходы', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'WORK', 'Работа', NULL
EXEC [FL].[SP_Budgets_Insert] @ID OUT, @ID, 'SM', 'СМ Клиника', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'PREMIUM', 'Премия', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'PREMIUM', NULL, NULL, @RUR_ID, @GUSB_ID, @ALEX_ID, 1, 'Премия'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID


EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', 'Доходы', NULL
EXEC [FL].[SP_Budgets_Insert] @ID out, @ID, 'LEASING', 'Аренда', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'REALTY', 'Недвижимость', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'REALTY', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, 'Недвижимость'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID

EXEC [FL].[SP_Budgets_Insert] @ID OUT, NULL, 'INCOMES', 'Доходы', NULL
EXEC [FL].[SP_Budgets_Insert] @ID out, @ID, 'LEASING', 'Аренда', NULL
EXEC [FL].[SP_Budgets_Insert] @Budget_ID OUT, @ID, 'MONEY', 'Денежные средства', NULL
EXEC FL.SP_MoneyAccounts_Insert @Account_ID OUT, 'MONEY', NULL, NULL, @RUR_ID, @GUSB_ID, @GUSB_ID, 1, 'Денежные средства'
EXEC FL.SP_MoneyAccounts_LinkBudget NULL, @Account_ID, @Budget_ID
*/

--  Формирование расходных бюджетов

/*
--  Импорт доходных счетов GUS --
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/WORK/EP' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SALARY', '', 'Зарплата', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/WORK/EP' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'PREMIUM', '', 'Премия', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/WORK/SM' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SALARY', '', 'Зарплата', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/WORK/SM' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'PREMIUM', '', 'Премия', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/LEASING' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'REALTY', '', 'Аренда недвижиости', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'INCOMES/LEASING' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'DEPOSITS', '', 'Аренда депозита', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
*/
;
/*
--  Импорт расходных счетов GUS --
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/SERVICES' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'WORK', '', 'Работа', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/SERVICES' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'PARTS', '', 'Запчасти', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'TAXES', '', 'Налоги', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/INSURANCE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'KASKO', '', 'КАСКО', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/INSURANCE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'OSAGO', '', 'ОСАГО', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/CAR/INSURANCE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'DOOSAGO', '', 'ДООСАГО', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FLAT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'RENT', '', 'Аренда', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FLAT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SERVICES', '', 'Услуги ЖКХ', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FLAT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CONCIERGE', '', 'Консьерж', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FLAT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'REPAIR', '', 'Ремонт', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GIFTS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FAMILY', '', 'Семейные', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GIFTS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FRIENDS', '', 'Друзья', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GIFTS' select @Budget_ID = ID from @IDs delete from @IDs	
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'WORK', '', 'Работа', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CLOTHES', '', 'Одежда', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SHOES', '', 'Обувь', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'COSMETICS', '', 'Косметика', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'JEWELLERY', '', 'Ювелирные украшения', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'HOMETECHS', '', 'Бытовая техника', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'COMPUTERS', '', 'Компьютеры', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/GOODS' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FURNITURE', '', 'Мебель', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'COMPLEX', '', 'Комплекс', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'MEAT', '', 'Мясо', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FRUITS', '', 'Фрукты', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FISH', '', 'Рыба', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/FOOD' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'OTHER', '', 'Прочее', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/HEALTH/SPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'VOLEYBALL', '', 'Волейбол', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/HEALTH/SPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FITNESS', '', 'Фитнес', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/HEALTH/SPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'BOXING', '', 'Бокс', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LEARN' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'BOOKS', '', 'Книги', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LEARN' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FOOD', '', 'Питание', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LEARN' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'DUES', '', 'Сборы', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LEARN' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'OTHER', '', 'Прочее', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/TRANSPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'GROUND', '', 'Наземный транспорт', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/TRANSPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SUBWAY', '', 'Метро', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/TRANSPORT' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'FUEL', '', 'Топливо', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LINK' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'MOBILE', '', 'Мобильная связь', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/LINK' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'MOBILE', '', 'Интернет', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/MEDICINE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'SERVICES', '', 'Услуги', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/MEDICINE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'MEDICAMENTS', '', 'Медикаменты', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/MEDICINE' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'ANALYSIS', '', 'Анализы', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------
INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'TOYS', '', 'Игрушки', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'VACAITION', '', 'Отпус', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'TRAVELS', '', 'Путешествие', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CAFE', '', 'Кафе&Ресторан', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CINEMA', '', 'Кинотеатр&Театр', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'CINEMA', '', '', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID

INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = 'COSTS/RECREATION' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', 'OTHER', '', 'Прочее', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
--------------------------------------------------------------------------------------------------------------


INSERT INTO @IDs EXEC FL.SP_Budgets_Insert @Budget_Path = '' select @Budget_ID = ID from @IDs delete from @IDs
INSERT INTO @IDs EXEC FL.SP_Accounts_Insert 'M', '', '', '', @GUSB_ID select @Account_ID = ID from @IDs delete from @IDs
EXEC FL.SP_Budgets_LinkAccount @Budget_ID, @Account_ID
*/
