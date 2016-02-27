USE [Ion]
GO

/****** Object:  UserDefinedFunction [FL].[DF_Objects_Relations_PathItems]    Script Date: 16.09.2013 21:16:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [FL].[DF_Objects_Relations_PathItems]
(	
	@Path NVARCHAR(MAX),
	@Delimiter CHAR(1) = '/',
	@Relation_Type_UID NVARCHAR(200)
)
RETURNS  @Results TABLE (
	Path_Number INT,
	Step_Number INT,
	[Object_ID] BIGINT,
	[Object_Code] NVARCHAR(200)
)
AS
BEGIN
	
	DECLARE @Items_Count INT

	DECLARE @Items TABLE (
		Number INT,
		Item NVARCHAR(MAX)
	)

	INSERT INTO @Items(Number, Item)
	SELECT Number, Item
	FROM FL.DF_Strings_Split(@Path, @Delimiter) S


	SELECT @Items_Count = COUNT(*) FROM @Items;
	
	WITH CTE ([Path_Number], [Step_Number], [Object_ID], [Object_Code])
	AS
	(
		SELECT
			ROW_NUMBER() OVER (ORDER BY I.Item) [Path_Number],
			I.Number [Step_Number],
			R.Child_Object_ID [Object_ID],
			R.Child_Object_Code [Object_Code]
		FROM
			@Items I
			INNER JOIN ML.Objects_Relations R ON
				R.Child_Object_Code = I.Item AND
				R.Type_UID = @Relation_Type_UID
		WHERE I.Number = 1
		UNION ALL
		SELECT
			C.Path_Number [Path_Number],
			C.Step_Number + 1 [Step_Number],
			R.Child_Object_ID [Object_ID],
			R.Child_Object_Code [Object_Code]
		FROM
			CTE C
			INNER JOIN ML.Objects_Relations R ON
				R.Parent_Object_ID = C.[Object_ID] AND
				R.Type_UID = @Relation_Type_UID
			INNER JOIN @Items I ON
				I.Item = R.Child_Object_Code AND
				I.Number = C.Step_Number + 1
	)
	INSERT INTO @Results
	SELECT * FROM CTE

	DELETE FROM @Results
	FROM
		@Results R
		INNER JOIN (
			SELECT [Path_Number]
			FROM @Results
			GROUP BY [Path_Number]
			HAVING COUNT([Step_Number]) < @Items_Count
		) G ON G.Path_Number = R.Path_Number

	RETURN
END


GO


