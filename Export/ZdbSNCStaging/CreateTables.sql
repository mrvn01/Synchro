SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000003_Payment_Terms]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000003_Payment_Terms](
	[Code] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000003_Payment_Terms] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000004_Currency]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000004_Currency](
	[Code] [nvarchar](10) NOT NULL,
	[ISO Code] [nvarchar](3) NULL,
	[Description] [nvarchar](30) NULL,
	[Symbol] [nvarchar](10) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000004_Currency] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000008_Language]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000008_Language](
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000008_Language] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000009_Country_Region]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000009_Country_Region](
	[Name] [nvarchar](100) NULL,
	[Code] [nvarchar](10) NOT NULL,
	[EU Country_Region Code] [nvarchar](10) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000009_Country_Region] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000010_Shipment_Method]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000010_Shipment_Method](
	[Code] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000010_Shipment_Method] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000013_Salesperson_Purchaser]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000013_Salesperson_Purchaser](
	[Name] [nvarchar](50) NULL,
	[Code] [nvarchar](20) NOT NULL,
	[Global Dimension 1 Code] [nvarchar](20) NULL,
	[Global Dimension 2 Code] [nvarchar](20) NULL,
	[Job Title] [nvarchar](30) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000013_Salesperson_Purchaser] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000018_Customer]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000018_Customer](
	[Name] [nvarchar](100) NULL,
	[Name 2] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[Address 2] [nvarchar](50) NULL,
	[City] [nvarchar](30) NULL,
	[Country_Region Code] [nvarchar](10) NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Search Name] [nvarchar](100) NULL,
	[Budgeted Amount] [numeric](38, 20) NULL,
	[Credit Limit (LCY)] [numeric](38, 20) NULL,
	[Customer Posting Group] [nvarchar](20) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Language Code] [nvarchar](10) NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Customer Disc_ Group] [nvarchar](20) NULL,
	[Blocked] [int] NULL,
	[Salesperson Code] [nvarchar](20) NULL,
	[Reminder Terms Code] [nvarchar](10) NULL,
	[Contact] [nvarchar](100) NULL,
	[Primary Contact No_] [nvarchar](20) NULL,
	[Territory Code] [nvarchar](10) NULL,
	[Post Code] [nvarchar](20) NULL,
	[Prepayment _] [numeric](38, 20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Shipment Method Code] [nvarchar](10) NULL,
	[Prices Including VAT] [tinyint] NULL,
	[Cash Flow Payment Terms Code] [nvarchar](10) NULL,
	[Block Payment Tolerance] [tinyint] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000018_Customer] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000023_Vendor]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000023_Vendor](
	[No_] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Search Name] [nvarchar](100) NULL,
	[Name 2] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[Address 2] [nvarchar](50) NULL,
	[City] [nvarchar](30) NULL,
	[Budgeted Amount] [numeric](38, 20) NULL,
	[Vendor Posting Group] [nvarchar](20) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Language Code] [nvarchar](10) NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Country_Region Code] [nvarchar](10) NULL,
	[Blocked] [int] NULL,
	[Purchaser Code] [nvarchar](20) NULL,
	[Contact] [nvarchar](100) NULL,
	[Primary Contact No_] [nvarchar](20) NULL,
	[Territory Code] [nvarchar](10) NULL,
	[Post Code] [nvarchar](20) NULL,
	[Prepayment _] [numeric](38, 20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Shipment Method Code] [nvarchar](10) NULL,
	[Prices Including VAT] [tinyint] NULL,
	[Cash Flow Payment Terms Code] [nvarchar](10) NULL,
	[Block Payment Tolerance] [tinyint] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000023_Vendor] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000027_Item]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000027_Item](
	[No_] [nvarchar](20) NOT NULL,
	[No_ 2] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[Search Description] [nvarchar](100) NULL,
	[Description 2] [nvarchar](50) NULL,
	[Type] [int] NULL,
	[Inventory Posting Group] [nvarchar](20) NULL,
	[Gen_ Prod_ Posting Group] [nvarchar](20) NULL,
	[Base Unit of Measure] [nvarchar](10) NULL,
	[Price Unit Conversion] [int] NULL,
	[Shelf No_] [nvarchar](10) NULL,
	[Unit Price] [numeric](38, 20) NULL,
	[Profit _] [numeric](38, 20) NULL,
	[Costing Method] [int] NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Standard Cost] [numeric](38, 20) NULL,
	[Last Direct Cost] [numeric](38, 20) NULL,
	[Indirect Cost _] [numeric](38, 20) NULL,
	[Vendor No_] [nvarchar](20) NULL,
	[Vendor Item No_] [nvarchar](50) NULL,
	[Reorder Point] [numeric](38, 20) NULL,
	[Maximum Inventory] [numeric](38, 20) NULL,
	[Reorder Quantity] [numeric](38, 20) NULL,
	[Alternative Item No_] [nvarchar](20) NULL,
	[Unit List Price] [numeric](38, 20) NULL,
	[Gross Weight] [numeric](38, 20) NULL,
	[Net Weight] [numeric](38, 20) NULL,
	[Blocked] [tinyint] NULL,
	[Block Reason] [nvarchar](250) NULL,
	[Low-Level Code] [int] NULL,
	[Lot Size] [numeric](38, 20) NULL,
	[Sales Unit of Measure] [nvarchar](10) NULL,
	[Purch_ Unit of Measure] [nvarchar](10) NULL,
	[Manufacturer Code] [nvarchar](10) NULL,
	[Item Category Code] [nvarchar](20) NULL,
	[Unit of Measure Id] [uniqueidentifier] NULL,
	[Common Item No_] [nvarchar](20) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000027_Item] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000079_Company_Information]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000079_Company_Information](
	[Name] [nvarchar](100) NULL,
	[Name 2] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[Address 2] [nvarchar](50) NULL,
	[City] [nvarchar](30) NULL,
	[Phone No_] [nvarchar](30) NULL,
	[Fax No_] [nvarchar](30) NULL,
	[VAT Registration No_] [nvarchar](20) NULL,
	[Post Code] [nvarchar](20) NULL,
	[County] [nvarchar](30) NULL,
	[E-Mail] [nvarchar](80) NULL,
	[Country_Region Code] [nvarchar](10) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
 CONSTRAINT [PK_BC_t0000079_Company_Information] PRIMARY KEY CLUSTERED 
(
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000092_Customer_Posting_Group]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000092_Customer_Posting_Group](
	[Code] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000092_Customer_Posting_Group] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000093_Vendor_Posting_Group]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000093_Vendor_Posting_Group](
	[Code] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000093_Vendor_Posting_Group] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000156_Resource]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000156_Resource](
	[No_] [nvarchar](20) NOT NULL,
	[Type] [int] NULL,
	[Name] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000156_Resource] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000231_Reason_Code]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000231_Reason_Code](
	[Code] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000231_Reason_Code] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000286_Territory]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000286_Territory](
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000286_Territory] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000340_Customer_Discount_Group]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000340_Customer_Discount_Group](
	[Code] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000340_Customer_Discount_Group] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000349_Dimension_Value]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000349_Dimension_Value](
	[Name] [nvarchar](100) NULL,
	[Blocked] [tinyint] NULL,
	[Code] [nvarchar](20) NOT NULL,
	[Dimension Code] [nvarchar](20) NOT NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
 CONSTRAINT [PK_BC_t0000349_Dimension_Value] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[Dimension Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0000480_Dimension_Set_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0000480_Dimension_Set_Entry](
	[Dimension Set ID] [int] NOT NULL,
	[Dimension Code] [nvarchar](20) NOT NULL,
	[Dimension Value Code] [nvarchar](20) NULL,
	[Dimension Value ID] [int] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000480_Dimension_Set_Entry] PRIMARY KEY CLUSTERED 
(
	[Dimension Set ID] ASC,
	[Dimension Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0005401_Item_Variant]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0005401_Item_Variant](
	[Code] [nvarchar](10) NOT NULL,
	[Item No_] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Description 2] [nvarchar](50) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0005401_Item_Variant] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[Item No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0005714_Responsibility_Center]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0005714_Responsibility_Center](
	[Name] [nvarchar](100) NULL,
	[Code] [nvarchar](10) NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0005720_Manufacturer]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0005720_Manufacturer](
	[Code] [nvarchar](20) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0005720_Manufacturer] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[com].[BC_t0005722_Item_Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [com].[BC_t0005722_Item_Category](
	[Code] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0005722_Item_Category] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[control].[SNCt_Aktiver_Mandant]') AND type in (N'U'))
BEGIN
CREATE TABLE [control].[SNCt_Aktiver_Mandant](
	[Bundesland] [nvarchar](50) NOT NULL,
	[Mandant Code] [nvarchar](5) NOT NULL,
	[Mandantname Business Central] [nvarchar](30) NOT NULL,
	[Kostenträger Code] [nvarchar](20) NOT NULL,
	[Kostenstelle Code] [nvarchar](20) NOT NULL,
	[Sortierreihenfolge] [int] NOT NULL,
	[Aktives Kennzeichen Verkauf] [bit] NOT NULL,
	[Aktives Kennzeichen Finanzen] [bit] NOT NULL,
	[Aktives Kennzeichen Einkauf] [bit] NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
	[Vermögensknoten Code] [nvarchar](10) NULL,
	[Verbindlichkeitsknoten Code] [nvarchar](10) NULL,
	[GuV Code] [nvarchar](10) NULL,
	[Schemabezeichnung BWA] [nvarchar](25) NULL,
	[Hauptmandant Kennzeichen] [bit] NOT NULL,
 CONSTRAINT [PK_SNCt_Active_Company] PRIMARY KEY CLUSTERED 
(
	[Mandant Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[control].[SNCt_Altersstruktur]') AND type in (N'U'))
BEGIN
CREATE TABLE [control].[SNCt_Altersstruktur](
	[Altersstruktur Code] [nvarchar](5) NOT NULL,
	[Altersstruktur Start] [int] NULL,
	[Altersstruktur Ende] [int] NULL,
	[Altersstrukturbezeichnung DE] [nvarchar](50) NULL,
	[Altersstrukturbezeichnung EN] [nvarchar](50) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_SNCt_Age_Structure] PRIMARY KEY CLUSTERED 
(
	[Altersstruktur Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[control].[SNCt_Bezeichnung]') AND type in (N'U'))
BEGIN
CREATE TABLE [control].[SNCt_Bezeichnung](
	[Optionsfeld Code] [int] NOT NULL,
	[Tabellen ID] [int] NULL,
	[Tabellenbezeichnung] [nvarchar](50) NOT NULL,
	[Spalte] [nvarchar](50) NOT NULL,
	[Optionsfeldbezeichnung DE] [nvarchar](50) NULL,
	[Optionsfeldbezeichnung EN] [nvarchar](50) NULL,
	[Quelle] [nvarchar](2) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_SNCt_Description] PRIMARY KEY CLUSTERED 
(
	[Optionsfeld Code] ASC,
	[Tabellenbezeichnung] ASC,
	[Spalte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[control].[SNCt_Fälligkeitsklasse]') AND type in (N'U'))
BEGIN
CREATE TABLE [control].[SNCt_Fälligkeitsklasse](
	[Fälligkeitsklasse Code] [nvarchar](5) NOT NULL,
	[Fälligkeitsklasse Start] [int] NULL,
	[Fälligkeitsklasse Ende] [int] NULL,
	[Fälligkeitsklassenbezeichnung DE] [nvarchar](50) NULL,
	[Fälligkeitsklassenbezeichnung EN] [nvarchar](50) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[Fällgkeitskategoriebezeichnung DE] [nvarchar](10) NULL,
	[Fälligkeitskategoriebezeichnung EN] [nvarchar](10) NULL,
 CONSTRAINT [PK_SNCt_Due_Date_Class] PRIMARY KEY CLUSTERED 
(
	[Fälligkeitsklasse Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[control].[SNCt_Kalender]') AND type in (N'U'))
BEGIN
CREATE TABLE [control].[SNCt_Kalender](
	[Datum] [datetime] NOT NULL,
	[Bundesland] [nvarchar](255) NOT NULL,
	[Periode] [datetime] NULL,
	[Datumint] [int] NULL,
	[Datumtext] [nvarchar](255) NULL,
	[Jahr] [int] NULL,
	[Monat] [int] NULL,
	[Monatbezeichnung] [nvarchar](255) NULL,
	[Monatbezeichnungkurz] [nvarchar](255) NULL,
	[Tag] [int] NULL,
	[Wochentag] [int] NULL,
	[Wochentagbezeichnung] [nvarchar](255) NULL,
	[Wochentagbezeichnungkurz] [nvarchar](255) NULL,
	[Kalenderwoche] [int] NULL,
	[Halbjahr] [int] NULL,
	[Quartal] [int] NULL,
	[JahrMonatint] [int] NULL,
	[JahrMonattext] [nvarchar](255) NULL,
	[Tageszaehler] [int] NULL,
	[Jahrwocheint] [int] NULL,
	[Jahrwochetext] [nvarchar](255) NULL,
	[IstFeiertag] [int] NULL,
	[Feiertagsbezeichnung] [nvarchar](255) NULL,
	[IstArbeitstag] [int] NULL,
	[Arbeitstagemonat] [int] NULL,
	[ArbeitstagnrJahr] [int] NULL,
	[Arbeitstagnrmonat] [int] NULL,
	[Faktoranteiltaganjahr] [numeric](18, 10) NULL,
	[Faktoranteiltaganmonatjahr] [numeric](18, 10) NULL,
	[GJJahr] [int] NULL,
	[GJMonat] [int] NULL,
	[GJMonattext] [nvarchar](255) NULL,
	[GJJahrMonattext] [nvarchar](255) NULL,
	[GJJahrMonatint] [int] NULL,
	[GJQuartal] [int] NULL,
	[GJHalbjahr] [int] NULL,
	[GJJahrQuartalint] [int] NULL,
	[GJJahrHalbjahrint] [int] NULL,
	[GJH Bezeichnung] [nvarchar](255) NULL,
	[GQ Bezeichnung] [nvarchar](255) NULL,
	[IstWerktag] [int] NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_SNCt_Calendar] PRIMARY KEY CLUSTERED 
(
	[Datum] ASC,
	[Bundesland] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[control].[SNCt_Konfiguration]') AND type in (N'U'))
BEGIN
CREATE TABLE [control].[SNCt_Konfiguration](
	[Wert] [int] NOT NULL,
	[Bezeichnung] [nvarchar](100) NOT NULL,
	[Parameter] [nvarchar](100) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
 CONSTRAINT [PK_SNCt_Configuration] PRIMARY KEY CLUSTERED 
(
	[Parameter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[control].[SNCt_Zeitkategorie]') AND type in (N'U'))
BEGIN
CREATE TABLE [control].[SNCt_Zeitkategorie](
	[ID] [int] NOT NULL,
	[Zeitkategorie] [nvarchar](50) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
 CONSTRAINT [PK_SNCt_Time_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0000038_Purchase_Header]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0000038_Purchase_Header](
	[Document Type] [int] NULL,
	[No_] [nvarchar](20) NULL,
	[Posting Date] [datetime] NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Currency Factor] [numeric](38, 20) NULL,
	[Correction] [tinyint] NULL,
	[Document Date] [datetime] NULL,
	[Status] [int] NULL,
	[Order Date] [datetime] NULL,
	[Due Date] [datetime] NULL,
	[Posting Description] [nvarchar](100) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Payment Discount _] [numeric](38, 20) NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Pay-to Vendor No_] [nvarchar](20) NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Purchaser Code] [nvarchar](20) NULL,
	[Promised Receipt Date] [datetime] NULL,
	[Requested Receipt Date] [datetime] NULL,
	[Buy-from Contact] [nvarchar](100) NULL,
	[Vendor Invoice No_] [nvarchar](35) NULL,
	[Vendor Order No_] [nvarchar](35) NULL,
	[Vendor Shipment No_] [nvarchar](35) NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[Shipment Method Code] [nvarchar](10) NULL,
	[Buy-from Contact No_] [nvarchar](20) NULL,
	[Invoice Discount Value] [numeric](38, 20) NULL,
	[Invoice Discount Calculation] [int] NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0000039_Purchase_Line]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0000039_Purchase_Line](
	[Document Type] [int] NULL,
	[Document No_] [nvarchar](20) NULL,
	[Line No_] [int] NULL,
	[Type] [int] NULL,
	[No_] [nvarchar](20) NULL,
	[Quantity] [numeric](38, 20) NULL,
	[Outstanding Quantity] [numeric](38, 20) NULL,
	[Line Discount Amount] [numeric](38, 20) NULL,
	[Amount] [numeric](38, 20) NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Outstanding Amount] [numeric](38, 20) NULL,
	[Inv_ Discount Amount] [numeric](38, 20) NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Line Amount] [numeric](38, 20) NULL,
	[Quantity (Base)] [numeric](38, 20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Description] [nvarchar](100) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Dimension Set ID] [int] NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Unit Price (LCY)] [numeric](38, 20) NULL,
	[Pay-to Vendor No_] [nvarchar](20) NULL,
	[Promised Receipt Date] [datetime] NULL,
	[Requested Receipt Date] [datetime] NULL,
	[Planned Receipt Date] [datetime] NULL,
	[Order Date] [datetime] NULL,
	[Bin Code] [nvarchar](20) NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[Direct Unit Cost] [numeric](38, 20) NULL,
	[Qty_ to Invoice] [numeric](38, 20) NULL,
	[Qty_ to Receive] [numeric](38, 20) NULL,
	[Quantity Received] [numeric](38, 20) NULL,
	[Quantity Invoiced] [numeric](38, 20) NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0000122_Purch_Inv_Header]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0000122_Purch_Inv_Header](
	[No_] [nvarchar](20) NULL,
	[Ship-to Code] [nvarchar](10) NULL,
	[Ship-to Name] [nvarchar](100) NULL,
	[Ship-to City] [nvarchar](30) NULL,
	[Posting Date] [datetime] NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Currency Factor] [numeric](38, 20) NULL,
	[Document Date] [datetime] NULL,
	[Order Date] [datetime] NULL,
	[Due Date] [datetime] NULL,
	[Posting Description] [nvarchar](100) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Payment Discount _] [numeric](38, 20) NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Correction] [tinyint] NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Pay-to Vendor No_] [nvarchar](20) NULL,
	[Expected Receipt Date] [datetime] NULL,
	[Purchaser Code] [nvarchar](20) NULL,
	[Buy-from Contact] [nvarchar](100) NULL,
	[Vendor Invoice No_] [nvarchar](35) NULL,
	[Vendor Order No_] [nvarchar](35) NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[Shipment Method Code] [nvarchar](10) NULL,
	[Buy-from Contact No_] [nvarchar](20) NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0000123_Purch_Inv_Line]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0000123_Purch_Inv_Line](
	[Document No_] [nvarchar](20) NULL,
	[Line No_] [int] NULL,
	[Type] [int] NULL,
	[No_] [nvarchar](20) NULL,
	[Quantity] [numeric](38, 20) NULL,
	[Line Discount Amount] [numeric](38, 20) NULL,
	[Amount] [numeric](38, 20) NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Inv_ Discount Amount] [numeric](38, 20) NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Line Amount] [numeric](38, 20) NULL,
	[Quantity (Base)] [numeric](38, 20) NULL,
	[Unit Cost (LCY)] [numeric](38, 20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Description] [nvarchar](100) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Dimension Set ID] [int] NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Unit Price (LCY)] [numeric](38, 20) NULL,
	[Pay-to Vendor No_] [nvarchar](20) NULL,
	[Bin Code] [nvarchar](20) NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[Direct Unit Cost] [numeric](38, 20) NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0000124_Purch_Cr_Memo_Hdr]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0000124_Purch_Cr_Memo_Hdr](
	[No_] [nvarchar](20) NULL,
	[Ship-to Code] [nvarchar](10) NULL,
	[Ship-to Name] [nvarchar](100) NULL,
	[Ship-to City] [nvarchar](30) NULL,
	[Posting Date] [datetime] NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Currency Factor] [numeric](38, 20) NULL,
	[Document Date] [datetime] NULL,
	[Correction] [tinyint] NULL,
	[Due Date] [datetime] NULL,
	[Posting Description] [nvarchar](100) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Payment Discount _] [numeric](38, 20) NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Pay-to Vendor No_] [nvarchar](20) NULL,
	[Expected Receipt Date] [datetime] NULL,
	[Purchaser Code] [nvarchar](20) NULL,
	[Buy-from Contact] [nvarchar](100) NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[Shipment Method Code] [nvarchar](10) NULL,
	[Buy-from Contact No_] [nvarchar](20) NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0000125_Purch_Cr_Memo_Line]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0000125_Purch_Cr_Memo_Line](
	[No_] [nvarchar](20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Pay-to Vendor No_] [nvarchar](20) NULL,
	[Document No_] [nvarchar](20) NULL,
	[Line No_] [int] NULL,
	[Type] [int] NULL,
	[Quantity] [numeric](38, 20) NULL,
	[Unit Price (LCY)] [numeric](38, 20) NULL,
	[Unit Cost (LCY)] [numeric](38, 20) NULL,
	[Line Discount Amount] [numeric](38, 20) NULL,
	[Amount] [numeric](38, 20) NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Inv_ Discount Amount] [numeric](38, 20) NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Line Amount] [numeric](38, 20) NULL,
	[Quantity (Base)] [numeric](38, 20) NULL,
	[Description] [nvarchar](100) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Dimension Set ID] [int] NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[Direct Unit Cost] [numeric](38, 20) NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0005109_Purchase_Header_Archive]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0005109_Purchase_Header_Archive](
	[Document Type] [int] NULL,
	[No_] [nvarchar](20) NULL,
	[Posting Date] [datetime] NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Currency Factor] [numeric](38, 20) NULL,
	[Document Date] [datetime] NULL,
	[Correction] [tinyint] NULL,
	[Order Date] [datetime] NULL,
	[Due Date] [datetime] NULL,
	[Status] [int] NULL,
	[Posting Description] [nvarchar](100) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Payment Discount _] [numeric](38, 20) NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Pay-to Vendor No_] [nvarchar](20) NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Purchaser Code] [nvarchar](20) NULL,
	[Promised Receipt Date] [datetime] NULL,
	[Requested Receipt Date] [datetime] NULL,
	[Buy-from Contact] [nvarchar](100) NULL,
	[Doc_ No_ Occurrence] [int] NULL,
	[Version No_] [int] NULL,
	[Vendor Invoice No_] [nvarchar](35) NULL,
	[Vendor Order No_] [nvarchar](35) NULL,
	[Vendor Shipment No_] [nvarchar](35) NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[Shipment Method Code] [nvarchar](10) NULL,
	[Buy-from Contact No_] [nvarchar](20) NULL,
	[Invoice Discount Value] [numeric](38, 20) NULL,
	[Invoice Discount Calculation] [int] NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0005110_Purchase_Line_Archive]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0005110_Purchase_Line_Archive](
	[Document Type] [int] NULL,
	[Document No_] [nvarchar](20) NULL,
	[Line No_] [int] NULL,
	[Type] [int] NULL,
	[No_] [nvarchar](20) NULL,
	[Quantity] [numeric](38, 20) NULL,
	[Outstanding Quantity] [numeric](38, 20) NULL,
	[Line Discount Amount] [numeric](38, 20) NULL,
	[Amount] [numeric](38, 20) NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Outstanding Amount] [numeric](38, 20) NULL,
	[Inv_ Discount Amount] [numeric](38, 20) NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Line Amount] [numeric](38, 20) NULL,
	[Quantity (Base)] [numeric](38, 20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Description] [nvarchar](100) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Doc_ No_ Occurrence] [int] NULL,
	[Version No_] [int] NULL,
	[Dimension Set ID] [int] NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Unit Price (LCY)] [numeric](38, 20) NULL,
	[Pay-to Vendor No_] [nvarchar](20) NULL,
	[Promised Receipt Date] [datetime] NULL,
	[Requested Receipt Date] [datetime] NULL,
	[Planned Receipt Date] [datetime] NULL,
	[Order Date] [datetime] NULL,
	[Bin Code] [nvarchar](20) NULL,
	[Responsibility Center] [nvarchar](10) NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[Direct Unit Cost] [numeric](38, 20) NULL,
	[Qty_ to Invoice] [numeric](38, 20) NULL,
	[Qty_ to Receive] [numeric](38, 20) NULL,
	[Quantity Received] [numeric](38, 20) NULL,
	[Quantity Invoiced] [numeric](38, 20) NULL,
	[SG_MandantCode] [nvarchar](5) NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ein].[BC_t0005805_Item_Charge_Assignment_Purch]') AND type in (N'U'))
