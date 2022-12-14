
USE [EIWeb]
GO

CREATE LOGIN [eiweb_appuser] WITH PASSWORD=N'P@ssW0rD', DEFAULT_DATABASE=[EIWeb],     
	DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF

GO

/****** Object:  User [eiweb_appuser]    Script Date: 4/18/2016 3:48:10 PM ******/
CREATE USER [eiweb_appuser] FOR LOGIN [eiweb_appuser] WITH DEFAULT_SCHEMA=[dbo]
GO


GRANT EXECUTE ON SCHEMA :: dbo TO [eiweb_appuser];

GO

CREATE ROLE [db_procexec] AUTHORIZATION [dbo]
GO



EXEC dbo.sp_addrolemember @rolename=N'db_procexec', @membername=N'eiweb_appuser'    
GO

EXEC dbo.sp_addrolemember @rolename=N'db_datareader', @membername=N'eiweb_appuser'
GO

EXEC dbo.sp_addrolemember @rolename=N'db_datawriter', @membername=N'eiweb_appuser'
GO

