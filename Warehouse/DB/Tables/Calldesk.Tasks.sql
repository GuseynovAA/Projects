USE [Warehouse]
GO

CREATE TABLE Calldesk.Tasks (
	Id INT IDENTITY(1,1) PRIMARY KEY,
	DateCreated DATETIME DEFAULT GETDATE(),
	CampaignId INT NULL,
	StatusCode NVARCHAR(20),
	DateNextCall DATETIME,
	IsCallAvailable BIT
) ON [PRIMARY]
GO


