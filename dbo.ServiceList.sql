
/*
Object:   [dbo].[ServiceList]
Date: 		2016-01-24
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database
*/

USE [DBAdmin_QA];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[ServiceList]
    (
     [Id] [BIGINT] IDENTITY(1, 1) NOT FOR REPLICATION
                   NOT NULL
    ,[ServerListId] [BIGINT] NOT NULL
    ,[ServerName] [VARCHAR](MAX) NOT NULL
    ,[ServiceDisplayName] [VARCHAR](MAX) NOT NULL
    ,[ServiceName] [VARCHAR](MAX) NOT NULL
    ,[ServiceState] [VARCHAR](MAX) NOT NULL
    ,[ServiceStartMode] [VARCHAR](MAX) NOT NULL
    ,[ServiceStartName] [VARCHAR](MAX) NOT NULL
    ,PRIMARY KEY CLUSTERED ( [Id] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
               IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
               ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

SET ANSI_PADDING OFF;
GO

ALTER TABLE [dbo].[ServiceList]  WITH CHECK ADD  CONSTRAINT [fk_ServiceList_ServerListId_ServerList_Id] FOREIGN KEY([ServerListId])
REFERENCES [dbo].[ServerList] ([Id]);
GO

ALTER TABLE [dbo].[ServiceList] CHECK CONSTRAINT [fk_ServiceList_ServerListId_ServerList_Id];
GO
