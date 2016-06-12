create trigger t_audit_trigger
on t
with execute as owner
after insert, update, delete
as
begin
    set nocount on;
    insert into audit (transaction_id) 
    select transaction_id from sys.dm_tran_current_transaction;
    if (@@ROWCOUNT != 1)
    	raiserror(N'Failed to audit transaction', 16, 1);
end
go