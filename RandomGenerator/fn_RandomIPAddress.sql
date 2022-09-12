SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random IP Address
-- =============================================
CREATE OR ALTER FUNCTION [dbo].[fn_RandomIPAddress]
()
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX) = ''
	SET @Result = TRIM(STR(dbo.fn_RandomIntBetween(1,255))) + '.' + TRIM(STR(dbo.fn_RandomIntBetween(1,255))) + '.' + TRIM(STR(dbo.fn_RandomIntBetween(1,255))) + '.' +TRIM(STR(dbo.fn_RandomIntBetween(1,255)))
	RETURN @Result
END
