DECLARE @counter INT = 0;

CREATE TABLE #CharacterTemp
(
	UC NCHAR(1)
)

WHILE @counter < 100000
BEGIN
	INSERT INTO #CharacterTemp (UC) VALUES (NCHAR(@Counter))
	SET @counter = @counter + 1
END

SELECT UC, CAST(UC as CHAR(1)) as CharCast FROM #CharacterTemp
DROP TABLE #CharacterTemp