
/*
Object:  	Stored Procedure [dbo].[prGetServerServices]
Date: 		2016-02-04
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database, ServerList and ServiceList tables
*/

USE [DBAdmin_QA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[prGetServerServices]
AS
    BEGIN

        SELECT  sl.ServerName
               ,svcl.ServiceName
               ,svcl.ServiceDisplayName
               ,svcl.ServiceState
               ,svcl.ServiceStartMode
               ,svcl.ServiceStartName AS 'Service_Logon'
        FROM    dbo.ServiceList svcl
        INNER JOIN dbo.ServerList AS sl ( NOLOCK ) ON svcl.ServerListId = sl.Id
        ORDER BY sl.ServerName
               ,svcl.ServiceName;

    END;

GO


