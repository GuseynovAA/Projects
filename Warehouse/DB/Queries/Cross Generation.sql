IF OBJECT_ID('Tempdb.dbo.Digits') IS NOT NULL
	DROP TABLE Tempdb.dbo.Digits

CREATE TABLE Tempdb.dbo.Digits (Value int primary key)

;
with t (I)
as
(
	select 0 I union all
	select 1 I union all
	select 2 I union all
	select 3 I union all
	select 4 I union all
	select 5 I union all
	select 6 I union all
	select 7 I union all
	select 8 I union all
	select 9
)
insert into Tempdb.dbo.Digits(Value)
select
	CALC.Value
from
	t t1
	cross join t t2
	cross join t t3 
	cross join t t4
	cross join t t5
	cross join t t6
	cross join t t7
	outer apply (
		select
			t7.I * 1000000 + t6.I * 100000 + t5.I * 10000 + t4.I * 1000 + t3.I * 100 + t2.I * 10 + t1.I as Value
	) CALC