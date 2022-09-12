SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT
	OBJECT_SCHEMA_NAME(IDX.OBJECT_ID) AS Schema_Name, 
	OBJECT_NAME(IDX.OBJECT_ID) AS Table_Name, 
    IDX.name AS Index_Name, 
    IDXPS.index_type_desc AS Index_Type, 
    IDXPS.avg_fragmentation_in_percent Fragmentation_Percentage,
	CASE
	WHEN IDXPS.avg_fragmentation_in_percent BETWEEN 5 AND 30
		THEN 'ALTER INDEX [' + IDX.name + '] ON [dbo].[' + OBJECT_NAME(IDX.OBJECT_ID) + '] REORGANIZE'
	WHEN IDXPS.avg_fragmentation_in_percent > 30
		THEN 'ALTER INDEX [' + IDX.name + '] ON [dbo].[' + OBJECT_NAME(IDX.OBJECT_ID) + '] REBUILD'
	ELSE
		'NO UPDATE NEEDED'
	END as [Rebuild/Reorg Query]
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) IDXPS
     INNER JOIN sys.indexes IDX ON IDX.object_id = IDXPS.object_id
                                   AND IDX.index_id = IDXPS.index_id
WHERE
	OBJECT_SCHEMA_NAME(IDX.OBJECT_ID) = 'dbo'
ORDER BY Fragmentation_Percentage DESC
