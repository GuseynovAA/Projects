USE MIRROR
GO

TRUNCATE TABLE BL.Partners
GO

EXEC [FL].[SP_Partners_Insert] NULL, 'ALEX', 'Гусейнов Алексей Анатольевич'
EXEC [FL].[SP_Partners_Insert] NULL, 'JULIA', 'Гусейнова Юлия Викторовна'
EXEC [FL].[SP_Partners_Insert] NULL, 'DIMA', 'Горбунов Дмитрий Сергеевич'

EXEC [FL].[SP_Partners_Insert] NULL, 'GUS', 'Система'
EXEC [FL].[SP_Partners_Insert] NULL, 'PSB', 'Промсвязьбанк'
EXEC [FL].[SP_Partners_Insert] NULL, 'MTS', 'МТС'
EXEC [FL].[SP_Partners_Insert] NULL, 'MOS', 'Банк Москвы'
EXEC [FL].[SP_Partners_Insert] NULL, 'OBI', 'Обибанк'
EXEC [FL].[SP_Partners_Insert] NULL, 'OPEN', 'Банк Открытие'
EXEC [FL].[SP_Partners_Insert] NULL, 'QIWI', 'Киви Банк'
EXEC [FL].[SP_Partners_Insert] NULL, 'UCB', 'Юникредит Банк'
EXEC [FL].[SP_Partners_Insert] NULL, 'VTB24', 'ВТБ24'
EXEC [FL].[SP_Partners_Insert] NULL, 'SBER', 'Сбербанк'
EXEC [FL].[SP_Partners_Insert] NULL, 'RKS', 'Рома Король Сервис'
GO

TRUNCATE TABLE BL.Currencies
GO

INSERT INTO [BL].[Currencies] ( [Code], [Name] ) VALUES ('RUR', 'Рубль')
INSERT INTO [BL].[Currencies] ( [Code], [Name] ) VALUES ('USD', 'Доллар')
INSERT INTO [BL].[Currencies] ( [Code], [Name] ) VALUES ('EUR', 'Евро')
GO