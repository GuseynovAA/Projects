ALTER PROCEDURE FL.SP_Budgets_LinkAccount
(
	@Budget_ID BIGINT,
	@Account_ID BIGINT
)
AS
BEGIN
	
	SET NOCOUNT ON

	INSERT INTO ML.Objects_Relations (
		[Parent_Object_ID],
		[Child_Object_ID],
		[Type_UID]
	)
	VALUES (
		@Budget_ID,
		@Account_ID,
		'Budget'
	)

END