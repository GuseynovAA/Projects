--	FL.SP_Budgets_Insert

declare
	@Budget_Path nvarchar(max) = 'INCOME/WORK/ALEX/SALARY'

begin

	set nocount on

	declare @Delimiter char(1) = '/'
	declare @Item nvarchar(4000)
	declare @Parent_ID bigint
	declare @Item_ID bigint
	declare @GUID uniqueidentifier

	declare cr_Items cursor local fast_forward FOR
	select Item from FL.DF_Split(@Budget_Path, @Delimiter)

	open cr_Items

	fetch next from cr_Items into @Item

	while @@FETCH_STATUS = 0
	begin

		select @Item

		set @Item_ID = null
		
		select @Item_ID = R.Child_Object_ID
		from
			ML.Objects_Relations R
			inner join ML.Objects O on
				O.ID = R.Child_Object_ID and
				O.Code = @Item
		where
			R.Type_UID = 'Budget' and
			(
				R.Parent_Object_ID is null or
				R.Parent_Object_ID = @Parent_ID
			)

		if @Item_ID is null
		begin
			
			set @GUID = NEWID()

			insert into ML.Budgets([GUID], [Code], [Name])
			values  (@GUID, @Item, @Item)

			select @Item_ID = O.[ID] from ML.Objects O where O.[GUID] = @GUID

			select @GUID, @Item_ID, @Parent_ID

			insert into ML.Objects_Relations(Type_UID, Parent_Object_ID, Child_Object_ID)
			values ('Budget', @Parent_ID, @Item_ID)
			
		end
		
		SET @Parent_ID = @Item_ID

		fetch next from cr_Items into @Item
	end
	
	close cr_Items
	deallocate cr_Items

end