BEGIN
CREATE TABLE [ein].[BC_t0005805_Item_Charge_Assignment_Purch](
	[Document Type] [int] NOT NULL,
	[Document No_] [nvarchar](20) NOT NULL,
	[Line No_] [int] NOT NULL,
	[Document Line No_] [int] NOT NULL,
	[Qty_ to Assign] [numeric](38, 20) NULL,
	[Qty_ Assigned] [numeric](38, 20) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0005805_Item_Charge_Assignment_Purch] PRIMARY KEY CLUSTERED 
(
	[Document Type] ASC,
	[Document No_] ASC,
	[Line No_] ASC,
	[Document Line No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000015_G_L_Account]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000015_G_L_Account](
	[Name] [nvarchar](100) NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Account Type] [int] NULL,
	[Income_Balance] [int] NULL,
	[Global Dimension 1 Code] [nvarchar](20) NULL,
	[Global Dimension 2 Code] [nvarchar](20) NULL,
	[No_ 2] [nvarchar](20) NULL,
	[Blocked] [tinyint] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
 CONSTRAINT [PK_BC_t0000015_G_L_Account] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000017_G_L_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000017_G_L_Entry](
	[timestamp] [bigint] NOT NULL,
	[Amount] [numeric](38, 20) NULL,
	[Entry No_] [int] NOT NULL,
	[G_L Account No_] [nvarchar](20) NULL,
	[Global Dimension 1 Code] [nvarchar](20) NULL,
	[Global Dimension 2 Code] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[Posting Date] [datetime] NULL,
	[Document Type] [int] NULL,
	[Document No_] [nvarchar](20) NULL,
	[Debit Amount] [numeric](38, 20) NULL,
	[Credit Amount] [numeric](38, 20) NULL,
	[Document Date] [datetime] NULL,
	[User ID] [nvarchar](50) NULL,
	[VAT Amount] [numeric](38, 20) NULL,
	[Reversed] [tinyint] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0000017_G_L_Entry] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000021_Cust_Ledger_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000021_Cust_Ledger_Entry](
	[timestamp] [bigint] NOT NULL,
	[Entry No_] [int] NOT NULL,
	[Global Dimension 1 Code] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[Global Dimension 2 Code] [nvarchar](20) NULL,
	[Customer No_] [nvarchar](20) NULL,
	[Posting Date] [datetime] NULL,
	[Document Type] [int] NULL,
	[Document No_] [nvarchar](20) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Inv_ Discount (LCY)] [numeric](38, 20) NULL,
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[Customer Posting Group] [nvarchar](20) NULL,
	[Salesperson Code] [nvarchar](20) NULL,
	[On Hold] [nvarchar](3) NULL,
	[Applies-to Doc_ Type] [int] NULL,
	[Applies-to Doc_ No_] [nvarchar](20) NULL,
	[Open] [tinyint] NULL,
	[Due Date] [datetime] NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Pmt_ Disc_ Given (LCY)] [numeric](38, 20) NULL,
	[Closed by Entry No_] [int] NULL,
	[Closed at Date] [datetime] NULL,
	[Closed by Amount] [numeric](38, 20) NULL,
	[Applies-to ID] [nvarchar](50) NULL,
	[Journal Batch Name] [nvarchar](10) NULL,
	[Reason Code] [nvarchar](10) NULL,
	[Bal_ Account Type] [int] NULL,
	[Bal_ Account No_] [nvarchar](20) NULL,
	[Transaction No_] [int] NULL,
	[Closed by Amount (LCY)] [numeric](38, 20) NULL,
	[Document Date] [datetime] NULL,
	[External Document No_] [nvarchar](35) NULL,
	[Calculate Interest] [tinyint] NULL,
	[Closing Interest Calculated] [tinyint] NULL,
	[No_ Series] [nvarchar](20) NULL,
	[Closed by Currency Code] [nvarchar](10) NULL,
	[Closed by Currency Amount] [numeric](38, 20) NULL,
	[Adjusted Currency Factor] [numeric](38, 20) NULL,
	[Original Currency Factor] [numeric](38, 20) NULL,
	[Pmt_ Disc_ Tolerance Date] [datetime] NULL,
	[Last Issued Reminder Level] [int] NULL,
	[Accepted Payment Tolerance] [numeric](38, 20) NULL,
	[Accepted Pmt_ Disc_ Tolerance] [tinyint] NULL,
	[Pmt_ Tolerance (LCY)] [numeric](38, 20) NULL,
	[Amount to Apply] [numeric](38, 20) NULL,
	[IC Partner Code] [nvarchar](20) NULL,
	[Applying Entry] [tinyint] NULL,
	[Reversed] [tinyint] NULL,
	[Reversed by Entry No_] [int] NULL,
	[Reversed Entry No_] [int] NULL,
	[Prepayment] [tinyint] NULL,
	[Payment Method Code] [nvarchar](10) NULL,
	[Applies-to Ext_ Doc_ No_] [nvarchar](35) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0000021_Cust_Ledger_Entry] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000025_Vendor_Ledger_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000025_Vendor_Ledger_Entry](
	[Entry No_] [int] NOT NULL,
	[Global Dimension 1 Code] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[Global Dimension 2 Code] [nvarchar](20) NULL,
	[Posting Date] [datetime] NULL,
	[Document Type] [int] NULL,
	[Document No_] [nvarchar](20) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Inv_ Discount (LCY)] [numeric](38, 20) NULL,
	[On Hold] [nvarchar](3) NULL,
	[Applies-to Doc_ Type] [int] NULL,
	[Applies-to Doc_ No_] [nvarchar](20) NULL,
	[Open] [tinyint] NULL,
	[Due Date] [datetime] NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Closed by Entry No_] [int] NULL,
	[Closed at Date] [datetime] NULL,
	[Closed by Amount] [numeric](38, 20) NULL,
	[Applies-to ID] [nvarchar](50) NULL,
	[Journal Batch Name] [nvarchar](10) NULL,
	[Reason Code] [nvarchar](10) NULL,
	[Bal_ Account Type] [int] NULL,
	[Bal_ Account No_] [nvarchar](20) NULL,
	[Transaction No_] [int] NULL,
	[Closed by Amount (LCY)] [numeric](38, 20) NULL,
	[Document Date] [datetime] NULL,
	[External Document No_] [nvarchar](35) NULL,
	[No_ Series] [nvarchar](20) NULL,
	[Closed by Currency Code] [nvarchar](10) NULL,
	[Closed by Currency Amount] [numeric](38, 20) NULL,
	[Adjusted Currency Factor] [numeric](38, 20) NULL,
	[Original Currency Factor] [numeric](38, 20) NULL,
	[Pmt_ Disc_ Tolerance Date] [datetime] NULL,
	[Accepted Payment Tolerance] [numeric](38, 20) NULL,
	[Accepted Pmt_ Disc_ Tolerance] [tinyint] NULL,
	[Pmt_ Tolerance (LCY)] [numeric](38, 20) NULL,
	[Amount to Apply] [numeric](38, 20) NULL,
	[IC Partner Code] [nvarchar](20) NULL,
	[Applying Entry] [tinyint] NULL,
	[Reversed] [tinyint] NULL,
	[Reversed by Entry No_] [int] NULL,
	[Reversed Entry No_] [int] NULL,
	[Prepayment] [tinyint] NULL,
	[Payment Method Code] [nvarchar](10) NULL,
	[Applies-to Ext_ Doc_ No_] [nvarchar](35) NULL,
	[timestamp] [bigint] NULL,
	[Vendor No_] [nvarchar](20) NULL,
	[Buy-from Vendor No_] [nvarchar](20) NULL,
	[Vendor Posting Group] [nvarchar](20) NULL,
	[Purchaser Code] [nvarchar](20) NULL,
	[Pmt_ Disc_ Rcd_(LCY)] [numeric](38, 20) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0000025_Vendor_Ledger_Entry] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000085_Acc_Schedule_Line]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000085_Acc_Schedule_Line](
	[Schedule Name] [nvarchar](10) NOT NULL,
	[Line No_] [int] NOT NULL,
	[Row No_] [nvarchar](10) NULL,
	[Description] [nvarchar](100) NULL,
	[Totaling] [nvarchar](250) NULL,
	[Totaling Type] [int] NULL,
	[New Page] [tinyint] NULL,
	[Show] [int] NULL,
	[Dimension 1 Totaling] [nvarchar](250) NULL,
	[Dimension 2 Totaling] [nvarchar](250) NULL,
	[Dimension 3 Totaling] [nvarchar](250) NULL,
	[Dimension 4 Totaling] [nvarchar](250) NULL,
	[Bold] [tinyint] NULL,
	[Italic] [tinyint] NULL,
	[Underline] [tinyint] NULL,
	[Show Opposite Sign] [tinyint] NULL,
	[Row Type] [int] NULL,
	[Amount Type] [int] NULL,
	[Cost Center Totaling] [nvarchar](80) NULL,
	[Cost Object Totaling] [nvarchar](80) NULL,
	[Double Underline] [tinyint] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
 CONSTRAINT [PK_BC_t0000085_Acc_Schedule_Line_1] PRIMARY KEY CLUSTERED 
(
	[Schedule Name] ASC,
	[Line No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000096_G_L_Budget_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000096_G_L_Budget_Entry](
	[timestamp] [bigint] NOT NULL,
	[Amount] [numeric](38, 20) NULL,
	[Entry No_] [int] NOT NULL,
	[G_L Account No_] [nvarchar](20) NULL,
	[Global Dimension 1 Code] [nvarchar](20) NULL,
	[Global Dimension 2 Code] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[Budget Name] [nvarchar](10) NULL,
	[Date] [datetime] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0000096_G_L_Budget_Entry] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000098_General_Ledger_Setup]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000098_General_Ledger_Setup](
	[Global Dimension 1 Code] [nvarchar](20) NULL,
	[Global Dimension 2 Code] [nvarchar](20) NULL,
	[Primary Key] [nvarchar](10) NULL,
	[Acc_ Sched_ for Balance Sheet] [nvarchar](10) NULL,
	[Acc_ Sched_ for Income Stmt_] [nvarchar](10) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000098_General_Ledger_Setup_1] PRIMARY KEY CLUSTERED 
