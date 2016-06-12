USE Warehouse
GO

CREATE TABLE Calldesk.Tasks_History (
	ChangeDate DATETIME,
	ChangeType NCHAR(1),

	Id INT,
	DateCreated DATETIME,
	CampaignId INT,
	StatusCode NVARCHAR(20),
	DateNextCall DATETIME,
	IsCallAvailable BIT
) ON [PRIMARY]
GO