USE Ion
GO
--CREATE PROCEDURE FL.SP_Budgets_LinkAccount
declare
	@Budget_Path nvarchar(max) = 'A/B/C',
	@Delimiter CHAR(1) = '/'
	

DECLARE @Relation_Type_UID NVARCHAR(10) = 'Budget'



BEGIN

	SET NOCOUNT ON

	

	DECLARE @Items TABLE (
		Number INT,
		Item NVARCHAR(MAX)
	)

	insert into @Items(Number, Item)
	select Number, Item
	FROM FL.DF_Split(@Budget_Path, @Delimiter) S

	;
	with cte ([Path_Number], [Step_Number], [Object_ID], [Object_Code])
	as
	(
		select
			ROW_NUMBER() OVER (ORDER BY I.Item) [Path_Number],
			I.Number [Step_Number],
			R.Child_Object_ID [Object_ID],
			R.Child_Object_Code [Object_Code]
		from
			@Items I
			inner join ML.Objects_Relations R on
				R.Child_Object_Code = I.Item and
				R.Type_UID = @Relation_Type_UID
		where I.Number = 1

		union all

		select
			C.Path_Number,
			C.Step_Number + 1 Step_Number,
			R.Child_Object_ID [Object_ID],
			R.Child_Object_Code [Object_Code]
		from
			cte C
			inner join ML.Objects_Relations R on
				R.Parent_Object_ID = C.[Object_ID] and
				R.Type_UID = @Relation_Type_UID
			inner join @Items I on
				I.Item = R.Child_Object_Code and
				I.Number = C.Step_Number + 1
	)
	select
		[Path_Number],
		count([Step_Number]) as Route_Items
	from cte
	group by [Path_Number]

end

/*
select
	C.Number + 1 Number,
	R.Child_Object_ID,
	R.Child_Object_Code,
	C.Route_ID
from
	(
		select 1 Number, 2 Object_ID, 'A' Object_Code, 1 Route_ID
	) C
	inner join ML.Objects_Relations R on R.Parent_Object_ID = C.[Object_ID]
where R.Child_Object_Code = (select Item from @Items where Number = C.Number + 1)
*/

/*

truncate table BL.Objects
truncate table BL.Objects_Relations

EXEC FL.SP_Budgets_Insert @Budget_Path = 'X/A/B/C'
EXEC FL.SP_Budgets_Insert @Budget_Path = 'X/A/E/C'
EXEC FL.SP_Budgets_Insert @Budget_Path = 'A/B/D'


select * from ML.Objects_Relations

*/