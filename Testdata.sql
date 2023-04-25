/****** Object:  Table [dbo].[Kunde]    Script Date: 25.04.2023 11:33:58 ******/
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
/****** Object:  Table [dbo].[Mitarbeiter]    Script Date: 25.04.2023 11:33:58 ******/
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
/****** Object:  Table [dbo].[Produkt]    Script Date: 25.04.2023 11:33:58 ******/
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
/****** Object:  Table [dbo].[Umsatz]    Script Date: 25.04.2023 11:33:58 ******/
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
