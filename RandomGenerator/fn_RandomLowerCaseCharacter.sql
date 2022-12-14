/****** Object:  UserDefinedFunction [dbo].[fn_RandomLowerCaseCharacter]    Script Date: 5/19/2022 10:43:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Scott Vercuski
-- Create Date: 19-MAY-2022
-- Description: Generates a random lower case character
-- =============================================
CREATE OR ALTER   FUNCTION [dbo].[fn_RandomLowerCaseCharacter]
(
)
RETURNS CHAR
AS
BEGIN
	RETURN CHAR(dbo.fn_RandomIntBetween(97,122))
END
