USE [DBAdmin];
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
/* 
Object:		[Utility].[prInsertNewServerAndInstance]
Date: 		2016-07-26
Author: 	Charlton Julius
Notes: 		Requires DBAdmin_QA Database with Utility Schema, [dbo].[ServerList] and [dbo].[InstanceList]
*/

CREATE PROCEDURE [Utility].[prInsertNewServerAndInstance]
	@ServerName VARCHAR(MAX)
   ,@InstanceName VARCHAR(MAX)
AS
	SET NOCOUNT ON;

	BEGIN
                             
		BEGIN TRANSACTION [InsertNewServerAndInstance];

		BEGIN TRY

			BEGIN
			
				IF EXISTS ( SELECT TOP ( 1 )
									[sl].[Id]
							FROM	[dbo].[ServerList] AS [sl]
							INNER JOIN [dbo].[InstanceList] AS [il] ( NOLOCK ) ON [il].[ServerListId] = [sl].[Id]
							WHERE	[sl].[ServerName] = @ServerName
									AND [il].[InstanceName] = @InstanceName )
					THROW 51000, 'Server and Instance Already Exist.',1;

				IF NOT EXISTS ( SELECT TOP ( 1 )
										[Id]
								FROM	[dbo].[ServerList] AS [sl]
								WHERE	[sl].[ServerName] = @ServerName )
					BEGIN
						INSERT	INTO [dbo].[ServerList]
								( [ServerName] )
						VALUES	( @ServerName  -- ServerName - varchar(max)
								  );
					END;

				INSERT	INTO [dbo].[InstanceList]
						(
						 [InstanceName]
						,[ServerListId]
						)
				SELECT	@InstanceName
					   ,[sl].[Id]
				FROM	[dbo].[ServerList] [sl]
				WHERE	[sl].[ServerName] = @ServerName;
			END;

			COMMIT TRANSACTION [InsertNewServerAndInstance];

		END TRY

		BEGIN CATCH

			DECLARE	@ErrorMessage NVARCHAR(4000);
			DECLARE	@ErrorSeverity INT;
			DECLARE	@ErrorState INT;

			SELECT	@ErrorMessage = ERROR_MESSAGE()
				   ,@ErrorSeverity = ERROR_SEVERITY()
				   ,@ErrorState = ERROR_STATE();

			RAISERROR (@ErrorMessage,
               @ErrorSeverity, 
               @ErrorState 
               );

			ROLLBACK TRANSACTION [InsertNewServerAndInstance];

			PRINT 'Transaction Rolled Back';

		END CATCH;
	END;
GO