(
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000292_Reminder_Terms]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000292_Reminder_Terms](
	[Code] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000292_Reminder_Terms] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000293_Reminder_Level]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000293_Reminder_Level](
	[No_] [nvarchar](20) NOT NULL,
	[Reminder Terms Code] [nvarchar](10) NOT NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000293_Reminder_Level] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[Reminder Terms Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000379_Detailed_Cust_Ledg_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000379_Detailed_Cust_Ledg_Entry](
	[timestamp] [bigint] NOT NULL,
	[Entry No_] [int] NOT NULL,
	[Customer No_] [nvarchar](20) NULL,
	[Posting Date] [datetime] NULL,
	[Document Type] [int] NULL,
	[Document No_] [nvarchar](20) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Journal Batch Name] [nvarchar](10) NULL,
	[Reason Code] [nvarchar](10) NULL,
	[Transaction No_] [int] NULL,
	[Remaining Pmt_ Disc_ Possible] [numeric](38, 20) NULL,
	[Max_ Payment Tolerance] [numeric](38, 20) NULL,
	[Cust_ Ledger Entry No_] [int] NULL,
	[Entry Type] [int] NULL,
	[Amount] [numeric](38, 20) NULL,
	[Amount (LCY)] [numeric](38, 20) NULL,
	[User ID] [nvarchar](50) NULL,
	[Source Code] [nvarchar](10) NULL,
	[Debit Amount] [numeric](38, 20) NULL,
	[Credit Amount] [numeric](38, 20) NULL,
	[Debit Amount (LCY)] [numeric](38, 20) NULL,
	[Credit Amount (LCY)] [numeric](38, 20) NULL,
	[Initial Entry Due Date] [datetime] NULL,
	[Initial Entry Global Dim_ 1] [nvarchar](20) NULL,
	[Initial Entry Global Dim_ 2] [nvarchar](20) NULL,
	[Gen_ Bus_ Posting Group] [nvarchar](20) NULL,
	[Gen_ Prod_ Posting Group] [nvarchar](20) NULL,
	[Use Tax] [tinyint] NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[VAT Prod_ Posting Group] [nvarchar](20) NULL,
	[Initial Document Type] [int] NULL,
	[Applied Cust_ Ledger Entry No_] [int] NULL,
	[Unapplied] [tinyint] NULL,
	[Unapplied by Entry No_] [int] NULL,
	[Tax Jurisdiction Code] [nvarchar](10) NULL,
	[Application No_] [int] NULL,
	[Ledger Entry Amount] [tinyint] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0000379_Detailed_Cust_Ledg_Entry] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0000380_Detailed_Vendor_Ledg_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0000380_Detailed_Vendor_Ledg_Entry](
	[Entry No_] [int] NOT NULL,
	[Posting Date] [datetime] NULL,
	[Document Type] [int] NULL,
	[Document No_] [nvarchar](20) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Journal Batch Name] [nvarchar](10) NULL,
	[Reason Code] [nvarchar](10) NULL,
	[Transaction No_] [int] NULL,
	[Remaining Pmt_ Disc_ Possible] [numeric](38, 20) NULL,
	[Max_ Payment Tolerance] [numeric](38, 20) NULL,
	[Entry Type] [int] NULL,
	[Amount] [numeric](38, 20) NULL,
	[Amount (LCY)] [numeric](38, 20) NULL,
	[User ID] [nvarchar](50) NULL,
	[Source Code] [nvarchar](10) NULL,
	[Debit Amount] [numeric](38, 20) NULL,
	[Credit Amount] [numeric](38, 20) NULL,
	[Debit Amount (LCY)] [numeric](38, 20) NULL,
	[Credit Amount (LCY)] [numeric](38, 20) NULL,
	[Initial Entry Due Date] [datetime] NULL,
	[Initial Entry Global Dim_ 1] [nvarchar](20) NULL,
	[Initial Entry Global Dim_ 2] [nvarchar](20) NULL,
	[Gen_ Bus_ Posting Group] [nvarchar](20) NULL,
	[Gen_ Prod_ Posting Group] [nvarchar](20) NULL,
	[Use Tax] [tinyint] NULL,
	[VAT Bus_ Posting Group] [nvarchar](20) NULL,
	[VAT Prod_ Posting Group] [nvarchar](20) NULL,
	[Initial Document Type] [int] NULL,
	[Unapplied] [tinyint] NULL,
	[Unapplied by Entry No_] [int] NULL,
	[Tax Jurisdiction Code] [nvarchar](10) NULL,
	[Application No_] [int] NULL,
	[Ledger Entry Amount] [tinyint] NULL,
	[timestamp] [bigint] NULL,
	[Vendor Ledger Entry No_] [int] NULL,
	[Vendor No_] [nvarchar](20) NULL,
	[Applied Vend_ Ledger Entry No_] [int] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0000380_Detailed_Vendor_Ledg_Entry] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0001103_Cost_Type]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0001103_Cost_Type](
	[Name] [nvarchar](100) NULL,
	[Totaling] [nvarchar](250) NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Type] [int] NULL,
	[Cost Center Code] [nvarchar](20) NULL,
	[Cost Object Code] [nvarchar](20) NULL,
	[Cost Classification] [int] NULL,
	[Blocked] [tinyint] NULL,
	[G_L Account Range] [nvarchar](50) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0001103_Cost_Type] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0001104_Cost_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0001104_Cost_Entry](
	[timestamp] [bigint] NOT NULL,
	[Amount] [numeric](38, 20) NULL,
	[Entry No_] [int] NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Cost Type No_] [nvarchar](20) NULL,
	[Posting Date] [datetime] NULL,
	[Document No_] [nvarchar](20) NULL,
	[Debit Amount] [numeric](38, 20) NULL,
	[Credit Amount] [numeric](38, 20) NULL,
	[Cost Center Code] [nvarchar](20) NULL,
	[Cost Object Code] [nvarchar](20) NULL,
	[G_L Account] [nvarchar](20) NULL,
	[G_L Entry No_] [int] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0001104_Cost_Entry] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0001112_Cost_Center]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0001112_Cost_Center](
	[Name] [nvarchar](100) NULL,
	[Blocked] [tinyint] NULL,
	[Code] [nvarchar](20) NOT NULL,
	[Sorting Order] [nvarchar](10) NULL,
	[Comment] [nvarchar](50) NULL,
	[Responsible Person] [nvarchar](50) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NOT NULL,
	[Cost Subtype] [int] NULL,
 CONSTRAINT [PK_BC_t0001112_Cost_Center] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[BC_t0001113_Cost_Object]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[BC_t0001113_Cost_Object](
	[Name] [nvarchar](100) NULL,
	[Blocked] [tinyint] NULL,
	[Code] [nvarchar](20) NOT NULL,
	[Sorting Order] [nvarchar](10) NULL,
	[Totaling] [nvarchar](250) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0001113_Cost_Object] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[TMP_fBilanz70_2_Zeit_Sachkonto]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[TMP_fBilanz70_2_Zeit_Sachkonto](
	[Sachkontonummer] [nvarchar](20) NOT NULL,
	[Datum (Zeit)] [datetime] NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[Bundesland] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TMP_fBilanz70_2_Zeit_Sachkonto] PRIMARY KEY CLUSTERED 
(
	[Sachkontonummer] ASC,
	[Datum (Zeit)] ASC,
	[Bundesland] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung]') AND type in (N'U'))
BEGIN
CREATE TABLE [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung](
	[Sachkontonummer] [nvarchar](20) NULL,
	[Strukturbezeichnung] [nvarchar](10) NULL,
	[Mandant Code] [nvarchar](5) NULL,
	[Parent Zeilennummer] [int] NULL,
	[Parent Code] [nvarchar](10) NULL,
	[Parentbezeichnung] [nvarchar](100) NULL,
	[Child Zeilennummer] [int] NULL,
	[Child Code] [nvarchar](20) NULL,
	[Childbezeichnung] [nvarchar](121) NULL,
	[Sachkontobezeichnung] [nvarchar](100) NULL,
	[Ist Sachkonto] [bit] NULL,
	[Zusammenzählung Start] [nvarchar](15) NULL,
	[Zusammenzählung Ende] [nvarchar](15) NULL,
	[Zusammenzählungstyp] [int] NULL,
	[Umkehr Code] [tinyint] NULL,
	[SG_LetzteAktualisierung] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[log].[BC_t0000014_Location]') AND type in (N'U'))
BEGIN
CREATE TABLE [log].[BC_t0000014_Location](
	[Code] [nvarchar](10) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Name 2] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](30) NULL,
	[Post Code] [nvarchar](20) NULL,
	[Default Bin Code] [nvarchar](20) NULL,
	[Address 2] [nvarchar](50) NULL,
	[Country_Region Code] [nvarchar](10) NULL,
	[Use As In-Transit] [tinyint] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
 CONSTRAINT [PK_BC_t0000014_Location] PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[log].[BC_t0005802_Value_Entry]') AND type in (N'U'))
BEGIN
CREATE TABLE [log].[BC_t0005802_Value_Entry](
	[Entry No_] [int] NOT NULL,
	[Posting Date] [datetime] NULL,
	[Valuation Date] [datetime] NULL,
	[Location Code] [nvarchar](10) NULL,
	[Document No_] [nvarchar](20) NULL,
	[timestamp] [bigint] NULL,
	[Item No_] [nvarchar](20) NULL,
	[Source No_] [nvarchar](20) NULL,
	[Description] [nvarchar](100) NULL,
	[Invoiced Quantity] [numeric](38, 20) NULL,
	[Source Type] [int] NULL,
	[Item Ledger Entry Type] [int] NULL,
	[Item Ledger Entry No_] [int] NULL,
	[Sales Amount (Actual)] [numeric](38, 20) NULL,
	[Salespers__Purch_ Code] [nvarchar](20) NULL,
	[Cost Amount (Actual)] [numeric](38, 20) NULL,
	[Drop Shipment] [tinyint] NULL,
	[Purchase Amount (Actual)] [numeric](38, 20) NULL,
	[Purchase Amount (Expected)] [numeric](38, 20) NULL,
	[Sales Amount (Expected)] [numeric](38, 20) NULL,
	[Cost Amount (Expected)] [numeric](38, 20) NULL,
	[Cost Amount (Non-Invtbl_)] [numeric](38, 20) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
	[Item Ledger Entry Quantity] [numeric](38, 20) NULL,
 CONSTRAINT [PK_BC_t0005802_Value_Entry] PRIMARY KEY CLUSTERED 
(
	[Entry No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ver].[BC_t0000036_Sales_Header]') AND type in (N'U'))
BEGIN
CREATE TABLE [ver].[BC_t0000036_Sales_Header](
	[Document Type] [int] NOT NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Posting Date] [datetime] NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Currency Factor] [numeric](38, 20) NULL,
	[Salesperson Code] [nvarchar](20) NULL,
	[Correction] [tinyint] NULL,
	[Document Date] [datetime] NULL,
	[Promised Delivery Date] [datetime] NULL,
	[Shipment Date] [datetime] NULL,
	[Status] [int] NULL,
	[External Document No_] [nvarchar](35) NULL,
	[Order Date] [datetime] NULL,
	[Due Date] [datetime] NULL,
	[Requested Delivery Date] [datetime] NULL,
	[Sell-to Contact] [nvarchar](100) NULL,
	[Posting Description] [nvarchar](100) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Payment Discount _] [numeric](38, 20) NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
	[Doc_ No_ Occurrence] [int] NULL,
 CONSTRAINT [PK_BC_t0000036_Sales_Header_1] PRIMARY KEY CLUSTERED 
(
	[Document Type] ASC,
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ver].[BC_t0000037_Sales_Line]') AND type in (N'U'))
BEGIN
CREATE TABLE [ver].[BC_t0000037_Sales_Line](
	[Document Type] [int] NOT NULL,
	[Document No_] [nvarchar](20) NOT NULL,
	[Line No_] [int] NOT NULL,
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[Type] [int] NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Quantity] [numeric](38, 20) NULL,
	[Outstanding Quantity] [numeric](38, 20) NULL,
	[Unit Price] [numeric](38, 20) NULL,
	[Line Discount Amount] [numeric](38, 20) NULL,
	[Amount] [numeric](38, 20) NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Outstanding Amount] [numeric](38, 20) NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Inv_ Discount Amount] [numeric](38, 20) NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Line Amount] [numeric](38, 20) NULL,
	[Quantity (Base)] [numeric](38, 20) NULL,
	[Promised Delivery Date] [datetime] NULL,
	[Location Code] [nvarchar](10) NULL,
	[Requested Delivery Date] [datetime] NULL,
	[Description] [nvarchar](100) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Planned Delivery Date] [datetime] NULL,
	[Planned Shipment Date] [datetime] NULL,
	[Shipment Date] [datetime] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
	[Dimension Set ID] [int] NULL,
	[Outstanding Qty_ (Base)] [numeric](38, 20) NULL,
	[VAT _] [numeric](38, 20) NULL,
 CONSTRAINT [PK_BC_t0000037_Sales_Line_1] PRIMARY KEY CLUSTERED 
