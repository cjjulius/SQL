
/*
Object:   [dbo].[InstanceList]
Date: 		2016-01-24
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database
*/

USE [DBAdmin_QA]
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[InstanceList]
    (
     [Id] [BIGINT] IDENTITY(1, 1) NOT FOR REPLICATION
                   NOT NULL
    ,[InstanceName] [VARCHAR](MAX) NOT NULL
    ,[ServerListId] [BIGINT] NOT NULL
    ,[MSSQLVersion] [VARCHAR](MAX) NULL
    ,[MSSQLVersionLong] [VARCHAR](MAX) NULL
    ,[MSSQLServicePack] [VARCHAR](20) NULL
    ,[MSSQLEdition] [VARCHAR](MAX) NULL
    ,[isProduction] [BIT] NULL
                          DEFAULT ( (0) )
    ,PRIMARY KEY CLUSTERED ( [Id] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
               IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
               ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

SET ANSI_PADDING OFF;
GO

ALTER TABLE [dbo].[InstanceList]  WITH CHECK ADD  CONSTRAINT [fk_ServerListId_ServerList_Id] FOREIGN KEY([ServerListId])
REFERENCES [dbo].[ServerList] ([Id]);
GO

ALTER TABLE [dbo].[InstanceList] CHECK CONSTRAINT [fk_ServerListId_ServerList_Id];
GO
