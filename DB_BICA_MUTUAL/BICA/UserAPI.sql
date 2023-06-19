USE [BICAMutual]
GO
/****** Object:  Table [dbo].[UserAPI]    Script Date: 16/06/2023 04:48:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAPI](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](40) NOT NULL,
	[full_name] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[diasbled] [bit] NOT NULL,
	[password] [varchar](80) NOT NULL,
	[client_id] [varchar](40) NOT NULL,
	[client_secret] [varchar](80) NOT NULL,
 CONSTRAINT [PK_UserAPI] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[UserAPI] ON 

INSERT [dbo].[UserAPI] ([id], [username], [full_name], [email], [diasbled], [password], [client_id], [client_secret]) VALUES (1, N'leoncio', N'Leoncio R. Barrios H.', N'leonciobarriosh@gmail.com', 0, N'$2a$12$jyI6TixvJz6S..1XgEiw7ezf7adk6EGq6jVKVI/cqArYJej6PR9vi', N'algo', N'algo')
INSERT [dbo].[UserAPI] ([id], [username], [full_name], [email], [diasbled], [password], [client_id], [client_secret]) VALUES (2, N'fulano', N'Fulano de Tal', N'fulanodetalh@gmail.com', 1, N'$2a$12$lEzBToc4HsUj81HwwvdC0ermC.mFQ54jHbx.Ouj4Ba8qFdZacsSWm', N'algo', N'algo')
INSERT [dbo].[UserAPI] ([id], [username], [full_name], [email], [diasbled], [password], [client_id], [client_secret]) VALUES (3, N'pepe', N'Pepe de los Palotes', N'pepito@gmail.com', 0, N'$2a$12$jyI6TixvJz6S..1XgEiw7ezf7adk6EGq6jVKVI/cqArYJej6PR9vi', N'algo', N'algo')
SET IDENTITY_INSERT [dbo].[UserAPI] OFF
GO
ALTER TABLE [dbo].[UserAPI] ADD  CONSTRAINT [DF_UserAPI_diasbled]  DEFAULT ((0)) FOR [diasbled]
GO
