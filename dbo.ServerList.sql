/* 
Object:   [dbo].[ServerList]
Date: 		2016-01-24
Author: 	Charlton Julius
Notes: 		Requires DBAdmin Database
*/

USE [DBAdmin_QA]
GO

/****** Object:  Table [dbo].[ServerList]    Script Date: 1/24/2016 3:50:05 PM ******/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

CREATE TABLE [dbo].[ServerList]
    (
     [Id] [BIGINT] IDENTITY(1, 1) NOT FOR REPLICATION
                   NOT NULL
    ,[ServerName] [VARCHAR](MAX) NOT NULL
    ,[IPAddress] [VARCHAR](20) NULL
    ,[OSName] [VARCHAR](100) NULL
    ,[OSServicePack] [VARCHAR](100) NULL
    ,PRIMARY KEY CLUSTERED ( [Id] ASC )
        WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
               IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
               ALLOW_PAGE_LOCKS = ON ) ON [PRIMARY]
    )
ON  [PRIMARY] TEXTIMAGE_ON [PRIMARY];

GO

SET ANSI_PADDING OFF;
GO