(
	[Document Type] ASC,
	[Document No_] ASC,
	[Line No_] ASC,
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ver].[BC_t0000112_Sales_Invoice_Header]') AND type in (N'U'))
BEGIN
CREATE TABLE [ver].[BC_t0000112_Sales_Invoice_Header](
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Ship-to Code] [nvarchar](10) NULL,
	[Ship-to Name] [nvarchar](100) NULL,
	[Ship-to City] [nvarchar](30) NULL,
	[Posting Date] [datetime] NULL,
	[Shipment Date] [datetime] NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Currency Factor] [numeric](38, 20) NULL,
	[Salesperson Code] [nvarchar](20) NULL,
	[Document Date] [datetime] NULL,
	[Document Type] [tinyint] NULL,
	[External Document No_] [nvarchar](35) NULL,
	[Order Date] [datetime] NULL,
	[Due Date] [datetime] NULL,
	[Sell-to Contact] [nvarchar](100) NULL,
	[Posting Description] [nvarchar](100) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Payment Discount _] [numeric](38, 20) NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Correction] [tinyint] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0000112_Sales_Invoice_Header_1] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ver].[BC_t0000113_Sales_Invoice_Line]') AND type in (N'U'))
BEGIN
CREATE TABLE [ver].[BC_t0000113_Sales_Invoice_Line](
	[Document No_] [nvarchar](20) NOT NULL,
	[Line No_] [int] NOT NULL,
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[Type] [int] NULL,
	[No_] [nvarchar](20) NULL,
	[Quantity] [numeric](38, 20) NULL,
	[Unit Price] [numeric](38, 20) NULL,
	[Line Discount Amount] [numeric](38, 20) NULL,
	[Amount] [numeric](38, 20) NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Inv_ Discount Amount] [numeric](38, 20) NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Line Amount] [numeric](38, 20) NULL,
	[Quantity (Base)] [numeric](38, 20) NULL,
	[Unit Cost (LCY)] [numeric](38, 20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Description] [nvarchar](100) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Shipment Date] [datetime] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
	[Dimension Set ID] [int] NULL,
	[VAT _] [numeric](38, 20) NULL,
 CONSTRAINT [PK_BC_t0000113_Sales_Invoice_Line_1] PRIMARY KEY CLUSTERED 
