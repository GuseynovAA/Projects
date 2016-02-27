IF OBJECT_ID('Calldesk.TR_Tasks_InsertUpdateDelete') IS NOT NULL
	DROP TRIGGER Calldesk.TR_Tasks_InsertUpdateDelete
GO

CREATE TRIGGER Calldesk.TR_Tasks_InsertUpdateDelete ON Calldesk.Tasks
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

	SET NOCOUNT ON

	INSERT INTO Calldesk.Tasks_History (
		ChangeDate, ChangeType,
		Id, DateCreated, CampaignId, StatusCode, DateNextCall, IsCallAvailable
	)
	SELECT
		GETDATE() [ChangeDate], 'D' [ChangeType],
		Id, DateCreated, CampaignId, StatusCode, DateNextCall, IsCallAvailable
	FROM
		DELETED

	UNION ALL

	SELECT
		GETDATE() [ChangeDate], 'I' [ChangeType],
		Id, DateCreated, CampaignId, StatusCode, DateNextCall, IsCallAvailable
	FROM
		INSERTED

END