DECLARE @TableName NVARCHAR(120) = ''

select schema_name(tab.schema_id) as schema_name,
	tab.*
from sys.tables as tab
where tab.name like '%'+@TableName+'%'
order by schema_name,
    tab.name