/****** Object:  UserDefinedFunction [dbo].[fn_RandomNumberString]    Script Date: 5/19/2022 10:44:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random string of numbers which is at least
--				MinStringSize and at most MaxStringSize
-- =============================================
CREATE OR ALTER   FUNCTION [dbo].[fn_RandomNumberString]
(
	@MinStringSize INT,
	@MaxStringSize INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @ResultSize INT = dbo.fn_RandomIntBetween(@MinStringSize, @MaxStringSize)
	DECLARE @Counter INT = 1
	DECLARE @Result VARCHAR(MAX) = ''

	WHILE (@Counter <= @ResultSize)
	BEGIN
		SET @Result = @Result + CHAR(dbo.fn_RandomIntBetween(48,57))
		SET @Counter = @Counter + 1
	END
	RETURN @Result
END
