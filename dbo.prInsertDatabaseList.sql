
/*
Object:  	Stored Procedure [dbo].[prInsertDatabaseList]
Date: 		2016-02-04
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database and DatabaseList table
*/

USE [DBAdmin_QA];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[prInsertDatabaseList]
    (
     @DatabaseName VARCHAR(MAX)
    ,@InstanceListId BIGINT
    ,@Size FLOAT
    )
AS
    BEGIN

        INSERT  INTO dbo.DatabaseList
                (DatabaseName
                ,InstanceListId
                ,SizeInMB
                )
        VALUES  ( @DatabaseName
                ,@InstanceListId
                ,@Size
                );

    END;

GO
