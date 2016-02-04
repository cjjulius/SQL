
/*
Object:  	Stored Procedure [dbo].[prGetInventory]
Date: 		2016-02-04
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database, DatabaseList, ServerList and InstanceList tables
*/

USE [DBAdmin_QA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[prGetInventory]
AS
    BEGIN

        SELECT  sl.ServerName, sl.IPAddress, sl.OSName, sl.OSServicePack
               ,il.InstanceName, il.MSSQLVersion, il.MSSQLServicePack, il.MSSQLEdition, il.MSSQLVersionLong
               ,dl.DatabaseName
               ,FORMAT(dl.SizeInMB / 1000, 'N3') AS SizeinGB
        FROM    dbo.ServerList AS sl
        INNER JOIN dbo.InstanceList AS il ( NOLOCK ) ON il.ServerListId = sl.Id
        LEFT JOIN dbo.DatabaseList AS dl ( NOLOCK ) ON dl.InstanceListId = il.Id
        ORDER BY sl.Id
               ,il.Id
               ,dl.Id;
    END;

GO
