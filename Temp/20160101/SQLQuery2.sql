INSERT INTO dbo.Files (DateCreated, Path, Name, Extension, Data)
SELECT
	GETDATE(),
	'Photos\PuhArtel',
	'20141221-IMG_0023-39',
	'jpg',
	*
FROM OPENROWSET(BULK 'S:\Photos\PuhArtel\20141221-IMG_0023-39.jpg', SINGLE_BLOB) AS F

if object_id('#files') is not null
	drop table #files

CREATE table #files (id int identity(1,1), name nvarchar(max), depth int, [file] bit)

insert into #files (name, depth, [file])
exec xp_dirtree 'S:\Photos\PuhArtel',1,1

declare @current int = 1
declare @name nvarchar(max)
declare @command = ''

while @current <= 194
begin

	select @name = 'C:\Photos\PuhArtel\' + name from #files where id = @current

	INSERT INTO dbo.Files (DateCreated, Path, Name, Extension, Data)
	SELECT
		GETDATE(),
		'Photos\PuhArtel',
		@name,
		'jpg',
		*
	FROM OPENROWSET(BULK @name, SINGLE_BLOB) AS F

	set @current = @current + 1

end