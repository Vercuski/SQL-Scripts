DECLARE @SQLStatement nvarchar(2000)
DECLARE @ColumnName varchar(50) = 'UnicodeValue'
DECLARE @TableName varchar(50) = 'UnicodeTest'
DECLARE @ColumnSize varchar(10) = '50'

SET @SQLStatement = 'SELECT 
	[' + @ColumnName + '],
	CAST([' + @ColumnName + '] AS VARCHAR(' + @ColumnSize + ')) as VarcharCast,
	CAST([' + @ColumnName + '] AS NVARCHAR(' + @ColumnSize + ')) as NVarcharCast
FROM
	' + @TableName + '
WHERE
	CAST([' + @ColumnName + '] AS VARCHAR(' + @ColumnSize + ')) <> CAST([' + @ColumnName + '] AS NVARCHAR(' + @ColumnSize + '))'

PRINT @SQLStatement
EXEC sp_executesql @SQLStatement