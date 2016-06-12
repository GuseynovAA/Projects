USE [Ion]
GO

/****** Object:  UserDefinedFunction [FL].[DF_Strings_Split]    Script Date: 16.09.2013 21:15:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [FL].[DF_Strings_Split](@Str nvarchar(4000), @Delimiter char(1))
RETURNS @Results TABLE (Number int identity, Item nvarchar(4000))
AS
BEGIN

	DECLARE @Counter INT
	DECLARE @Slice NVARCHAR(4000)

	SELECT @Counter = 1

	IF @Str IS NULL RETURN

	WHILE @Counter !=0
	BEGIN 

		SELECT @Counter = CHARINDEX(@Delimiter,@Str)

		IF @Counter !=0
			SELECT @Slice = LEFT(@Str,@Counter - 1)
		ELSE
			SELECT @Slice = @Str

		INSERT INTO @Results(Item) VALUES(@Slice)

		SELECT @Str = RIGHT(@Str,LEN(@Str) - @Counter)

		IF LEN(@Str) = 0 BREAK

	END

	RETURN

END


GO


