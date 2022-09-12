DECLARE @dbid INT

SELECT @dbid = Db_id('Reporting')

SELECT TableName = Object_name(s.object_id),
       Reads = Sum(user_seeks + user_scans + user_lookups),
       Writes = Sum(user_updates),
	   [RowCount] = Sum(sPTN.Rows)
FROM   sys.dm_db_index_usage_stats AS s
       INNER JOIN sys.indexes AS i
               ON s.object_id = i.object_id
                  AND i.index_id = s.index_id
	   INNER JOIN sys.objects as sOBJ
			   ON sOBJ.object_id = s.object_id
	   INNER JOIN sys.partitions as sPTN
			   ON sOBJ.object_id = sPTN.object_id
WHERE  Objectproperty(s.object_id, 'IsUserTable') = 1
       AND s.database_id = @dbid
GROUP  BY Object_name(s.object_id)
ORDER  BY 4 DESC 

