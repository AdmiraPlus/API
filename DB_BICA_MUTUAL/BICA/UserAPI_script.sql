USE [BICAMutual]
GO
/****** Object:  Table [dbo].[UserAPI]    Script Date: 09/06/2023 14:14:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAPI](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](40) NOT NULL,
	[password] [varchar](80) NOT NULL,
	[client_id] [varchar](40) NOT NULL,
	[client_secret] [varchar](80) NOT NULL,
 CONSTRAINT [PK_UserAPI] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
