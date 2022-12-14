/****** Object:  UserDefinedFunction [dbo].[fn_RandomSSN]    Script Date: 5/19/2022 10:45:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random string of numbers to mimic a Social Security Number.
--				A bit flag parameter is included to include or exclude the dashes in the SSN
-- =============================================
CREATE OR ALTER   FUNCTION [dbo].[fn_RandomSSN]
(
	@IncludeDashes BIT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @Result VARCHAR(MAX) = ''
	IF @IncludeDashes = 1
		BEGIN
			SET @Result = dbo.fn_RandomNumberString(3,3)+'-'+dbo.fn_RandomNumberString(2,2)+'-'+dbo.fn_RandomNumberString(4,4)
		END
	ELSE
		BEGIN
			SET @Result = dbo.fn_RandomNumberString(9,9)
		END
	RETURN @Result
END
