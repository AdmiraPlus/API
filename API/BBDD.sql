USE [master]
GO
/****** Object:  Database [BICAMutual]    Script Date: 9/06/2023 05:48:42 ******/
CREATE DATABASE [BICAMutual]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BICAMutual', FILENAME = N'E:\BD_SQL\BICAMutual.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BICAMutual_log', FILENAME = N'E:\BD_SQL\BICAMutual_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BICAMutual] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BICAMutual].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BICAMutual] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BICAMutual] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BICAMutual] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BICAMutual] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BICAMutual] SET ARITHABORT OFF 
GO
ALTER DATABASE [BICAMutual] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BICAMutual] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BICAMutual] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BICAMutual] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BICAMutual] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BICAMutual] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BICAMutual] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BICAMutual] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BICAMutual] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BICAMutual] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BICAMutual] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BICAMutual] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BICAMutual] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BICAMutual] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BICAMutual] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BICAMutual] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BICAMutual] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BICAMutual] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BICAMutual] SET  MULTI_USER 
GO
ALTER DATABASE [BICAMutual] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BICAMutual] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BICAMutual] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BICAMutual] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BICAMutual] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BICAMutual] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BICAMutual', N'ON'
GO
ALTER DATABASE [BICAMutual] SET QUERY_STORE = OFF
GO
USE [BICAMutual]
GO
/****** Object:  Table [dbo].[AMVMovimientos]    Script Date: 9/06/2023 05:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMVMovimientos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cuit] [bigint] NOT NULL,
	[NumeroCuenta] [bigint] NOT NULL,
	[CodigoMovimiento] [varchar](40) NOT NULL,
	[TipoMovimiento] [char](1) NOT NULL,
	[NumeroMovimiento] [bigint] NOT NULL,
	[FechaMovimiento] [datetime] NOT NULL,
	[Importe] [decimal](16, 4) NOT NULL,
	[estado] [char](1) NOT NULL,
 CONSTRAINT [PK_AMVMovimientos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CodMovimientos]    Script Date: 9/06/2023 05:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CodMovimientos](
	[Codigo] [varchar](40) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[TipoMovimiento] [char](1) NOT NULL,
	[Producto] [char](2) NOT NULL,
 CONSTRAINT [PK_Hoja1$] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[verMovimientos]    Script Date: 9/06/2023 05:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[verMovimientos]
AS
SELECT        dbo.AMVMovimientos.id, dbo.AMVMovimientos.cuit, dbo.AMVMovimientos.NumeroCuenta, dbo.AMVMovimientos.CodigoMovimiento, dbo.CodMovimientos.Descripcion, dbo.AMVMovimientos.TipoMovimiento, 
                         dbo.AMVMovimientos.NumeroMovimiento, dbo.AMVMovimientos.FechaMovimiento, dbo.AMVMovimientos.Importe, dbo.AMVMovimientos.estado
FROM            dbo.AMVMovimientos INNER JOIN
                         dbo.CodMovimientos ON dbo.AMVMovimientos.CodigoMovimiento = dbo.CodMovimientos.Codigo
GO
/****** Object:  Table [dbo].[AMVSaldos]    Script Date: 9/06/2023 05:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMVSaldos](
	[cuenta] [bigint] NOT NULL,
	[saldo] [numeric](18, 2) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[modificado] [bit] NOT NULL,
 CONSTRAINT [PK_AMVSaldos] PRIMARY KEY CLUSTERED 
(
	[cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AMVMovimientos] ON 

INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (1, 30650032868, 1000747, N'L1001ECASH', N'D', 1, CAST(N'2022-09-01T19:31:52.150' AS DateTime), CAST(12500.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (2, 30650032868, 1000747, N'L511100', N'D', 2, CAST(N'2022-09-01T19:38:52.633' AS DateTime), CAST(5000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (3, 30650032868, 1000026, N'L511100', N'D', 3, CAST(N'2022-09-01T19:39:05.697' AS DateTime), CAST(3500.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (4, 30650032868, 1000026, N'L811100', N'D', 4, CAST(N'2022-09-01T19:40:34.733' AS DateTime), CAST(3150.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (5, 30650032868, 1000133, N'L811100', N'D', 5, CAST(N'2022-09-01T19:40:43.120' AS DateTime), CAST(3150.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (6, 30650032868, 1000133, N'LF31100', N'D', 6, CAST(N'2022-09-01T19:41:04.563' AS DateTime), CAST(3150.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (7, 30650032868, 1000133, N'LF31100', N'D', 7, CAST(N'2022-09-01T19:41:12.663' AS DateTime), CAST(8050.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (8, 30650032868, 1000026, N'LF31100', N'D', 8, CAST(N'2022-09-01T19:41:21.820' AS DateTime), CAST(800.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (9, 30650032868, 1000747, N'LF31100', N'D', 9, CAST(N'2022-09-01T19:41:38.967' AS DateTime), CAST(6700.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (10, 30650032868, 1000747, N'CREPGOHAB', N'C', 10, CAST(N'2022-09-01T19:42:43.580' AS DateTime), CAST(15000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (11, 30650032868, 1000026, N'CREPGOHAB', N'C', 11, CAST(N'2022-09-01T19:42:53.663' AS DateTime), CAST(50000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (12, 30650032868, 1000133, N'CREPGOHAB', N'C', 12, CAST(N'2022-09-01T19:43:03.533' AS DateTime), CAST(508000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (13, 30650032868, 1000133, N'CREPGOHAB', N'C', 320, CAST(N'2022-09-01T19:59:05.570' AS DateTime), CAST(508000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (14, 30650032868, 100026, N'ACRFPPFICA', N'C', 322, CAST(N'2022-09-01T20:00:08.067' AS DateTime), CAST(85000.0000 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (15, 30650032868, 1000133, N'IVACFC', N'C', 3804, CAST(N'2022-09-01T20:01:33.513' AS DateTime), CAST(250.5500 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (16, 30650032868, 100026, N'IVACFC', N'C', 3222, CAST(N'2022-09-01T20:01:33.513' AS DateTime), CAST(2100.0000 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (17, 30650032868, 1000747, N'COMRESMEN', N'D', 3804, CAST(N'2022-09-01T20:02:50.923' AS DateTime), CAST(1050.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (18, 30650032868, 100026, N'COMRESMEN', N'D', 3222, CAST(N'2022-09-01T20:02:50.923' AS DateTime), CAST(800.0000 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (19, 30650032868, 100026, N'COMRESMEN', N'D', 921, CAST(N'2022-09-01T20:24:25.000' AS DateTime), CAST(8506.3300 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (20, 30650032868, 100026, N'COMRESMEN', N'D', 921, CAST(N'2022-09-01T20:25:09.000' AS DateTime), CAST(8506.3300 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (21, 30650032868, 100474, N'COMRESMEN', N'D', 261, CAST(N'2022-09-01T20:28:12.000' AS DateTime), CAST(1502.5000 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (22, 30650032868, 100026, N'COMRESMEN', N'D', 617, CAST(N'2022-09-02T08:59:28.000' AS DateTime), CAST(2000.0000 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (23, 30650032868, 100026, N'COMRESMEN', N'D', 617, CAST(N'2022-09-02T09:30:28.000' AS DateTime), CAST(2000.0000 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (24, 30650032868, 100481, N'CENCHQC', N'D', 4617, CAST(N'2022-09-02T09:34:29.000' AS DateTime), CAST(22000.0000 AS Decimal(16, 4)), N' ')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (25, 30650032868, 2000133, N'CENCHQC', N'D', 4617, CAST(N'2022-09-02T09:41:09.000' AS DateTime), CAST(22000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (26, 30650032868, 2000099, N'CENCHQC', N'D', 4617, CAST(N'2022-09-02T09:41:27.000' AS DateTime), CAST(50000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (27, 30650032868, 2000001, N'CENCHQC', N'D', 4619, CAST(N'2022-09-02T10:10:24.000' AS DateTime), CAST(50000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (28, 30650032868, 2000001, N'DADEBTERCA', N'D', 3221, CAST(N'2022-09-02T10:18:29.000' AS DateTime), CAST(48000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (29, 30650032868, 2000001, N'DADEBTERCA', N'D', 9180, CAST(N'2022-09-02T10:18:52.000' AS DateTime), CAST(48000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (30, 30650032868, 1000531, N'DADEBTERCA', N'D', 7278, CAST(N'2022-09-02T10:19:38.000' AS DateTime), CAST(85000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (31, 30650032868, 1000531, N'DADEBTERCA', N'D', 6836, CAST(N'2022-09-02T10:20:21.000' AS DateTime), CAST(85000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (32, 30650032868, 1000474, N'DATADEBCA', N'D', 5362, CAST(N'2022-09-02T10:22:03.000' AS DateTime), CAST(5000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (33, 30650032868, 2000132, N'DATADEBCA', N'D', 3459, CAST(N'2022-09-02T10:22:17.000' AS DateTime), CAST(15000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (34, 30650032868, 2000001, N'CENCHQC', N'D', 4619, CAST(N'2022-09-02T09:41:38.000' AS DateTime), CAST(50000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (35, 30650032868, 2000132, N'DATADEBCA', N'D', 1971, CAST(N'2022-09-02T12:04:15.000' AS DateTime), CAST(5000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (36, 30650032868, 1000026, N'DATADEBCA', N'D', 2442, CAST(N'2022-09-02T12:04:41.000' AS DateTime), CAST(820.9800 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (37, 30650032868, 1000026, N'DATADEBCA', N'D', 6288, CAST(N'2022-09-02T19:28:49.000' AS DateTime), CAST(820.9800 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (38, 30650032868, 1000026, N'ACREFCCTAS', N'D', 1240, CAST(N'2022-09-02T20:34:31.000' AS DateTime), CAST(10000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (39, 30650032868, 1000133, N'ACREFCCTAS', N'D', 3389, CAST(N'2022-09-02T20:34:40.000' AS DateTime), CAST(10000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (40, 30650032868, 2000001, N'ACREFCCTAS', N'D', 6073, CAST(N'2022-09-02T20:34:56.000' AS DateTime), CAST(10000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (41, 30650032868, 1000026, N'ACREFCCTAS', N'D', 6446, CAST(N'2022-09-02T20:37:41.000' AS DateTime), CAST(150000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (42, 30650032868, 1000026, N'ACREFCCTAS', N'D', 3851, CAST(N'2022-09-02T20:44:27.000' AS DateTime), CAST(350000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (43, 30650032868, 1000026, N'ACREFCCTAS', N'D', 8513, CAST(N'2022-09-06T08:13:37.000' AS DateTime), CAST(400000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (44, 30650032868, 1000133, N'ACREFCCTAS', N'D', 5548, CAST(N'2022-09-06T08:13:51.000' AS DateTime), CAST(400000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (45, 30650032868, 2000045, N'ACREFCCTAS', N'D', 9087, CAST(N'2022-09-06T08:14:13.000' AS DateTime), CAST(40000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (46, 30650032868, 2000001, N'ACREFCCTAS', N'D', 8331, CAST(N'2022-09-06T08:14:29.000' AS DateTime), CAST(40000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (47, 30650032868, 2000003, N'ACREFCCTAS', N'D', 8513, CAST(N'2023-05-21T15:43:57.000' AS DateTime), CAST(45000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (48, 30650032868, 1000026, N'ACREFCCTAS', N'D', 5548, CAST(N'2023-05-21T15:44:18.000' AS DateTime), CAST(45000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (49, 30650032868, 1000002, N'ACREFCCTAS', N'D', 9087, CAST(N'2023-05-21T15:44:27.000' AS DateTime), CAST(45000.0000 AS Decimal(16, 4)), N'P')
INSERT [dbo].[AMVMovimientos] ([id], [cuit], [NumeroCuenta], [CodigoMovimiento], [TipoMovimiento], [NumeroMovimiento], [FechaMovimiento], [Importe], [estado]) VALUES (50, 30650032868, 1000007, N'ACREFCCTAS', N'D', 8331, CAST(N'2023-05-21T15:44:39.000' AS DateTime), CAST(85700.0000 AS Decimal(16, 4)), N'P')
SET IDENTITY_INSERT [dbo].[AMVMovimientos] OFF
GO
INSERT [dbo].[AMVSaldos] ([cuenta], [saldo], [fecha], [modificado]) VALUES (1000026, CAST(250000.00 AS Numeric(18, 2)), CAST(N'2023-05-23T19:20:44.060' AS DateTime), 1)
INSERT [dbo].[AMVSaldos] ([cuenta], [saldo], [fecha], [modificado]) VALUES (1000133, CAST(50000.00 AS Numeric(18, 2)), CAST(N'2023-05-23T19:20:23.953' AS DateTime), 1)
INSERT [dbo].[AMVSaldos] ([cuenta], [saldo], [fecha], [modificado]) VALUES (1000747, CAST(15087.68 AS Numeric(18, 2)), CAST(N'2023-05-23T19:19:40.360' AS DateTime), 1)
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'319', N'Reversa Cod.392', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'319CA', N'Reversa Cod.392', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'320', N'Reversa Cod.400-402-406', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'320CA', N'Reversa Cod.400-402-406', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'321', N'Reversa Cod.404', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'321CA', N'Reversa Cod.404', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'392', N'Cobro de Exportaciones', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'392CA', N'Cobro de Exportaciones', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'400', N'Pago Importaciones', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'400CA', N'Pago Importaciones', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'402', N'Transf.al Exterior P/pago Importaciones', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'402CA', N'Transf.al Exterior P/pago Importaciones', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'404', N'Operación de cambio', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'404CA', N'Operación de cambio', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'406', N'Operación de cambio', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'406CA', N'Operación de Cambio', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'500', N'Anticipos y Pre Financiaciones', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'500CA', N'Anticipos y Pre Financiaciones', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'501', N'Financiaciones de Exportaciones', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'501CA', N'Financiaciones de Exportaciones', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'503', N'Pago por operación de cambio, pase cuentas mismo t', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'503CA', N'Pago por operación de cambio, pase cuentas mismo t', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'504', N'Cobro por operación de cambio, pase cuentas mismo ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'504CA', N'Cobro por operación de cambio, pase cuentas mismo ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACBTNPAGCC', N'Acreditación Servicio Botón de Pago', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACINTDEVCA', N'Acreditación de Intereses Devengados', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACINTDEVCC', N'Acreditación de Intereses Devengados', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDL0CA', N'Transferencia MEP automática - DL0 - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDL0CC', N'Transferencia MEP automática - DL0 - CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDL1CA', N'Transferencia MEP automática - DL1 - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDL1CC', N'Transferencia MEP automática - DL1 - CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDL2CA', N'Transferencia MEP automática - DL2 - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDL2CC', N'Transferencia MEP automática - DL2 - CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDR0', N'Transferencia MEP automática - DR0', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDR1', N'Transferencia MEP automática - DR1', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPDR2', N'Transferencia MEP automática - DR2', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPGC3CA', N'Transferencia MEP automática - GC3 - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACMEPGC3CC', N'Transferencia MEP automática - GC3 - CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACPAPRBBCA', N'Acreditación por Pago a Proveedores Banco Bica', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACPAPRBBCC', N'Acreditación por Pago a Proveedores Banco Bica ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACPPCACRED', N'Acreditación por transferencia CREDIN de Pago a Pr', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACPPCCCRED', N'Acreditación por transferencia CREDIN de Pago a Pr', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCAECHE', N'Acreditación por Compra de E-CHEQ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCCECHE', N'Acreditación por Compra de E-CHEQ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCHOBCA', N'Acreditación Cheque Otros Bcos CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCHOBCAO', N'Acreditación Cheque Otros Bcos CA - Otras Plazas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCHOBCC', N'Acreditacion Cheques Otros Bcos CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCHOBCCO', N'Acreditacion Cheques Otros Bcos CC - Otras Plazas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCHPRCA', N'Acreditación Cheque Propio Banco CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCHPRCC', N'Acreditacion Cheque Propio Banco CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCOMC10', N'Acred en Cta de Serv por Liq de Tarjetas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCPRACAR', N'Acreditación por Compra de Cartera', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRCPRACCC', N'Acreditación por Compra de Cartera', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRDEBAUCA', N'Acreditación  Débitos Automáticos', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRDEBAUCC', N'Acreditación  Débitos Automáticos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRDEUVS', N'Credito Deudores Varios - ACV', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREAFORO', N'Acreditación p/devolución Aforo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREAMOR', N'Acreditacion por Amortizacion/Renta/Rescate', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREAMORCA', N'Acreditacion por Amortizacion/Renta/Rescate', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRECAPRCA', N'Acreditación Cancelación Prestamos', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRECAPRCC', N'Acreditación Cancelación Prestamos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREDEBA', N'Acreditación Débitos Automáticos', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREFCATAS', N'Acreditación deposito efectivo en caja de ahorro T', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREFCCTAS', N'Acreditacion deposito efectivo en cuenta corriente', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREOPECRE', N'Acreditación por operatoria crediticia', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREOPPC', N'Cámara - Acreditación Op.Pend.Pasivas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREOPPCI', N'Canje Interno - Acreditación Op.Pend.Pasivas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREPRECC', N'Acreditación Préstamos en Cuenta Corriente', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREPREST', N'Acreditación Préstamos en Caja de Ahorro', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRERENTI', N'Acreditación de Rentas por Títulos', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRESFCICA', N'Acreditación por ajuste de Rescate CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRESFCICC', N'Acreditación por ajuste de Rescate CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACREWEB', N'Acreditación Préstamos WEB', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRFCLCA', N'Acreditación Fondo de Cese Laboral', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRFPPFICA', N'Transferencia por Pago de PF a CA Cuentas Propias ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRFPPFICC', N'Transferencia por Pago de PF a CC Cuentas Propias ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRHABAGUI', N'Acreditación de Haberes – Aguinaldo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRHABCPBB', N'Acreditación de Haberes', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRHABCPCA', N'Acreditación de Haberes Ctas Bco Bica ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRHABOBCA', N'Acreditación de Haberes Ctas Otros Bcos ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRHABOCRE', N'Acreditación de Haberes - Otros Conceptos Remunera', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRHONPROF', N'Acreditacion - Devolucion Honorarios Profesionales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRINTCA', N'Cuenta Efectiva', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRINTCC', N'Cuenta Efectiva', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRINTDEV', N'Acreditación de Intereses Devengados', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRINTDVCA', N'Acreditación de Intereses Devengados', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRNGECHEQ', N'Acreditacion  por negociación E-cheq', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRODDCC', N'Acreditación por Órdenes de Débito Directo', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRODDCPCC', N'Acreditación  x OD Directo - Ctas Propias', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRODDOBCC', N'Acreditación x OD Directo - Ctas Otros Bancos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPAGCLCA', N'Acreditación por Pago a Clientes ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPAGCLCC', N'Acreditación por Pago a Clientes ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPAGOHOB', N'Acreditación por pago de honorarios', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPAGOHON', N'Acreditación por pago de honorarios', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPAGPRCA', N'Acreditación por Servicio de Pago a Proveedores', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPAGPRCC', N'Acreditación por Servicio de Pago a Proveedores', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPFOBCA', N'Acreditación PF Otros Bcos CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPFOBCC', N'Acreditacion PF Otros Bcos CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPGOHON', N'Acreditación por pago de honorarios (BO-MA)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPPRCASI', N'Acreditacion por Pago a Prov sImp', N'H', N'CA')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPPRCCSI', N'Acreditacion por Pago a Prov sImp', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPRCASI', N'Acreditacion por Pago a Prov sImp', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPRECA', N'Acreditacion por Prestamos en Caja de Ahorro', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPRECC', N'Acreditacion por Prestamos en Cta Cte', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRPREFTER', N'Acreditación Prestamos Fondos de Terceros', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRRECBICA', N'Acreditacion por recarga I-Bica CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACRRECBICC', N'Acreditacion por recarga I-Bica en CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACTRANMTCA', N'Acreditación por Transferencia Cuenta Mismo Titula', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ACTRANMTCC', N'Acreditación por Transferencia Cuenta Mismo Titula', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCAMCHQH', N'Ajuste Cheques Cámara - Créditos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCAMCHQHA', N'Ajuste Cheques Cámara - Créditos', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDEFECC', N'Ajuste Crédito Por Depósito De Efectivo Erróneo', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDEPCHC', N'Ajuste Crédito Por Depósito De Cheques Erróneo', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDEPCHQ', N'Ajuste Crédito Por Depósito De Cheques Erróneo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDEPEFE', N'Ajuste Crédito Por Depósito De Efectivo Erróneo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDINTPF', N'Acreditación De Intereses En Plazo Fijo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDOPCAM', N'Ajuste Crédito Por Operaciones De Cambio', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDPRES', N'Ajuste Crédito Por Préstamos', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDTAR', N'Ajuste Crédito Por Tarjeta De Crédito', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDTARDB', N'Ajuste Crédito Por Tarjeta De Débito', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDTRACC', N'Ajuste Crédito Por Transferencias Link', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDTRIB', N'Ajuste Crédito Por Transferencias Interbanking', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDTRMEP', N'Ajuste Crédito Por Transferencias Mep', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRDTRSCC', N'Ajuste Crédito Por Transferencias Sinapa', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRECASHV', N'Ajuste Crédito VISA - Extra Cash CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREDGTO', N'Ajuste - Reintegro Gastos de Envío (BO-MA)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREDIC', N'Ajuste - Devolución Impuesto a los Créditos (BO-MA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREDICCC', N'Ajuste - Devolución Impuesto a los Créditos (BO-MA', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREDID', N'Ajuste - Devolución Impuesto a los Débitos (BO-MA)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREDIDCC', N'Ajuste - Devolución Impuesto a los Débitos (BO-MA)', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREDINT', N'Crédito por Ajuste de Intereses (BO-MA)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREDRIB', N'Ajuste - Devolución Retención Ingresos Brutos (BO-', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREIVA', N'Crédito - Ajuste I.V.A.', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCREIVACC', N'Crédito - Ajuste I.V.A.', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRERIBCC', N'Ajuste - Devolución Retención Ingresos Brutos (BO-', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRESEL', N'CREDITO - Ajuste Impuesto a los sellos - CC.', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJCRESELCA', N'CREDITO - Ajuste Impuesto a los sellos - CA.', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDBCPRACA', N'Ajuste Débito VISA - Compras CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDBCPRAV', N'Ajuste Débito VISA - Compras CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDBECASHV', N'Ajuste Débito VISA - Extra Cash CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBCHCC', N'Ajuste Débito Por Depósito De Cheques Erróneo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBDEPCH', N'Ajuste Débito Por Depósito De Cheques Erróneo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBDEPEF', N'Ajuste Débito Por Depósito De Efectivo Erróneo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBEFECC', N'Ajuste Débito Por Depósito De Efectivo Erróneo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBGCIA', N'Cobro Manual de Impuesto a las Ganancias (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBIBMUL', N'Débito - Ajuste Ret de IB (Convenio Multilateral) ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBIC', N'Débito - Ajuste Impuesto a los Créditos (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBICCC', N'Débito - Ajuste Impuesto a los Créditos (BO-MA)', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBID', N'Débito - Ajuste Impuesto a los Débitos (BO-MA) ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBIDCC', N'Débito - Ajuste Impuesto a los Débitos (BO-MA) ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBINT', N'Débito por Ajuste de Intereses (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBIVA', N'Débito - Ajuste I.V.A. (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBIVACC', N'Débito - Ajuste I.V.A. (BO-MA)', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBPF', N'Ajuste Débito Por Plazo Fijo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBPRECC', N'Ajuste Débito Por Préstamos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBRIB', N'Ajuste - Débito SIRCREB', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBRIBCC', N'Ajuste - débito SIRCREB', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBSEL', N'Débito - Ajuste Impuesto a los Sellos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBSELCA', N'Ajuste DébitoImpuesto a los Sellos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBTARDB', N'Ajuste Débito Por Tarjeta De Débito', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBTRIB', N'Ajuste Débito Por Transferencias Interbanking', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBTRLCC', N'Ajuste Débito Por Transferencias Link', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBTRMEP', N'Ajuste Débito Por Transferencias Mep', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDEBTRSCC', N'Ajuste Débito Por Transferencias Sinapa', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJDECASHCA', N'Ajuste Débito VISA - Extra Cash CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJECASHV', N'Ajuste Crédito VISA - Extra Cash CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJPAGCHQD', N'Ajuste por Pago de Cheque - Debito', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJPAGCHQDA', N'Ajuste por Pago de Cheque - Débito', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJPAGCHQH', N'Ajuste Cheques - Creditos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJSAVIVACC', N'SAV - Ajuste I.V.A.', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJSAVNEACC', N'Ajuste Sav Neto Acredita en CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AJSAVNEDCC', N'Ajuste Sav Neto Debita en CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ANSESACRE', N'Acreditación Anses', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ANSESACREA', N'Acreditación Anses Anticipada', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ANSESACREM', N'Acreditación Anses (BO-MA)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ANSESCOMA', N'Comisión - Acreditación Anticipada Anses', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ANSESCOMAM', N'Comisión por Acreditación Anticipada ANSES', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ANUACRODD', N'Anulación por Acreditación Ordenes de Débito Direc', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'AVALINCUMP', N'Débito por Incumplimiento de Garantía', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BAJAPF', N'Baja de Plazo Fijo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BCAGILCR', N'Rendición cobranza BICA AGIL', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BCAGILCRCC', N'Rendición cobranza BICA AGIL', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BCAGILDB', N'Rendición Cobranza AFIP - Bica Agil', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BENCTAPOS', N'Beneficio Cuentas Positivas por Influencer', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BENCTAPOSM', N'Beneficio Cuentas Positivas por Influencer Manual', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BENRFCTAPM', N'Beneficio Cuentas Positivas por Referido Manual', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BENRFCTAPO', N'Beneficio Cuentas Positivas por Referido', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BEXTD3583C', N'Débito Percepción Impuesto PAIS', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BEXTDB3583', N'Débito Percepción Impuesto PAIS', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BEXTDBGCIA', N'Débito por Ret. Gcia - Beneficiarios del Exterior', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BEXTDBGCIC', N'Débito por Ret. Gcia - Beneficiarios del Exterior', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BEXTDBIVA', N'Débito por Ret. IVA - Beneficiarios del Exterior', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BEXTDBIVAC', N'Débito por Ret. IVA - Beneficiarios del Exterior', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BEXTDBPER', N'Débito por Percep. RG 3550 - Vta. Moneda Extranjer', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BEXTDBPERC', N'Débito por Percep. RG 3550 - Vta. Moneda Extranjer', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BONPOSNET', N'Bonificación Terminal Posnet', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BUFHO', N'Comisión Buzón fuera de hora', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BUFHOCC', N'Comisión Buzón de Depósitos a toda hora', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BUFUHO', N'Buzón Fuera de Hora', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'BUFUHOCC', N'Buzón Fuera de Hora', N'H', N'CC')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CACUER', N'Comisión Alta Acuerdos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CACUERSB', N'Comisión Alta Sobregiro', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CAJASEG', N'cAJA DE SEGURIDAD', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CANCFCBB', N'Cancelación Factura Banco Bica', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CANCFCBBCA', N'Cancelación Factura Banco Bica', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CAPINT', N'Capitalización de intereses', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CAPINTM', N'Capitalización de intereses (BO-MA)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CCDEPOEFEC', N'Depósito en efectivo', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CCEXTEFEC', N'Extracción en efectivo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CCHQCERT', N'Comisión Cheque certificado', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CCHQCERTCJ', N'Comisión Cheque certificado- Para Caja', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CDENCHE', N'Comision Denuncia de Cheques', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CENCHQ', N'Comisión Entrega Chequera normal', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CENCHQC', N'Comisión Entrega Chequera Continuo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CENCHQCM', N'Comisión Entrega Chequera Continuo - BO', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CENCHQM', N'Comisión Entrega Chequera normal - BO', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOCFIRCR', N'Crédito - Certificación de Firmas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOCFIRMA', N'Cargo por Certificación de firmas', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOESCCRCA', N'Crédito - Escribanía', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOESCRIB', N'Cargo por Honorarios Escribano', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOESCRICC', N'Débito - Escribanía', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOESCRICR', N'Crédito - Escribanía', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOFIRCRCA', N'Crédito - Certificación de Firmas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOFIRMACC', N'Cargo por Honorarios Escribano', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOGESCRCA', N'Crédito - Por Honorarios Gestoría', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOGESRIB', N'Cargo por Honorarios Gestoría', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOGESRICC', N'Cargo por Honorarios Gestoría', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CGOGESRICR', N'Crédito - Por Honorarios Gestoría', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CHQCERT', N'Certificación de Cheque', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CHQSAV', N'Acreditación en CA Compra de Cheques SAV', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CHQSAVBJ', N'Baja de Liq. en CA Compra de Cheques SAV', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CHQSAVCC', N'Acreditación en CC Compra de Cheques SAV', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CHQSAVCCBJ', N'Baja de Liq. en CC Compra de Cheques SAV', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CJSEGTXCA1', N'Comision por servicio de Caja de Seguridad', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CJSEGTXCA2', N'Sellado Caja de Seguridad', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CJSEGTXCA3', N'Cobro de Comision CA por Acceso Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CJSEGTXCC1', N'Comision por servicio de Caja de Seguridad', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CJSEGTXCC2', N'Sellado Caja de Seguridad', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CJSEGTXCC3', N'Cobro de Comision CC por Acceso Adicional', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CMPBCRACA', N'Compensacion Gastos Operativos BCRA CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CMPBCRACC', N'Compensacion Gastos Operativos BCRA CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COBCRECALP', N'Debito por Transferencia', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COBPRESTCA', N'Cobro cuota de préstamos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COBPRESTCC', N'Cobro cuota de préstamos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COBROCRECA', N'Cobro de Cuotas de Préstamos en Caja de Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COBROCRECC', N'Cobro de Cuotas de Préstamos en Cta. Cte.', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COBVISTCCA', N'Cobranza Visa Tarjeta Crédito en CA(por Link)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COBVISTCCC', N'Cobranza Visa Tarjeta Crédito en CC(por Link)', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COM60212', N'Comisión por Transferencia Recibida', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMACRCHCA', N'Comisión por Acreditación de Cheque', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMACRECHQ', N'Comision Acreditacion  por negociación E-cheq', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMACRSUCP', N'Comisión por Acreditación de Sueldo  Ctas Bco Bica', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMACRSUOB', N'Comisión por Acreditación de Sueldos Otros Bcos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMADVALCA', N'Comisión por Administración de Valores', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMADVALCC', N'Comisión por Administración de Valores', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMALTACTA', N'Comisión por Servicio de Alta de Cuenta', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMASEBU', N'Comisión por Asesoramiento en Operaciones Bursátil', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMASEBUCC', N'Comisión por Asesoramiento en Operaciones Bursátil', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMBTNPAG', N'Comisión Servicio Botón de Pago', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCAACHCM', N'Comisión Comercializadoras-Haberes', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCADONCM', N'Comisión Comercializadoras-Dongles', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCAPRDCM', N'Comisión Acreditacion de Productos - Comercializad', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCATARCM', N'Comisión Comercializadoras-Tarjetas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCCACHCM', N'Comisión Comercializadoras-Haberes', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCCDONCM', N'Comisión Comercializadoras-Dongles', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCCPRDCM', N'Comisión Acreditacion de Productos - Comercializad', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCCTARCM', N'Comisión Comercializadoras-Tarjetas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCEDIN', N'Comisión gestiones CEDIN', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCERF', N'Comisión por Certificación de Firmas', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCERFIRC', N'Comisión por Certificación de Firmas', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCERSDO', N'Comisión por Certificación de Saldos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCERTF', N'Comisión por Certificación de Firmas', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCERTFIR', N'Comisión por Certificación de Firmas', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCERTSC', N'Comisión por Certificación de Saldos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCERTSCC', N'Comisión por Certificación de Saldos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCERTSDO', N'Comisión por Certificación de Saldos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCHQCONS', N'Comisión por Cheque en Consulta', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCVUCACP', N'Comision valida CVU Coelsa CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMCVUCCCP', N'Comisión por consulta de CBU', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEBAUCA', N'Comisión por Débito Automático ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEBAUCC', N'Comisión por Débito Automático ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDECHCCM', N'Comisión por Depósito de Cheques Otros Bancos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPCABO', N'Comision depositos entre sucursales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPCCBO', N'Comision depositos entre sucursales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPCHEM', N'Comisión por Depósito de Cheques Otros Bancos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPEFA', N'Comisión por depósitos en Efectivo por acumulación', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPEFAC', N'Comisión por depósitos en Efectivo por acumulación', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPES', N'Comisión depósitos entre sucursales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPESCC', N'Comisión depósitos entre sucursales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPOEF', N'Comisión Depósitos en efectivo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEPOEFC', N'Comision depositos en efectivo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDEVDD', N'Devolución de comisiones - Servicio de débito dire', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDISHTCA', N'Comisión Dispositivo Hard Token', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMDISHTCC', N'Comisión Dispositivo Hard Token', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMEMECHEM', N'Comisión por Emision de e-Cheq Masivos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMEX392', N'Cobro de Exportaciones', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMEX392CA', N'Cobro de Exportaciones', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMEXCABO', N'Comision extraccion entre sucursales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMEXES', N'Comisión extracciones entre sucursales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMEXESCC', N'Comisión extracciones entre sucursales', N'D', N'CC')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMEXTBO', N'Comision extracciones entre sucursales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFCLCC', N'Comisión Fondo Cese Laboral', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFINCA', N'Débito por Cierre de C.A. Inmovilizada (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFINCCM', N'Comisión por Cierre de Cuenta', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFINCTA', N'Comisión por Cierre de Cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFINCTAC', N'Comisión por Cierre de Cuenta', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFINCTAM', N'Comisión por Cierre de Cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFININM', N'Débito por Cierre de Caja de Ahorro (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFOCERCA', N'Comisión por Fotocopia de Comprobantes con Certifi', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFOTCCA', N'Comisión por Fotocopia de Comprobantes con Certifi', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFOTCER', N'Comisión por Fotocopia de Comprobantes con Certifi', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFOTCERC', N'Comisión por Fotocopia de Comprobantes con Certifi', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFOTO', N'Comision por Fotocopia de Comprobantes', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFOTOC', N'Comisión por Fotocopia de Comprobantes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFOTOCA', N'Comisión por Fotocopia de Comprobantes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFOTOCCC', N'Comisión por Fotocopia de Comprobantes', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFTE_1', N'Comisión extracciones por caja adicionales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFTE_1CC', N'Comisión extracciones por caja adicionales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFTECJ', N'Comisión extracciones por caja adicionales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFTECJCC', N'Comisión extracciones por caja adicionales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMFTECJE', N'Comisión extracciones por caja adicionales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGCCHOAO', N'Comisión por Depósito de Cheques OTROS BANCOS - Ot', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGCCHOCA', N'Comisión por Depósito de Cheques OTROS BANCOS', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGCCHOCC', N'Comisión Gestión de Cobro Chq Otros Bcos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGCCHOCO', N'Comisión Gestión de Cobro Chq Otros Bcos - Otras P', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGCCHPCA', N'Comisión por Gestión de Cobro Cheque Propio Banco ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGCCHPCC', N'Comisión Gestión de Cobro Cheque Propio Banco', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGCPFOCA', N'Comisión por Depósito de PF OTROS BANCOS', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGCPFOCC', N'Comisión Gestión de Cobro PF Otros Bcos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGTIAOT', N'Comisión Garantías Otorgadas', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMGTIAOTU', N'Comisión Otorgamiento de la Garantía', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMMCRCC', N'Comisión tarjeta Master Prepaga', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMMCREG', N'Comisión tarjeta Master Prepaga', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMMEP', N'Comisión por transferencia vía MEP $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMMEPCA', N'Comisión por transferencia vía MEP', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMODDBO', N'Comisión por Débito Directo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMODDCPCC', N'Comisión por Débito Directo - Ctas Propias', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMODDOBCC', N'Comisión por Débito Directo - Ctas Otros Bancos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPAGCHCC', N'Comisión por Pago de Cheque por Cámara', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPAGCHCI', N'Comisión por Pago de Cheque por Canje Interno - CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPAGCHEM', N'Comisión por Pago de e-Cheq Masivos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPAGPRCP', N'Comisión por Pago a Prov Ctas Bco Bica', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPAGPROB', N'Comisión por Pago a Prov Ctas Otros Bcos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPCHMTCC', N'Comisión por Pago de Cheque por Mostrador', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPENSDCA', N'Transferencia emitida intrabancaria', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPENSDCC', N'Transferencia emitida intrabancaria', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPENSHCA', N'Transferencia recibida intrabancaria', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPENSHCC', N'Transferencia recibida intrabancaria', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPESDO', N'Débito Automático por Compensación de Saldos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPESDOM', N'Débito Automático por Compensación de Saldos (BO-M', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPPRCPCA', N'Comisión por Pago a Prov Ctas Bco Bica', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPPROBCA', N'Comisión por Pago a Prov Ctas Otros Bcos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPPROLN', N'Comision pago prov. online', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPREFSU', N'Compensación Referente Cuenta Sueldo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPSPCTCA', N'Comisión PSP Cuentas CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPSPCTCC', N'Comisión PSP Cuentas CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPSPTRCA', N'Comisión PSP Transferencias CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMPSPTRCC', N'Comisión PSP Transferencias CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRCHCICA', N'Comisión Rechazo Cheque Canje Interno  - Cta Depos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRCHCICC', N'Comisión Rechazo Cheque Canje Interno  - Cta Depos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRCZCHD', N'Comisión x Rechazo de Cheque - De Depositaria', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRCZCHG', N'Comisión x Rechazo de Cheque - De Girada', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMREADCA', N'Comisión Resumen Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMREADICA', N'Comisión Resumen Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRECHCCM', N'Comisión por Rechazo de Cheque', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMREDEBAC', N'Comisión por Reintento Débito Automático ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMREDEBAU', N'Comisión por Reintento Débito Automático ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMREFSUCC', N'Compensación Referente Cuenta Sueldo', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESADB', N'Comisión Resumen Adicional', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESADBO', N'Comisión Resumen Adicional', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESADCC', N'Comisión Resumen Adicional', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESADI', N'Comisión Resumen Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESCUA', N'Comisión Resumen Cuatrimestral', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESDIA', N'Comisión Resumen Diario - Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESMEN', N'Comisión Resumen Mensual - Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESQUIN', N'Comisión Resumen Quincenal - Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESSEM', N'Comisión Resumen Semestral - Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESSEMA', N'Comisión Resumen Semanal - Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESTRI', N'Comisión Resumen Trimestral - Adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESVAL', N'Comisión por Rescate de Valores', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESVALC', N'Comisión por Rescate de Valores', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESVLCA', N'Comisión por Rescate de Valores ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRESVLCC', N'Comisión por Rescate de Valores', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRZCHCIE', N'Comisión por Rechazo de Chq Canje Interno - Emisor', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRZCOBCA', N'Comision x Rechazo Cheque Otros Bcos CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRZCOBCC', N'Comision x Rechazo Cheque Otros Bcos CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRZOCHQ', N'Comisión por Cancelación de Cheque Rechazado', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRZPFOCA', N'Comision x Rechazo PF Otros Bcos CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRZPFOCC', N'Comision x Rechazo Plazo Fijo Otros Bcos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMRZPFOPF', N'Comision x Rechazo PF q const. otro PF', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSAVSGR', N'Comisión SGR', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSBRGIRO', N'Uso de Sobregiro Sin Acuerdo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSDERECA', N'Comisión Servicio Depósito Remoto', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSDERECC', N'Comisión Servicio Depósito Remoto', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSDOINM', N'Comisión por Saldos Inmovilizados', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSDOINMM', N'Comisión por Saldos Inmovilizados', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSERBV', N'Comision por Transferencia Bolsa de Valores', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSINAPA', N'Comisión por transferencia vía SINAPA $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSINAPCA', N'Comisión por transferencia vía SINAPA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSOCDCC', N'Compensación Bancarización Social débito', N'D', N'CC')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSOCHCC', N'Compensación Bancarización Social crédito', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSOLIMG', N'Solicitud Imagen Cheque', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSOLIMGC', N'Comisión por Solicitud de imagen de cheque', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMSRVACTA', N'Comisión Servicio Alta de Cuentas', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTCPBBCA', N'Comisión Transferencia Cuentas Propias en Banco Bi', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTCPOBCA', N'Comisión Transferencia Cuentas Propias en Otros Ba', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRCPBBI', N'Comisión Transferencia Cuentas Propias en Banco Bi', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRCPOTB', N'Comisión Transferencia Cuentas Propias en Otros Ba', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRDBMCA', N'Comisión por Transferencias', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRDBMCC', N'Comisión por Transferencias', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRDT', N'Comisión por transferencias - Distinto Titular Cue', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRDTCC', N'Comisión por transferencias - Distinto Titular Cue', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRPAMEP', N'Comisión por Servicio Transferencias MEP', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRPRO', N'Comisión por Transferencias', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMTRPROCC', N'Comisión por transferencias', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMVISARCC', N'Comisión tarjeta VISA regalo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMVISAREG', N'Comisión tarjeta VISA regalo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMVRFRCA', N'Recupero gastos de verificación registral', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMVRFRCC', N'Recupero gastos de verificación registral', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMVRFREG', N'Recupero gastos de verificación registral', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COMVRFREGC', N'Recupero gastos de verificación registral', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CONDSDODEU', N'Acreditación por condonación de saldo deudor', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COPACLCACP', N'Comisión por Pago a Clientes Ctas Bco Bica', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COPACLCAOB', N'Comisión por Pago a Clientes Ctas Otros Bcos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COPACLCCCP', N'Comisión por Pago a Clientes Ctas Bco Bica', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COPACLCCOB', N'Comisión por Pago a Clientes Ctas Otros Bcos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'COSTOPAQ', N'Comisión por Servicios Incluidos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CPAGPROLCP', N'Comisión por Pago a Prov On Line Ctas Bco Bica', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CPAGPROLOB', N'Comisión por Pago a Prov On Line Ctas Otros Bcos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CPPROLCPCA', N'Comisión por Pago a Prov On Line Ctas Bco Bica', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CPPROLOBCA', N'Comisión por Pago a Prov On Line Ctas Otros Bcos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRDCCESSDO', N'Crédito - Cesión de Saldos a Terceros', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRDCONGTIA', N'Crédito por restitución de garantía', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREBICAODT', N'DISTINTA TITULARIDAD - Dep. en cta Banco Bica en O', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREBICAOE', N'Depósito en cuenta de Banco Bica en Otras Entidade', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREBICOECC', N'MISMA TITULARIDAD - Dep. en cta Banco Bica en Otra', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREBIODTCC', N'DISTINTA TITULARIDAD - Dep. en cta Banco Bica en O', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRECAPPRO', N'Crédito - Por Pago a Proveedores', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRECBIOCA', N'Crédito por Operaciones de Cambio', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRECBIOCC', N'Crédito por Operaciones de Cambio', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRECCPPRO', N'Crédito - Por Pago a Proveedores', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRECEROBRA', N'Crédito - Por Cancelación de Certificado de Obra', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRECLICA', N'Crédito - Por Pago a Clientes', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRECLICC', N'Crédito - Por Pago a Clientes', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDAUTCS', N'Crédito Automático por compensación de saldos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDAUTCSM', N'Crédito Automático por compensación de saldos (BO-', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDCOMFDO', N'Crédito - Cuenta Compensadora de Fondos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDCOMICA', N'Acreditación en CUENTA COMITENTE BANCO BICA S.A.', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDCOMITE', N'Acreditación en CUENTA COMITENTE BANCO BICA S.A.', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDCTAPR', N'Créditos Varios Cuentas Propias', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDEPGTIA', N'Crédito Reintegro de Dep en Gtia. Ley 19550 Art 18', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDOPEPFM', N'Crédito por Operaciones de Plazo fijo (BO-MA)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREDVARIOS', N'Créditos Varios', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CREPGOHAB', N'Acreditación de Haberes', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRESCFCICA', N'Confirmación de Rescate a FCI en CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRESCFCICC', N'Confirmación de Rescate a FCI en CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRETBURCA', N'Crédito por Transacciones Bursátiles CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'CRETBURCC', N'Crédito por Transacciones Bursátiles CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACREDJUCA', N'Datanet Creditos CA Depósitos Judiciales', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACREDJUCC', N'Datanet Creditos CC Depósitos Judiciales', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACREPJUCA', N'Datanet Debitos CA Pagos Judiciales', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACREPJUCC', N'Datanet Debitos CC Pagos Judiciales', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACRETERCA', N'Datanet Creditos CA Pagos Terceros', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACRETERCC', N'Datanet Creditos CC Pagos Terceros', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACRFCLCC', N'Débito por Fondo de Cese Laboral', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACRHABBBO', N'Débito por Acreditación de Haberes Otras Cuentas -', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACRHABBBP', N'Débito por Acreditación de Haberes Cuentas Propias', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACRHABCA', N'Débito por Acreditación de Haberes Caja de Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DACRHABCC', N'Débito por Acreditación de Haberes ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DADEBDJUCA', N'Datanet Debitos CA Depósitos Judiciales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DADEBDJUCC', N'Datanet Debitos CC Depósitos Judiciales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DADEBPJUCA', N'Datanet Debitos CA Pagos Judiciales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DADEBPJUCC', N'Datanet Debitos CA Pagos Judiciales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DADEBTERCA', N'Datanet Debitos CA Pago a Terceros', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DADEBTERCC', N'Datanet Debitos CC Pago a Terceros', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATACOCADT', N'Datanet Comisión CA Distinto Titular ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATACOCCDT', N'Comisión por Transferencia vía Datanet Distinto Ti', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATACOMICA', N'Comisión por Transferencia vía Datanet ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATACOMICC', N'Comisión por Transferencia vía Datanet', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATACRCADT', N'Datanet Creditos CA Distinto Titular Automático', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATACRCCDT', N'Datanet Creditos CC - Distinto Titular', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATACRECA', N'Datanet Creditos CA Automático', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATACRECC', N'Datanet Creditos CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATADEBCA', N'Datanet Debitos CA Automático', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATADEBCC', N'Datanet Debitos CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATADECADT', N'Datanet Debitos CA Distinto Titular Automático', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATADECCDT', N'Datanet Debitos CC - Distinto Titular', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATAFACTCA', N'Datanet Facturación CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATAFACTCC', N'Datanet Facturación CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATAFIPCA', N'Datanet pagos a AFIP CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATAFIPCC', N'Datanet pagos a AFIP CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATAPAFACA', N'Datanet pago facturación electrónica CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATAPAFACC', N'Datanet pago facturación electrónica CC ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATCRCADTM', N'Datanet Creditos CA Distinto Titular', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATCRCCDTM', N'Datanet Creditos CC - Distinto Titular', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATCRECAM', N'Datanet Creditos CA ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATCRECCM', N'Datanet Creditos CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATCRESUCA', N'Acreditación de haberes en caja de ahorro', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATDEBCAM', N'Datanet Debitos CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATDEBCCM', N'Datanet Debitos CC', N'D', N'CC')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATDEBSUCA', N'Débito en CA por orden de acreditación de haberes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATDEBSUCC', N'Débito en CC por orden de acreditación de haberes', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATDECADTM', N'Datanet Debitos CA Distinto Titular', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DATDECCDTM', N'Datanet Debitos CC - Distinto Titular', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DBCOBCPRAC', N'Débito compra de Cartera', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DBCONSGTIA', N'Débito para constituir garantía', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DBEMBBO', N'Débito por Embargo Judicial', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DBEMBCABO', N'Débito por Embargo Judicial', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DBRESFCICA', N'Débito por ajuste de Rescate CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DBRESFCICC', N'Débito por ajuste de Rescate CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DDTRPAGMEP', N'Devolución Servicio Transferencias MEP', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBAMCLMCA', N'Debito promociones AMCL Mastercard Caja Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBAMCLVCA', N'Debito promociones AMCL Visa Caja Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBAUTCA', N'Débito Automático', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBAUTCC', N'Débito Automático', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBBTNPAG', N'Débito por servicio Botón de Pago', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCAANPR', N'Débito Caja Ahorro por Anulación de Préstamo ya pa', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCARECBI', N'Recargas varias I-Bica CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCBIOCA', N'Débito por Operaciones de Cambio', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCBIOCC', N'Débito por Operaciones de Cambio', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCCANPR', N'Débito Cta Cte por Anulación de Préstamo ya pagado', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCCRECBI', N'Recargas varias I-Bica CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCEROBRA', N'Débito por pago Certificado de Obra', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCESSDO', N'Débito - Cesión de Saldos a Terceros', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCOBFTER', N'Debito Cobranza fondos de terceros', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCOMFDO', N'Débito - Cuenta Compensadora de Fondos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCOMICA', N'Débito en CUENTA COMITENTE BANCO BICA S.A.', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCOMISCA', N'Comisión', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCOMISCC', N'Comisión Alta Sobregiro', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBCTAPR', N'Débitos Varios Cuentas Propias', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBDEPGTIA', N'Débito por Depósito en Gtía. Ley 19550 Art. 187', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBEM', N'Debito por embargo ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBEMCA', N'Débito por Embargo Judicial', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBEMCC', N'Débito por Embargo Judicial', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBFPPFICA', N'Debito fondos provenientes de Plazos Fijos Indispo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBINFBOLE', N'Debito informe boletin - Manual', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBMCRCC', N'Débito - Carga Tarjeta de Prepaga Master', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBMCREG', N'Débito - Carga Tarjeta de Prepaga Master', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBOPC', N'Cámara - Debito Op.Pendientes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBOPCI', N'Canje Interno - Debito Op.Pendientes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPAGOHON', N'Débito por Pago de Honorarios', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPGCDTCC', N'DISTINTA TITULARIDAD - Débito por pagos por nuestr', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPGOCLI', N'Débito - Por Pago a Clientes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPGOHAB', N'Débito para pago de haberes', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPGOHON', N'Débito por Pago de Honorarios (BO-MA)', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPGONC', N'Débito por pagos por nuestra Cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPGONCCC', N'MISMA TITULARIDAD - Débito por pagos por nuestra C', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPGONCDT', N'DISTINTA TITULARIDAD - Débito por pagos por nuestr', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPGOPRO', N'Débito - Por Pago a Proveedores', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBPREST', N'Debito cuota prestamo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBRESC10', N'Debito Resumen Master en Cta Cte', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBRESCA', N'Debito Resumen Master en Caja de Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBRESVICA', N'Debito Resumen VISA en Caja de Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBRESVICC', N'Debito Resumen VISA en Cta Cte', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBRESVLCA', N'Débito Intereses por Rescate - CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBRESVLCC', N'Débito Intereses por Rescate - CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBTBURCA', N'Débito por Transacciones Bursátiles CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBTBURCC', N'Débito por Transacciones Bursátiles CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBTMASTCA', N'Débito Resumen Master en Caja de Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBTMASTCC', N'Débito Resumen Master en Cta. Cte.', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBTRCREDT', N'Debito por transferencia CREDIN. Distinta titulari', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBTRCREMT', N'Debito por transferencia CREDIN. Misma titularidad', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBTVISACA', N'Débito Resumen VISA en Caja de Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBTVISACC', N'Débito Resumen VISA en Cta. Cte.', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBVARIOS', N'Débitos Varios', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'debverde', N'Buzon Verde', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'debverdeca', N'Buzon Verde', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBVISARCC', N'Debito - Carga Tarjeta de Regalo VISA', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEBVISAREG', N'Débito - Carga Tarjeta de Regalo VISA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPBBOTBCC', N'Depósito en Efectivo en Cta Bco Bica en Otro Bco', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPBBOTRB', N'Depósitos en Cuenta Bancaria de Banco Bica', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPCHE', N'Depósito de cheques', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPCHEOTR', N'Depósito de cheques - Otros Bancos', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPCHQ', N'Depósito de Cheques', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPCHQOTR', N'Depósito de Cheques - Otros Bancos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPCPF', N'Depósito de Certificado de Plazo Fijo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPCPFCC', N'Depósito de Certificado de Plazo Fijo', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPCPFD', N'Depósito de Certificado de Plazo Fijo-Dólar', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPCPFPF', N'Depósito de Certificado de Plazo Fijo para Const. ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPEFAGR', N'Depósitos en Efectivo - acumulación', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPEFAGRCA', N'Depósitos en Efectivo - acumulación', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPOEFEC', N'Depósito en efectivo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPOEFECAN', N'Depósito en Efectivo - Anulación', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPPFPRO', N'Deposito certificado de Plazo Fijo Banco Bica', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEPPFPROCC', N'Deposito certificado de Plazo Fijo Banco Bica', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVACRFCL', N'Devolución Transf Fondo Cese Laboral', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVACRHAB', N'Devolución Transf Acred Sueldo', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVCOMHON', N'Devolución de Convenios Pago Honorarios', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVCONVSU', N'Devolución por convenio sueldos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVINTVCCA', N'DEVOLUCION INTERESES VAL. AL COBRO - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVINTVCCC', N'DEVOLUCION INTERESES VAL. AL COBRO - CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVMEP', N'Devolución transferencia Inmediata - Via MEP', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVMEPCA', N'Devolución transferencia Inmediata - Via MEP', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPAGOHON', N'Devolución de honorarios', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPAGPRCA', N'Devolución Transf Pago Proveedores', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPAGPRMT', N'Devolución Transf Pago Proveedores - Mismo Titular', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPAGPRO', N'Devolución Transf Pago Proveedores', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPAGPROA', N'Devolución Transf Pago Proveedores', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPGOCLCA', N'Devolución - Servicio Pago a Clientes', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPGOCLCC', N'Devolución - Servicio Pago a Clientes CC', N'H', N'CC')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPGOCLI', N'Devolución - Servicio Pago a clientes', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVPPRMTCA', N'Devolución Transf Pago Proveedores - Mismo Titular', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVSINREC', N'Devolución Transferencia Recibida SINAPA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DEVSINRECC', N'Devolución Transferencia Recibida SINAPA', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DIFNEGMEXT', N'Dif. negativa por compra-venta moneda extranjera a', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DIFPOSMEXT', N'Dif. positiva por compra-venta moneda extranjera a', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DMULTARZOC', N'Devolución de Multa por Cheque Rechazado', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPAGCLICA', N'Débito por Pago a Clientes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPAGCLICC', N'Débito por Pago a Clientes', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPAGPRBBCP', N'Débito por Pago a Proveedores Banco Bica - Cuentas', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPAGPRBBOB', N'Débito por Pago a Proveedores Banco Bica - Otros B', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPAGPROVCA', N'Débito por Pago a Proveedores', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPAGPROVCC', N'Débito por Pago a Proveedores', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPAGTPPRCA', N'Débito por Transferencia a Cuenta Mismo Titular', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPAGTPPRCC', N'Débito por Transferencia a Cuenta Mismo Titular', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPPROVCASI', N'Debito por Pago a Prov sImp', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DPPROVCCSI', N'Debito por pago a Prov sImp', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DTOIVA7256', N'Descuento de IVA de Lïnea 7256', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DTOSELLA', N'Descuento Sellado', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DTRCRECCDT', N'Debito CC por transf CREDIN. Distinta titularidad', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DTRCRECCMT', N'Debito CC por transf CREDIN. Misma titularidad', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'DTRPAGMEP', N'Servicio Transferencias MEP', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'EUROPACRE', N'Credito Europ Assistance', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'EUROPDEB', N'Debito Europ Assistance', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'EXTCIERRE', N'Extracción por cierre de cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'EXTCIERREC', N'Extracción por cierre de cuenta', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'EXTEFEC', N'Extracción en efectivo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCIRECRSC', N'Transferencia Recibida Rescate FCI – Integrar SA', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCIRECTRCA', N'Transferencia Recibida para Suscripción de FCI', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCIRECTRF', N'Transferencia Recibida para Suscripción de FCI – I', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCIRERSCCA', N'Transferencia Recibida Rescate FCI – Integrar SA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCITRFRSC', N'Transferencia Rescate FCI – Integrar SA', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCITRFRSCA', N'Transferencia Rescate FCI – Integrar SA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCITRFSUS', N'Transferencia para Suscripción de FCI – Integrar S', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCITRSUSCA', N'Transferencia para Suscripción de FCI – Integrar S', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCLCREDITO', N'Acreditación servicio Fondo de CL', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCLDEBITO', N'Débito servicio Fondo de CL (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'FCLINTDEV', N'Interes - FCL', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'GCIAINS', N'Impuesto a las Gcias - 3%', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'GCIAINSCC', N'Impuesto a las Gcias - 3%', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'GCIANOI', N'Impuesto a las Gcias - 10 %', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'GCIANOICC', N'Impuesto a las Gcias - 10 %', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'GTOFRAVRE', N'Gastos de Franqueo con Aviso de Retorno', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'GTOFRAVREM', N'Gastos de Franqueo con Aviso de Retorno (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'GTOFRSIMP', N'Gastos de Franqueo Simple', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'GTOFRSIMPM', N'Gastos de Franqueo Simple (BO-MA)', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IATRERECCA', N'Intereses por atraso rend. de las recaudaciones CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IATRERECCC', N'Intereses por atraso rend. de las recaudaciones CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'INMOVSDOCA', N'Inmovilización de Saldos para cobro de pendientes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'INMOVSDOCC', N'Inmovilización de Saldos para cobro de pendientes', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'INTACUUTI', N'Interés por Saldo Deudor Cubierto por Acuerdo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'INTEGACRCA', N'Sociedad de Bolsa - Acreditación de fondos', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'INTEGACREF', N'Sociedad de Bolsa - Acreditación de fondos', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'INTEGDEBCC', N'Sociedad de Bolsa - Debito Movimiento de fondos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'INTEGDEBF', N'Sociedad de Bolsa - Debito movimiento de fondos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'INTSOBREG', N'Interés por Saldo Deudor No Cubierto por Acuerdo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ITF25413', N'Impuesto a las tx financieras Déb', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ITF25413CR', N'Impuesto a las tx financieras Cred.', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVACF', N'IVA Consumidor final', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVACFC', N'IVA Consumidor final', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVACFCC', N'IVA Consumidor final', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVACFCR', N'IVA Consumidor final', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVAEX', N'IVA Exento', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVAEXC', N'IVA Exento', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVAEXCC', N'IVA Exento', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVAEXCR', N'IVA Exento', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVANCAT', N'IVA No Categorizado', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVANCATCAR', N'IVA No Categorizado', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVANCATCC', N'IVA No Categorizado', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVANCATCR', N'IVA No Categorizado', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVANOA', N'IVA No Alcanzado', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVANOACC', N'IVA No Alcanzado', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVANOACCR', N'IVA No Alcanzado', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVANOACR', N'IVA No Alcanzado', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVARESCC', N'IVA Rescate SAV', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVARGTOSAV', N'IVA RECUPERO DE GTOS SAV', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVARI', N'IVA Resp. Inscripto', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVARIC', N'IVA Resp. Inscripto', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVARICC', N'IVA Resp. Inscripto', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVARICR', N'IVA Resp. Inscripto', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVEXT', N'IVA RG 212-98', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVEXTC', N'IVA RG 212-98', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVEXTCACR', N'IVA RG 212-98', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVEXTCC', N'IVA RG 212 98', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVEXTCCCR', N'IVA RG 212-98', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVEXTCR', N'IVA RG 212-98', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVMON', N'IVA - Monotributo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVMONC', N'IVA - Monotributo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVMONCC', N'IVA - Monotributo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVMONCR', N'IVA - Monotributo', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVRNI', N'IVA Resp. No Inscripto', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVRNIC', N'IVA Resp. No Inscripto', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVRNICC', N'IVA Resp. No Inscripto', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'IVRNICR', N'IVA Resp. No Inscripto', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L100100', N'Extraccion en $ en CC en $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L100102', N'Extracción en ATM del exterior CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L100102D', N'Extraccion en U$S en CC en $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L1001ECASH', N'Extraccion Extra Cash en CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L101100', N'Extraccion en $ en CA en $', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L101102', N'Extracción en ATM del exterior CA', N'D', N'CA')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L101102D', N'Extraccion en U$S en CA en $', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L1011ECASH', N'Extraccion Extra Cash en CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L101502', N'Extraccion de U$S en CA en U$S', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L170100', N'Recargas con débito en CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L171100', N'Recargas con débito en CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L180100', N'Débito p/Constitución de Plazo Fijo CC Medios Elec', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L181100', N'Débito p/Constitución de Plazo Fijo CA Medios Elec', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L190100', N'Debito por transferencia interbancaria de CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L191100', N'Debito por transferencia interbancaria de CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L191500', N'Debito por transferencia interbancaria de CA U$S', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L1B0100', N'Transf.Minorista desde CC a cta no propia mediante', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L1B0101C', N'Transf.Minorista desde CC a CC monobanco mediante ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L1B0111C', N'Transf.Minorista desde CC a CA monobanco mediante ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L1B1100', N'Transf.Minorista desde CA a cta no propia mediante', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L1B1101C', N'Transf.Minorista desde CA a CC monobanco mediante ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L1B1111C', N'Transf.Minorista desde CA a CA monobanco mediante ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L200001', N'Deposito de $ en efectivo o cheque en CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L200011', N'Deposito de $ en efectivo o cheque en CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L200015', N'Deposito de U$S en CA U$S', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L220001', N'Deposito de $ en efectivo en CC no vinculada o Cta', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L220011', N'Deposito de $ en efectivo en CA no vinculada o Cta', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L220015', N'Deposito de U$S en efectivo en CA no vinculada o C', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L290001', N'Orden de Acreditación por transferencia interbanca', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L290011', N'Orden de Acreditación por transferencia interbanca', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L290015', N'Orden de Acreditación por transferencia interb a C', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L2P0001', N'Acreditación de Prestamo Electrónico CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L2P0011', N'Acreditación de Prestamo Electrónico CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L400101', N'Transferencia de CC$ a CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L400101C', N'Transferencia de CC$ a CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L400111', N'Transferencia de CC$ a CA$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L400111C', N'Transferencia de CC$ a CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L400115', N'Operaciones de Cambio por Banca Electrónica', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L400115C', N'Transferencia de CC$ a CA U$S', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401101', N'Transferencia de CA$ a CC$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401101C', N'Transferencia de CA$ a CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401111', N'Transferencia de CA$ a CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401111C', N'Transferencia de CA$ a CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401115', N'Operaciones de Cambio por Banca Electrónica', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401115C', N'Transferencia de CA$ a CAU$S', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401501', N'Transferencia de CAU$S a CC$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401501C', N'Operaciones de Cambio por Banca Electrónica', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401511', N'Operaciones de Cambio por Banca Electrónica', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401511C', N'Transferencia de CAU$S a CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401515', N'Transferencia de CA U$S a CA U$S', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L401515C', N'Transferencia de CA U$S a CA U$S', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L510100', N'Pago de servicios CC en $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L511100', N'Pago de servicios CA en $', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L710100', N'Compra con tarjeta con debito en CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L710100D', N'Compras en el exterior CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L710100P', N'Compras en el exterior CC $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L711100', N'Compra con tarjeta con debito en CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L711100D', N'Compras en el exterior CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L711100P', N'Compras en el exterior CA $', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L711500', N'Compra con tarjeta en U$S con debito en CA U$S', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L720100', N'Anulación de compra con tarjeta con debito en CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L721100', N'Anulación de compra con tarjeta con debito en CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L740100', N'Devolución de compra con tarjeta con debito en CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L741100', N'Devolución de compra con tarjeta con debito en CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L750100', N'Anulación devolución de compra con tarjeta con deb', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L751100', N'Anulación devolución de compra con tarjeta con deb', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L770100', N'Anulación de compra con TD y retiro efectivo en CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L771100', N'Anulación de compra con TD y retiro efectivo en CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L810100', N'Pago de servicios CC en $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L811100', N'Pago de servicios CA en $', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L880100', N'Pago de servicio sin base en CC en $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L881100', N'Pago de servicio sin base en CA en $', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L88CAAFIP', N'Pago de servicio VEP AFIP CA en $', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'L88CCAFIP', N'Pago de servicio VEP AFIP CC en $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LACREOPP', N'Acreditación Op. Pend. Activas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LACREPCC', N'Acreditación Pendiente CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJCRATMCA', N'Ajuste Crédito ATM CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJCRATMCC', N'Ajuste Crédito ATM CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJCRCOECA', N'Ajuste Crédito COELSA CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJCRCOECC', N'Ajuste Crédito COELSA CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJCRTASCA', N'Ajuste Crédito TAS CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJCRTASCC', N'Ajuste Crédito TAS CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJDEATMCA', N'Ajuste Débito ATM CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJDEATMCC', N'Ajuste Débito ATM CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJDECOECA', N'Ajuste Débito COELSA CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJDECOECC', N'Ajuste Débito COELSA CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJDETASCA', N'Ajuste Débito TAS CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJDETASCC', N'Ajuste Débito TAS CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJEXATECA', N'Ajuste Extracciones en el exterior CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJEXATECC', N'Ajuste Extracciones en el exterior CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJUCPRACA', N'Ajuste Crédito VISA - Compras CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LAJUCPRACC', N'Ajuste Crédito VISA - Compras CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LBPB190100', N'Boton de Pagos - Débito en CC $', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LBPB191100', N'Boton de Pagos - Débito en CA $', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LBPB191500', N'Boton de Pagos - Débito en CA u$s', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LBPB290001', N'Boton de Pagos - Crédito en CC $', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LBPB290011', N'Boton de Pagos - Crédito en CA $', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LBPB290015', N'Boton de Pagos - Crédito en CA u$s', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOLINKSCC', N'Comisión TD link solución.', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOLINKSOL', N'Comisión TD link solución', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOLPCA', N'Comisión por recaudación LINK Pagos en CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOLPCC', N'Comisión por recaudación LINK Pagos en CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMDOCC', N'Comisión por adquisición de dispositivo dongle.', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMDONGLE', N'Comision por adquisicion dispositivo dongle', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMEEX', N'Comisión uso ATM en el exterior', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMEEXCC', N'Comisión uso ATM en el exterior', N'D', N'CC')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMEEXTCA', N'Comisión uso ATM en el exterior con débito en peso', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMEEXTCC', N'Comisión uso ATM en el exterior con débito en peso', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMEOB', N'Comisión uso ATM otros bancos', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMEOBCC', N'Comisión uso ATM otros bancos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMEOR', N'Comisión uso ATM otras redes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMEORCC', N'Comisión uso ATM otras redes', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMLINKCA', N'Compensación Red Link CA.', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMLINKCC', N'Compensación Red Link CC.', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMTADIC', N'Comisión por tarjeta adicional', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMTADICC', N'Comisión por tarjeta adicional', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMTRATM', N'Comisión por transferencia ATM', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMTRATMC', N'Comisión por transferencia ATM', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMTREP', N'Comisión Reposición de Tarjeta de Débito', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMTREPCC', N'Comisión Reposición Tarjeta Débito', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMTRHB', N'Comisión por transferencia Home Banking', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOMTRHBCC', N'Comisión transferencia HB', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOREPTDCA', N'Comisión Reposición de Tarjeta de Débito en CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LCOREPTDCC', N'Comisión Reposición de Tarjeta de Débito en CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LDEBOP', N'Débito Op. Pendientes Activas', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LDEBOPCC', N'Debito Op.Pendientes CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LDEVIVACA', N'Reintegro Ley de Solidaridad Social N° 27.541', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LDEVIVACC', N'Reintegro Ley de Solidaridad Social N° 27.541', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LF30100', N'Debito por transf. interb. de CC$ DEBIN', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LF31100', N'Debito por transf. interb. de CA$ DEBIN', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LF31500', N'Debito por transf. interb. de CA u$s DEBIN', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LF40001', N'Orden de Acred. por transf. interb. a CC$ DEBIN', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LF40011', N'Orden de Acred. por transf. interb. a CA$ DEBIN', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LF40015', N'Orden de Acred. por transf. interb. a CA u$s DEBIN', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMAVIM', N'Liquidación a Comercios Prisma en CA  - CRD', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMCA', N'Liquidación a Comercios en Caja de Ahorro - Master', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMCAVI', N'Liquidación a Comercios en Caja de Ahorro - Prisma', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMCC', N'Liquidación a Comercios en Cuenta Corriente- Maste', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMCCAM', N'Liquidación a Comercios MASTERCARD en CA Manual', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMCCVI', N'Liquidación a Comercios en Cuenta Corriente- Prism', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMCVIM', N'Liquidación a Comercios Prisma en CC  - CRD', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMDEB', N'Liquidación a Comercios-MASTERCARD - DEB', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMDEVI', N'Liquidación a Comercios-Prisma - DEB', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMLPCA', N'Liquidación a Comercios Link Pagos - BE - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMLPCC', N'Liquidación a Comercios Link Pagos - BE - CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMMADB', N'Liquidación a Comercios-MASTERCARD - DEB', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMMCM', N'Liquidación a Comercios MASTERCARD en CC Manual', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LIQCOMVIDB', N'Liquidación a Comercios Prisma en CA  - DEB', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRA190100', N'Devolución de pago con lectura de código QR CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRA191100', N'Devolución de pago con lectura de código QR (Débit', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRA290001', N'Devolución de pago con lectura de código QR (Crédi', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRA290011', N'Devolución de pago con lectura de código QR (Crédi', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRCF40001', N'Venta con Transferencia', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRCF40011', N'Venta con Transferencia', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRDF30100', N'Devolución de Pago con Transferencia', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRDF31100', N'Devolución de Pago con Transferencia', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRDF40001', N'Devolución de Pago con Transferencia', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRDF40011', N'Devolución de Pago con Transferencia', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRI190100', N' Distribución de tasa de intercambio (Débito) CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRI191100', N'Distribución de tasa de intercambio (Débito) CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRI290001', N'Distribución de tasa de intercambio (Crédito) CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRI290011', N'Distribución de tasa de intercambio (Crédito) CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRP190100', N'Pago con lectura de código QR (Débito) CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRP191100', N'Pago con lectura de código QR (Débito) CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRP290001', N'Pago con lectura de código QR (Crédito) CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRP290011', N'Pago con lectura de código QR (Crédito) CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRPF30100', N'Pago con Transferencia', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LQRPF31100', N'Pago con Transferencia', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LRMB190100', N'Orden de Debito TRansf. inmediata RedMob CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LRMB191100', N'Orden de Debito Transf. Inmediata RedMob CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LRMB290001', N'Orden de Credito Transf. inmediata RedMob CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LRMB290011', N'Orden de Credito Transf. inmediata RedMob CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LVAL190100', N'Orden de débito  transf inmediata vale CC$', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LVAL191100', N'Orden de débito  transf inmediata vale CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LVAL290001', N'Orden de crédito transf inmediata vale CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'LVAL290011', N'Orden de crédito transf inmediata vale CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MANCTA', N'Comisión por Servicio de Cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MANCTACC', N'Comisión por Servicio de Cuenta', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MANCTACIVA', N'Comisión por Servicio de Cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MANCTADOL', N'Comisión por Servicio de Cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MANCTAM', N'Comisión por Servicio de Cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MANCTAMCC', N'Comisión por Servicio de Cuenta', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MANCTAMCE', N'Comisión por Servicio de Cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODOBONICA', N'Bonificación MODO', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODOBONICC', N'Bonificación MODO', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODOCRCCDT', N'Crédito CC por transferencia MODO - Distinta titul', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODOCRCCMT', N'Crédito CC por transferencia MODO - Misma titulari', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODOCREDT', N'Crédito por transferencia MODO - Distinta titulari', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODOCREMT', N'Crédito por transferencia MODO - Misma titularidad', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODODEBDT', N'Debito por transferencia MODO - Distinta titularid', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODODEBMT', N'Debito por transferencia MODO - Misma titularidad', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODODECCDT', N'Debito CC por transferencia MODO - Distinta titula', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MODODECCMT', N'Debito CC por transferencia MODO - Misma titularid', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MRENAUT', N'Modificación Ren. Aut. Plazo Fijo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'MULTARZOCH', N'Multa por Cheque Rechazado', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'NCREDITO', N'Créditos Varios', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'NDEBITO', N'Débitos Varios', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ODDCA', N'Orden de Débito Directo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ODDCC', N'Orden de Débito Directo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ORDDEB', N'Órden de Débito', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ORDDEBCC', N'Órden de Débito', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ORDDEBREV', N'Reversión Órden de Débito', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'ORDEBREVCC', N'Reversión Órden de Débito', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PACOMCRECA', N'Pago a Comercios Credibica CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PACOMCRECC', N'Pago a Comercios Credibica CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGCH', N'Pago de cheque', N'D', N'CC')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGCHC', N'Pago Cheque de Cámara', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGCHCI', N'Pago de cheque', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGCHQC', N'Pago Cheque de Cámara ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGCHQRZO', N'Presentación Cheques Rechazados', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGCPFC', N'Pago de Certificado de Plazo Fijo - Cámara', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGINFBOLE', N'Débito Informes Boletín Oficial', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGOCRECA', N'Pago de Crédito en C. Ahorro', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGOCRECC', N'Pago de Crédito en Cta. Cte.', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGOPF', N'Pago Plazo fijo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PAGOPFJUD', N'Pago Plazo fijo - Oficio Judicial', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PASEGES', N'Cancelación por Pase a Gestión', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PECPRAEXCA', N'Perc.imp.sobre compras en el exterior CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PECPRAEXCC', N'Perc.imp.sobre compras en el exterior CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PERC4815CA', N'Percepción 35% RG 4815/2020', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PERC4815CC', N'Percepción 35% RG 4815/2020', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PERCEPCA', N'PERCEPCION - CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PERCEPCC', N'PERCEPCION - CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PERCEPCCA', N'PERCEPCION DEV.- CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PERCEPCCC', N'PERCEPCION DEV.- CC', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFDEBCTA', N'Débito en cuenta Plazo Fijo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFDSELLA', N'Descuento Sellado', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT', N'Interés - Tasa Fija Instransferible', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_5526', N'Interés - Tasa Fija Instransferible', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_6871', N'Interés - Tasa Fija Pre-cancelable (UVA)', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_BE', N'Interés - Tasa Fija Instransferible', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_CANC', N'Interés - Sector Público - Tasa Fija cancelación', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_CAPR', N'Interés - Sector Privado - Tasa Fija cancelacion', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_CER', N'Interés - Ajustable CER', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_CERH', N'Interés variable CER', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_CUVA', N'Interés - Tasa Fija cancelación - UVA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_EV', N'Interés - Tasa Fija', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_EVD', N'Interés variable', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_EVDV', N'Devengamiento int. EV', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_EVH', N'Interés Ajustable', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_PER', N'Interés Pago Periódico', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_PREC', N'Interés - Sector Público - Tasa Fija Pre-cancelabl', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_PRI', N'Interés - Sector Privado - Tasa Fija Pre-cancelabl', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT_TRAN', N'Interés - Tasa Fija Transferible', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINT6871V', N'Interés - Tasa Fija Pre', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINTM', N'Diferencia de Intereses', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFINTMCC', N'Diferencia de Intereses', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFSELLA', N'Sellados Plazo Fijo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF', N'Intransferible - Tasa Fija', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_5526', N'Intransferible - Tasa Fija - Com. A 5526', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_6667', N'Intransferible - Tasa Fija', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_6871', N'Intransferible -Tasa Fija- Opción Cancelación Anti', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_6871H', N'Interés variable - Cláusula de aplicación CER', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_6871T', N'Transferible -Tasa Fija- Opción Cancelación Antici', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_6871V', N'Intransferible-Plazo Fijo UVA-Actualizable CER', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_BE', N'Intransferible - Tasa Fija  ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_CER', N'Intransferible - Ajustable - Cláusula de aplicació', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_EV', N'Intransferible - Ajustable - Cláusula de aplicació', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_EV_A', N'Intransferible - Ajustable - Cláusula de aplicació', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_PER', N'Intransferible - Tasa Fija - Pago Periódico de Int', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_PREC', N'Intransferible - Tasa Fija - Opción Cancelación An', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_PRI', N'Intransferible - Tasa Fija - Opción Cancelación An', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_PRIT', N'Transferible - Tasa Fija - Opción Cancelación Anti', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_R6871', N'Retiro Anticipado Plazo Fijo - UVA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_RET', N'Retiro Anticipado Plazo Fijo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_RETPR', N'Retiro Anticipado Plazo Fijo - Privados', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PFTF_TRAN', N'Transferible - Tasa Fija', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PGOCHEQ', N'Pago de Cheques en efectivo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PGOCHEQMST', N'Pago de Cheques Mostrador en efectivo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PGOPFTR', N'Pago Plazo Fijo Transferible', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PRCRTDCAOT', N'Bonificacion compra Tarjeta Débito promoción CA - ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PRCRTDCCOT', N'Bonificación compra Tarjeta Débito promoción CC - ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PRDBTDCCOT', N'Débito por Devolución Prom.TD.Otr.Inst', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PREFINON', N'Prefinanciación emisión ON', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PROMCRTDCA', N'Bonificación compra Tarjeta Débito promoción CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PROMCRTDCC', N'Bonificación compra Tarjeta Débito promoción CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PSPACRECA', N'PSP  Creditos CA Automático', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PSPACRECC', N'PSP  Creditos CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PSPADEBCA', N'PSP  Debitos CA Automático', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'PSPADEBCC', N'PSP  Debitos CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECGASCOEL', N'Recupero de Gastos COELSA', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECGASXN', N'Recupero de Gastos X Nativa', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECGTOGTIA', N'Comisión Otorgamiento de la Garantía', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECGTOSAV', N'Recupero de Gastos Cheque Rechazado SAV', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECGTOSAVC', N'Recupero de Gastos Cheque Rechazado SAV', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECINCOMCA', N'Reconocimiento Intereses Compensatorios', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECINTCOM', N'Reconocimiento Intereses Compensatorios', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECTRBILL', N'Recupero Costo Traslado de Billetes', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RECTRBILLC', N'Recupero Costo Traslado de Billetes', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'REDMOBCA', N'Comisión Servicio REDMOBCA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'REDMOBCAD', N'REcupero de Gastos RedMob CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'REDMOBCAF', N'Comisión Fija Servicio REDMOBCA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'REDMOBCC', N'Comisión Servicio REDMOBCC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'REDMOBCCD', N'Recupero de Gastos RedMob CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'REDMOBCCF', N'Comisión Fija Servicio REDMOBCC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'REINTMINPR', N'Reintegro Intereses Ministerio de la Producción', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RENCOBTER', N'Rendición cobros por cuenta de Terceros', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RENCOBTERM', N'Rendición cobros por cuenta de Terceros', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RENRECAFIP', N'RENDICIÓN RECAUDACION AFIP', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RESCVALCA', N'Por Rescate de Valores en CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RESCVALCC', N'Rescate de Valores - CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RESTFOPCAM', N'Restitucion de fondos para Operatoria de Cambio', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RESVFOPCAM', N'Reserva de fondos para operatoria de cambio', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RETRIAFIPB', N'RETRIBUCIÓN SERVICIO RECAUDACION AFIP', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RETRIAFIPC', N'RETRIBUCIÓN SERVICIO RECAUDACION AFIP', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RGROCOGCCA', N'Reintegro Comisión por Gestión de Cobro Cheques Ot', N'H', N'CA')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RGROCOTRCA', N'Reintegro Comisión por Transferencias', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RGTOSAVCA', N'RECUPERO DE GTOS SAV - CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RGTOSAVCC', N'RECUPERO DE GTOS SAV - CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RODDCC', N'Reversa Orden de Débito Directo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RTGCOM24', N'Reintegro comisiones créditos al 24%', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RTGROCOMGC', N'Reintegro Comisión por Gestión de Cobro Cheques Ot', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RTGROCOTCC', N'Reintegro Comisión por Transferencias ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCH', N'Rechazo Cheque ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHC', N'Rechazo de Cheque de Cámara ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHCA', N'Rechazo Cheque Canje Interno', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHCC', N'Rechazo Cheque  Canje Interno', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHOBCA', N'Rechazo Cheque Otros Bcos CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHOBCC', N'Rechazo Cheque Otros Bcos CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHQCD', N'Rechazo de Cheque Cámara - De Depositaria', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHQCG', N'Rechazo de Cheque Cámara - De Girada', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHQDECI', N'Rechazo de Cheque Canje Interno - Dep del Chq', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHQEMCI', N'Rechazo de Cheque Canje Interno - Emisor del Chq', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHSAV', N'Rechazo Cheque SAV ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOCHSAVCA', N'Rechazo Cheque SAV ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOPFOBCA', N'Rechazo PF Otros Bcos CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOPFOBCC', N'Rechazo PF Otros Bcos CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'RZOPFOBPF', N'Rechazo Plazo Fijo en Cuenta Plazo Fijo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SDOINM', N'Pase saldos Inmovilizados', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SDOINMCC', N'Pase saldos Inmovilizados', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SEGAP', N'Seguro por Accidentes Personales', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SEGAPCC', N'Seguro por Accidentes Personales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SEGAPCCACR', N'Seguro por Accidentes Personales', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SEGAPCRE', N'Seguro por Accidentes Personales', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SEGSDODEU', N'Cargo seguro de vida Saldo Deudor', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SELLACU', N'Sellados Acuerdos', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SELLATRA', N'Sellados Transferencias', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SELLATRACC', N'Sellados Transferencias', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SELLCHQR', N'Sellados Entrega Chequera', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SELLGTIA', N'Sellados Garantías Otorgadas', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SELLINTCA', N'Sello sobre Interes en Caja de Ahorro', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SELLINTCC', N'Sello sobre Interes en Cuenta Corriente', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SELLSOBG', N'Sellados Descubierto', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'sellsolav', N'Sellado Solicitud Avales', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SIRCREB', N'SIRCREB', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SIRCREBCC', N'SIRCREB - CUENTA CORRIENTE', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SIRCREBDEI', N'SIRCREB - Devolución', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SIRCREBDEV', N'SIRCREB - Devolución', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SIRCREBDV', N'SIRCREB - Devolución', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SIRCREBDVI', N'SIRCREB - Devolución', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SRESCFCICA', N'Solicitud de Rescate a FCI en CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SRESCFCICC', N'Solicitud de Rescate a FCI en CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SSUSCFCICA', N'Solicitud de Suscripcion a FCI en CA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SSUSCFCICC', N'Solicitud de Suscripcion a FCI en CC', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SUPRICOM', N'Comisión por Suscripción Primaria', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SUPRICOMCA', N'Comisión por suscripción primaria', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SUSPRIDBCA', N'Débito por Suscripción Primaria', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'SUSPRIDBCC', N'Débito por Suscripción Primaria', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIFCA', N'Impuesto Débito', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIFCC', N'Impuesto Débito', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIFCRECA', N'Impuesto Crédito', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIFCRECC', N'Impuesto Crédito', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIFDEVCA', N'Impuesto Débito', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIFDEVCC', N'Impuesto Débito', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIFDVCRECA', N'Impuesto Crédito', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIFDVCRECC', N'Impuesto Crédito', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_AMORT', N'Títulos - Amortización', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_DEP', N'Titulos – Depósito', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_EXT', N'Titulos – Extracción', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_PF', N'Títulos Valores Públicos Nacionales - Intransferib', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_PFDEB', N'Titulos – Débito en cuenta', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_PFINT', N'Titulos – Estimulo', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_RENTA', N'Titulos – Renta', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_SELLA', N'Títulos - Débito Sellados ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TIT_SELLAH', N'Títulos - Acreditación Sellados', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TR27260_41', N'Transferencia entre cuentas propias Bica - Ley 272', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TR27260_44', N'Transferencia Otro Cliente Bica - Ley 27260 Art 44', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TR2726038', N'Transferencia Ley 27260 Art 38 C', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TR2726042B', N'Transferencia Ley 27260 Art 42 B', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANBANBC', N'Transferencia a Clientes', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANCAOCLI', N'Transferencia a Cuenta de Otro Cliente BICA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANCAPRO', N'Transferencia entre Cuentas Propias BICA', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANCCOCLI', N'Transf. de CC a cuenta de otro Cliente BICA', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANCCPRO', N'Transf. de CC a otra cuenta propia BICA', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANMEPCA', N'Transferencias vía MEP', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANMEPFCI', N'Transferencias vía MEP – FCI', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANPF', N'Transferencia a cuenta de origen por vencimiento p', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANPF6667', N'Transferencia para constitución Plazo Fijo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANPFOF', N'Trasferencia entre cuentas propias por pago de Pla', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANSFPF', N'Transferencia para constitución Plazo Fijo', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANSFPFCC', N'Transferencia para constitución Plazo Fijo', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANSFPFM', N'Transferencia para Constitución de Plazo Fijo  (BO', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRANSMEP', N'Transferencias vía MEP', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECI6667', N'Acreditación de Plazo Fijo debitado en cuenta', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECICAOCL', N'Transf. recibida de otra cuenta Bica - Otro Client', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECICAPF', N'Transf. recibida de otra Cta. propia para Const. P', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECICAPRO', N'Transf. recibida de otra Cta. propia Bica', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECICCOCL', N'Trans recibida de cuenta  Bica - Otro Cliente', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECICCPRO', N'Transf. recibida de otra Cta. de Bica - Propia', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECIPFCA', N'Acreditación de Plazo Fijo debitado en cuenta', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECIPFCC', N'Acreditación de Plazo Fijo debitado en cuenta', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRECPF6667', N'Acreditación de Plazo Fijo para Transferencia Cred', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRF2726041', N'Transferencia Ley 27260 Art 41', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRF2726042', N'Transferencia Ley 27260 Art 42 A', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRF2726044', N'Transferencia Ley 27260 Art 44', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRFCREDIN', N'Credin a cuenta de origen por vencimiento plazo fi', N'D', N'CC')
GO
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRFECHEQ', N'Transferencia CREDIN por Compra E-CHEQ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJAJRENAC', N'Ajuste cargos por renov. anual tarjetas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJAJURENA', N'Ajuste cargos por renov. anual tarjetas ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJCGOSDOC', N'Ajuste cargo s. vida sdo. deudor tarjetas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJCGOSDOD', N'Ajuste cargo s. vida sdo. deudor tarjetas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJCOMCTAC', N'Ajuste comis. mant. de cuenta tarjetas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJCOMMCTA', N'Ajuste comis. mant. de cuenta tarjetas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJIMPSELC', N'Ajuste impuesto de sellos tarjetas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJIMPSELL', N'Ajuste impuesto de sellos tarjetas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJINTFIN', N'Ajuste int. financieros tarjetas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJINTFINC', N'Ajuste int. financieros tarjetas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJINTPUNC', N'Ajuste int. punitorios tarjetas ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJINTPUNI', N'Ajuste int. punitorios tarjetas ', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJIVA21', N'Ajuste IVA 21% tarjetas', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRJIVA21C', N'Ajuste IVA 21% tarjetas', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRMEP', N'Transferencia MEP Recibida', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRMEPCAFCI', N'Transferencias vía MEP – FCI', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRMEPCC', N'Transferencia MEP Recibida', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRPFCC6667', N'Transf. a Cta. para envío de Fondos por Credin', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRPPCCCRED', N'Transferencia CREDIN por Pago a Proveedores Online', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRPROOBCC', N'Transferencias Inmediatas IB-ES', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRPROOBI', N'Transferencias Inmediatas IB-ES', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRPROOBM', N'Transferencia entre Cuentas Propias Otro Banco', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRPROOBMCC', N'Transferencia entre Cuentas Propias Otro Banco', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRREJECCAM', N'Transferencia Rejectada por Cámara ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSIN', N'Transferencia SINAPA Recibida', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINAPA', N'Transferencias vía SINAPA ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINAPAR', N'Rechazo Transferencias vía SINAPA ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINAPARJ', N'Reject Transferencias vía SINAPA ', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINAPCA', N'Transferencias vía SINAPA ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINAPCAR', N'Rechazo Transferencias vía SINAPA - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINAPCRJ', N'RejectTransferencias vía SINAPA - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCA', N'Transferencia SINAPA Recibida - CA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCA315', N'Dto. 315/20 Gob. Nac.', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCAASI', N'Anses SIPA', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCAASU', N'Anses SUAF/UVHI', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCAATP', N'ATP-Aporte del Gobierno Nacional', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCAG', N'Transferencia SINAPA Recibida - CA Gravada', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCC', N'Transferencia SINAPA Recibida - CC', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCC315', N'Dto. 315/20 Gob. Nac.', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCCASI', N'Anses SIPA', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCCASU', N'Anses  SUAF/UVHI', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCCATP', N'ATP-Aporte del Gobierno Nacional', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINCCG', N'Transferencia SINAPA Recibida - CC Gravada', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'TRSINMCC', N'Transferencia SINAPA Recibida', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'UNDERW', N'UNDERWRITING', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'VCSAV', N'Acreditación por administración de Valores al Cobr', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'VCSAVCC', N'Acreditación en CC por administración de Valores a', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'VTACHCANCA', N'Venta Cheque Cancelatorio ', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'VTACHCANCC', N'Venta Cheque Cancelatorio ', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W400115', N'Débito Transferencia de CC$ a CA U$S', N'D', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W400115C', N'Crédito Transferencia de CC$ a CA U$S', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W401115', N'Débito Transferencia de CA$ a CA U$S', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W401115C', N'Crédito Transferencia de CA$ a CA U$S', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W401501', N'Débito Transferencia de CAU$S a CC$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W401501C', N'Crédito Transferencia de CAU$S a CC$', N'H', N'CC')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W401511', N'Débito Transferencia de CAU$S a CA$', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W401511C', N'Crédito Transferencia de CAU$S a CA$', N'H', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W401515', N'Débito Transferencia de CA U$S a CA U$S', N'D', N'CA')
INSERT [dbo].[CodMovimientos] ([Codigo], [Descripcion], [TipoMovimiento], [Producto]) VALUES (N'W401515C', N'Crédito Transferencia de CA U$S a CA U$S', N'H', N'CA')
GO
ALTER TABLE [dbo].[AMVMovimientos] ADD  CONSTRAINT [DF_AMVMovimientos_estado]  DEFAULT ('') FOR [estado]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarMovimiento]    Script Date: 9/06/2023 05:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarMovimiento]
	@nID int,
	@cEstado char(1)    --*** Qué va aquí??
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	update AMVMovimientos SET estado = @cEstado where id=@nID 
END
GO
/****** Object:  StoredProcedure [dbo].[GuardarMovimiento]    Script Date: 9/06/2023 05:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GuardarMovimiento]
	@cuit bigint,
	@Cuenta bigint,
	@CodMov Varchar(40),
	@TipoMov Char(1),
	@Numero bigint,
	@Fecha datetime,
	@Importe Decimal(16,4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	insert into AMVMovimientos (cuit, NumeroCuenta, CodigoMovimiento, TipoMovimiento, NumeroMovimiento, FechaMovimiento, Importe) 
		values (@cuit, @Cuenta, @CodMov, @TipoMov, @Numero, @Fecha, @Importe)
END
GO
/****** Object:  StoredProcedure [dbo].[GuardarSaldo]    Script Date: 9/06/2023 05:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mario Andres Ageno
-- Create date: 20/05/2023
-- Description:	Actualizar saldo de Ahorro Mutual Variable 
-- =============================================
CREATE PROCEDURE [dbo].[GuardarSaldo]
	@Cuenta bigint,
	@saldo Decimal(16,4)
AS
BEGIN
	SET NOCOUNT ON;

	begin 
		UPDATE AMVSaldos Set saldo=@saldo, fecha=GETDATE(), modificado=1 where cuenta=@Cuenta
		if @@ROWCOUNT  = 0         -- Si no existe el registro en la tabla de Saldos lo agrego
			begin 
				insert into AMVSaldos (Cuenta, Saldo, Fecha, Modificado) 
					values (@Cuenta, @saldo, getdate(), 1)
			end 
	end 

END
GO
/****** Object:  StoredProcedure [dbo].[LeerMovimiento]    Script Date: 9/06/2023 05:48:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LeerMovimiento]
	@nSuc int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM verMovimientos WHERE cast(NumeroCuenta/1000000 as int)=@nSuc and estado = ' ' 
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "AMVMovimientos"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 242
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CodMovimientos"
            Begin Extent = 
               Top = 6
               Left = 284
               Bottom = 136
               Right = 492
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1755
         Width = 2685
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'verMovimientos'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'verMovimientos'
GO
USE [master]
GO
ALTER DATABASE [BICAMutual] SET  READ_WRITE 
GO
