/*
Object:  	Stored Procedure [dbo].[prGetServerNames] 
Date: 		2016-02-04
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database, ServerList table
*/

USE [DBAdmin_QA];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO


CREATE PROCEDURE [dbo].[prGetServerNames]
AS
    BEGIN

        SELECT  sl.ServerName
        FROM    dbo.ServerList AS sl;

    END;

GO
