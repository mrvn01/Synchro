/****** Object:  Database [TestStaging]    Script Date: 25.04.2023 11:33:17 ******/
CREATE DATABASE [TestStaging]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Test_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE Latin1_General_CI_AS
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestStaging].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestStaging] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestStaging] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestStaging] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestStaging] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestStaging] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestStaging] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestStaging] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestStaging] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestStaging] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestStaging] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestStaging] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestStaging] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestStaging] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestStaging] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestStaging] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestStaging] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestStaging] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestStaging] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestStaging] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestStaging] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestStaging] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestStaging] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestStaging] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestStaging] SET  MULTI_USER 
GO
ALTER DATABASE [TestStaging] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestStaging] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestStaging] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestStaging] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestStaging] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestStaging] SET QUERY_STORE = OFF
GO
ALTER DATABASE [TestStaging] SET  READ_WRITE 
GO
/****** Object:  Database [TestStaging]    Script Date: 25.04.2023 11:33:17 ******/
CREATE DATABASE [TestStaging]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Test', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Test.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Test_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Test_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 COLLATE Latin1_General_CI_AS
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestStaging].[dbo].[sp_fulltext_database] @action = 'enable'
end
ALTER DATABASE [TestStaging] SET ANSI_NULL_DEFAULT OFF 
ALTER DATABASE [TestStaging] SET ANSI_NULLS OFF 
ALTER DATABASE [TestStaging] SET ANSI_PADDING OFF 
ALTER DATABASE [TestStaging] SET ANSI_WARNINGS OFF 
ALTER DATABASE [TestStaging] SET ARITHABORT OFF 
ALTER DATABASE [TestStaging] SET AUTO_CLOSE OFF 
ALTER DATABASE [TestStaging] SET AUTO_SHRINK OFF 
ALTER DATABASE [TestStaging] SET AUTO_UPDATE_STATISTICS ON 
ALTER DATABASE [TestStaging] SET CURSOR_CLOSE_ON_COMMIT OFF 
ALTER DATABASE [TestStaging] SET CURSOR_DEFAULT  GLOBAL 
ALTER DATABASE [TestStaging] SET CONCAT_NULL_YIELDS_NULL OFF 
ALTER DATABASE [TestStaging] SET NUMERIC_ROUNDABORT OFF 
ALTER DATABASE [TestStaging] SET QUOTED_IDENTIFIER OFF 
ALTER DATABASE [TestStaging] SET RECURSIVE_TRIGGERS OFF 
ALTER DATABASE [TestStaging] SET  DISABLE_BROKER 
ALTER DATABASE [TestStaging] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
ALTER DATABASE [TestStaging] SET DATE_CORRELATION_OPTIMIZATION OFF 
ALTER DATABASE [TestStaging] SET TRUSTWORTHY OFF 
ALTER DATABASE [TestStaging] SET ALLOW_SNAPSHOT_ISOLATION OFF 
ALTER DATABASE [TestStaging] SET PARAMETERIZATION SIMPLE 
ALTER DATABASE [TestStaging] SET READ_COMMITTED_SNAPSHOT OFF 
ALTER DATABASE [TestStaging] SET HONOR_BROKER_PRIORITY OFF 
ALTER DATABASE [TestStaging] SET RECOVERY SIMPLE 
ALTER DATABASE [TestStaging] SET  MULTI_USER 
ALTER DATABASE [TestStaging] SET PAGE_VERIFY CHECKSUM  
ALTER DATABASE [TestStaging] SET DB_CHAINING OFF 
ALTER DATABASE [TestStaging] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
ALTER DATABASE [TestStaging] SET TARGET_RECOVERY_TIME = 60 SECONDS 
ALTER DATABASE [TestStaging] SET DELAYED_DURABILITY = DISABLED 
ALTER DATABASE [TestStaging] SET QUERY_STORE = OFF
ALTER DATABASE [TestStaging] SET  READ_WRITE 
/****** Object:  Table [dbo].[Kunde]    Script Date: 25.04.2023 11:33:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kunde](
	[KundenID] [int] NOT NULL,
	[Vorname] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Nachname] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Email] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[Telefonnummer] [varchar](20) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Mitarbeiter]    Script Date: 25.04.2023 11:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mitarbeiter](
	[MitarbeiterID] [int] NOT NULL,
	[Vorname] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Nachname] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Position] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Gehalt] [decimal](10, 2) NULL,
	[Geburtsdatum] [date] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Produkt]    Script Date: 25.04.2023 11:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produkt](
	[ProduktID] [int] NOT NULL,
	[Produktname] [varchar](100) COLLATE Latin1_General_CI_AS NULL,
	[Kategorie] [varchar](50) COLLATE Latin1_General_CI_AS NULL,
	[Preis] [decimal](10, 2) NULL,
	[Bestand] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Umsatz]    Script Date: 25.04.2023 11:33:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Umsatz](
	[UmsatzID] [int] NOT NULL,
	[Menge] [int] NULL,
	[Gesamtsumme] [decimal](10, 2) NULL,
	[Verkaufsdatum] [date] NULL
) ON [PRIMARY]

GO
INSERT [dbo].[Kunde] ([KundenID], [Vorname], [Nachname], [Email], [Telefonnummer]) VALUES (1, N'John', N'Doe', N'johndoe@example.com', N'555-1234')
GO
INSERT [dbo].[Kunde] ([KundenID], [Vorname], [Nachname], [Email], [Telefonnummer]) VALUES (2, N'Jane', N'Smith', N'janesmith@example.com', N'555-5678')
GO
INSERT [dbo].[Kunde] ([KundenID], [Vorname], [Nachname], [Email], [Telefonnummer]) VALUES (3, N'Bob', N'Johnson', N'bobjohnson@example.com', N'555-9012')
GO
INSERT [dbo].[Kunde] ([KundenID], [Vorname], [Nachname], [Email], [Telefonnummer]) VALUES (4, N'Alice', N'Williams', N'alicewilliams@example.com', N'555-3456')
GO
INSERT [dbo].[Kunde] ([KundenID], [Vorname], [Nachname], [Email], [Telefonnummer]) VALUES (5, N'Mike', N'Brown', N'mikebrown@example.com', N'555-7890')
GO
INSERT [dbo].[Produkt] ([ProduktID], [Produktname], [Kategorie], [Preis], [Bestand]) VALUES (1, N'Widget', N'Elektronik', CAST(9.99 AS Decimal(10, 2)), 100)
GO
INSERT [dbo].[Produkt] ([ProduktID], [Produktname], [Kategorie], [Preis], [Bestand]) VALUES (2, N'Gizmo', N'Elektronik', CAST(19.99 AS Decimal(10, 2)), 50)
GO
INSERT [dbo].[Produkt] ([ProduktID], [Produktname], [Kategorie], [Preis], [Bestand]) VALUES (3, N'Thingamajig', N'Haushaltswaren', CAST(4.99 AS Decimal(10, 2)), 200)
GO
INSERT [dbo].[Produkt] ([ProduktID], [Produktname], [Kategorie], [Preis], [Bestand]) VALUES (4, N'Doodad', N'Haushaltswaren', CAST(7.99 AS Decimal(10, 2)), 150)
GO
INSERT [dbo].[Produkt] ([ProduktID], [Produktname], [Kategorie], [Preis], [Bestand]) VALUES (5, N'Doohickey', N'Werkzeug', CAST(14.99 AS Decimal(10, 2)), 75)
GO
