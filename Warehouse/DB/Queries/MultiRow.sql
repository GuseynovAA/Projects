USE Warehouse
GO

if object_id( 'tempdb..#T' ) is not null
	drop table #T

create table #T( id int, X float, Y float, ct int )
insert into #T values
	( 1, 26,	0.909565,	17637 ),
	( 2, 26.1,	0.931857,	18241 ),
	( 3, 25.7,	0.438038,	20432 ),
	( 4, 24.2,	0.574432,	20213 ),
	( 5, 27.2,	0.465611,	19832 ),
	( 6, 23.4,	0.509839,	16007 ),
	( 7, 27.4,	0.773530,	28092 ),
	( 8, 24.1,	0.635649,	18946 ),
	( 9, 21,	0.389559,	11531 )


CREATE CLUSTERED INDEX CL_id ON #T (Id)

IF OBJECT_ID( 'tempdb..#Results' ) IS NOT NULL
	DROP TABLE #Results

;
WITH Cte AS
(
	select T.Id, T.X, T.Y, 1 AS Number from #T AS T
	UNION ALL
	SELECT T.Id, C.X, C.Y, C.Number + 1 [Number]
	FROM
		Cte AS C

		INNER JOIN #T AS T ON
			T.id = C.Id AND
			T.ct > C.Number
)
SELECT * INTO #Results FROM Cte OPTION (MAXRECURSION 32767);

--SELECT * FROM #Results order BY Id, Number