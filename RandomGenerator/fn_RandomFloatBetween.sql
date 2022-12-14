/****** Object:  UserDefinedFunction [dbo].[fn_RandomFloatBetween]    Script Date: 5/19/2022 10:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random floating point value between an inclusive minimum and exclusive maximum
-- =============================================
CREATE OR ALTER   FUNCTION [dbo].[fn_RandomFloatBetween]
(
	@MinInclusiveValue FLOAT,
	@MaxExclusiveValue FLOAT
)
RETURNS FLOAT
AS
BEGIN
	DECLARE @randValue float
	SELECT @randValue = [Value] FROM v_getRANDValue
	RETURN @randValue*((@MaxExclusiveValue-1)-@MinInclusiveValue+1)+@MinInclusiveValue
END
