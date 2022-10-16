USE [EIWeb]  
GO

------- Insert Organization -----
-- Create an Organization key by creating a GUID and encrypting it using the encryption tool.
-- Provide the encrypted key as the  value for OrganizationKey.

INSERT INTO [Organization]
           ([OrganizationKey]
           ,[Organization]
           ,[IsEnabled]
           ,[IsHostOrganization])
     VALUES
           ('put encrypted key here',
		    'Your Organization name',
			1,    
            1)
GO
--


