use tempdb
go

--create table Securities_Quotes (Security_ID int, Date smalldatetime, Value decimal(10,5))
-- truncate table Securities_Quotes
/*
create unique clustered index CIX_Securities_Quotes_Security_ID_Date on Securities_Quotes
(
	[Security_ID] asc,
	[Date] desc
)
GO
*/

/*
create unique nonclustered index NIX_Securities_Quotes_Security_ID_Date on Securities_Quotes
(
	[Security_ID] asc,
	[Date] desc
)
include (Value)
GO
*/

set nocount on

declare @Current bigint = 0
declare @Current_Date smalldatetime = getdate()
declare @Value decimal(38,10)

--begin transaction

	while @Current < 1000000
	begin

		select @Value = RAND(CHECKSUM(NEWID()))
	--begin try
		insert into Securities_Quotes(Security_ID, Date, Value) values (2, dateadd(MINUTE, -@Current, @Current_Date), case when @Value > 0.99999 then 0.99999 when @Value < 0 then 0 else @Value end)
	--end try
	--begin catch
	--	select @Value
	--end catch

		set @Current = @Current + 1
	end

--commit transaction
