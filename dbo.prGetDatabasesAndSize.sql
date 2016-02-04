/*
Object:  	Stored Procedure [dbo].[prGetDatabasesAndSize]
Date: 		2016-02-04
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database, DatabaseList and InstanceList tables
*/

USE [DBAdmin_QA];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[prGetDatabasesAndSize]
AS
    BEGIN

        SELECT  il.InstanceName
               ,dl.DatabaseName
               ,ROUND(dl.SizeInMB / 1000, 2) AS SizeinGB
        FROM    dbo.DatabaseList AS dl
        INNER JOIN dbo.InstanceList AS il ON il.Id = dl.InstanceListId
        ORDER BY dl.DatabaseName;
    END;

GO
