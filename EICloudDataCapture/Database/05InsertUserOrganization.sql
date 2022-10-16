----- Insert User and Organization relationship -------

USE [EIWeb]  
GO
/****** Object:  Table [dbo].[UserOrganization]    Script Date: 4/18/2016 4:01:11 ******/

INSERT INTO [dbo].[UserOrganization]
           ([UserID]
           ,[OrganizationID]
           ,[RoleID]
           ,[Active])
     VALUES
           (1
           ,1
           ,3
           ,1)
GO


