DECLARE @SchemaName NVARCHAR(128) = NULL
DECLARE @TableName NVARCHAR(128) = 'fact'
DECLARE @ColumnName NVARCHAR(128) = 'campaign'
DECLARE @UseSchemaLike bit = 1	-- set to 1 if you want to search all schemas like %@SchemaName% or set to 0 for an exact search
DECLARE @UseTableLike bit = 1	-- set to 1 if you want to search all tables like %@Tablename% or set to 0 for an exact search
DECLARE @UseColumnLike bit = 1  -- set to 1 if you want to search all tables like %@ColumnName% or set to 0 for an exact search

select schema_name(tab.schema_id) as schema_name,
    tab.name as table_name, 
    col.column_id,
    col.name as column_name, 
    t.name as data_type,    
    col.max_length,
    col.precision,
	COALESCE(pkdata.isPK, 0) as PrimaryKey
from sys.tables as tab
    inner join sys.columns as col
        on tab.object_id = col.object_id
	left join (
		SELECT K.COLUMN_NAME as ColName, K.TABLE_NAME as TableName, 1 as isPK
		FROM
			INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS C
			JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS K
				ON C.TABLE_NAME = K.TABLE_NAME
				AND C.CONSTRAINT_CATALOG = K.CONSTRAINT_CATALOG
				AND C.CONSTRAINT_SCHEMA = K.CONSTRAINT_SCHEMA
				AND C.CONSTRAINT_NAME = K.CONSTRAINT_NAME
				AND C.CONSTRAINT_TYPE = 'PRIMARY KEY'
	) as pkdata
		on pkdata.ColName = col.name
		AND pkdata.TableName = tab.name
    left join sys.types as t
		on col.user_type_id = t.user_type_id
where
(
	(@UseColumnLike = 1 AND col.name like '%'+@ColumnName+'%')
	OR (@UseColumnLike = 0 AND col.name = @ColumnName)
)
AND
(
	(@UseTableLike = 1 AND @TableName IS NOT NULL AND tab.name like '%'+@TableName+'%')
	OR
	(@UseTableLike = 0 AND @TableName IS NOT NULL AND tab.name = @TableName)
)
--AND
--(
--	(@UseSchemaLike = 1 AND @SchemaName IS NOT NULL AND schema_name(tab.schema_id) like '%'+@SchemaName+'%')
--	OR
--	(@UseSchemaLike = 0 AND @SchemaName IS NOT NULL AND schema_name(tab.schema_id) = @SchemaName)
--)
order by schema_name,
    table_name, 
    column_id;