SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

/*********************************************************************
Author : cjjulius
Created : 2017-05-16
Description : Compresses tables in non-system databases that are older 
	than a certain date and reside in a specific schema.

CHANGES:

Name		DATE        REASON
------   	-------		--------
cjjulius	2017-05-21	Created

*********************************************************************/
CREATE PROCEDURE [Utility].[prCompressCleanupTables]
	@CompressBeforeDate DATETIME
	,@Schema sysname
AS
	SET NOCOUNT ON;

	BEGIN
                                          
/*

Setup and pre-logic

*/

		BEGIN TRY
		
			IF OBJECT_ID('tempdb..#DBList') IS NOT NULL
				DROP TABLE [#DBList];
			
			DECLARE	@UseDB VARCHAR(MAX)
			   ,@d INT
			   ,@CompressBeforeDateSQL VARCHAR(50) = CAST(@CompressBeforeDate AS VARCHAR(50));
			
			CREATE TABLE [#DBList]
				(
				 [Id] INT IDENTITY(1, 1)
				,[DBName] VARCHAR(MAX)
				);
			
			INSERT	INTO [#DBList]
			SELECT	'USE [' + [name] + ']; '
			FROM	[sys].[databases] AS [d]
			WHERE	[name] NOT IN ( 'master', 'tempdb', 'model', 'msdb',
								  'distribution', 'ReportServer', 'SSISDB' )
					AND [d].[state] = 0;
			
			SET @d = ( SELECT	MAX([Id])
					   FROM		[#DBList]
					 );
			
			WHILE @d > 0
				BEGIN 
					SET @UseDB = ( SELECT	[DBName]
								   FROM		[#DBList] AS [cc]
								   WHERE	[Id] = @d
								 );
			
					EXEC(@UseDB + ' IF OBJECT_ID(''tempdb..#CompressionCandidates'') IS NOT NULL
					DROP TABLE #CompressionCandidates;
				
					DECLARE @SQL VARCHAR(MAX)
					,@i INT
				
					CREATE TABLE #CompressionCandidates ( Id INT IDENTITY(1,1), [Tables] VARCHAR(MAX) );
				
					INSERT INTO [#CompressionCandidates]
					SELECT ''['' + SCHEMA_NAME(st.[schema_id]) + ''].['' + st.name + '']'' FROM sys.tables st
					INNER JOIN sys.partitions sp (NOLOCK) ON  st.object_id = sp.object_id 
					WHERE SCHEMA_NAME(st.[schema_id]) = ''' + @Schema + '''
					AND sp.data_compression = 0
					AND [st].[create_date] < ''' + @CompressBeforeDateSQL + ''';
				
					UPDATE [#CompressionCandidates]
					SET [Tables] = ''ALTER TABLE '' + [Tables] + '' REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE);'';
				
					SET @i = (SELECT MAX(Id) FROM [#CompressionCandidates] AS [cc])
				
					WHILE @i > 0
					BEGIN 
					SET @SQL = (SELECT [Tables] FROM [#CompressionCandidates] AS [cc] 
					WHERE Id = @i)
			
					EXEC(@SQL)
					SET @i = @i - 1
					END'
					);
					SET @d = @d - 1;
				END;		

        /*
		
		Cleanup
		
		*/

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

			ROLLBACK TRANSACTION [prCompressCleanupTables];

			PRINT 'Transaction Rolled Back';

		END CATCH;
	END;

GO


