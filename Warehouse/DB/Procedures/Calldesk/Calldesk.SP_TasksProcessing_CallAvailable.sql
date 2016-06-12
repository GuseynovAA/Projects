USE Warehouse
GO

IF OBJECT_ID('Calldesk.SP_TasksProcessing_CallAvailable') IS NOT NULL
	DROP PROCEDURE Calldesk.SP_TasksProcessing_CallAvailable
GO

CREATE PROCEDURE Calldesk.SP_TasksProcessing_CallAvailable
AS
BEGIN

	SET NOCOUNT ON

	UPDATE T SET
		T.IsCallAvailable = 1
	FROM Calldesk.Tasks AS T
	WHERE
		T.StatusCode IN ('New', 'Postphoned', 'CantCall', 'Promised') AND
		T.IsCallAvailable = 0 AND
		T.DateNextCall <= GETDATE()

END

/*
WHILE 1 = 1
BEGIN
	
	EXEC Calldesk.SP_TasksProcessing_CallAvailable

	WAITFOR DELAY '00:01:00'

END
*/