use tempdb
go

set nocount on
go

create table T(ID int)

insert into T(ID) values(1)
insert into T(ID) values(1)
insert into T(ID) values(2)
insert into T(ID) values(2)
insert into T(ID) values(3)
insert into T(ID) values(3)
insert into T(ID) values(4)
insert into T(ID) values(5)
insert into T(ID) values(5)
insert into T(ID) values(5)

--select * from T where Id = 1

create statistics X on T(ID)

--insert into T(ID) values(5)
--insert into T(ID) values(5)
--insert into T(ID) values(6)
--insert into T(ID) values(6)

--dbcc show_statistics ('tempdb..T', X) with density_vector
dbcc show_statistics ('tempdb..T', X) with histogram

--drop table T