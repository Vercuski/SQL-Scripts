/****** Object:  UserDefinedFunction [dbo].[fn_RandomIntBetween]    Script Date: 5/19/2022 10:43:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random integer between two inclusive integers
-- =============================================
CREATE OR ALTER   FUNCTION [dbo].[fn_RandomIntBetween]
(
	@MinInclusiveValue INT,
	@MaxInclusiveValue INT
)
RETURNS INT
AS
BEGIN
	DECLARE @randValue float
	SELECT @randValue = [Value] FROM v_getRANDValue
	RETURN FLOOR(@randValue*(@MaxInclusiveValue-@MinInclusiveValue+1))+@MinInclusiveValue
END
