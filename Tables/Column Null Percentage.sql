-- Change this value to any table you're analyzing
DECLARE @tableName NVARCHAR(100) = 'Leadinfo';

DECLARE @sqlStatement NVARCHAR(MAX);
DECLARE @totalRows INT;
DECLARE @ParmDefinition nvarchar(500);
DECLARE @columnName nvarchar(50);
DECLARE @rowCount INT;

CREATE TABLE #columnNames
(
	columnName nvarchar(50) NOT NULL,
)

INSERT INTO #columnNames (columnName)
SELECT name
FROM sys.all_columns ac
WHERE ac.object_id = (SELECT object_id FROM sys.tables WHERE name = @tableName)
	AND ac.is_nullable = 1
ORDER BY name

SET @sqlStatement = N'select @retvalOUT = COUNT(*) from ' + @tableName + ' (NOLOCK)'
SET @ParmDefinition = N'@retvalOUT int OUTPUT';

EXEC sp_executesql @sqlStatement, @ParmDefinition, @retvalOUT=@totalRows OUTPUT;
SET @sqlStatement = '';

-- DECLARE AND OPEN CURSOR
DECLARE columnCursor CURSOR FOR 
	SELECT columnName FROM #columnNames
OPEN columnCursor

FETCH NEXT FROM columnCursor INTO @columnName
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sqlStatement = @sqlStatement + N' 100.0 * SUM(CASE WHEN ' + @columnName + ' IS NULL THEN 1 ELSE 0 END) / ' + CAST(@totalRows as VARCHAR) + ' AS ' + @columnName + 'Percent,';
	FETCH NEXT FROM columnCursor INTO @columnName
END

-- CLOSE AND DEALLOCATE CURSOR
CLOSE columnCursor
DEALLOCATE columnCursor

SET @SqlStatement = 'SELECT ' + LEFT(@SqlStatement, len(@SqlStatement) - 1) + ' FROM ' + @tableName;

EXEC sp_executesql @sqlStatement, @ParmDefinition, @retvalOUT=@totalRows OUTPUT;

-- DROP TEMP TABLES
DROP TABLE #columnNames
