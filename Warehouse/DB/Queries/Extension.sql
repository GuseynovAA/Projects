declare @Main table (ID int, Name nvarchar(100))
declare @First table (ID int, Name nvarchar(100))
declare @Second table (ID int, Name nvarchar(100))

insert into @Main
select 1, 'Main Value 1' union all
select 2, 'Main Value 2'

insert into @First
select 1, 'First Value 1-1' union all
select 1, 'First Value 1-2' union all
select 1, 'First Value 1-3' union all
select 2, 'First Value 2-1'

insert into @Second
select 1, 'Second Value 1-1' union all
select 2, 'Second Value 2-1' union all
select 2, 'Second Value 2-2'

select
	*
from
	(select 1 as Number, * FROM @Main) M
	RIGHT JOIN (select ROW_NUMBER() OVER (ORDER BY Name) as Number, * FROM @First) F on
		F.ID = M.ID
	RIGHT JOIN (select ROW_NUMBER() OVER (ORDER BY Name) as Number, * FROM @Second) S on
		S.ID = M.ID
	--	S.Number = isnull(F.Number, M.Number)
order by 5,4

