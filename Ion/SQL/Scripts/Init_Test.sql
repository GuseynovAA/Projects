USE Ion
GO

TRUNCATE TABLE dbo.Stores
TRUNCATE TABLE dbo.Pipes
TRUNCATE TABLE dbo.StoresResources

INSERT INTO dbo.Stores (Id, Code) VALUES (1, 'S1'), (2, 'S2')

INSERT INTO dbo.Pipes (SourceStoreId, TargetStoreId, TypeId, ResourceId)
VALUES
	--(1, 2, 1, NULL),
	(1, 2, 2, 1)
	--(2, 1, 1, NULL)

INSERT INTO dbo.StoresResources (ResourceId, StoreId)
VALUES
	(1, 1),
	(1, 1),
	(1, 1),
	(2, 1),
	(1, 1)



