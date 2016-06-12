USE Warehouse
GO

IF OBJECT_ID('Dashboard.SP_SoftCollection_CampaignManagement_TasksState') IS NOT NULL
	DROP PROCEDURE Dashboard.SP_SoftCollection_CampaignManagement_TasksState
GO

CREATE PROCEDURE Dashboard.SP_SoftCollection_CampaignManagement_TasksState
AS
BEGIN

	SET NOCOUNT ON
/*	;
	WITH History AS
	(
		SELECT
			D.ReportDate,
			H.Id,
			I.StatusCode,
			ROW_NUMBER() OVER (PARTITION BY D.ReportDate, H.Id ORDER BY H.ChangeDate DESC) [RowNumber]
		FROM
			(
				SELECT DISTINCT
					CAST(ChangeDate AS DATE) [ReportDate]
				FROM Calldesk.Tasks_History
			) AS D

			LEFT JOIN (SELECT DISTINCT ChangeDate, Id FROM Calldesk.Tasks_History) AS H ON
				H.ChangeDate < DATEADD(DD, 1, D.ReportDate)

			LEFT JOIN Calldesk.Tasks_History AS I ON
				I.Id = H.Id AND
				I.ChangeDate = H.ChangeDate AND
				I.ChangeType = 'I'
	)
	SELECT
		ReportDate,
		StatusCode,
		1 [Amount]
	FROM History
	WHERE RowNumber = 1

	ORDER BY
		ReportDate,
		Id
*/

SELECT CAST('2016-01-22' AS DATE) [ReportDate], 2 [NewStatusCode], 5 [CantcallStatusCode], 3 [Postphoned] UNION ALL
SELECT CAST('2016-01-23' AS DATE) [ReportDate], 1 [NewStatusCode], 7 [CantcallStatusCode], 1 [Postphoned] UNION ALL
SELECT CAST('2016-01-24' AS DATE) [ReportDate], 0 [NewStatusCode], 9 [CantcallStatusCode], 4 [Postphoned] UNION ALL
SELECT CAST('2016-01-25' AS DATE) [ReportDate], 2 [NewStatusCode], 3 [CantcallStatusCode], 2 [Postphoned] UNION ALL
SELECT CAST('2016-01-26' AS DATE) [ReportDate], 7 [NewStatusCode], 1 [CantcallStatusCode], 1 [Postphoned]

END