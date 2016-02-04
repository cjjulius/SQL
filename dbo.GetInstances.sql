/*
Object:  	Stored Procedure [dbo].[prGetInstances]
Date: 		2016-02-04
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database, InstanceList table
*/

USE [DBAdmin_QA]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[prGetInstances]
AS
    BEGIN

        SELECT  il.InstanceName
               ,il.MSSQLVersion
               ,il.MSSQLServicePack
               ,il.MSSQLEdition
               ,il.MSSQLVersionLong
        FROM    dbo.InstanceList AS il
        ORDER BY il.InstanceName;
    END;
	
GO
