select
	schema_name(t.schema_id) SchemaName,
	t.[name] TableName,
	FORMAT(SUM(p.row_count), '###,###,###') as TotalRows
FROM
	sys.tables t
	INNER JOIN sys.dm_db_partition_stats p
		ON t.object_id = p.object_id
		and T.type_desc = 'USER_TABLE'
		AND p.index_id IN (0,1)
GROUP BY t.schema_id, t.[name]
