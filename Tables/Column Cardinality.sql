DECLARE @TableName varchar(50) = ''
DECLARE @ColumnName varchar(50) = ''

DECLARE @SQL nvarchar(1000) = '
DECLARE @TotalValueCount INT 
DECLARE @UniqueValueCount INT

SELECT @TotalValueCount=COUNT(' + @ColumnName + ') FROM ' + @TableName + '
SELECT @UniqueValueCount=COUNT(DISTINCT ' + @ColumnName + ') FROM ' + @TableName + '

SELECT
	@TotalValueCount as [Total Values Count],
	@UniqueValueCount as [Unique Values Count],
	CASE
		WHEN CAST(@TotalValueCount as decimal(18,2)) = 0 THEN 0
		ELSE (CAST(@UniqueValueCount as decimal(18,2))/CAST(@TotalValueCount as decimal(18,2))) * 100
	END as [Cardinality Percentage]'
PRINT @SQL
EXEC sp_executeSQL @SQL