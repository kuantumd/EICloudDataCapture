USE [EIWeb]
GO

INSERT INTO [dbo].[lk_RecordSource]
           ([RecordSourceId]
           ,[RecordSource]
           ,[RecordSourceDescription])
     VALUES (1 ,'EWE' ,'Source is EWE web application' ),
            (2 ,'Epi7' ,'Source is Epi7 desktop application' ),
	        (3 ,'MA' ,'Source is mobile application' ),
			(4 ,'EIWS' ,'Source is  EIWS web application' )
GO


INSERT INTO [dbo].[lk_Status]
           ([StatusId]
           ,[Status])
     VALUES
           (0, 'deleted'),
           (1, 'In Process'),
		   (2, 'Saved'),
		   (3, 'for the future'),
		   (4, 'downloaded')
GO


INSERT INTO [dbo].[lk_SurveyType]
           ([SurveyTypeId]
           ,[SurveyType])
     VALUES
           (1, 'Single Response'),
		   (2, 'Multiple Reponse')
GO

INSERT INTO [dbo].[DataAccessRules] 
			([RuleId], 
			[RuleName], 
			[RuleDescription])
	VALUES
		(1, 'Access within organization', ' Organization users can only access the data of their organization'),
		(2, 'Enable data access for central organization', ' All users in host organization will have access to all data of all organizations'),
		(3, 'Enable data access to all', 'All users of all organizations can access all data')
GO




