USE Warehouse
GO

EXEC Config.SP_Sync_Check_RowChangeSAFOFromLastTime @VAR_IsDetailed = 1
GO