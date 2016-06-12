DECLARE @Table TABLE (
	--Id INT IDENTITY(1,1),
	GroupId INT,
	Value FLOAT,
	RunValue FLOAT
)

INSERT INTO @Table (GroupId, Value)
VALUES
	(1, 100),
	(1, 200),
	(2, 100),
	(1, 500),
	(1, 500),
	(2, 800),
	(1, 200),
	(2, 200),
	(2, 100),
	(2, 200),
	(1, 300),
	(1, 200)


;
with tbl as (
	select
		Value, RunValue, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) [RowNumber]
	from @Table
)
update t1 set
	RunValue = (select sum(Value) from tbl as t2 where t1.RowNumber >= t2.RowNumber)
FROM
	tbl AS t1


select * from @Table
