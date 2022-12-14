/****** Object:  UserDefinedFunction [dbo].[fn_RandomPhoneNumber]    Script Date: 5/19/2022 10:44:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random phone number
-- =============================================
CREATE OR ALTER   FUNCTION [dbo].[fn_RandomPhoneNumber]
()
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX) = ''
	SET @Result = '(' + dbo.fn_RandomNumberString(3,3) + ') ' + dbo.fn_RandomNumberString(3,3) + '-' + dbo.fn_RandomNumberString(4,4)
	RETURN @Result
END