(
	[Document No_] ASC,
	[Line No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ver].[BC_t0000114_Sales_Cr_Memo_Header]') AND type in (N'U'))
BEGIN
CREATE TABLE [ver].[BC_t0000114_Sales_Cr_Memo_Header](
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Ship-to Code] [nvarchar](10) NULL,
	[Ship-to Name] [nvarchar](100) NULL,
	[Ship-to City] [nvarchar](30) NULL,
	[Posting Date] [datetime] NULL,
	[Shipment Date] [datetime] NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Currency Factor] [numeric](38, 20) NULL,
	[Salesperson Code] [nvarchar](20) NULL,
	[Document Date] [datetime] NULL,
	[Correction] [tinyint] NULL,
	[External Document No_] [nvarchar](35) NULL,
	[Due Date] [datetime] NULL,
	[Sell-to Contact] [nvarchar](100) NULL,
	[Posting Description] [nvarchar](100) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Payment Discount _] [numeric](38, 20) NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0000114_Sales_Cr_Memo_Header_1] PRIMARY KEY CLUSTERED 
(
	[No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ver].[BC_t0000115_Sales_Cr_Memo_Line]') AND type in (N'U'))
BEGIN
CREATE TABLE [ver].[BC_t0000115_Sales_Cr_Memo_Line](
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[No_] [nvarchar](20) NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Document No_] [nvarchar](20) NOT NULL,
	[Line No_] [int] NOT NULL,
	[Type] [int] NULL,
	[Quantity] [numeric](38, 20) NULL,
	[Unit Price] [numeric](38, 20) NULL,
	[Unit Cost (LCY)] [numeric](38, 20) NULL,
	[Line Discount Amount] [numeric](38, 20) NULL,
	[Amount] [numeric](38, 20) NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Inv_ Discount Amount] [numeric](38, 20) NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Line Amount] [numeric](38, 20) NULL,
	[Quantity (Base)] [numeric](38, 20) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Description] [nvarchar](100) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Shipment Date] [datetime] NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
	[Dimension Set ID] [int] NULL,
	[VAT _] [numeric](38, 20) NULL,
 CONSTRAINT [PK_BC_t0000115_Sales_Cr_Memo_Line_2] PRIMARY KEY CLUSTERED 
