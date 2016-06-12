USE MIRROR
GO

TRUNCATE TABLE BL.Partners
GO

EXEC [FL].[SP_Partners_Insert] NULL, 'ALEX', '�������� ������� �����������'
EXEC [FL].[SP_Partners_Insert] NULL, 'JULIA', '��������� ���� ����������'
EXEC [FL].[SP_Partners_Insert] NULL, 'DIMA', '�������� ������� ���������'

EXEC [FL].[SP_Partners_Insert] NULL, 'GUS', '�������'
EXEC [FL].[SP_Partners_Insert] NULL, 'PSB', '�������������'
EXEC [FL].[SP_Partners_Insert] NULL, 'MTS', '���'
EXEC [FL].[SP_Partners_Insert] NULL, 'MOS', '���� ������'
EXEC [FL].[SP_Partners_Insert] NULL, 'OBI', '�������'
EXEC [FL].[SP_Partners_Insert] NULL, 'OPEN', '���� ��������'
EXEC [FL].[SP_Partners_Insert] NULL, 'QIWI', '���� ����'
EXEC [FL].[SP_Partners_Insert] NULL, 'UCB', '��������� ����'
EXEC [FL].[SP_Partners_Insert] NULL, 'VTB24', '���24'
EXEC [FL].[SP_Partners_Insert] NULL, 'SBER', '��������'
EXEC [FL].[SP_Partners_Insert] NULL, 'RKS', '���� ������ ������'
GO

TRUNCATE TABLE BL.Currencies
GO

INSERT INTO [BL].[Currencies] ( [Code], [Name] ) VALUES ('RUR', '�����')
INSERT INTO [BL].[Currencies] ( [Code], [Name] ) VALUES ('USD', '������')
INSERT INTO [BL].[Currencies] ( [Code], [Name] ) VALUES ('EUR', '����')
GO