----- Insert Roles -------

USE [EIWeb]  
GO
/****** Object:  Table [dbo].[Role]    Script Date: 4/18/2016 3:50:21 ******/
SET IDENTITY_INSERT [dbo].[Role] ON
INSERT [dbo].[Role] ([RoleID], [RoleValue], [RoleDescription]) VALUES (1, 1, N'Analyst')
INSERT [dbo].[Role] ([RoleID], [RoleValue], [RoleDescription]) VALUES (2, 2, N'Administrator')
INSERT [dbo].[Role] ([RoleID], [RoleValue], [RoleDescription]) VALUES (3, 3, N'SuperAdministrator')
SET IDENTITY_INSERT [dbo].[Role] OFF

------ Insert Super Administrator User ------
INSERT INTO [dbo].[User]
           ([UserName]
           ,[FirstName]
           ,[LastName]
           ,[PasswordHash]
           ,[ResetPassword]
           ,[EmailAddress]
           ,[PhoneNumber]
		   ,[UGuid])
     VALUES
           ('testUser@test.com', 
            'testUser',
            'testUser',
            '',
            1,
            'test@test.com',
            '404-404-4404',
			'3348E05B-B146-4708-9DE5-C840729520C8')
GO