(
	[Document No_] ASC,
	[Line No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ver].[BC_t0005107_Sales_Header_Archive]') AND type in (N'U'))
BEGIN
CREATE TABLE [ver].[BC_t0005107_Sales_Header_Archive](
	[Document Type] [int] NOT NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Posting Date] [datetime] NULL,
	[Currency Code] [nvarchar](10) NULL,
	[Currency Factor] [numeric](38, 20) NULL,
	[Salesperson Code] [nvarchar](20) NULL,
	[Document Date] [datetime] NULL,
	[Promised Delivery Date] [datetime] NULL,
	[Correction] [tinyint] NULL,
	[Shipment Date] [datetime] NULL,
	[External Document No_] [nvarchar](35) NULL,
	[Order Date] [datetime] NULL,
	[Due Date] [datetime] NULL,
	[Requested Delivery Date] [datetime] NULL,
	[Status] [int] NULL,
	[Sell-to Contact] [nvarchar](100) NULL,
	[Posting Description] [nvarchar](100) NULL,
	[Location Code] [nvarchar](10) NULL,
	[Payment Discount _] [numeric](38, 20) NULL,
	[Pmt_ Discount Date] [datetime] NULL,
	[Payment Terms Code] [nvarchar](10) NULL,
	[Doc_ No_ Occurrence] [int] NOT NULL,
	[Version No_] [int] NOT NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
 CONSTRAINT [PK_BC_t0005107_Sales_Header_Archive_1] PRIMARY KEY CLUSTERED 
(
	[Document Type] ASC,
	[No_] ASC,
	[Doc_ No_ Occurrence] ASC,
	[Version No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ver].[BC_t0005108_Sales_Line_Archive]') AND type in (N'U'))
BEGIN
CREATE TABLE [ver].[BC_t0005108_Sales_Line_Archive](
	[Document Type] [int] NOT NULL,
	[Document No_] [nvarchar](20) NOT NULL,
	[Line No_] [int] NOT NULL,
	[Sell-to Customer No_] [nvarchar](20) NULL,
	[Type] [int] NULL,
	[No_] [nvarchar](20) NOT NULL,
	[Quantity] [numeric](38, 20) NULL,
	[Outstanding Quantity] [numeric](38, 20) NULL,
	[Unit Price] [numeric](38, 20) NULL,
	[Line Discount Amount] [numeric](38, 20) NULL,
	[Amount] [numeric](38, 20) NULL,
	[Shortcut Dimension 1 Code] [nvarchar](20) NULL,
	[Shortcut Dimension 2 Code] [nvarchar](20) NULL,
	[Outstanding Amount] [numeric](38, 20) NULL,
	[Bill-to Customer No_] [nvarchar](20) NULL,
	[Inv_ Discount Amount] [numeric](38, 20) NULL,
	[Unit Cost] [numeric](38, 20) NULL,
	[Line Amount] [numeric](38, 20) NULL,
	[Quantity (Base)] [numeric](38, 20) NULL,
	[Promised Delivery Date] [datetime] NULL,
	[Location Code] [nvarchar](10) NULL,
	[Requested Delivery Date] [datetime] NULL,
	[Description] [nvarchar](100) NULL,
	[Unit of Measure Code] [nvarchar](10) NULL,
	[Planned Delivery Date] [datetime] NULL,
	[Planned Shipment Date] [datetime] NULL,
	[Shipment Date] [datetime] NULL,
	[Doc_ No_ Occurrence] [int] NOT NULL,
	[Version No_] [int] NOT NULL,
	[SG_MandantCode] [nvarchar](5) NOT NULL,
	[SG_LetzteAktualisierung] [datetime] NULL,
	[SG_Bundesland] [nvarchar](50) NULL,
	[Dimension Set ID] [int] NULL,
	[Outstanding Qty_ (Base)] [numeric](38, 20) NULL,
	[VAT _] [numeric](38, 20) NULL,
 CONSTRAINT [PK_BC_t0005108_Sales_Line_Archive_2] PRIMARY KEY CLUSTERED 
(
	[Document Type] ASC,
	[Document No_] ASC,
	[Line No_] ASC,
	[No_] ASC,
	[Doc_ No_ Occurrence] ASC,
	[Version No_] ASC,
	[SG_MandantCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
