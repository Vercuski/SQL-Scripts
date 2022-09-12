DECLARE @Table_Name SYSNAME = 'my_table_name';

;
WITH xmlnamespaces(DEFAULT
N'http://schemas.microsoft.com/sqlserver/2004/07/showplan')

SELECT cp.plan_handle,
	   operators.value('(TableScan/Object/@Database)[1]', 'sysname') AS Database_Name,
       operators.value('(TableScan/Object/@Schema)[1]', 'sysname') AS Schema_Name,
       operators.value('(TableScan/Object/@Table)[1]', 'sysname')  AS Table_Name,
       operators.value('(TableScan/Object/@Index)[1]', 'sysname')  AS Index_Name,
       operators.value('@PhysicalOp', 'nvarchar(50)')              AS Physical_Operator,
       cp.usecounts,
       qp.query_plan
FROM   sys.dm_exec_cached_plans cp
       CROSS apply sys.Dm_exec_query_plan(cp.plan_handle) qp
       CROSS apply query_plan.nodes('//RelOp') rel(operators)
WHERE  operators.value('@PhysicalOp', 'nvarchar(60)') IN ( 'Table Scan' )
AND operators.value('(TableScan/Object/@Database)[1]', 'sysname') NOT IN ('[tempdb]', '[msdb]')
ORDER BY
	cp.usecounts desc
--AND operators.value('(TableScan/Object/@Table)[1]','sysname') = QUOTENAME(@Table_Name,'[');