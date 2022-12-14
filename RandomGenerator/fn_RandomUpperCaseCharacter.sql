/****** Object:  UserDefinedFunction [dbo].[fn_RandomUpperCaseCharacter]    Script Date: 5/19/2022 10:45:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random upper case character
-- =============================================
CREATE OR ALTER   FUNCTION [dbo].[fn_RandomUpperCaseCharacter]
(
)
RETURNS CHAR
AS
BEGIN
	RETURN CHAR(dbo.fn_RandomIntBetween(65,90))
END
