SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @Include_Primary_Key_Indexes bit = 1

SELECT OBJECT_NAME(IX.OBJECT_ID) Table_Name, 
       IX.name AS Index_Name, 
       IX.type_desc Index_Type, 
	   IX.is_primary_key as Primary_Key_Index,
       SUM(PS.[used_page_count]) * 8 IndexSizeKB, 
       IXUS.user_seeks AS NumOfSeeks, 
       IXUS.user_scans AS NumOfScans, 
       IXUS.user_lookups AS NumOfLookups, 
       IXUS.user_updates AS NumOfUpdates, 
       IXUS.last_user_seek AS LastSeek, 
       IXUS.last_user_scan AS LastScan, 
       IXUS.last_user_lookup AS LastLookup, 
       IXUS.last_user_update AS LastUpdate
FROM sys.indexes IX
     INNER JOIN sys.dm_db_index_usage_stats IXUS ON IXUS.index_id = IX.index_id
                                                    AND IXUS.OBJECT_ID = IX.OBJECT_ID
     INNER JOIN sys.dm_db_partition_stats PS ON PS.object_id = IX.object_id
WHERE
	OBJECTPROPERTY(IX.OBJECT_ID, 'IsUserTable') = 1
	AND 
	IXUS.user_seeks = 0
	AND
	IXUS.user_scans = 0
	AND
	IXUS.user_lookups = 0
GROUP BY OBJECT_NAME(IX.OBJECT_ID), 
         IX.name, 
         IX.type_desc, 
		 IX.is_primary_key,
         IXUS.user_seeks, 
         IXUS.user_scans, 
         IXUS.user_lookups, 
         IXUS.user_updates, 
         IXUS.last_user_seek, 
         IXUS.last_user_scan, 
         IXUS.last_user_lookup, 
         IXUS.last_user_update
ORDER BY
	lastupdate desc