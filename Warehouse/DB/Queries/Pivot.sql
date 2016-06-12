declare @T table (Section nvarchar(max), Value int, Descr nvarchar(max))
insert into @T values('A', 100, 'X')
insert into @T values('A', 120, 'X')
insert into @T values('B', 1000, 'X')
insert into @T values('B', 1500, 'X')
insert into @T values('B', 500, 'X')
insert into @T values('C', 150, 'Y')
insert into @T values('D', 160, 'Y')
insert into @T values('E', 150, 'Y')
insert into @T values('E', 1150, 'Y')
insert into @T values('E', 1500, 'Y')

select * from @T

select PVT.*
from @T T pivot (sum(Value) for Section in ([A], [B], [C], [D], [E])) PVT

