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
),
cte (Section, H, D, U)
as
(
	select
		0 [Section],
		t3.I [H],
		t2.I [U],
		t1.I [D]
	from
		t t1 cross join t t2 cross join t t3
	union all
	select
		cte.Section + 1 [Section],
		cte.H [H],
		cte.D [D],
		cte.U [U]
	from
		cte
	where cte.Section < 999
)
insert into dbo.numbers (Value, Name)
select
	cte.Section * 1000 + cte.H * 100 + cte.D * 10 + cte.U + 1,
	cte.Section * 1000 + cte.H * 100 + cte.D * 10 + cte.U + 1
from cte
option (maxrecursion 10000)
go