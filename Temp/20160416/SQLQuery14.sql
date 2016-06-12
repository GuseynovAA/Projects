USE Warehouse
GO

drop trigger tr_TargetNumbers_InsteadOf_Update
drop trigger tr_TargetNumbers_InsteadOf_Insert
drop trigger tr_TargetNumbers_InsteadOf_Delete
go

create trigger tr_TargetNumbers_InsteadOf_Update on dbo.TargetNumbers
INSTEAD OF UPDATE
AS
BEGIN

	SET NOCOUNT ON

END
go

create trigger tr_TargetNumbers_InsteadOf_Insert on dbo.TargetNumbers
INSTEAD OF INSERT
AS
BEGIN

	SET NOCOUNT ON

END
go

create trigger tr_TargetNumbers_InsteadOf_Delete on dbo.TargetNumbers
INSTEAD OF DELETE
AS
BEGIN

	SET NOCOUNT ON

END
go