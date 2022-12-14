/*
Run this script on:

        fetpepiinfodbs.cloudapp.net,8443.EIWeb_Prod    -  This database will be modified

to synchronize it with:

        fetpepiinfodbs.cloudapp.net,8443.EIWeb_Dev

You are recommended to back up your database before running this script

Script created by SQL Compare version 11.1.3 from Red Gate Software Ltd at 7/27/2017 3:46:27 PM

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping foreign keys from [dbo].[SurveyResponse]'
GO
ALTER TABLE [dbo].[SurveyResponse] DROP CONSTRAINT [FK_SurveyResponse_SurveyResponse]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[ErrorLog]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[ErrorLog] ALTER COLUMN [Comment] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering [dbo].[SurveyMetaData]'
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
ALTER TABLE [dbo].[SurveyMetaData] ADD
[LastUpdate] [datetime2] NULL
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Admin]'
GO
CREATE TABLE [dbo].[Admin]
(
[AdminId] [uniqueidentifier] NOT NULL,
[AdminEmail] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OrganizationId] [int] NOT NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF_Admin_IsActive] DEFAULT ((1)),
[Notify] [bit] NOT NULL CONSTRAINT [DF_Admin_Notify] DEFAULT ((0)),
[LastName] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PhoneNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Admin] on [dbo].[Admin]'
GO
ALTER TABLE [dbo].[Admin] ADD CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED  ([AdminId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[Address]'
GO
CREATE TABLE [dbo].[Address]
(
[AddressId] [int] NOT NULL IDENTITY(1, 1),
[AddressLine1] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AddressLine2] [nvarchar] (60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StateProvinceId] [int] NOT NULL,
[PostalCode] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AdminId] [uniqueidentifier] NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_Address] on [dbo].[Address]'
GO
ALTER TABLE [dbo].[Address] ADD CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED  ([AddressId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[SourceTables]'
GO
CREATE TABLE [dbo].[SourceTables]
(
[SourceTableName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FormId] [uniqueidentifier] NOT NULL,
[SourceTableXml] [xml] NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_SourceTables] on [dbo].[SourceTables]'
GO
ALTER TABLE [dbo].[SourceTables] ADD CONSTRAINT [PK_SourceTables] PRIMARY KEY CLUSTERED  ([SourceTableName], [FormId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating [dbo].[States]'
GO
CREATE TABLE [dbo].[States]
(
[StateProvinceId] [int] NOT NULL,
[StateCode] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StateName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Creating primary key [PK_States] on [dbo].[States]'
GO
ALTER TABLE [dbo].[States] ADD CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED  ([StateProvinceId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[Organization]'
GO
ALTER TABLE [dbo].[Organization] ADD CONSTRAINT [UK_Organization] UNIQUE NONCLUSTERED  ([Organization])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[SurveyMetaData]'
GO
ALTER TABLE [dbo].[SurveyMetaData] ADD CONSTRAINT [DF_SurveyMetaData_OwnerId] DEFAULT ((0)) FOR [OwnerId]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding constraints to [dbo].[SurveyResponse]'
GO
ALTER TABLE [dbo].[SurveyResponse] ADD CONSTRAINT [DF_SurveyResponse_IsLocked] DEFAULT ((0)) FOR [IsLocked]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[Address]'
GO
ALTER TABLE [dbo].[Address] ADD CONSTRAINT [FK_Address_Admin] FOREIGN KEY ([AdminId]) REFERENCES [dbo].[Admin] ([AdminId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[Admin]'
GO
ALTER TABLE [dbo].[Admin] ADD CONSTRAINT [FK_Admin_Organization] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([OrganizationId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SurveyMetaData]'
GO
ALTER TABLE [dbo].[SurveyMetaData] ADD CONSTRAINT [FK_SurveyMetaData_Organization] FOREIGN KEY ([OrganizationId]) REFERENCES [dbo].[Organization] ([OrganizationId])
ALTER TABLE [dbo].[SurveyMetaData] ADD CONSTRAINT [FK_SurveyMetaData_lk_SurveyType] FOREIGN KEY ([SurveyTypeId]) REFERENCES [dbo].[lk_SurveyType] ([SurveyTypeId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Adding foreign keys to [dbo].[SurveyResponse]'
GO
ALTER TABLE [dbo].[SurveyResponse] ADD CONSTRAINT [FK_SurveyResponse_lk_RecordSource] FOREIGN KEY ([RecordSourceId]) REFERENCES [dbo].[lk_RecordSource] ([RecordSourceId])
ALTER TABLE [dbo].[SurveyResponse] ADD CONSTRAINT [FK_SurveyResponse_SurveyResponse] FOREIGN KEY ([RelateParentId]) REFERENCES [dbo].[SurveyResponse] ([ResponseId])
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering trigger [dbo].[tr_delete_surveyresponse] on [dbo].[SurveyResponse]'
GO
ALTER TRIGGER [dbo].[tr_delete_surveyresponse]
    ON [dbo].[SurveyResponse]	
    FOR DELETE
AS 

BEGIN

	   SET NOCOUNT ON;

	   -- Cleanup    
	   IF OBJECT_ID('tempdb..#temp') IS NOT NULL
		   DROP TABLE #temp;

	   DECLARE @IsSQLResponse AS BIT;
	   DECLARE @IsResponseinsertedToEpi7 AS BIT;
	   DECLARE @ViewTableName AS VARCHAR (50);
	   DECLARE @UpdateSQL AS VARCHAR (MAX);
	   DECLARE @Epi7DBName AS VARCHAR (50);
	   DECLARE @RECSTATUS AS SMALLINT = 0;
	   DECLARE @IsSQLProject AS BIT;
	   DECLARE @SurveyId AS UNIQUEIDENTIFIER;
	   DECLARE @ResponseId AS UNIQUEIDENTIFIER;
	   DECLARE @PageTableName AS VARCHAR (50);
	   DECLARE @DeleteSQL AS VARCHAR (500); 
	   DECLARE @RecordsourceId  AS VARCHAR (50); 

	    SELECT @RecordsourceId = d.RecordsourceId			  
	   FROM   deleted AS d;

	   If @RecordsourceId='2' --Epi7
		BEGIN
			RETURN;
		END

		 If @RecordsourceId='3' --MobileApplication
		BEGIN
			RETURN;
		END

		 If @RecordsourceId='4' --EIWS
		BEGIN
			RETURN;
		END

	   SELECT @ResponseId = d.responseid,
			  @SurveyId = d.surveyid
	   FROM   deleted AS d;
	   	   
	   SELECT @IsSQLProject = issqlproject
	   FROM   surveymetadata
	   WHERE  surveyid = @SurveyId;
	   
	   -- Is this a SQL project?            
	   IF @IsSQLProject = 1
		   BEGIN
		   
			   -- Get the Epi7 proects's DB name      
			   SELECT @Epi7DBName = initialcatalog
			   FROM   eidatasource
			   WHERE  surveyid = @SurveyId;
			   
			   -- Get the Epi7 ViewTable name     
			   SELECT @ViewTableName = viewtablename
			   FROM   surveymetadataview
			   WHERE  surveyid = @SurveyId;
			   
			   -- Get a uique list of the data collection tabs
			   -- for this SurveyId    
			   SELECT DISTINCT [TableName]
			   INTO   #temp
			   FROM   [SurveyMetaDataTransform]
			   WHERE  SurveyId = @SurveyId;    
			   			   			   
			   -- Loop through all data collection tabs and delete 
			   -- the response records    aaaa  			   			   			   
			   DECLARE PAGE_TABLE CURSOR FAST_FORWARD
				   FOR SELECT TableName
					   FROM   #temp;
			   OPEN PAGE_TABLE;
			   FETCH NEXT FROM PAGE_TABLE INTO @PageTableName;        
			   			   			   			   
			   WHILE (@@FETCH_STATUS = 0)
				   BEGIN
					   SET @DeleteSQL = ' DELETE FROM ' + '[' + @Epi7DBName + '].[dbo].[' + @PageTableName + ']' + 
										' WHERE GlobalRecordId = ' + QUOTENAME(CAST (@ResponseId AS VARCHAR (255)), '''');
										
					   EXECUTE (@DeleteSQL);
					    IF @@ERROR > 0
							GOTO ERRORBLOCK;

					   FETCH NEXT FROM PAGE_TABLE INTO @PageTableName;
				   END
			   
			   CLOSE PAGE_TABLE;
			   DEALLOCATE PAGE_TABLE;
			   			   
			   SET @DeleteSQL = ' DELETE FROM ' + '[' + @Epi7DBName + '].[dbo].[' + @ViewTableName + ']' + 
								' WHERE GlobalRecordId = ' + QUOTENAME(CAST (@ResponseId AS VARCHAR (255)), '''');
			   
			   -- Delete the parent record  										
			   EXECUTE (@DeleteSQL);
			   IF @@ERROR > 0
					GOTO ERRORBLOCK;
		   END

		    RETURN;

		   ERRORBLOCK:
			 BEGIN  
					DECLARE @ErrorNumber AS INT;
					DECLARE @ErrorSeverity AS INT;
					DECLARE @ErrorState AS INT;
					DECLARE @ErrorProcedure AS NVARCHAR (128);
					DECLARE @ErrorLine AS INT;
					DECLARE @ErrorMessage AS NVARCHAR (4000);  
			         
					SELECT @ErrorNumber = ERROR_NUMBER(), --  AS ErrorNumber
							@ErrorSeverity = ERROR_SEVERITY(), --  AS ErrorSeverity
							@ErrorState = ERROR_STATE(), --  AS ErrorState
							@ErrorProcedure = ERROR_PROCEDURE(), --  AS ErrorProcedure
							@ErrorLine = ERROR_LINE(), --   AS ErrorLine
							@ErrorMessage = ERROR_MESSAGE(); --   AS ErrorMessage;
            
					EXECUTE usp_log_to_errorlog 
						@SurveyId, @ResponseId, '', 
						'tr_delete_surveyresponse', @DeleteSQL, 
						@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine, @ErrorMessage;	

			END   

	RETURN;
END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering trigger [dbo].[tr_insert_surveyresponse] on [dbo].[SurveyResponse]'
GO
ALTER    TRIGGER [dbo].[tr_insert_surveyresponse]
    ON [dbo].[SurveyResponse]
    FOR INSERT  
    AS 
    
    BEGIN
           -- SET NOCOUNT ON added to prevent extra result sets from
           -- interfering with SELECT statements.
           SET NOCOUNT ON;
    
           DECLARE @SurveyId AS UNIQUEIDENTIFIER;
           DECLARE @ResponseId AS UNIQUEIDENTIFIER;
           DECLARE @StatusId AS INT;
           DECLARE @IsDraftMode AS BIT;
           DECLARE @RecordsourceId  AS VARCHAR (50); 		   
           
           SELECT @ResponseId = i.ResponseId,
                  @SurveyId = i.SurveyId,
                  @StatusId = i.StatusId,
                  @IsDraftMode = i.IsDraftMode, 
                  @RecordsourceId = i.RecordsourceId
           FROM   inserted AS i;

		If @RecordsourceId='3' --MobileApplication
		BEGIN
			RETURN;
		END

		If @RecordsourceId='4' --EIWS
		BEGIN
			RETURN;
		END


           -- Get project's SQL status       
           DECLARE @IsSQLProject AS BIT;
           SELECT @IsSQLProject = IsSQLProject 
           FROM   SurveyMetaData
           WHERE  SurveyId = @SurveyId;


           -- PATH 1     
           IF @IsSQLProject = 1
              AND @StatusId = 1
              AND @RecordsourceId = '1'
               BEGIN
                    INSERT INTO   SurveyResponseTracking
						(ResponseId, IsSQLResponse, IsResponseinsertedToEpi7  )
						VALUES
						(@ResponseId, 1, 0)
						
						IF @@ERROR > 0
							GOTO ERRORBLOCK;						  						           
                   RETURN;
               END
           
           -- PATH 2        
           IF @IsSQLProject = 0
               BEGIN
                    INSERT INTO   SurveyResponseTracking
						(ResponseId, IsSQLResponse, IsResponseinsertedToEpi7  )
						VALUES
						(@ResponseId,  0, 0 ) 	

						IF @@ERROR > 0
							GOTO ERRORBLOCK;

                   RETURN;
               END
           
           --  PATH 3            
           IF @IsSQLProject = 1
              AND @StatusId = 2       
              and @RecordsourceId = '2'  
               BEGIN
                INSERT INTO   SurveyResponseTracking
						(ResponseId, IsSQLResponse, IsResponseinsertedToEpi7  )
						VALUES
						(@ResponseId, 1, 1 ) 
						
						IF @@ERROR > 0
							GOTO ERRORBLOCK;
								      
                   RETURN;
               END
           
           --  PATH  5                        
           IF @IsSQLProject = 1
              AND @StatusId = 2
              AND @RecordsourceId  = '3'
               BEGIN
					INSERT INTO   SurveyResponseTracking
						(ResponseId, IsSQLResponse, IsResponseinsertedToEpi7  )
						   VALUES
						(@ResponseId, 1, 0 ) 		                   
				
                     UPDATE  SurveyResponseTracking
						SET IsResponseinsertedToEpi7 = 1     
                     WHERE  ResponseId =  @ResponseId ;

					 IF @@ERROR > 0
							GOTO ERRORBLOCK;

                   RETURN;
               END
      	  
	   RETURN;

	   ERRORBLOCK:
		 BEGIN  
				DECLARE @ErrorNumber AS INT;
				DECLARE @ErrorSeverity AS INT;
				DECLARE @ErrorState AS INT;
				DECLARE @ErrorProcedure AS NVARCHAR (128);
				DECLARE @ErrorLine AS INT;
				DECLARE @ErrorMessage AS NVARCHAR (4000);  
			         
				SELECT @ErrorNumber = ERROR_NUMBER(), --  AS ErrorNumber
						@ErrorSeverity = ERROR_SEVERITY(), --  AS ErrorSeverity
						@ErrorState = ERROR_STATE(), --  AS ErrorState
						@ErrorProcedure = ERROR_PROCEDURE(), --  AS ErrorProcedure
						@ErrorLine = ERROR_LINE(), --   AS ErrorLine
						@ErrorMessage = ERROR_MESSAGE(); --   AS ErrorMessage;
            
				EXECUTE usp_log_to_errorlog 
					@SurveyId, @ResponseId, '', 
					'tr_insert_surveyresponse', 'Insert/Update of SurveyResponseTracking failed', 
					@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine, @ErrorMessage;	

		END   

	   RETURN;

	END
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Altering trigger [dbo].[tr_update_surveyresponse] on [dbo].[SurveyResponse]'
GO
ALTER TRIGGER [dbo].[tr_update_surveyresponse]
    ON [dbo].[SurveyResponse]
    FOR UPDATE
    AS 
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from 
    -- interfering with SELECT statements. 
    SET NOCOUNT ON;

    DECLARE @SurveyId AS UNIQUEIDENTIFIER;
    DECLARE @ResponseId AS UNIQUEIDENTIFIER;
    DECLARE @StatusId AS INT;
    DECLARE @ResponseXml AS XML;
    DECLARE @IsDraftMode AS BIT;
    DECLARE @IsSQLResponse AS BIT;
    DECLARE @IsResponseinsertedToEpi7 AS BIT;
    DECLARE @ParentRecordId AS UNIQUEIDENTIFIER;   
    DECLARE @InsertText AS VARCHAR (MAX);
    DECLARE @Epi7DBName AS VARCHAR (50);
    DECLARE @UpdateText AS VARCHAR (MAX);
    DECLARE @ResultText AS VARCHAR (MAX);
    DECLARE @UpdateResultText AS VARCHAR (MAX);
    DECLARE @RecordsourceId AS VARCHAR (50);
    DECLARE @UseDBText AS VARCHAR (100);
    DECLARE @ViewTableName AS VARCHAR (50);
    DECLARE @RelateParentId AS UNIQUEIDENTIFIER;
	DECLARE @throw_text as  VARCHAR(MAX); 
	DECLARE @ErrorNumber AS INT;
	DECLARE @ErrorSeverity AS INT;
	DECLARE @ErrorState AS INT;
	DECLARE @ErrorProcedure AS NVARCHAR (128);
	DECLARE @ErrorLine AS INT;
	DECLARE @ErrorMessage AS NVARCHAR (4000);
	DECLARE @InsertviewText AS VARCHAR (500); 

	-- Get values from just inserted record                
    SELECT @ResponseId = i.responseid,
            @SurveyId = i.surveyid,
            @StatusId = i.statusid,
            @ResponseXml = i.responsexml,
            @IsDraftMode = i.isdraftmode,
            @ParentRecordId = i.parentrecordid,
            @RelateParentId = i.relateparentid
    FROM   inserted AS i;


	-- Get record source                    
    SELECT @RecordsourceId = recordsourceid
    FROM   surveyresponse
    WHERE  responseid = @ResponseId;


	 IF @RecordsourceId='3' --MobileApplication
	  BEGIN
	 RETURN;--For Future Implementation
	 END

	 IF @RecordsourceId='4' --EIWS
		BEGIN
		DECLARE @FirstSaveLogonNameWS AS VARCHAR (100) = 'EIWS';		
       
       IF  @StatusId <> 3  --If the record is not complete
           BEGIN
               RETURN;
           END
	---		   			
		SELECT @IsSQLResponse = IsSQLProject           
		FROM   surveymetadata
		WHERE  surveyid = @SurveyId;									
			   
			IF @IsSQLResponse = 1 --For SQL response implement the following logic
				BEGIN
					--===========================		
					-- If Response is not finalized then return    														
					-- Get the Epi7 proects's DB name      
					SELECT @Epi7DBName = initialcatalog
					FROM   eidatasource
					WHERE  surveyid = @SurveyId;			
					-- STEP 1   
					-- call usp_create_Epi7_views_statement   				
					SELECT @ViewTableName = viewtablename
					FROM   surveymetadataview
					WHERE  surveyid = @SurveyId;
				
					SET @InsertviewText = 'INSERT  INTO  [' + @Epi7DBName + '].dbo.[' + @ViewTableName + ']' + ' ([RECSTATUS]    ,
								[GlobalRecordId]    ,
								[FirstSaveLogonName]    ,
								[FirstSaveTime]    ,
								[LastSaveLogonName]    ,
								[LastSaveTime]  )
								values   ' + 
								'(  ' + 
									'1 ,  ' + 
									quotename(CAST (@ResponseId AS VARCHAR (100)), '''') + ', ' + 
									quotename(@FirstSaveLogonNameWS, '''') + ', ' + 
									quotename(CAST (Getdate() AS VARCHAR (100)), '''') + ', ' + 
									quotename(@FirstSaveLogonNameWS, '''') + ', ' + 
									quotename(CAST (Getdate() AS VARCHAR (100)), '''')  +   
									') ';

						IF @InsertviewText IS NULL
							BEGIN            
								INSERT  INTO [ErrorLog] ([SurveyId], [ResponseId], comment, [ErrorText])
								VALUES                 (@SurveyId, @ResponseId, '@InsertviewText is null ', @InsertviewText);				  
							END 
						ELSE
							BEGIN
								EXECUTE (@InsertviewText);

									IF @@ERROR >  0    
									  BEGIN 					             
										SELECT @ErrorNumber = ERROR_NUMBER(), --  AS ErrorNumber
												@ErrorSeverity = ERROR_SEVERITY(), --  AS ErrorSeverity
												@ErrorState = ERROR_STATE(), --  AS ErrorState
												@ErrorProcedure = ERROR_PROCEDURE(), --  AS ErrorProcedure
												@ErrorLine = ERROR_LINE(), --   AS ErrorLine
												@ErrorMessage = ERROR_MESSAGE(); --   AS ErrorMessage;
            
										EXECUTE usp_log_to_errorlog 
											@SurveyId, @ResponseId, @InsertviewText, 
											'usp_create_epi7_sql_statements', 'Insert/Update in #temp table may have failed', 
											@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine, @ErrorMessage;
									  END   
						END    					
					 
					-- STEP 2    
					EXECUTE usp_create_epi7_sql_statements_driver 
							@ResponseXml, 
							@SurveyId,  
							@ResponseId, 
							'i', 
							@Epi7DBName;                                      

					EXECUTE (@InsertText);  --  returned from  sp      
					
					
						IF @@ERROR >  0    
							BEGIN 					             
								SELECT @ErrorNumber = ERROR_NUMBER(), --  AS ErrorNumber
								@ErrorSeverity = ERROR_SEVERITY(), --  AS ErrorSeverity
								@ErrorState = ERROR_STATE(), --  AS ErrorState
								@ErrorProcedure = ERROR_PROCEDURE(), --  AS ErrorProcedure
								@ErrorLine = ERROR_LINE(), --   AS ErrorLine
								@ErrorMessage = ERROR_MESSAGE(); --   AS ErrorMessage;
            
							EXECUTE usp_log_to_errorlog 
							@SurveyId, @ResponseId, @InsertText, 
							'usp_create_epi7_sql_statements', 'Insert/Update in #temp table may have failed', 
							@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine, @ErrorMessage;
					  END                          					
					--===========================  
					RETURN 
				END
			ELSE  --This logic is for pivot logic for Access project
				BEGIN 
				   -- Simple replace of Yes with 1 / No with 
					--DECLARE @xmltext AS VARCHAR (MAX);
					--SET @xmltext = CONVERT (VARCHAR (MAX), @ResponseXML);
					--SET @xmltext = REPLACE(@xmltext, 'Yes', 1);
					--SET @xmltext = REPLACE(@xmltext, 'No', 0);
					--SET @ResponseXML  = CONVERT (XML, @xmltext);



				   -- Create the relational records from the XML     
				 --  INSERT INTO [dbo].[ResponsesForPivot] ([SurveyId], [ResponseId], [FieldName], [FieldValue])
				 --  (SELECT @SurveyId AS SurveyId,
					--	   @ResponseId AS ResponseId,
					--	   T.c.value('(@QuestionName)[1 ]  ', 'Varchar(100 )  ') AS FieldName,
					--	   T.c.value('(.)', 'Varchar(100 )  ') AS FieldValue
					--FROM   @ResponseXML.nodes('/SurveyResponse/Page/*') AS T(c));
				   
				 --  --  Explicilty deal with fields that should NULL    
				 --  UPDATE  ResponsesForPivot
					--   SET FieldValue = NULL
				 --  WHERE   FieldValue = '';		
				



			RETURN;
			END
		END

	  IF (@RecordsourceId='1' OR @RecordsourceId='2')
		BEGIN

		 DECLARE @FirstSaveLogonName AS VARCHAR (100) = 'EWE\';

    -- Get User Id 
    DECLARE @UserId AS INT;
    DECLARE @UserName AS VARCHAR (100);
    SELECT @UserId = UserId
    FROM   SurveyResponseUser
    WHERE  ResponseId = @ResponseId;
    
	-- Get User name
    SELECT @UserName = UserName
    FROM   dbo.[User]
    WHERE  UserId = @UserId;
    
	-- Update  @FirstSaveLogonName
    SET @FirstSaveLogonName = @FirstSaveLogonName + @UserName;
    
	-- If Response is not finalized then return    
    IF @StatusId = 1
        BEGIN            
            RETURN;
        END    

	-- If status is delete then soft delete    					
	IF @StatusId = 0
        BEGIN
            EXECUTE usp_soft_delete_Epi7_record @ResponseId, @SurveyId, 1;           
            RETURN;
        END

    -- Is this response from SQL?  Query surveyresponsetracking 
    SELECT @IsSQLResponse = issqlresponse,
            @IsResponseinsertedToEpi7 = isresponseinsertedtoepi7
    FROM   surveyresponsetracking
    WHERE  responseid = @ResponseId;    
		
			
    -- If Response is not from a SQL server project then return          
    IF @IsSQLResponse = 0
        BEGIN            
            RETURN;
        END    

    -- Get the Epi7 proects's DB name      
    SELECT @Epi7DBName = initialcatalog
    FROM   eidatasource
    WHERE  surveyid = @SurveyId;   
				
	-- Get project's SQL status        
    DECLARE @IsSQLProject AS BIT;
    SELECT @IsSQLProject = issqlproject
    FROM   surveymetadata
    WHERE  surveyid = @SurveyId;    	

    IF @IsSQLResponse = 1 AND @IsResponseinsertedToEpi7 = 0
        BEGIN
            -- STEP 1   
            -- call usp_create_Epi7_views_statement   
            SELECT @ViewTableName = viewtablename
            FROM   surveymetadataview
            WHERE  surveyid = @SurveyId;                     


			IF @RelateParentId IS NOT NULL
                BEGIN
                    SET @InsertviewText = 'INSERT  INTO  [' + @Epi7DBName + '].dbo.[' + @ViewTableName + ']' + ' ([RECSTATUS]    ,
								[GlobalRecordId]    ,
								[FirstSaveLogonName]    ,
								[FirstSaveTime]    ,
								[LastSaveLogonName]    ,
								[LastSaveTime]    ,
								[FKEY])     
								values    ' + 
								'(  ' + '1 ,  ' + 
								QUOTENAME(CAST (@ResponseId AS VARCHAR (100)), '''') + ', ' + 
								QUOTENAME(@FirstSaveLogonName, '''') + ', ' + 
								QUOTENAME(CAST (Getdate() AS VARCHAR (100)), '''') + ', ' + 
								QUOTENAME(@FirstSaveLogonName, '''') + ', ' + 
								QUOTENAME(CAST (Getdate() AS VARCHAR (100)), '''') + ', ' + 
								QUOTENAME(CAST (@RelateParentId AS VARCHAR (100)), '''') + ') ';
                END
            ELSE
                BEGIN
                    SET @InsertviewText = 'INSERT  INTO  [' + @Epi7DBName + '].dbo.[' + @ViewTableName + ']' + ' ([RECSTATUS]    ,
								[GlobalRecordId]    ,
								[FirstSaveLogonName]    ,
								[FirstSaveTime]    ,
								[LastSaveLogonName]    ,
								[LastSaveTime]  )
								values   ' + 
								'(  ' + '1 ,  ' + 
								QUOTENAME(CAST (@ResponseId AS VARCHAR (100)), '''') + ', ' + 
								QUOTENAME(@FirstSaveLogonName, '''') + ', ' + 
								QUOTENAME(CAST (Getdate() AS VARCHAR (100)), '''') + ', ' + 
								QUOTENAME(@FirstSaveLogonName, '''') + ', ' + 
								QUOTENAME(CAST (Getdate() AS VARCHAR (100)), '''') + ') ';
                END
            

			IF @InsertviewText IS NULL
                BEGIN            
                    INSERT  INTO [ErrorLog] ([SurveyId], [ResponseId], comment, [ErrorText])
                    VALUES                 (@SurveyId, @ResponseId, '@InsertviewText is null ', @InsertviewText);				  
                END
            ELSE
                BEGIN
                    EXECUTE (@InsertviewText);
					

					IF @@ERROR >  0    
					  BEGIN 					             
						SELECT @ErrorNumber = ERROR_NUMBER(), --  AS ErrorNumber
								@ErrorSeverity = ERROR_SEVERITY(), --  AS ErrorSeverity
								@ErrorState = ERROR_STATE(), --  AS ErrorState
								@ErrorProcedure = ERROR_PROCEDURE(), --  AS ErrorProcedure
								@ErrorLine = ERROR_LINE(), --   AS ErrorLine
								@ErrorMessage = ERROR_MESSAGE(); --   AS ErrorMessage;
            
						EXECUTE usp_log_to_errorlog 
							@SurveyId, @ResponseId, @InsertviewText, 
							'usp_create_epi7_sql_statements', 'Insert/Update in #temp table may have failed', 
							@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine, @ErrorMessage;
					  END   
                END    

			--STEP 2    
			-- this sp returns  @InsertText
            EXECUTE [usp_create_epi7_sql_statements_driver] 
				@ResponseXml, @SurveyId, 
				@ResponseId, 'i', @Epi7DBName;
            EXECUTE (@InsertText); --  returned from  sp  
			
			IF @@ERROR >  0    
					  BEGIN 					             
						SELECT @ErrorNumber = ERROR_NUMBER(), --  AS ErrorNumber
								@ErrorSeverity = ERROR_SEVERITY(), --  AS ErrorSeverity
								@ErrorState = ERROR_STATE(), --  AS ErrorState
								@ErrorProcedure = ERROR_PROCEDURE(), --  AS ErrorProcedure
								@ErrorLine = ERROR_LINE(), --   AS ErrorLine
								@ErrorMessage = ERROR_MESSAGE(); --   AS ErrorMessage;
            
						EXECUTE usp_log_to_errorlog 
							@SurveyId, @ResponseId, @InsertText, 
							'usp_create_epi7_sql_statements', 'Insert/Update in #temp table may have failed', 
							@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine, @ErrorMessage;
					  END                       
            
			-- STEP 3   
            -- after insert update tracking   
            UPDATE  surveyresponsetracking
            SET IsResponseinsertedToEpi7 = 1
            WHERE   responseid = @ResponseId;
			            
			RETURN;
        END    
	
    IF @IsSQLResponse = 1  AND @IsResponseinsertedToEpi7 = 1
        BEGIN    

            -- STEP 1   
            -- call usp_create_Epi7_views_statement   
            SELECT @ViewTableName = viewtablename
            FROM   surveymetadataview
            WHERE  surveyid = @SurveyId;
            
			DECLARE @UpdateviewText AS VARCHAR (500);
              

			IF @RelateParentId IS NOT NULL
                BEGIN
                    SET @UpdateviewText =              
						' UPDATE   [' + @Epi7DBName + '].dbo.[' + @ViewTableName + ']' + 
						' SET [LastSaveLogonName] = ' + quotename(@FirstSaveLogonName, '''') + ', ' + 
						'     [LastSaveTime] = ' + quotename(CAST (Getdate() AS VARCHAR (100)), '''') + ' , ' + 
						'     [FKEY] = ' + quotename(CAST (@RelateParentId AS VARCHAR (100)), '''') + ' ' + 
						 ' WHERE GlobalRecordId = ' + QUOTENAME(CAST (@ResponseId AS VARCHAR (255)), '''');    
						--  ' WHERE GlobalRecordId = ' +  CAST (@ResponseId AS VARCHAR (255))        ;    
                END
            ELSE
                BEGIN
                    SET @UpdateviewText =   
						' UPDATE   [' + @Epi7DBName + '].dbo.[' + @ViewTableName + ']' + 
						' SET [LastSaveLogonName] = ' + quotename(@FirstSaveLogonName, '''') + ', ' + 
						'     [LastSaveTime] = ' + quotename(CAST (Getdate() AS VARCHAR (100)), '''') + '  ' + 
						 ' WHERE GlobalRecordId = ' + QUOTENAME(CAST (@ResponseId AS VARCHAR (255)), '''');    
						--    ' WHERE GlobalRecordId = ' +  CAST (@ResponseId AS VARCHAR (255))        ;    						 
						                    
                END    
  
            IF @UpdateviewText IS NULL
                BEGIN

			
                    INSERT  INTO [ErrorLog] ([SurveyId], [ResponseId],comment, [ErrorText])
                    VALUES                 (@SurveyId, @ResponseId, '@UpdateViewText  ',   @UpdateViewText  );
					
                END
            ELSE
                BEGIN
                    EXECUTE (@UpdateviewText);
					
					IF @@ERROR >  0    
					  BEGIN 					             
						SELECT @ErrorNumber = ERROR_NUMBER(), --  AS ErrorNumber
								@ErrorSeverity = ERROR_SEVERITY(), --  AS ErrorSeverity
								@ErrorState = ERROR_STATE(), --  AS ErrorState
								@ErrorProcedure = ERROR_PROCEDURE(), --  AS ErrorProcedure
								@ErrorLine = ERROR_LINE(), --   AS ErrorLine
								@ErrorMessage = ERROR_MESSAGE(); --   AS ErrorMessage;
            
						EXECUTE usp_log_to_errorlog 
							@SurveyId, @ResponseId, @UpdateviewText, 
							'usp_create_epi7_sql_statements', 'Insert/Update in #temp table may have failed', 
							@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine, @ErrorMessage;
					  END    
                END

            -- STEP 2   
			-- this sp returns  @UpdateText    
            EXECUTE [usp_create_epi7_sql_statements_driver] 
				@ResponseXml, @SurveyId, 
				@ResponseId, 'u', @Epi7DBName;
            EXECUTE (@UpdateText); -- returned   
			
			IF @@ERROR >  0    
					  BEGIN 					             
						SELECT @ErrorNumber = ERROR_NUMBER(), --  AS ErrorNumber
								@ErrorSeverity = ERROR_SEVERITY(), --  AS ErrorSeverity
								@ErrorState = ERROR_STATE(), --  AS ErrorState
								@ErrorProcedure = ERROR_PROCEDURE(), --  AS ErrorProcedure
								@ErrorLine = ERROR_LINE(), --   AS ErrorLine
								@ErrorMessage = ERROR_MESSAGE(); --   AS ErrorMessage;
            
						EXECUTE usp_log_to_errorlog 
							@SurveyId, @ResponseId, @UpdateText, 
							'usp_create_epi7_sql_statements', 'Insert/Update in #temp table may have failed', 
							@ErrorNumber, @ErrorSeverity, @ErrorState, @ErrorProcedure, @ErrorLine, @ErrorMessage;
					  END    
            
			RETURN;
        END
	END

END
GO

PRINT(N'Update rows in [dbo].[DataAccessRules]')
UPDATE [dbo].[DataAccessRules] SET [RuleDescription]=' Users within an organization can only access the data created by their organization' WHERE [RuleId]=1
UPDATE [dbo].[DataAccessRules] SET [RuleDescription]=' The users in central organization will have access to all the data created by all organizations' WHERE [RuleId]=2
UPDATE [dbo].[DataAccessRules] SET [RuleName]='Enable data access  to all', [RuleDescription]='All users part of all organizations can access all data created by all organizations' WHERE [RuleId]=3
PRINT(N'Operation applied to 3 rows out of 3')

PRINT(N'Add row to [dbo].[lk_RecordSource]')
INSERT INTO [dbo].[lk_RecordSource] ([RecordSourceId], [RecordSource], [RecordSourceDescription]) VALUES (4, N'EIWS', N'Source is  EIWS web application')

IF @@ERROR <> 0 SET NOEXEC ON
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
