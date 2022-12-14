/****** Object:  UserDefinedFunction [dbo].[fn_RandomDate]    Script Date: 5/19/2022 10:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random datetime based on a MinDate and a MaxDate
-- =============================================
CREATE OR ALTER   FUNCTION [dbo].[fn_RandomDate]
(
	@MinDateTime DATETIME,
	@MaxDateTime DATETIME
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @MinFloat FLOAT = CONVERT(FLOAT, @MinDateTime)
	DECLARE @MaxFloat FLOAT = CONVERT(FLOAT, @MaxDateTime)

	RETURN CONVERT(DATETIME, dbo.fn_RandomFloatBetween(@MinFloat, @MaxFloat))
END
