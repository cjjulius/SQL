
/*
Object:  	Stored Procedure [dbo].[prGetServers]
Date: 		2016-02-04
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database, ServerList table
*/

USE [DBAdmin_QA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[prGetServers]
AS
    BEGIN
        SELECT   sl.ServerName
				,sl.OSName
				,sl.OSServicePack
        FROM    dbo.ServerList AS sl
        ORDER BY sl.ServerName;
    END;

GO


