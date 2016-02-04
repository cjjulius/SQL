
/*
Object:  	Stored Procedure [dbo].[prUpdateServerList]
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

CREATE PROCEDURE [dbo].[prUpdateServerList]
    (
     @IPAddress AS VARCHAR(20)
    ,@OSName AS VARCHAR(100)
    ,@OSServicePack AS VARCHAR(100)
    ,@ServerName AS VARCHAR(MAX)
    )
AS
    BEGIN

        UPDATE  dbo.ServerList
        SET     [IPAddress] = @IPAddress
               ,[OSName] = @OSName
               ,[OSServicePack] = OSServicePack
        WHERE   ServerName = @ServerName;
    END;

GO
