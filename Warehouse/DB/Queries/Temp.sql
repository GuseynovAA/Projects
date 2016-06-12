if object_id('tempdb..#T') is not null
	drop table #T

create table #T(Id int, Version int, DateTime datetime)
create unique clustered index CL_Id_Version on #T (Id asc, Version desc, DateTime desc)

insert into #T(Id, Version, DateTime) values(1, 1, '2013-09-01')
insert into #T(Id, Version, DateTime) values(1, 2, '2013-09-10')
insert into #T(Id, Version, DateTime) values(1, 0, '2013-09-20')
insert into #T(Id, Version, DateTime) values(2, 1, '2013-09-05')
insert into #T(Id, Version, DateTime) values(2, 2, '2013-09-15')
insert into #T(Id, Version, DateTime) values(3, 1, '2013-09-02')

select
	T.*
from
	#T T
	inner join (
		select
			TG.Id,
			max(TG.[Version]) [Version]
		from #T TG
		group by TG.Id
		having min(TG.[Version]) > 0
	) TG on TG.Id = T.Id and TG.Version = T.Version
order by T.Id

--select
--	TG.Id,
--	min(TG.[Version]),
--	max(TG.[Version])
--from #T TG
--group by TG.Id


