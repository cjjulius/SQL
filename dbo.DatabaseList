
/* 
Object:   [dbo].[DatabaseList]
Date: 		2016-01-24
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database
*/

USE [DBAdmin];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[DatabaseList]
    (
     [Id] [BIGINT] IDENTITY(1, 1) NOT FOR REPLICATION
                   NOT NULL
    ,[DatabaseName] [VARCHAR](MAX) NOT NULL
    ,[InstanceListId] [BIGINT] NOT NULL
    ,[SizeInMB] [FLOAT] NULL
    ,PRIMARY KEY CLUSTERED ( [Id] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
               IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
               ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

SET ANSI_PADDING OFF;
GO

ALTER TABLE [dbo].[DatabaseList]  WITH CHECK ADD  CONSTRAINT [fk_InstanceListId_InstanceList_Id] FOREIGN KEY([InstanceListId])
REFERENCES [dbo].[InstanceList] ([Id]);
GO

ALTER TABLE [dbo].[DatabaseList] CHECK CONSTRAINT [fk_InstanceListId_InstanceList_Id];
GO
