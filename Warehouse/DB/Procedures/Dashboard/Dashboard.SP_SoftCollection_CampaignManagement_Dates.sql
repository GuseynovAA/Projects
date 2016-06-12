USE Warehouse
GO

IF OBJECT_ID('Dashboard.SP_SoftCollection_CampaignManagement_Dates') IS NOT NULL
	DROP PROCEDURE Dashboard.SP_SoftCollection_CampaignManagement_Dates
GO

CREATE PROCEDURE Dashboard.SP_SoftCollection_CampaignManagement_Dates
AS
BEGIN

	SET NOCOUNT ON

	SELECT DISTINCT
		CAST(ChangeDate AS DATE) [Date],
		CONVERT(NVARCHAR(20), ChangeDate, 104 ) [DateName]
	FROM Calldesk.Tasks_History

END