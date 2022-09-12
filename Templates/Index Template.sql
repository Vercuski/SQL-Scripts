/*
Index Naming Convention
-----------------------
<PK|UK|IX[O]|UX[O]>_<Table name>_<indexed columns>_INC_<included columns>
	PK = Primary key (clustered)
	UK = Unique key
	IX = Non clustered, non-unique index
	IXO = Non clustered, non-unique index (Online ON)
	UX = Unique index
	UXO = Unique index (Online ON)

Example:
--------
CREATE INDEX [IXO_DimCampaign_DealerId_ExternalId_INC_Name_Status_Account]
ON [dbo].[DimCampaign]
(
	[DealerId] ASC,
	[ExternalId] DESC
)
INCLUDE([Name], [Status], [Account])
WITH (ONLINE = ON, STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
ON [PRIMARY]
GO
*/

CREATE INDEX [<index_name>]
ON [<schema_name>].[<table_name, sysname, Address>]
(
	[<column_name1><ASC|DESC>],
)
INCLUDE([<column_name_list>],)
WITH (ONLINE = <ON|OFF>, STATISTICS_NORECOMPUTE = OFF, DROP_EXISTING = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)
ON [PRIMARY]
GO
