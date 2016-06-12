USE Warehouse
GO

DECLARE @Tasks TABLE (Id INT)


BEGIN

	SET NOCOUNT ON

	DELETE FROM @Tasks

	UPDATE CT SET
		StatusCode = 'InWork'
	OUTPUT INSERTED.Id INTO @Tasks(Id)
	FROM
		(
			SELECT TOP 1
				Id,
				StatusCode,
				DateNextCall
			FROM
				Calldesk.Tasks AS CT
			WHERE
				StatusCode IN ('New', 'CantCall', 'Postphoned', 'Promised') AND
				CT.IsCallAvailable = 1
		) AS CT

	IF EXISTS (SELECT * FROM @Tasks)
	BEGIN

		WAITFOR DELAY '00:00:05'

		UPDATE CT SET
			StatusCode =
				CASE
					WHEN CALC.Value BETWEEN 0 AND 19 THEN 'Promise'
					WHEN CALC.Value BETWEEN 20 AND 39 THEN 'Postphoned'
					ELSE 'CantCall'
				END,
			DateNextCall = DATEADD(MINUTE, 10, GETDATE()),
			IsCallAvailable = 0
		FROM
			Calldesk.Tasks AS CT

			OUTER APPLY ( SELECT ABS(CHECKSUM(NEWID())) % 100 [Value] ) AS CALC

		WHERE CT.Id IN (SELECT Id FROM @Tasks)

	END

	WAITFOR DELAY '00:00:01'

END

