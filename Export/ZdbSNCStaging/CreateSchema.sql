IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'com')
EXEC sys.sp_executesql N'CREATE SCHEMA [com]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'control')
EXEC sys.sp_executesql N'CREATE SCHEMA [control]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dim')
EXEC sys.sp_executesql N'CREATE SCHEMA [dim]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'ein')
EXEC sys.sp_executesql N'CREATE SCHEMA [ein]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'fin')
EXEC sys.sp_executesql N'CREATE SCHEMA [fin]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'log')
EXEC sys.sp_executesql N'CREATE SCHEMA [log]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'ver')
EXEC sys.sp_executesql N'CREATE SCHEMA [ver]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'vv')
EXEC sys.sp_executesql N'CREATE SCHEMA [vv]'
GO
