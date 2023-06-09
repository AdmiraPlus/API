USE [master]
GO

/****** Object:  Database [BICAMutual]    Script Date: 23/05/2023 19:22:30 ******/
CREATE DATABASE [BICAMutual]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BICAMutual', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\BICAMutual.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BICAMutual_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\BICAMutual_log.ldf' , SIZE = 1280KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
ALTER DATABASE [BICAMutual] SET DISABLE_BROKER 
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
ALTER DATABASE [BICAMutual] SET MULTI_USER 
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

USE [BICAMutual]
GO


/****** Object:  Table [dbo].[AMVMovimientos]    Script Date: 23/05/2023 19:22:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
	[estado] [char](1) NOT NULL CONSTRAINT [DF_AMVMovimientos_estado]  DEFAULT (''),  --*** Qué va aquí??
 CONSTRAINT [PK_AMVMovimientos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO


/****** Object:  Table [dbo].[AMVSaldos]    Script Date: 23/05/2023 19:22:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AMVSaldos](
	[cuenta] [bigint] NOT NULL,
	[saldo] [numeric](18, 2) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[modificado] [bit] NOT NULL,   --*** Qué va aquí??  (En el SP veo que siempre (UPDATE & INSERT) se agrega 1)
 CONSTRAINT [PK_AMVSaldos] PRIMARY KEY CLUSTERED 
(
	[cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[CodMovimientos]    Script Date: 23/05/2023 19:22:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CodMovimientos](
	[Codigo] [varchar](40) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[TipoMovimiento] [char](1) NOT NULL,
	[Producto] [char](2) NOT NULL,     --*** Qué va aquí??
 CONSTRAINT [PK_Hoja1$] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO





/****** Object:  View [dbo].[verMovimientos]    Script Date: 23/05/2023 19:22:30 ******/
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





/****** Object:  StoredProcedure [dbo].[ActualizarMovimiento]    Script Date: 23/05/2023 19:22:30 ******/
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


/****** Object:  StoredProcedure [dbo].[GuardarMovimiento]    Script Date: 23/05/2023 19:22:30 ******/
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


/****** Object:  StoredProcedure [dbo].[GuardarSaldo]    Script Date: 23/05/2023 19:22:30 ******/
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


/****** Object:  StoredProcedure [dbo].[LeerMovimiento]    Script Date: 23/05/2023 19:22:30 ******/
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
