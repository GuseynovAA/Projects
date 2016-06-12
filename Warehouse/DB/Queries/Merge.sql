USE Warehouse
GO

drop table #Source
drop table #Target
select * into #Source from #A
select * into #Target from #B



MERGE #Target AS T USING #Source AS S ON
	T.Id = S.Id

WHEN MATCHED THEN
	UPDATE SET
		Name = S.Name

WHEN NOT MATCHED BY TARGET THEN
	INSERT (Id, Name)
	VALUES (S.Id, S.Name)

WHEN NOT MATCHED BY SOURCE THEN
	DELETE
;


select * from #Source order BY 1
select * from #Target order BY 1
	


