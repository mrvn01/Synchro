SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vSNCt_Beschreibung]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vSNCt_Beschreibung












CREATE VIEW [vv].[vSNCt_Beschreibung] AS								   
SELECT [Optionsfeld Code]			   AS [Optionsfeld Code]					-- Objekt Code 
      ,[Tabellen ID]					   AS [Tabellen ID]							-- BC Objekt ID (aktuell nicht genutzt/gefuellt)
      ,[Tabellenbezeichnung]					   AS [Tabellenname]						-- Mapping zu einer bestimmten Tabelle/View oder uebergreifend (Global)
      ,[Spalte]						   AS [Spaltenbezeichnung]					-- Spaltenbezeichnung
      ,[Optionsfeldbezeichnung DE]   AS [Optionsfeldbezeichnung DE]			-- deutsche Bezeichnung
      ,[Optionsfeldbezeichnung EN]   AS [Optionsfeldbezeichnung EN]			-- englische Bezeichnung
      ,[Quelle]						   AS [Herkunft der Bezeichnung]			-- Herkunft der Bezeichnung (SG = SIEVERS-GROUP/BC = Business Central AL)
  FROM [control].[SNCt_Bezeichnung]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vSNCt_Aktiver_Mandant]'))
EXEC dbo.sp_executesql @statement = N'







-- Alter View vSNCt_Aktiver_Mandant


CREATE VIEW [vv].[vSNCt_Aktiver_Mandant] AS 
SELECT [Mandant Code]							AS [Mandant Code]			-- Mandant ID
	  ,[Aktives Kennzeichen Verkauf]						AS [Aktives Kennzeichen Verkauf]			-- Aktiv Flag fuer Vertrieb (True/False)
	  ,[Aktives Kennzeichen Finanzen]					AS [Aktives Kennzeichen Finanzen]			-- Aktiv Flag fuer Finanzen (True/False)
	  ,[Aktives Kennzeichen Einkauf]					AS [Aktives Kennzeichen Einkauf]			-- Aktiv Flag fuer Finanzen (True/False)
	  ,[Bundesland]									AS [Bundesland]				-- Bundeslandsbezeichnung (äquivalent zu denen im Kalender) 
	  ,[Kostenstelle Code]						AS [Kostenstelle Code]		-- Kostenstellencode 
	  ,[Kostenträger Code]						AS [Kostenträger Code]		-- Kostenträgercode
	  ,[Sortierreihenfolge]							AS [Sortierreihenfolge]		-- Sortierschlüssel für die Mandanten (Wichtig für die Auflösung der BC Strukturen)
	  ,[Vermögensknoten Code]						AS [Aktiva Code]			-- Gibt den Code fuer den Aktiva-Knoten an
	  ,[Verbindlichkeitsknoten Code]					AS [Passiva Code]			-- Gibt den Code fuer den Aktiva-Knoten an
	  ,[GuV Code]					AS [GuV Code]				-- Gibt den Code fuer den GuV-Knoten an
	  ,[Hauptmandant Kennzeichen]						AS [Hauptmandant]			-- Gibt den führenden Mandanten an (in erster Linie für die Bilanzstruktur)
	  ,[Schemabezeichnung BWA]	AS [Schemabezeichnung BWA]				-- Name für den Struktur Report (BWA) Ergänzung zu der Steuerungstabelle für die FIBU (General Ledger Setup) (JH - 2020-02-08 - #8082)
  FROM [control].[SNCt_Aktiver_Mandant]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2













CREATE VIEW [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2] AS 
SELECT [Global Dimension 1 Code]		 AS [Kostenstellencode]			-- Kostenstellencode
      ,[Global Dimension 2 Code]		 AS [Kostenträgercode]			-- Kostenträgercode
      ,[Primary Key]					 AS [Primärschlüssel]						-- Primärschlüssel
      ,[Acc_ Sched_ for Balance Sheet]	 AS [Name des Bilanz-Reports]				-- Name des Bilanz-Reports
      ,[Acc_ Sched_ for Income Stmt_]	 AS [Name des GuV-Reports]					-- Name des GuV-Reports
      ,[SG_MandantCode]					 AS [Mandant Code]							-- Mandant ID
  FROM [fin].[BC_t0000098_General_Ledger_Setup]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000098_Finanzbuchhaltung_Einrichtung



CREATE VIEW [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung] AS

--Anpassung für die Steuerung der Strukturreports (Erweiterung BWA Struktur, Zusammenführung der Konfig-Parameter) (JH - 2020-02-08 - #8082)
SELECT [vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2].[Kostenstellencode]
      ,[vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2].[Kostenträgercode]
      ,[vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2].[Primärschlüssel]
      ,[vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2].[Name des Bilanz-Reports]
      ,[vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2].[Name des GuV-Reports]
	  ,[vSNCt_Aktiver_Mandant].[Schemabezeichnung BWA]
      ,[vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2].[Mandant Code]
  FROM [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vBC_t0000098_Finanzbuchhaltung_Einrichtung95_2].[Mandant Code] = [vSNCt_Aktiver_Mandant].[Mandant Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000017_Sachposten95_2]'))
EXEC dbo.sp_executesql @statement = N'





CREATE VIEW [vv].[vBC_t0000017_Sachposten95_2] AS 
SELECT [SG_MandantCode]						AS [Mandant Code]														-- Mandant ID
      ,[Amount]								AS [Betrag]																-- Betrag
      ,[Entry No_]							AS [Sachposten Lfd. Nr.]												-- Sachposten Lfd. Nr.
      ,[G_L Account No_]					AS [Sachkontonummer]													-- Sachkontonummer
      ,[Global Dimension 1 Code]			AS [Kostenstellencode]   -- Global Dimension Code 1 (entweder Kostenstelle o. Kostenträger)
      ,[Global Dimension 2 Code]			AS [Kostenträgercode]   -- Global Dimension Code 2 (entweder Kostenstelle o. Kostenträger)
      ,[Description]						AS [Sachpostenbezeichnung]											-- Sachposten Beschreibung
      ,[Posting Date]						AS [Buchungsdatum]														-- Buchungsdatum
      ,[Document Type]						AS [Belegart Code]														-- Belegartcode
      ,[Document No_]						AS [Belegnummer]														-- Belegnummer
      ,[Debit Amount]						AS [Sollbetrag]															-- Soll-Betrag
      ,[Credit Amount]						AS [Habenbetrag]														-- Haben-Betrag
      ,[Document Date]						AS [Belegdatum]															-- Belegdatum
	  ,[User ID]							AS [Benutzer-ID]														-- Benutzer-ID
	  ,[VAT Amount]							AS [MwSt.-Betrag]														-- MwSt.-Betrag
	  ,[Reversed]							AS [Vorzeichenumkehr]													-- Vorzeichenumkehr
	  ,[SG_Bundesland]							AS [Bundesland]															-- Bundesland
  FROM [fin].[BC_t0000017_G_L_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000017_Sachposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000017_Sachposten

CREATE VIEW [vv].[vBC_t0000017_Sachposten] AS
SELECT [Mandant Code]
      ,[Betrag]
      ,[Sachposten Lfd. Nr.]
      ,[Sachkontonummer]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Sachpostenbezeichnung]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])				AS [Buchungsdatum]
      ,[Belegart Code]
      ,[Belegnummer]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])					AS [Belegdatum]
      ,[Benutzer-ID]
      ,[MwSt.-Betrag]
      ,[Vorzeichenumkehr]
      ,[Bundesland]
  FROM [vv].[vBC_t0000017_Sachposten95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fFinanzcontrolling95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View vBC_t0000017_Sachposten95_2























-- Alter View fFinanzcontrolling95_2





















CREATE VIEW

[fin].[fFinanzcontrolling95_2]

AS

SELECT [vBC_t0000017_Sachposten].[Mandant Code]
	  ,[vBC_t0000017_Sachposten].[Sachposten Lfd. Nr.]
      ,[vBC_t0000017_Sachposten].[Sachkontonummer]
	  --in der General Ledger Setup Tabelle ist defineirt on welchem Global Dim Code welcher Dimensionswert steht
	  ,IIF([vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenstellencode] = [vSNCt_Aktiver_Mandant].[Kostenstelle Code]
																		,[vBC_t0000017_Sachposten].[Kostenstellencode]
																		,[vBC_t0000017_Sachposten].[Kostenträgercode]) 
		AS [Kostenstelle Code]
	  ,IIF([vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenträgercode] = [vSNCt_Aktiver_Mandant].[Kostenträger Code]
																		,[vBC_t0000017_Sachposten].[Kostenträgercode]
																		,[vBC_t0000017_Sachposten].[Kostenstellencode]) 
		AS [Kostenträger Code]
      ,[vBC_t0000017_Sachposten].[Buchungsdatum]
      ,[vBC_t0000017_Sachposten].[Belegart Code]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Belegartbezeichnung DE]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Belegartbezeichnung EN]
      ,[vBC_t0000017_Sachposten].[Belegnummer]
      ,[vBC_t0000017_Sachposten].[Belegdatum]
      ,[vBC_t0000017_Sachposten].[Sachpostenbezeichnung]
      ,[vBC_t0000017_Sachposten].[Vorzeichenumkehr]
      ,[vBC_t0000017_Sachposten].[Betrag]
      ,[vBC_t0000017_Sachposten].[Sollbetrag]
      ,[vBC_t0000017_Sachposten].[Habenbetrag]
      ,CASE WHEN  MONTH([vBC_t0000017_Sachposten].[Buchungsdatum]) = 12 
				AND DAY([vBC_t0000017_Sachposten].[Buchungsdatum]) = 31
				AND CONVERT(VARCHAR(10), [vBC_t0000017_Sachposten].[Buchungsdatum], 108) = ''23:59:59''
			THEN 1
			ELSE 0
	   END AS [Nullstellungsbuchung]
	  ,[vBC_t0000017_Sachposten].[Bundesland]
 FROM [vv].[vBC_t0000017_Sachposten]
  
  LEFT JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON [vBC_t0000017_Sachposten].[Mandant Code] = [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code] = [vSNCt_Aktiver_Mandant].[Mandant Code]


  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Belegartbezeichnung]
  ON [vBC_t0000017_Sachposten].[Belegart Code]  = [Belegartbezeichnung].[Optionsfeld Code]
  AND [Belegartbezeichnung].[Tabellenname]		= ''Finanzen''
  AND [Belegartbezeichnung].[Spaltenbezeichnung]			= ''Belegartbezeichnung''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000096_Sachbudgetposten95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000096_Sachbudgetposten95_2




















CREATE VIEW[vv].[vBC_t0000096_Sachbudgetposten95_2] AS
																						
SELECT [SG_MandantCode]									AS [Mandant Code]														-- Mandant ID
      ,[Amount]											AS [Betrag]																-- Betrag
      ,[Entry No_]										AS [Finanzbudgetposten Lfd. Nr.]											-- Finanzbudgetposten Lfd.
      ,[Budget Name]									AS [Budgetbezeichnung]															-- Budgetname
      ,[G_L Account No_]								AS [Sachkontonummer]													-- Sachkontonummer
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Date])	AS [Datum]																-- Datum
      ,[Global Dimension 1 Code]						AS [Kostenstellencode]	-- Global Dimension 1 Code (entweder Kostenstelle o. Kostenträger)
	  ,[Global Dimension 1 Code]						AS [Kostenträgercode]	-- Global Dimension 2 Code (entweder Kostenstelle o. Kostenträger)
      ,[Description]									AS [Finanzbudgetpostenbezeichnung]										-- Finanzbudgetpostenbeschreibung
	  ,[SG_Bundesland]										AS [Bundesland]															-- Bundesland
  FROM [fin].[BC_t0000096_G_L_Budget_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000096_Sachbudgetposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000096_Sachbudgetposten













CREATE VIEW [vv].[vBC_t0000096_Sachbudgetposten] AS
SELECT [Mandant Code]
      ,[Betrag]
      ,[Finanzbudgetposten Lfd. Nr.]
      ,[Budgetbezeichnung]
      ,[Sachkontonummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Datum]) AS [Datum]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Finanzbudgetpostenbezeichnung]
      ,[Bundesland]
  FROM [vv].[vBC_t0000096_Sachbudgetposten95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fFinanzcontrolling95_2_Budgeteintrag]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fFinanzcontrolling95_2_Budgeteintrag

















CREATE VIEW

[fin].[fFinanzcontrolling95_2_Budgeteintrag]

AS


SELECT [vBC_t0000096_Sachbudgetposten].[Mandant Code]
      ,[vBC_t0000096_Sachbudgetposten].[Finanzbudgetposten Lfd. Nr.]
      ,[vBC_t0000096_Sachbudgetposten].[Budgetbezeichnung]
      ,[vBC_t0000096_Sachbudgetposten].[Sachkontonummer]
      ,[vBC_t0000096_Sachbudgetposten].[Datum]
	  --in der General Ledger Setup Tabelle ist defineirt on welchem Global Dim Code welcher Dimensionswert steht
	  ,IIF([vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenstellencode] = [vSNCt_Aktiver_Mandant].[Kostenstelle Code]
																		,[vBC_t0000096_Sachbudgetposten].[Kostenstellencode]
																		,[vBC_t0000096_Sachbudgetposten].[Kostenträgercode]) 
		AS [Kostenstelle Code]
	  ,IIF([vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenträgercode] = [vSNCt_Aktiver_Mandant].[Kostenträger Code]
																		,[vBC_t0000096_Sachbudgetposten].[Kostenträgercode]
																		,[vBC_t0000096_Sachbudgetposten].[Kostenstellencode]) 
		AS [Kostenträger Code]
      ,[vBC_t0000096_Sachbudgetposten].[Betrag]
      ,[vBC_t0000096_Sachbudgetposten].[Finanzbudgetpostenbezeichnung]
	  ,[vBC_t0000096_Sachbudgetposten].[Bundesland]
  FROM [vv].[vBC_t0000096_Sachbudgetposten]

  LEFT JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON [vBC_t0000096_Sachbudgetposten].[Mandant Code] = [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code] = [vSNCt_Aktiver_Mandant].[Mandant Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fFinanzcontrolling90_2_UNION]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fFinanzcontrolling90_2_UNION



















CREATE VIEW

[fin].[fFinanzcontrolling90_2_UNION]


AS

SELECT [Mandant Code]
      ,CAST(''Actual'' AS NVARCHAR(10))		AS [Aktuell/Plan Code]
      ,CAST(''Actual'' AS NVARCHAR(21))		AS [Budget Code]
      ,[Sachposten Lfd. Nr.]				AS [Sachposten Lfd. Nr.]
      ,[Sachpostenbezeichnung]
      ,[Sachkontonummer]
      ,[Buchungsdatum] 
      ,[Belegart Code]
	  ,[Belegartbezeichnung DE]
	  ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Belegdatum]
      ,[Kostenstelle Code]
	  ,[Kostenträger Code]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Betrag]
      ,[Nullstellungsbuchung]
	  ,[Vorzeichenumkehr]
	  ,[Bundesland]
  FROM [fin].[fFinanzcontrolling95_2]
  
UNION ALL

SELECT [Mandant Code]
      ,CAST(''Plan'' AS NVARCHAR(10))			AS [Aktuell/Plan Code]
      ,[Budgetbezeichnung]					AS [Budget Code]
      ,[Finanzbudgetposten Lfd. Nr.]		AS [Finanzbudgetposten Lfd. Nr.]
      ,[Finanzbudgetpostenbezeichnung]
      ,[Sachkontonummer]
      ,[Datum]								AS [Buchungsdatum]
      ,CAST(NULL AS INT)					AS [Belegart Code]
      ,CAST(NULL AS NVARCHAR(50))			AS [Belegartbezeichnung DE]
	  ,CAST(NULL AS NVARCHAR(50))			AS [Belegartbezeichnung EN]
      ,CAST(NULL AS NVARCHAR(20))			AS [Belegnummer]
      ,[Datum]								AS [Belegdatum]
      ,[Kostenstelle Code]
	  ,NULL									AS [Kostenträger Code]
      ,CAST(0 AS NUMERIC(18,5))				AS [Sollbetrag]
      ,CAST(0 AS NUMERIC(18,5))				AS [Habenbetrag]
      ,[Betrag]
      ,CAST(0 AS INT)						AS [Neutrale Position Buchung]
	  ,CAST(0 AS INT)						AS [Vorzeichenumkehr]
	  ,[Bundesland]
  FROM [fin].[fFinanzcontrolling95_2_Budgeteintrag]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000113_Verkaufsrechnungzeile95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000113_Verkaufsrechnungzeile95_2
























CREATE VIEW [vv].[vBC_t0000113_Verkaufsrechnungzeile95_2]

AS

SELECT [SG_MandantCode]					AS [Mandant Code]												-- Mandant ID
      ,[Document No_]					AS [Belegnummer]												-- Belegnummer
      ,[Line No_]						AS [Zeilennummer]												-- Zeilennummer
      ,[Sell-to Customer No_]			AS [Verkauf an Debitornummer]									-- Verkauf an Debitornummer
      ,[Type]							AS [Produktart]													-- Produktart
      ,[No_]							AS [Produktnummer]												-- ProduktNnmmer
      ,[Quantity]						AS [Menge]														-- Menge
      ,[Unit Price]						AS [Verkaufspreis (MW)]												-- Verkaufspreis
      ,[Unit Cost (LCY)]				AS [Einstandspreis (MW)]										-- Einstandspreis (MW)
      ,[Line Discount Amount]			AS [Zeilenrabattbetrag]											-- ZeilenrabattBetrag
      ,[Amount]							AS [Betrag]														-- Betrag
      ,[Shortcut Dimension 1 Code]		AS [Kostenstellencode]											-- Kostenstellencode
      ,[Shortcut Dimension 2 Code]		AS [Kostenträgercode]											-- Kostenträgercode
      ,[Bill-to Customer No_]			AS [Rechnung an Debitornummer]									-- Rechnung an Debitornummer
      ,[Inv_ Discount Amount]			AS [Rechnungsrabattbetrag]										-- Rechnungsrabattbetrag
      ,[Unit Cost]						AS [Einstandspreis]												-- Einstandspreis
      ,[Line Amount]					AS [Zeilenbetrag]												-- Zeilenbetrag
      ,[Quantity (Base)]				AS [Menge (Basis)]												-- Menge (Basis)
      ,[Location Code]					AS [Lagerort Code]												-- Lagerort Code
      ,[Description]					AS [Beschreibung]												-- Beschreibung
      ,[Unit of Measure Code]			AS [Einheitencode]												-- Einheitencode
      ,[Shipment Date]					AS [Warenausgangsdatum]											-- Warenausgangsdatum
      ,[Dimension Set ID]				AS [Dimension Set ID]	-- Dimension Set ID Link zur Tabelle [Dimension Set Entry]
	  ,[VAT _]							AS [MwSt. in Prozent]											-- MwSt. in Prozent
	  ,[SG_Bundesland]						AS [Bundesland]													-- Bundesland
  FROM [ver].[BC_t0000113_Sales_Invoice_Line]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000113_Verkaufsrechnungzeile]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000113_Verkaufsrechnungzeile




CREATE VIEW [vv].[vBC_t0000113_Verkaufsrechnungzeile] AS
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Zeilennummer]
      ,[Verkauf an Debitornummer]
      ,[Produktart]
      ,[Produktnummer]
      ,[Menge]
      ,[Verkaufspreis (MW)]
      ,[Einstandspreis (MW)]
      ,[Zeilenrabattbetrag]
      ,[Betrag]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Einstandspreis]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[Lagerort Code]
      ,[Beschreibung]
      ,[Einheitencode]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Warenausgangsdatum])			AS [Warenausgangsdatum]
      ,[Dimension Set ID]
      ,[MwSt. in Prozent]
      ,[Bundesland]
  FROM [vv].[vBC_t0000113_Verkaufsrechnungzeile95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fFinanzcontrolling85_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fFinanzcontrolling85_2

















CREATE VIEW 

[fin].[fFinanzcontrolling85_2]

AS

SELECT [Mandant Code]
      ,[Aktuell/Plan Code]
      ,[Budget Code]
      ,[Sachposten Lfd. Nr.]
      ,[Sachpostenbezeichnung]
      ,[Sachkontonummer]
      ,[Buchungsdatum]
      ,[Belegart Code]
      ,[Belegartbezeichnung DE]
	  ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Belegdatum]
	  ,[Kostenträger Code]
      ,[Kostenstelle Code]
	  ,[Nullstellungsbuchung]
	  ,[Vorzeichenumkehr]
	  ,[Bundesland]
--Kennzahlen
      ,[Sollbetrag]			AS [Sollbetrag inkl. Budget]
      ,[Habenbetrag]		AS [Habenbetrag inkl. Budget]
      ,[Betrag]				AS [Betrag inkl. Budget]

      ,IIF([Aktuell/Plan Code] = ''Actual'',[Sollbetrag],0)	AS [Sollbetrag exkl. Budget]
      ,IIF([Aktuell/Plan Code] = ''Actual'',[Habenbetrag],0) AS [Habenbetrag exkl. Budget] 
      ,IIF([Aktuell/Plan Code] = ''Actual'',[Betrag],0)		AS [Betrag exkl. Budget]

	  ,IIF([Aktuell/Plan Code] = ''Actual'' and [Nullstellungsbuchung] = 0,[Sollbetrag],0)	AS [Sollbetrag exkl. Budget & Nullstellung]
	  ,IIF([Aktuell/Plan Code] = ''Actual'' and [Nullstellungsbuchung] = 0,[Habenbetrag],0)	AS [Habenbetrag exkl. Budget & Nullstellung]
	  ,IIF([Aktuell/Plan Code] = ''Actual'' and [Nullstellungsbuchung] = 0,[Betrag],0)			AS [Betrag exkl. Budget & Nullstellung]

      ,IIF([Aktuell/Plan Code] = ''Plan'',[Sollbetrag],0)	AS [Sollbetrag Budget]
      ,IIF([Aktuell/Plan Code] = ''Plan'',[Habenbetrag],0)	AS [Habenbetrag Budget]
      ,IIF([Aktuell/Plan Code] = ''Plan'',[Betrag],0)			AS [Betrag Budget]

      ,IIF([Nullstellungsbuchung] = 0,[Sollbetrag],0)		AS [Sollbetrag exkl. Nullstellung]
      ,IIF([Nullstellungsbuchung] = 0,[Habenbetrag],0)	AS [Habenbetrag exkl. Nullstellung] 
      ,IIF([Nullstellungsbuchung] = 0,[Betrag],0)			AS [Betrag exkl. Nullstellung]

      ,IIF([Nullstellungsbuchung] = 1,[Sollbetrag],0)		AS [Sollbetrag Nullstellung]
      ,IIF([Nullstellungsbuchung] = 1,[Habenbetrag],0)	AS [Habenbetrag Nullstellung] 
      ,IIF([Nullstellungsbuchung] = 1,[Betrag],0)			AS [Betrag Nullstellung]

  FROM [fin].[fFinanzcontrolling90_2_UNION]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000112_Verkaufsrechnungkopf95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000112_Verkaufsrechnungkopf95_2


















CREATE VIEW [vv].[vBC_t0000112_Verkaufsrechnungkopf95_2]

AS

SELECT [SG_MandantCode]			        	AS [Mandant Code]						-- Mandant ID
      ,[No_]								AS [Belegnummer]						-- Belegnummer
      ,[Sell-to Customer No_]				AS [Verkauf an Debitornummer]			-- Verkauf an Debitornummer
      ,[Bill-to Customer No_]				AS [Rechnung an Debitornummer]			-- Rechnung an Debitornummer
      ,[Ship-to Code]						AS [Lieferung an Debitornummer]		-- Lieferung an Debitornummer
      ,[Ship-to Name]						AS [Lieferung an Name]					-- Lieferung an Name
      ,[Ship-to City]						AS [Lieferung an Ort]					-- Lieferung an Ort  
	  ,[Posting Date]						AS [Buchungsdatum]						-- Buchungsdatum
      ,[Shipment Date]						AS [Warenausgangsdatum]					-- Warenausgangsdatum
      ,[Payment Terms Code]					AS [Zlg.-Bedingung Code]				-- Zahlungsbedingungcode
      ,[Currency Code]						AS [Währung Code]						-- Währungcode
      ,[Currency Factor]					AS [Währungsfaktor]						-- Währungfaktor
      ,[Salesperson Code]					AS [Verkäufer Code]						-- Verkäufercode
      ,[Document Date]						AS [Belegdatum]							-- Belegdatum
	  ,[Correction]				         	AS [Storno Flag]						-- Storno Flag
      ,[Document Type]						AS [Belegart]							-- Belegart
      ,[External Document No_]				AS [Externe Belegnummer]				-- externe Belegnummer
      ,[Order Date]							AS [Auftragsdatum]						-- Auftragsdatum
      ,[Due Date]							AS [Fälligkeitsdatum]					-- Fälligkeitsdatum
      ,[Sell-to Contact]					AS [Verkauf an Kontakt]							-- Kontakt
      ,[Posting Description]				AS [Beschreibung]						-- Beschreibung
      ,[Location Code]						AS [Lagerort Code]						-- Lagerortcode
      ,[Payment Discount _]					AS [Skonto]								-- Skonto
      ,[Pmt_ Discount Date]					AS [Skontodatum]						-- Skontodatum
	  ,[SG_Bundesland]							AS [Bundesland]							-- Bundesland
  FROM [ver].[BC_t0000112_Sales_Invoice_Header]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000112_Verkaufsrechnungkopf]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000112_Verkaufsrechnungkopf




CREATE VIEW [vv].[vBC_t0000112_Verkaufsrechnungkopf] AS
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Verkauf an Debitornummer]
      ,[Rechnung an Debitornummer]
      ,[Lieferung an Debitornummer]
      ,[Lieferung an Name]
      ,[Lieferung an Ort]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])				AS [Buchungsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Warenausgangsdatum])			AS [Warenausgangsdatum]
      ,[Zlg.-Bedingung Code]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])					AS [Belegdatum]
      ,[Storno Flag]
      ,[Belegart]
      ,[Externe Belegnummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Auftragsdatum])				AS [Auftragsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])			AS [Fälligkeitsdatum]
      ,[Verkauf an Kontakt]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[Skonto]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])		AS [Skontodatum]
      ,[Bundesland]
  FROM [vv].[vBC_t0000112_Verkaufsrechnungkopf95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling95_2_Rechnung]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fVerkaufscontrolling95_2_Rechnung























CREATE VIEW [ver].[fVerkaufscontrolling95_2_Rechnung] AS 

SELECT [vv].[vBC_t0000112_Verkaufsrechnungkopf].[Mandant Code]
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Belegnummer]
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Buchungsdatum]
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Währung Code]
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Währungsfaktor]
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Verkäufer Code]
	  ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Belegdatum]
	  ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Storno Flag]
	  ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Warenausgangsdatum]  		
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Externe Belegnummer]    
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Lagerort Code]    		
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Auftragsdatum]    			
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Fälligkeitsdatum]    								
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Verkauf an Kontakt]    		  					
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Beschreibung]    	  					
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Skonto]    	
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Skontodatum]    	
      ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Zlg.-Bedingung Code]  
	  ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Bundesland]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Zeilennummer]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Verkauf an Debitornummer]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Kostenstellencode]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Kostenträgercode]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Produktart]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Produktnummer]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Zeilenrabattbetrag]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Rechnung an Debitornummer]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Rechnungsrabattbetrag]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Zeilenbetrag]
	  ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Menge]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Menge (Basis)]
      ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Einstandspreis] 
	  ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Betrag]
	  ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Verkaufspreis (MW)] 
	  ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Einheitencode]    	 	
	  ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[Dimension Set ID]  
	  ,[vv].[vBC_t0000113_Verkaufsrechnungzeile].[MwSt. in Prozent]
  FROM [vv].[vBC_t0000112_Verkaufsrechnungkopf]

LEFT JOIN [vv].[vBC_t0000113_Verkaufsrechnungzeile]

ON  [vv].[vBC_t0000112_Verkaufsrechnungkopf].[Mandant Code]	            = [vv].[vBC_t0000113_Verkaufsrechnungzeile].[Mandant Code]
AND	[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Belegnummer]	= [vv].[vBC_t0000113_Verkaufsrechnungzeile].[Belegnummer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fFinanzcontrolling80_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fFinanzcontrolling80_2_CONCAT

CREATE VIEW [fin].[fFinanzcontrolling80_2_CONCAT]AS
SELECT [Mandant Code]
      ,[Aktuell/Plan Code]
      ,[Budget Code]
      ,[Sachposten Lfd. Nr.]
      ,[Sachpostenbezeichnung]
      ,[Sachkontonummer]
      ,[Buchungsdatum]
      ,[Belegart Code]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Belegdatum]
      ,[Kostenträger Code]
      ,[Kostenstelle Code]
      ,[Nullstellungsbuchung]
      ,[Vorzeichenumkehr]
      ,[Bundesland]
      ,[Sollbetrag inkl. Budget]
      ,[Habenbetrag inkl. Budget]
      ,[Betrag inkl. Budget]
      ,[Sollbetrag exkl. Budget]
      ,[Habenbetrag exkl. Budget]
      ,[Betrag exkl. Budget]
      ,[Sollbetrag exkl. Budget & Nullstellung]
      ,[Habenbetrag exkl. Budget & Nullstellung]
      ,[Betrag exkl. Budget & Nullstellung]
      ,[Sollbetrag Budget]
      ,[Habenbetrag Budget]
      ,[Betrag Budget]
      ,[Sollbetrag exkl. Nullstellung]
      ,[Habenbetrag exkl. Nullstellung]
      ,[Betrag exkl. Nullstellung]
      ,[Sollbetrag Nullstellung]
      ,[Habenbetrag Nullstellung]
      ,[Betrag Nullstellung]
	  --PK for PowerBI
	  ,[Mandant Code]																									AS [PK dMandant]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenstelle Code],''NULL'')															AS [PK dKostenstelleDimension]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenträger Code],''NULL'')															AS [PK dKostenträgerDimension]
	  ,[Mandant Code] +''_''+ ISNULL([Sachkontonummer],''NULL'')															AS [PK dSachkonto]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Belegdatum],21),''NULL'')											AS [PK dZeit (Belegdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Buchungsdatum],21),''NULL'')												AS [PK dZeit (Buchungsdatum)]
  FROM [fin].[fFinanzcontrolling85_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fFinanzcontrolling]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fFinanzcontrolling




















CREATE VIEW [fin].[fFinanzcontrolling] AS

SELECT [Mandant Code]
      ,[Aktuell/Plan Code]
      ,[Budget Code]
      ,[Sachposten Lfd. Nr.]
      ,[Sachpostenbezeichnung]
      ,[Sachkontonummer]
      ,[Buchungsdatum]
      ,[Belegart Code]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Belegdatum]
      ,[Kostenträger Code]
      ,[Kostenstelle Code]
      ,[Nullstellungsbuchung]
      ,[Vorzeichenumkehr]
      ,[Bundesland]
      ,[Sollbetrag inkl. Budget]
      ,[Habenbetrag inkl. Budget]
      ,[Betrag inkl. Budget]
      ,[Sollbetrag exkl. Budget]
      ,[Habenbetrag exkl. Budget]
      ,[Betrag exkl. Budget]
      ,[Sollbetrag exkl. Budget & Nullstellung]
      ,[Habenbetrag exkl. Budget & Nullstellung]
      ,[Betrag exkl. Budget & Nullstellung]
      ,[Sollbetrag Budget]
      ,[Habenbetrag Budget]
      ,[Betrag Budget]
      ,[Sollbetrag exkl. Nullstellung]
      ,[Habenbetrag exkl. Nullstellung]
      ,[Betrag exkl. Nullstellung]
      ,[Sollbetrag Nullstellung]
      ,[Habenbetrag Nullstellung]
      ,[Betrag Nullstellung]
      ,[PK dMandant]
      ,[PK dKostenstelleDimension]
      ,[PK dKostenträgerDimension]
      ,[PK dSachkonto]
      ,[PK dZeit (Belegdatum)]
      ,[PK dZeit (Buchungsdatum)]
  FROM [fin].[fFinanzcontrolling80_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000115_Verkaufsgutschriftzeile95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000115_Verkaufsgutschriftzeile95_2






















CREATE VIEW [vv].[vBC_t0000115_Verkaufsgutschriftzeile95_2]

AS

SELECT [SG_MandantCode]					AS [Mandant Code]													-- Mandant ID
      ,[Document No_]					AS [Belegnummer]													-- Belegnummer
      ,[Line No_]						AS [Zeilennummer]													-- Zeilennummer
      ,[Sell-to Customer No_]			AS [Verkauf an Debitor Code]										-- Verkauf an Debitor Code
      ,[Type]							AS [Produktart]														-- Produktart
      ,[No_]							AS [Produktnummer]													-- Produktnummer
      ,[Quantity]						AS [Menge]															-- Menge
      ,[Unit Price]						AS [Verkaufspreis (MW)]													-- Verkaufspreis
      ,[Unit Cost (LCY)]				AS [Einstandspreis (MW)]											-- Einstandspreis (MW)
      ,[Line Discount Amount]			AS [Zeilenrabattbetrag]												-- Zeilenrabattbetrag
      ,[Amount]							AS [Betrag]															-- Betrag
      ,[Shortcut Dimension 1 Code]		AS [Kostenstellencode]												-- Kostenstellencode
      ,[Shortcut Dimension 2 Code]		AS [Kostenträgercode]												-- Kostenträgercode
      ,[Bill-to Customer No_]			AS [Rechnung an Debitornummer]										-- Rechnung an Debitornummer
      ,[Inv_ Discount Amount]			AS [Rechnungsrabattbetrag]											-- Rechnungsrabattbetrag
      ,[Unit Cost]						AS [Einstandspreis]													-- Einstandspreis
      ,[Line Amount]					AS [Zeilenbetrag]													-- Zeilenbetrag
      ,[Quantity (Base)]				AS [Menge (Basis)]													-- Menge (Basis)
      ,[Location Code]				    AS [Lagerort Code]													-- Lagerort Code
      ,[Description]				    AS [Beschreibung]													-- Beschreibung
      ,[Unit of Measure Code]		    AS [Einheitencode]													-- Einheitencode
	  ,[Shipment Date]				    AS [Warenausgangsdatum]												-- Warenausgangsdatum
      ,[Dimension Set ID]				AS [Dimension Set ID]		-- Dimension Set ID Link zur Tabelle [Dimension Set Entry]
	  ,[VAT _]							AS [MwSt. in Prozent]												-- MwSt. in Prozent
	  ,[SG_Bundesland]						AS [Bundesland]														-- Bundesland
  FROM [ver].[BC_t0000115_Sales_Cr_Memo_Line]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000115_Verkaufsgutschriftzeile]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000115_Verkaufsgutschriftzeile


CREATE VIEW [vv].[vBC_t0000115_Verkaufsgutschriftzeile] AS
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Zeilennummer]
      ,[Verkauf an Debitor Code]
      ,[Produktart]
      ,[Produktnummer]
      ,[Menge]
      ,[Verkaufspreis (MW)]
      ,[Einstandspreis (MW)]
      ,[Zeilenrabattbetrag]
      ,[Betrag]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Einstandspreis]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[Lagerort Code]
      ,[Beschreibung]
      ,[Einheitencode]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Warenausgangsdatum])			AS [Warenausgangsdatum]
      ,[Dimension Set ID]
      ,[MwSt. in Prozent]
      ,[Bundesland]
  FROM [vv].[vBC_t0000115_Verkaufsgutschriftzeile95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fBilanz95_2






















CREATE VIEW

[fin].[fBilanz95_2]

AS

SELECT [fin].[fFinanzcontrolling].[Mandant Code]
	  ,[fin].[fFinanzcontrolling].[Sachkontonummer]
	  ,[fin].[fFinanzcontrolling].[Kostenstelle Code]
	  ,[fin].[fFinanzcontrolling].[Buchungsdatum]
	  ,[fin].[fFinanzcontrolling].[Nullstellungsbuchung]
	  --,[fin].[fFinanceControlling].[Amount incl. Budget]		AS [Amount]
      ,[fin].[fFinanzcontrolling].[Betrag exkl. Budget & Nullstellung]		AS [Betrag]
	  ,[fin].[fFinanzcontrolling].[Bundesland]
	  ,[fin].[fFinanzcontrolling].[Aktuell/Plan Code]
  FROM [fin].[fFinanzcontrolling]

  --Plan/Budget Daten werden abgefiltert
  WHERE [fin].[fFinanzcontrolling].[Aktuell/Plan Code] = ''Actual''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fBilanz90_2



















CREATE VIEW

[fin].[fBilanz90_2]

AS

SELECT [Mandant Code]
	  ,[Bundesland]
      ,[Sachkontonummer]
	  ,[Kostenstelle Code]
	  -- Nullstellungen müssen in den Folgemonat (bzw. Folgegeschäftsjahr)
	  -- umdatiert werden, um für GuV Konten für den ersten Geschäftsmonat einen Bestand von 0 auszuweisen
      ,CASE WHEN [Nullstellungsbuchung] = 1
			THEN DATEADD(S,1,[Buchungsdatum])
			ELSE [Buchungsdatum]
       END AS [Buchungsdatum]
      ,[Betrag] AS [Bewegung inkl. Nullstellungsbuchung]
	  ,CASE WHEN [Nullstellungsbuchung] = 1 
			THEN 0 
			ELSE [Betrag]
       END AS  [Bewegung exkl. Nullstellungsbuchung]
  FROM [fin].[fBilanz95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000114_Verkaufsgutschriftkopf95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000114_Verkaufsgutschriftkopf95_2
















CREATE VIEW [vv].[vBC_t0000114_Verkaufsgutschriftkopf95_2]

AS

SELECT [SG_MandantCode]			        	AS [Mandant Code]					-- Mandant ID
      ,[No_]								AS [Belegnummer]					-- Belegnummer
      ,[Sell-to Customer No_]				AS [Verkauf an Debitornummer]		-- Verkauf an Debitornummer
      ,[Bill-to Customer No_]				AS [Rechnung an Debitornummer]		-- Rechnung an Debitornummer
      ,[Ship-to Code]						AS [Lieferung an Debitornummer]	-- Lieferung an Debitornummer
      ,[Ship-to Name]						AS [Lieferung an Name]				-- Lieferung an Name
      ,[Ship-to City]						AS [Lieferung an Ort]				-- Lieferung an Ort
	  ,[Posting Date]						AS [Buchungsdatum]					-- Buchungsdatum
      ,[Shipment Date]						AS [Warenausgangsdatum]				-- Warenausgangsdatum
      ,[Payment Terms Code]					AS [Zlg.-Bedingungscode]			-- Zahlungsbedingungscode
      ,[Currency Code]						AS [Währung Code]					-- Währungscode
      ,[Currency Factor]					AS [Währungsfaktor]				-- Währungsfaktor
      ,[Salesperson Code]					AS [Verkäufer Code]					-- Verkauefercode
      ,[Document Date]						AS [Belegdatum]						-- Belegdatum
	  ,[Correction]				         	AS [Storno]							-- Storno
      ,[External Document No_]				AS [Externe Belegnummer]			-- externe Belegnummer
      ,[Due Date]							AS [Fälligkeitsdatum]				-- Fälligkeitsdatum
      ,[Sell-to Contact]					AS [Verkauf an Kontakt]						-- Kontakt
      ,[Posting Description]				AS [Buchungsbeschreibung]					-- Beschreibung
      ,[Location Code]						AS [Lagerort Code]					-- Lagerort Code
      ,[Payment Discount _]					AS [Skonto]							-- Skonto
      ,[Pmt_ Discount Date]					AS [Skontodatum]					-- Skontodatum
	  ,[SG_Bundesland]							AS [Bundesland]						-- Bundesland
  FROM [ver].[BC_t0000114_Sales_Cr_Memo_Header]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000114_Verkaufsgutschriftkopf]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000114_Verkaufsgutschriftkopf



CREATE VIEW [vv].[vBC_t0000114_Verkaufsgutschriftkopf] AS 
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Verkauf an Debitornummer]
      ,[Rechnung an Debitornummer]
      ,[Lieferung an Debitornummer]
      ,[Lieferung an Name]
      ,[Lieferung an Ort]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])				AS [Buchungsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Warenausgangsdatum])			AS [Warenausgangsdatum]
      ,[Zlg.-Bedingungscode]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])					AS [Belegdatum]
      ,[Storno]
      ,[Externe Belegnummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])			AS [Fälligkeitsdatum]
	  ,[Verkauf an Kontakt]
      ,[Buchungsbeschreibung]
      ,[Lagerort Code]
      ,[Skonto]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])					AS [Skontodatum]
      ,[Bundesland]
  FROM [vv].[vBC_t0000114_Verkaufsgutschriftkopf95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz85_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fBilanz85_2



















CREATE VIEW

[fin].[fBilanz85_2]

AS

SELECT [Mandant Code]
	  ,[Bundesland]
	  ,[Sachkontonummer]
	  ,[Kostenstelle Code]
      ,CAST(EOMONTH([Buchungsdatum]) AS DATETIME) AS [Buchungsdatum]
      ,[Bewegung inkl. Nullstellungsbuchung]
      ,[Bewegung exkl. Nullstellungsbuchung]
  FROM [fin].[fBilanz90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling95_2_Gutschrift]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fVerkaufscontrolling95_2_Gutschrift


















 



CREATE VIEW [ver].[fVerkaufscontrolling95_2_Gutschrift] AS 

SELECT [vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Mandant Code]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Belegnummer]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Buchungsdatum]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Währung Code]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Währungsfaktor]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Verkäufer Code]
	  ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Belegdatum]
	  ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Storno]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Externe Belegnummer]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Fälligkeitsdatum]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Verkauf an Kontakt]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Buchungsbeschreibung]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Lagerort Code]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Skonto]
      ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Skontodatum]
	  ,[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Bundesland]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Zeilennummer]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Verkauf an Debitor Code]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Kostenstellencode]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Kostenträgercode]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Produktart]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Produktnummer]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Zeilenrabattbetrag] * -1	 AS  [Zeilenrabattbetrag]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Rechnung an Debitornummer]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Rechnungsrabattbetrag] * -1	 AS  [Rechnungsrabattbetrag]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Zeilenbetrag] * -1			 AS  [Zeilenbetrag]
	  ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Menge] * -1				 AS  [Menge]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Menge (Basis)] * -1		 AS  [Menge (Basis)]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Einstandspreis] * -1				 AS  [Einstandspreis]
	  ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Betrag]
	  ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Verkaufspreis (MW)]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Beschreibung]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Einheitencode]
      ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Warenausgangsdatum]
	  ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Dimension Set ID]
	  ,[vv].[vBC_t0000115_Verkaufsgutschriftzeile].[MwSt. in Prozent]
  FROM [vv].[vBC_t0000114_Verkaufsgutschriftkopf]

LEFT JOIN [vv].[vBC_t0000115_Verkaufsgutschriftzeile]
ON	[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Mandant Code]				= [vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Mandant Code]
AND	[vv].[vBC_t0000114_Verkaufsgutschriftkopf].[Belegnummer]	= [vv].[vBC_t0000115_Verkaufsgutschriftzeile].[Belegnummer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz80_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fBilanz80_2





















CREATE VIEW [fin].[fBilanz80_2]

AS

SELECT [Mandant Code]
	  ,[Bundesland]
	  ,[Sachkontonummer]
	  ,[Kostenstelle Code]
      ,[Buchungsdatum]
      ,SUM([Bewegung inkl. Nullstellungsbuchung]) AS [Bewegung inkl. Nullstellungsbuchung]
      ,SUM([Bewegung exkl. Nullstellungsbuchung]) AS [Bewegung exkl. Nullstellungsbuchung]
  FROM [fin].[fBilanz85_2]
  
  GROUP BY [Mandant Code]
		  ,[Bundesland]
		  ,[Sachkontonummer]
		  ,[Kostenstelle Code]
		  ,[Buchungsdatum]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000037_Verkaufsbelegzeile95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000037_Verkaufsbelegzeile95_2





























CREATE VIEW [vv].[vBC_t0000037_Verkaufsbelegzeile95_2]

AS

SELECT [SG_MandantCode]					AS [Mandant Code]												-- Mandant ID
      ,[Document Type]					AS [Belegart]													-- Belegart
      ,[Document No_]					AS [Belegnummer]												-- Belegnummer
      ,[Line No_]						AS [Zeilennummer]												-- Zeilennummer
      ,[Sell-to Customer No_]			AS [Verkauf an Debitornummer]									-- Verkauf an Debitornummer
      ,[Type]							AS [Produktart]													-- Produktart
      ,[No_]							AS [Produktnummer]												-- Produktnummer
      ,[Quantity]						AS [Menge]														-- Menge
      ,[Outstanding Quantity]			AS [Restauftragsmenge]											-- Restauftragsmenge
	  ,[Outstanding Qty_ (Base)]        AS [Restauftragsmenge (Basis)]									-- Restauftragsmenge (Basis)
      ,[Unit Price]						AS [Verkaufspreis (MW)]												-- Verkaufspreis
      ,[Line Discount Amount]			AS [Zeilenrabattbetrag]											-- Zeilenrabattbetrag
      ,[Amount]							AS [Betrag]														-- Betrag
      ,[Shortcut Dimension 1 Code]		AS [Kostenstellencode]											-- Kostenstellencode
      ,[Shortcut Dimension 2 Code]		AS [Kostenträgercode]											-- Kostenträgercode
      ,[Outstanding Amount]				AS [Restauftragsbetrag]											-- Restauftragsbetrag
      ,[Bill-to Customer No_]			AS [Rechnung an Debitornummer]									-- Rechnung an Debitornummer
      ,[Inv_ Discount Amount]			AS [Rechnungsrabattbetrag]										-- Rechnungsrabattbetrag
      ,[Unit Cost]						AS [Einstandspreis]												-- Einstandspreis
      ,[Line Amount]					AS [Zeilenbetrag]												-- Zeilenbetrag
      ,[Quantity (Base)]				AS [Menge (Basis)]												-- Menge (Basis)
      ,[Promised Delivery Date]			AS [Lieferdatum Zugesagt]										-- Lieferdatum Zugesagt
      ,[Location Code]					AS [Lagerort Code]												-- Lagerort Code
      ,[Requested Delivery Date]		AS [Gewünschtes Lieferdatum]									-- gewünschtes Lieferdaatum
      ,[Description]					AS [Beschreibung]												-- Beschreibung
      ,[Unit of Measure Code]			AS [Einheitencode]												-- Einheitencode
      ,[Planned Delivery Date]			AS [Geplantes Lieferdatum]										-- geplantes Lieferdatum
      ,[Planned Shipment Date]			AS [Geplantes Warenausgangsdatum]								-- geplantes Warenausgangsdatum
      ,[Shipment Date]					AS [Lieferdatum]												-- Lieferdatum
      ,[Dimension Set ID]				AS [Dimension Set ID]	--Dimension Set ID Link zur Tabelle [Dimension Set Entry]
	  ,[VAT _]							AS [MwSt. %]													-- MwSt. in Prozent
	  ,[SG_Bundesland]						AS [Bundesland]
  FROM [ver].[BC_t0000037_Sales_Line]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000037_Verkaufsbelegzeile]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000037_Verkaufsbelegzeile






CREATE VIEW [vv].[vBC_t0000037_Verkaufsbelegzeile] AS 
SELECT [Mandant Code]
      ,[Belegart]
      ,[Belegnummer]
      ,[Zeilennummer]
      ,[Verkauf an Debitornummer]
      ,[Produktart]
      ,[Produktnummer]
      ,[Menge]
      ,[Restauftragsmenge]
      ,[Restauftragsmenge (Basis)]
      ,[Verkaufspreis (MW)]
      ,[Zeilenrabattbetrag]
      ,[Betrag]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Restauftragsbetrag]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Einstandspreis]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Lieferdatum Zugesagt])				AS [Lieferdatum Zugesagt]
      ,[Lagerort Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Gewünschtes Lieferdatum])				AS [Gewünschtes Lieferdatum]
      ,[Beschreibung]
      ,[Einheitencode]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Geplantes Lieferdatum])				AS [Geplantes Lieferdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Geplantes Warenausgangsdatum])		AS [Geplantes Warenausgangsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Lieferdatum])							AS [Lieferdatum]
      ,[Dimension Set ID]
	  ,[MwSt. %]
      ,[Bundesland]
  FROM [vv].[vBC_t0000037_Verkaufsbelegzeile95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000036_Verkaufsbelegkopf95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000036_Verkaufsbelegkopf95_2
-- Alter View vBC_t0000036_Verkaufsbelegkopf95_2



















CREATE VIEW [vv].[vBC_t0000036_Verkaufsbelegkopf95_2]

AS

SELECT [SG_MandantCode]				AS [Mandant Code]							-- Mandant ID
      ,[Document Type]				AS [Belegart]								-- Belegart
      ,[No_]						AS [Belegnummer]							-- Belegnummer
      ,[Sell-to Customer No_]		AS [Verkauf an Debitornummer]				-- Verkauf an Debitornummer
      ,[Bill-to Customer No_]		AS [Rechnung an Debitornummer]				-- Rechnung an Debitornummer
      ,[Posting Date]				AS [Buchungsdatum]							-- Buchungsdatum
      ,[Currency Code]				AS [Währung Code]							-- Währungscode
      ,[Currency Factor]			AS [Währungsfaktor]						-- Währungsfaktor
      ,[Salesperson Code]			AS [Verkäufer Code]							-- Verkauefercode
      ,[Correction]					AS [Storno]									-- Storno
	  ,[Document Date]				AS [Belegdatum]								-- Belegdatum
      ,[Promised Delivery Date]		AS [Lieferdatum Zugesagt]					-- Lieferdatum Zugesagt]
	  ,[Shipment Date]				AS [Lieferdatum]							-- Lieferdatum]
	  ,[Status]						AS [Status]									-- Status
	  ,[SG_Bundesland]					AS [Bundesland]								-- Bundesland
      ,[External Document No_]		AS [Externe Belegnummer]					-- externe Belegnummer
      ,[Order Date]					AS [Auftragsdatum]							-- Auftragsdatum
      ,[Due Date]					AS [Fälligkeitsdatum]						-- Fällgikeitsdatun
      ,[Requested Delivery Date]	AS [Gewünschtes Lieferdatum]				-- Gewünschtes Lieferdatum
      ,[Sell-to Contact]			AS [Verkauf an Kontakt]								-- Kontakt
      ,[Posting Description]		AS [Beschreibung]							-- Beschreibung
      ,[Location Code]				AS [Lagerort Code]							-- Lagerort Code
      ,[Payment Discount _]			AS [Zahlungsrabatt %]						-- Skonto %
      ,[Pmt_ Discount Date]			AS [Skontodatum]							-- Skontodatum
      ,[Payment Terms Code]			AS [Zlg.-Bedingungscode]					-- Zahlungsbedinungscode
	  ,[Doc_ No_ Occurrence]		AS [Belegnummerhäufigkeit]					-- Belegnummernhäufigkeit
  FROM [ver].[BC_t0000036_Sales_Header]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000036_Verkaufsbelegkopf]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000036_Verkaufsbelegkopf





CREATE VIEW  [vv].[vBC_t0000036_Verkaufsbelegkopf] AS
SELECT [Mandant Code]
      ,[Belegart]
      ,[Belegnummer]
      ,[Verkauf an Debitornummer]
      ,[Rechnung an Debitornummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])				AS [Buchungsdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[Storno]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])					AS [Belegdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Lieferdatum Zugesagt])		AS [Lieferdatum Zugesagt]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Lieferdatum])					AS [Lieferdatum]
      ,[Status]
      ,[Bundesland]
      ,[Externe Belegnummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Auftragsdatum])				AS [Auftragsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])			AS [Fällgikeitsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Gewünschtes Lieferdatum])		AS [Gewünschtes Lieferdatum]
      ,[Verkauf an Kontakt]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[Zahlungsrabatt %]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])					AS [Skontodatum]
      ,[Zlg.-Bedingungscode]
      ,[Belegnummerhäufigkeit]
  FROM [vv].[vBC_t0000036_Verkaufsbelegkopf95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling95_2_Auftrag]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fVerkaufscontrolling95_2_Auftrag




























CREATE VIEW [ver].[fVerkaufscontrolling95_2_Auftrag] AS 
SELECT [vv].[vBC_t0000036_Verkaufsbelegkopf].[Mandant Code]
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Belegnummer]
	  ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Belegnummerhäufigkeit]
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Belegart]
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Buchungsdatum]
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Belegdatum]
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Währung Code]
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Währungsfaktor]
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Verkäufer Code]
	  ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Storno]
	  ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Lieferdatum]
	  ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Status]    		
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Externe Belegnummer]    
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Lagerort Code]    		
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Auftragsdatum]    			
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Fällgikeitsdatum]    				
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Gewünschtes Lieferdatum]   				
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Verkauf an Kontakt]    		  					
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Beschreibung]    	   				
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Zahlungsrabatt %]    	
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Skontodatum]    	
      ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Zlg.-Bedingungscode]   
	  ,[vv].[vBC_t0000036_Verkaufsbelegkopf].[Bundesland]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Zeilennummer]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Lieferdatum Zugesagt]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Menge]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Verkauf an Debitornummer]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Kostenstellencode]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Kostenträgercode]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Produktart]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Produktnummer]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Zeilenrabattbetrag]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Betrag]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Rechnung an Debitornummer]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Rechnungsrabattbetrag]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Zeilenbetrag]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Restauftragsbetrag]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Restauftragsmenge]
	  ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Restauftragsmenge (Basis)]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Verkaufspreis (MW)]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Menge (Basis)]
      ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Einstandspreis]
	  ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Einheitencode]    	
	  ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Geplantes Lieferdatum]   	
	  ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Geplantes Warenausgangsdatum]  
	  ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[Dimension Set ID]
	  ,[vv].[vBC_t0000037_Verkaufsbelegzeile].[MwSt. %]
  FROM [vv].[vBC_t0000036_Verkaufsbelegkopf]

LEFT JOIN [vv].[vBC_t0000037_Verkaufsbelegzeile]
ON	[vv].[vBC_t0000036_Verkaufsbelegkopf].[Mandant Code]			= [vv].[vBC_t0000037_Verkaufsbelegzeile].[Mandant Code]
AND	[vv].[vBC_t0000036_Verkaufsbelegkopf].[Belegnummer]	= [vv].[vBC_t0000037_Verkaufsbelegzeile].[Belegnummer]
AND	[vv].[vBC_t0000036_Verkaufsbelegkopf].[Belegart]	= [vv].[vBC_t0000037_Verkaufsbelegzeile].[Belegart]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005107_Verkaufskopfarchiv95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005107_Verkaufskopfarchiv95_2
-- Alter View vBC_t0005107_Verkaufskopf_Archiv95_2



















CREATE VIEW [vv].[vBC_t0005107_Verkaufskopfarchiv95_2]

AS

SELECT [SG_MandantCode]			        	AS [Mandant Code]					-- Mandant ID		
      ,[Document Type]						AS [Belegart]						-- Belegart
      ,[No_]								AS [Belegnummer]					-- Belegnummer
      ,[Doc_ No_ Occurrence]				AS [Belegnummer Häufigkeit]		-- Belegnummer Häufgkeit
      ,[Version No_]						AS [Versionsnummer]					-- Versionsnummer
      ,[Sell-to Customer No_]				AS [Verkauf an Debitornummer]		-- Verkauf an Debitornummer
      ,[Bill-to Customer No_]				AS [Rechnung an Debitornummer]		-- Rechnung an Debitornummer
	  ,[Posting Date]						AS [Buchungsdatum]					-- Buchungsdatum
      ,[Currency Code]						AS [Währung Code]					-- Währungscode
      ,[Currency Factor]					AS [Währungsfaktor]				-- Währungsfaktor
      ,[Salesperson Code]					AS [Verkäufer Code]					-- Verkauefercode
      ,[Document Date]						AS [Belegdatum]						-- Belegdatum
      ,[Promised Delivery Date]				AS [Lieferdatum Zugesagt]			-- Lieferdatum Zugesagt
	  ,[Correction]				         	AS [Storno]							-- Storno
	  ,[Shipment Date]						AS [Lieferdatum]					-- Lieferdatum
      ,[External Document No_]				AS [Externe Belegnummer]			-- externe Belegnummer
      ,[Order Date]							AS [Auftragsdatum]					-- Auftragsdatum
      ,[Due Date]							AS [Fälligkeitsdatum]				-- Fälligkeitsdatum
      ,[Requested Delivery Date]			AS [Gewünschtes Lieferdatum]		-- gewünschtes Lieferdatum
      ,[Status]								AS [Status]							-- Status
      ,[Sell-to Contact]					AS [Verkauf an Kontakt]						-- Kontakt
      ,[Posting Description]				AS [Buchungsbeschreibung]					-- Beschreibung
      ,[Location Code]						AS [Lagerort Code]				-- Lagerort Code  
      ,[Payment Discount _]					AS [Skonto]							-- Skonto
      ,[Pmt_ Discount Date]					AS [Skontodatum]					-- Skontodatum
      ,[Payment Terms Code]					AS [Zahlungsbedingungscode]			-- Zahlungsbedingungscode
	  ,[SG_Bundesland]							AS [Bundesland]						-- Bundesland
  FROM [ver].[BC_t0005107_Sales_Header_Archive]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005107_Verkaufskopfarchiv]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005107_Verkaufskopfarchiv
-- Alter View vBC_t0005107_Verkaufskopf_Archiv



CREATE VIEW [vv].[vBC_t0005107_Verkaufskopfarchiv] AS
SELECT [Mandant Code]
      ,[Belegart]
      ,[Belegnummer]
      ,[Belegnummer Häufigkeit]
      ,[Versionsnummer]
      ,[Verkauf an Debitornummer]
      ,[Rechnung an Debitornummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])			AS [Buchungsdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])				AS [Belegdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Lieferdatum Zugesagt])	AS [Lieferdatum Zugesagt]
      ,[Storno]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Lieferdatum])				AS [Lieferdatum]
      ,[Externe Belegnummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Auftragsdatum])			AS [Auftragsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])		AS [Fälligkeitsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Gewünschtes Lieferdatum])	AS [Gewünschtes Lieferdatum]
      ,[Status]
      ,[Verkauf an Kontakt]
      ,[Buchungsbeschreibung]
      ,[Lagerort Code]
      ,[Skonto]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])		AS [Skontodatum]
      ,[Zahlungsbedingungscode]
      ,[Bundesland]
  FROM [vv].[vBC_t0005107_Verkaufskopfarchiv95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005108_Verkaufszeilenarchiv95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005108_Verkaufszeilenarchiv95_2
























CREATE VIEW [vv].[vBC_t0005108_Verkaufszeilenarchiv95_2]

AS

SELECT [SG_MandantCode]					AS [Mandant Code]												-- Mandant ID
      ,[Document Type]					AS [Belegart]													-- Belegart
      ,[Document No_]					AS [Belegnummer]												-- Belegnummer
      ,[Doc_ No_ Occurrence]			AS [Belegnummer Häufigkeit]									-- Belegnummer Häufgkeit
      ,[Version No_]					AS [Versionsnummer]												-- Versionsnummer
      ,[Line No_]						AS [Zeilennummer]												-- Zeilennummer
      ,[Sell-to Customer No_]			AS [Verkauf an Debitor Code]									-- Verkauf an Debitor Code
      ,[Type]							AS [Produktart]													-- Produktart
      ,[No_]							AS [Produktnummer]												-- Produktnummer
      ,[Quantity]						AS [Menge]														-- Menge
      ,[Outstanding Quantity]			AS [Restauftragsmenge]											-- Restauftragsmenge
	  ,[Outstanding Qty_ (Base)]        AS [Restauftragsmenge (Basis)]									-- Restauftragsmenge (Basis)
      ,[Unit Price]						AS [Verkaufspreis (MW)]												-- Verkaufspreis
      ,[Line Discount Amount]			AS [Zeilenrabattbetrag]											-- Zeilenrabattbetrag
      ,[Amount]							AS [Betrag]														-- Betrag
      ,[Outstanding Amount]				AS [Restauftragsbetrag]											-- Restauftragsbetrag
      ,[Bill-to Customer No_]			AS [Rechnung an Debitornummer]									-- Rechnung an Debitornummer
      ,[Inv_ Discount Amount]			AS [Rechnungsrabattbetrag]										-- Rechnungsrabattbetrag
      ,[Line Amount]					AS [Zeilenbetrag]												-- Zeilenbetrag
      ,[Quantity (Base)]				AS [Menge (Basis)]												-- Menge (Basis)
      ,[Promised Delivery Date]			AS [Lieferdatum Zugesagt]										-- Lieferdatum Zugesagt
      ,[Shortcut Dimension 1 Code]		AS [Kostenstellencode]											-- Kostenstellencode
      ,[Shortcut Dimension 2 Code]		AS [Kostenträgercode]											-- Kostenträgercode
      ,[Unit Cost]						AS [Einstandspreis]												-- Einstandspreis
      ,[Location Code]					AS [Lagerort Code]												-- Lagerort Code
      ,[Requested Delivery Date]		AS [Gewünschtes Warenausgangsdatum]								-- Gewünschtes Warenausgangsdatum
      ,[Description]					AS [Beschreibung]												-- Beschreibung
      ,[Unit of Measure Code]			AS [Einheitencode]												-- Einheitencode
      ,[Planned Delivery Date]			AS [Geplantes Lieferdatum]										-- geplantes Lieferdatum
      ,[Planned Shipment Date]			AS [Geplantes Warenausgangsdatum]								-- geplantes Warenausgangsdatum
      ,[Shipment Date]					AS [Warenausgangsdatum]											-- Warenausgangsdatum
      ,[Dimension Set ID]				AS [Dimension Set ID]	-- Dimension Set ID Link zur Tabelle [Dimension Set Entry]
	  ,[VAT _]							AS [MwSt. in Prozent]											-- MwSt. in Prozent
	  ,[SG_Bundesland]						AS [Bundesland]													-- Bundeland
  FROM [ver].[BC_t0005108_Sales_Line_Archive]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005108_Verkaufszeilenarchiv]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005108_Verkaufszeilenarchiv



CREATE VIEW [vv].[vBC_t0005108_Verkaufszeilenarchiv] AS
SELECT [Mandant Code]
      ,[Belegart]
      ,[Belegnummer]
      ,[Belegnummer Häufigkeit]
      ,[Versionsnummer]
      ,[Zeilennummer]
      ,[Verkauf an Debitor Code]
      ,[Produktart]
      ,[Produktnummer]
      ,[Menge]
      ,[Restauftragsmenge]
      ,[Restauftragsmenge (Basis)]
      ,[Verkaufspreis (MW)]
      ,[Zeilenrabattbetrag]
      ,[Betrag]
      ,[Restauftragsbetrag]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Lieferdatum Zugesagt])					AS [Lieferdatum Zugesagt]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Einstandspreis]
      ,[Lagerort Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Gewünschtes Warenausgangsdatum])			AS [Gewünschtes Warenausgangsdatum]
      ,[Beschreibung]
      ,[Einheitencode]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Geplantes Lieferdatum])					AS [Geplantes Lieferdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Geplantes Warenausgangsdatum])			AS [Geplantes Warenausgangsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Warenausgangsdatum])						AS [Warenausgangsdatum]
      ,[Dimension Set ID]
      ,[MwSt. in Prozent]
      ,[Bundesland]
  FROM [vv].[vBC_t0005108_Verkaufszeilenarchiv95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling95_2_Archiv]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fVerkaufscontrolling95_2_Archiv
























CREATE VIEW [ver].[fVerkaufscontrolling95_2_Archiv] AS 
SELECT [vv].[vBC_t0005107_Verkaufskopfarchiv].[Mandant Code]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Belegnummer]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Belegart]
	  ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Versionsnummer]
	  ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Belegnummer Häufigkeit]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Buchungsdatum]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Belegdatum]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Währung Code]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Währungsfaktor]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Verkäufer Code]
	  ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Storno]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Lieferdatum]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Externe Belegnummer]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Auftragsdatum]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Fälligkeitsdatum]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Gewünschtes Lieferdatum]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Status]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Verkauf an Kontakt]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Buchungsbeschreibung]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Lagerort Code]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Skonto]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Skontodatum]
      ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Zahlungsbedingungscode]
	  ,[vv].[vBC_t0005107_Verkaufskopfarchiv].[Bundesland]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Zeilennummer]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Lieferdatum Zugesagt]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Menge]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Verkauf an Debitor Code]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Kostenstellencode]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Kostenträgercode]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Produktart]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Produktnummer]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Zeilenrabattbetrag]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Betrag]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Rechnung an Debitornummer]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Rechnungsrabattbetrag]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Zeilenbetrag]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Restauftragsbetrag]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Restauftragsmenge]
	  ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Restauftragsmenge (Basis)]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Verkaufspreis (MW)]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Menge (Basis)]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Einstandspreis]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Beschreibung]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Einheitencode]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Geplantes Lieferdatum]
      ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Geplantes Warenausgangsdatum]
	  ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[Dimension Set ID]
	  ,[vv].[vBC_t0005108_Verkaufszeilenarchiv].[MwSt. in Prozent]
  FROM [vv].[vBC_t0005107_Verkaufskopfarchiv]

LEFT JOIN [vv].[vBC_t0005108_Verkaufszeilenarchiv]
ON	[vv].[vBC_t0005107_Verkaufskopfarchiv].[Mandant Code]				= [vv].[vBC_t0005108_Verkaufszeilenarchiv].[Mandant Code]
AND	[vv].[vBC_t0005107_Verkaufskopfarchiv].[Belegnummer]	= [vv].[vBC_t0005108_Verkaufszeilenarchiv].[Belegnummer]
AND	[vv].[vBC_t0005107_Verkaufskopfarchiv].[Belegart]			= [vv].[vBC_t0005108_Verkaufszeilenarchiv].[Belegart]
AND	[vv].[vBC_t0005107_Verkaufskopfarchiv].[Versionsnummer]					= [vv].[vBC_t0005108_Verkaufszeilenarchiv].[Versionsnummer]
AND	[vv].[vBC_t0005107_Verkaufskopfarchiv].[Belegnummer Häufigkeit]			= [vv].[vBC_t0005108_Verkaufszeilenarchiv].[Belegnummer Häufigkeit]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling90_2_ArchivbelegAusschließen













--laut Nschuette werden bei aktuellen Belegen die archivierten Belege nicht benötigt. daher werden diese hier rausgefilter. (09.03.2020 - JW)

CREATE VIEW [ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen] AS 
SELECT [Mandant Code]
      ,[Belegnummer]
	  ,[Belegnummer Häufigkeit]
      ,[Belegart]
  FROM [ver].[fVerkaufscontrolling95_2_Archiv]
  EXCEPT 
  SELECT [Mandant Code]
      ,[Belegnummer]
	  ,[Belegnummerhäufigkeit]
      ,[Belegart]
  FROM [ver].[fVerkaufscontrolling95_2_Auftrag]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling85_2_MaxVersion]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling85_2_MaxVersion





















CREATE VIEW [ver].[fVerkaufscontrolling85_2_MaxVersion] AS 

SELECT [ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Mandant Code]
      ,[ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Belegnummer]
      ,[ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Belegart]
      ,[ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Belegnummer Häufigkeit]
      ,MAX([ver].[fVerkaufscontrolling95_2_Archiv].[Versionsnummer]) AS [Versionsnummer (Max)]
  FROM [ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen]

  LEFT JOIN [ver].[fVerkaufscontrolling95_2_Archiv]
  ON [ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Mandant Code]					= [ver].[fVerkaufscontrolling95_2_Archiv].[Mandant Code]
  AND [ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Belegnummer]	= [ver].[fVerkaufscontrolling95_2_Archiv].[Belegnummer]
  AND [ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Belegart]			= [ver].[fVerkaufscontrolling95_2_Archiv].[Belegart]

GROUP BY  [ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Mandant Code]
          ,[ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Belegart]
		  ,[ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Belegnummer]
		  ,[ver].[fVerkaufscontrolling90_2_ArchivbelegAusschließen].[Belegnummer Häufigkeit]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling80_2_ArchivMaxVersion]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling80_2_ArchivMaxVersion






















CREATE VIEW [ver].[fVerkaufscontrolling80_2_ArchivMaxVersion] AS 
SELECT [ver].[fVerkaufscontrolling85_2_MaxVersion].[Mandant Code]
      ,[ver].[fVerkaufscontrolling85_2_MaxVersion].[Belegnummer]
      ,[ver].[fVerkaufscontrolling85_2_MaxVersion].[Belegart]
      ,[ver].[fVerkaufscontrolling85_2_MaxVersion].[Versionsnummer (Max)] AS [Versionsnummer]
      ,[ver].[fVerkaufscontrolling85_2_MaxVersion].[Belegnummer Häufigkeit]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Buchungsdatum]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Belegdatum]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Währung Code]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Währungsfaktor]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Verkäufer Code]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Storno]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Lieferdatum]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Externe Belegnummer]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Auftragsdatum]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Fälligkeitsdatum]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Gewünschtes Lieferdatum]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Status]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Verkauf an Kontakt]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Buchungsbeschreibung]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Lagerort Code]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Skonto]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Skontodatum]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Zahlungsbedingungscode]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Zeilennummer]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Lieferdatum Zugesagt]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Menge]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Verkauf an Debitor Code]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Kostenstellencode]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Kostenträgercode]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Produktart]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Produktnummer]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Zeilenrabattbetrag]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Betrag]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Rechnung an Debitornummer]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Rechnungsrabattbetrag]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Zeilenbetrag]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Restauftragsbetrag]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Restauftragsmenge]
	  ,[ver].[fVerkaufscontrolling95_2_Archiv].[Restauftragsmenge (Basis)]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Verkaufspreis (MW)]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Menge (Basis)]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Einstandspreis]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Beschreibung]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Einheitencode]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Geplantes Lieferdatum]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Geplantes Warenausgangsdatum]
	  ,[ver].[fVerkaufscontrolling95_2_Archiv].[Dimension Set ID]
	  ,[ver].[fVerkaufscontrolling95_2_Archiv].[MwSt. in Prozent]
      ,[ver].[fVerkaufscontrolling95_2_Archiv].[Bundesland]
  FROM [ver].[fVerkaufscontrolling85_2_MaxVersion]

LEFT JOIN [ver].[fVerkaufscontrolling95_2_Archiv] 
ON  [ver].[fVerkaufscontrolling85_2_MaxVersion].[Mandant Code]					= [ver].[fVerkaufscontrolling95_2_Archiv].[Mandant Code]
AND [ver].[fVerkaufscontrolling85_2_MaxVersion].[Belegart]			= [ver].[fVerkaufscontrolling95_2_Archiv].[Belegart]
AND [ver].[fVerkaufscontrolling85_2_MaxVersion].[Belegnummer]	= [ver].[fVerkaufscontrolling95_2_Archiv].[Belegnummer]
AND [ver].[fVerkaufscontrolling85_2_MaxVersion].[Belegnummer Häufigkeit]			= [ver].[fVerkaufscontrolling95_2_Archiv].[Belegnummer Häufigkeit]
AND [ver].[fVerkaufscontrolling85_2_MaxVersion].[Versionsnummer (Max)]			= [ver].[fVerkaufscontrolling95_2_Archiv].[Versionsnummer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling75_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling75_2

































CREATE VIEW [ver].[fVerkaufscontrolling75_2] AS 

SELECT [Mandant Code]
      ,[Belegnummer]				AS [Belegnummer]
	  ,CAST(1 AS INT)							AS [Belegnummer Häufigkeit]
      ,CAST(-1 AS INT)							AS [Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[Zeilennummer]		AS [Zeilennummer]
      ,[Verkauf an Debitornummer]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Produktart]
      ,[Produktnummer]
      ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge]      
      ,[Menge (Basis)]
      ,[Einstandspreis]
      ,[Menge] * [Einstandspreis]					AS [Einheit Betrag]
	  ,[Betrag]
	  ,[Verkaufspreis (MW)]
	  ,CAST(NULL AS DATETIME)					AS [Lieferdatum Zugesagt]    
	  ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsbetrag]
      ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsmenge]
	  ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsmenge (Basis)]
	  ,[Storno Flag]
	  ,CAST(NULL AS INT)						AS [Status]		
	  ,[Externe Belegnummer]    		
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,CAST(NULL AS DATETIME)					AS [Gewünschtes Lieferdatum]    				
	  ,[Verkauf an Kontakt]    		    					
	  ,[Beschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,CAST(NULL AS DATETIME)					AS [Geplantes Lieferdatum]   	
	  ,CAST(NULL AS DATETIME)					AS [Geplantes Warenausgangsdatum]   	
	  ,[Warenausgangsdatum]   			
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,[Zlg.-Bedingung Code]   
	  ,[Dimension Set ID]
	  ,[MwSt. in Prozent]
	  ,[Bundesland]
	  ,CAST(0 AS INT)							AS [Ist Archivbeleg]
  FROM [ver].[fVerkaufscontrolling95_2_Rechnung]

UNION ALL


SELECT [Mandant Code]
      ,[Belegnummer]			AS [Belegnummer]
	  ,CAST(1 AS INT)							AS [Belegnummer Häufigkeit]
      ,CAST(-2 AS INT)							AS [Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]      
      ,[Zeilennummer]		AS [Zeilennummer]
      ,[Verkauf an Debitor Code]
      ,[Kostenstellencode]
      ,[Kostenträgercode]      
      ,[Produktart]
      ,[Produktnummer]
      ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge]            
      ,[Menge (Basis)]
      ,[Einstandspreis]
      ,[Menge] * [Einstandspreis] *-1				AS [Einheit Betrag]
	  ,[Betrag]
	  ,[Verkaufspreis (MW)]
      ,CAST(NULL AS DATETIME)					AS [Lieferdatum Zugesagt]    
	  ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsbetrag]
      ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsmenge]
	  ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsmenge (Basis)]
	  ,[Storno]
	  ,CAST(NULL AS INT)						AS [Status]	
	  ,[Externe Belegnummer]       		
	  ,CAST(NULL AS DATETIME)					AS [Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,CAST(NULL AS DATETIME)					AS [Gewünschtes Lieferdatum]   
	  ,[Verkauf an Kontakt]    		    					
	  ,[Buchungsbeschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,CAST(NULL AS DATETIME)					AS [Geplantes Lieferdatum]   	
	  ,CAST(NULL AS DATETIME)					AS [Geplantes Warenausgangsdatum]   	
	  ,[Warenausgangsdatum]   			
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,CAST(NULL AS NVARCHAR(10))				AS [Zahlungsbedingungcode]    	
	  ,[Dimension Set ID]
	  ,[MwSt. in Prozent]
	  ,[Bundesland]
	  ,CAST(0 AS INT)							AS [Ist Archivbeleg]
  FROM [ver].[fVerkaufscontrolling95_2_Gutschrift]

  UNION ALL

SELECT [Mandant Code]
      ,[Belegnummer]						AS [Belegnummer]
	  ,[Belegnummerhäufigkeit]
	  ,[Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[Zeilennummer]				AS [Zeilennummer]
	  ,[Verkauf an Debitornummer]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Produktart]
      ,[Produktnummer]
      ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge]
      ,[Menge (Basis)]
      ,[Einstandspreis]
	  ,[Menge] * [Einstandspreis] *-1				AS [Einheit Betrag]
	  ,[Betrag]
	  ,[Verkaufspreis (MW)]
      ,[Lieferdatum Zugesagt]    
	  ,[Restauftragsbetrag]
      ,[Restauftragsmenge]
	  ,[Restauftragsmenge (Basis)]
	  ,[Storno]
	  ,[Status]   		
	  ,[Externe Belegnummer]    		
	  ,[Auftragsdatum]    			
	  ,[Fällgikeitsdatum]    				
	  ,[Gewünschtes Lieferdatum]   
	  ,[Verkauf an Kontakt]    		    					
	  ,[Beschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,[Geplantes Lieferdatum]   	
	  ,[Geplantes Warenausgangsdatum]   	
	  ,[Lieferdatum]   			
	  ,[Zahlungsrabatt %]    	
	  ,[Skontodatum]    	
	  ,[Zlg.-Bedingungscode]   
	  ,[Dimension Set ID]
	  ,[MwSt. %]
	  ,[Bundesland]
	  ,CAST(0 AS INT)							AS [Ist Archivbeleg]
  FROM [ver].[fVerkaufscontrolling95_2_Auftrag]

 UNION ALL

 SELECT [Mandant Code]
      ,[Belegnummer]				AS [Belegnummer]
	  ,[Belegnummer Häufigkeit]
      ,[Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[Zeilennummer]					AS [Zeilennummer]
      ,[Verkauf an Debitor Code]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Produktart]
      ,[Produktnummer]
      ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge]
      ,[Menge (Basis)]
      ,[Einstandspreis]
	  ,[Menge] * [Einstandspreis] *-1				AS [Einheit Betrag]
	  ,[Betrag]
	  ,[Verkaufspreis (MW)]
      ,[Lieferdatum Zugesagt]
      ,[Restauftragsbetrag]
      ,[Restauftragsmenge]
	  ,[Restauftragsmenge (Basis)]
	  ,[Storno]
	  ,[Status]		
	  ,[Externe Belegnummer]    		
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,[Gewünschtes Lieferdatum]   
	  ,[Verkauf an Kontakt]    		    					
	  ,[Buchungsbeschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,[Geplantes Lieferdatum]   	
	  ,[Geplantes Warenausgangsdatum]   	
	  ,[Lieferdatum]   			
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,[Zahlungsbedingungscode]  
	  ,[Dimension Set ID]
	  ,[MwSt. in Prozent]
	  ,[Bundesland]
	  ,CAST(1 AS INT)							AS [Ist Archivbeleg]
  FROM [ver].[fVerkaufscontrolling80_2_ArchivMaxVersion]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz65_2_Schlussbilanz]'))
EXEC dbo.sp_executesql @statement = N'







-- Alter View fBilanz65_2_Schlussbilanz


























CREATE VIEW

[fin].[fBilanz65_2_Schlussbilanz]

AS

SELECT [fBilanz80_2].[Mandant Code]
      ,[fBilanz80_2].[Kostenstelle Code]
	  ,[fBilanz80_2].[Bundesland]
      ,[TMP_fBilanz70_2_Zeit_Sachkonto].[Sachkontonummer] AS [Sachkontonummer]
      ,[TMP_fBilanz70_2_Zeit_Sachkonto].[Datum (Zeit)]
	  ,SUM([fBilanz80_2].[Bewegung exkl. Nullstellungsbuchung]) AS [Endsaldo]
  FROM [fin].[TMP_fBilanz70_2_Zeit_Sachkonto]

LEFT JOIN [fin].[fBilanz80_2]
ON  [TMP_fBilanz70_2_Zeit_Sachkonto].[Sachkontonummer]	=  [fBilanz80_2].[Sachkontonummer]
AND [TMP_fBilanz70_2_Zeit_Sachkonto].[Bundesland]				=  [fBilanz80_2].[Bundesland]
AND [TMP_fBilanz70_2_Zeit_Sachkonto].[Datum (Zeit)]		>= [fBilanz80_2].[Buchungsdatum]	



GROUP BY 
       [fBilanz80_2].[Mandant Code]
	  ,[fBilanz80_2].[Kostenstelle Code]
	  ,[fBilanz80_2].[Bundesland]
	  ,[TMP_fBilanz70_2_Zeit_Sachkonto].[Sachkontonummer]
      ,[TMP_fBilanz70_2_Zeit_Sachkonto].[Datum (Zeit)]



' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling70_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling70_2






























CREATE VIEW [ver].[fVerkaufscontrolling70_2] AS 

SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Belegnummer Häufigkeit]
      ,[Belegart]
      ,[Buchungsdatum]
      ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,ISNULL([Zeilennummer],0)							AS [Zeilennummer]
      ,ISNULL([Verkauf an Debitornummer],'''')			AS [Verkauf an Debitornummer]
      ,ISNULL([Kostenstellencode],'''')		AS [Kostenstellencode]
      ,ISNULL([Kostenträgercode],'''')		AS [Kostenträgercode]
      ,ISNULL([Produktart],0)						AS [Produktart]
      ,ISNULL([Produktnummer],'''')						AS [Produktnummer]
      ,ISNULL([Zeilenrabattbetrag],0)				AS [Zeilenrabattbetrag]
      ,ISNULL([Rechnung an Debitornummer],'''')			AS [Rechnung an Debitornummer]
      ,ISNULL([Rechnungsrabattbetrag],0)				AS [Rechnungsrabattbetrag]
      ,ISNULL([Zeilenbetrag],0)						AS [Zeilenbetrag]
      ,ISNULL([Menge],0)							AS [Menge]
      ,ISNULL([Menge (Basis)],0)					AS [Menge (Basis)]
      ,ISNULL([Einstandspreis],0)						AS [Einstandspreis]
      ,ISNULL([Einheit Betrag],0)						AS [Einheit Betrag]
      ,ISNULL([Betrag],0)							AS [Betrag]
      ,ISNULL([Verkaufspreis (MW)],0)						AS [Verkaufspreis (MW)]
      ,ISNULL([Lieferdatum Zugesagt],'''')			AS [Lieferdatum Zugesagt]
      ,ISNULL([Restauftragsbetrag],0)				AS [Restauftragsbetrag]
      ,ISNULL([Restauftragsmenge],0)				AS [Restauftragsmenge]
	  ,ISNULL([Restauftragsmenge (Basis)],0)		AS [Restauftragsmenge (Basis)]
      ,ISNULL([Storno Flag],0)						AS [Storno Flag]
	  ,[Warenausgangsdatum]  		
	  ,[Externe Belegnummer]     		
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,[Gewünschtes Lieferdatum]   
	  ,[Verkauf an Kontakt]    		    					
	  ,[Beschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,[Geplantes Lieferdatum]   	
	  ,[Geplantes Warenausgangsdatum]   				
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,[Zlg.-Bedingung Code]  
	  ,[Dimension Set ID]
	  ,[MwSt. in Prozent]
	  ,[Ist Archivbeleg]
	  ,CAST(CASE WHEN [Belegart] = 1 AND [Status] = 1 THEN 1 
																ELSE 0 
		END AS TINYINT) AS [Auftrag veröffentlicht]
	  ,[Bundesland]
  FROM [ver].[fVerkaufscontrolling75_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz65_2_Bewegung]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fBilanz65_2_Bewegung


























CREATE VIEW

[fin].[fBilanz65_2_Bewegung]

AS

SELECT [fBilanz80_2].[Mandant Code]
	  ,[fBilanz80_2].[Bundesland]
	  ,[fBilanz80_2].[Kostenstelle Code]
	  ,[TMP_fBilanz70_2_Zeit_Sachkonto].[Sachkontonummer] AS [Sachkontonummer]
      ,[TMP_fBilanz70_2_Zeit_Sachkonto].[Datum (Zeit)]
	  ,SUM([fBilanz80_2].[Bewegung inkl. Nullstellungsbuchung]) AS [Bewegung]
  FROM [fin].[TMP_fBilanz70_2_Zeit_Sachkonto]

LEFT JOIN [fin].[fBilanz80_2]
ON  [TMP_fBilanz70_2_Zeit_Sachkonto].[Sachkontonummer]	= [fBilanz80_2].[Sachkontonummer]
AND [TMP_fBilanz70_2_Zeit_Sachkonto].[Bundesland]				= [fBilanz80_2].[Bundesland]
AND [TMP_fBilanz70_2_Zeit_Sachkonto].[Datum (Zeit)]		= [fBilanz80_2].[Buchungsdatum]	

GROUP BY 
	   [fBilanz80_2].[Mandant Code]
	  ,[fBilanz80_2].[Bundesland]
	  ,[fBilanz80_2].[Kostenstelle Code]
      ,[TMP_fBilanz70_2_Zeit_Sachkonto].[Sachkontonummer]
      ,[TMP_fBilanz70_2_Zeit_Sachkonto].[Datum (Zeit)]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling65_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling65_2













































CREATE VIEW [ver].[fVerkaufscontrolling65_2] AS 

SELECT [Mandant Code]
      ,[Belegnummer]
	  ,[Belegnummer Häufigkeit]
	  ,[Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]      
      ,[Verkauf an Debitornummer]      
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Produktart]
      ,[Zeilennummer]
      ,[Produktnummer]
	  --wenn die Produktart = 2 ist, dann handelt es sich um einen Artikel, andernfalss Ressource oder Sachkonto
	  ,CASE WHEN [Produktart] = 2 THEN [Produktnummer]
								 ELSE ''''
	   END AS [Artikelnummer]
      ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
	  ,[Menge]
	  --2020-02-21 Anpassungswunsch NSchuette - JW
	  --Ansonsten ist die Marge höher als der Betrag
      ,[Einheit Betrag] * -1	AS [Einheit Betrag]
      ,[Einstandspreis] * -1		AS [Einstandspreis]
	  ,[Verkaufspreis (MW)]
      ,[Auftrag veröffentlicht]
	  ,[Warenausgangsdatum]  		
	  ,[Externe Belegnummer]     		
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,[Gewünschtes Lieferdatum]   
	  ,[Verkauf an Kontakt]    		    					
	  ,[Beschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,[Geplantes Lieferdatum]   	
	  ,[Geplantes Warenausgangsdatum]   				
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,[Zlg.-Bedingung Code]
	  ,[Dimension Set ID]
	  ,[MwSt. in Prozent]
	  ,[Ist Archivbeleg]
	  ,[Bundesland]
	  ,[Storno Flag]
--Kennzahlen  
	  ,[Betrag]    
	  --Deckungsbeitrag
	  ,CASE WHEN [Storno Flag] = 0 AND [Belegart] IN (-1,-2)
			THEN [Zeilenbetrag] - [Einheit Betrag] - [Rechnungsrabattbetrag] - [Zeilenrabattbetrag]
			ELSE 0
			END AS [Deckungsbeitrag]
	  -- AuftragseingangMenge (Aktuell)
	  ,CASE WHEN [Belegdatum] = [dbo].[SG_REPORT_DATE_TODAY]() AND [Belegart] = 1
			THEN [Menge]																				
			ELSE 0
			END AS [Auftragseingangsmenge (Aktuell)]
		-- AuftragseingangBetrag (Aktuell)
      ,CASE WHEN [Belegdatum] = [dbo].[SG_REPORT_DATE_TODAY]() AND [Belegart] = 1
			THEN [Zeilenbetrag]																			
			ELSE 0
			END AS [Auftragseingangsbetrag (Aktuell)]
		--Restbetrag
	  ,CASE WHEN [Belegart] = 1
			THEN [Restauftragsbetrag]
			ELSE 0
			END AS [Restbetrag]
		--Restmenge
	  ,CASE WHEN [Belegart] = 1
			THEN [Restauftragsmenge]
			ELSE 0
			END AS [Restmenge]
		--Restmenge (Basis)
	  ,CASE WHEN [Belegart] = 1
			THEN [Restauftragsmenge (Basis)]
			ELSE 0
			END AS [Restmenge (Basis)]
	  ,CASE WHEN [Belegart] IN (1,4)
			THEN [Restauftragsbetrag]
			ELSE 0
			END AS [Auftragbestandsbetrag (Aktuell)]
	  ,CASE WHEN [Belegart] IN (1,4)
			THEN [Restauftragsmenge]
			ELSE 0
			END AS [Auftragbestandsmenge (Aktuell)]
        --Anpassung der Kennzahl 24.02.2020 -JW (Task 2081: NSchuette)
		--RückstandsBetrag nur fuer Belegart = 1 (Auftrag)
	  ,CASE WHEN [Lieferdatum Zugesagt] < [dbo].[SG_REPORT_DATE_TODAY]() AND [Belegart] = 1
			THEN [Restauftragsbetrag]
			ELSE 0
			END AS [Rückstandsbetrag]
		--Anpassung der Kennzahl 24.02.2020 -JW (Task 2081: NSchuette)
		--RückstandsMenge nur fuer Belegart = 1 (Auftrag)
	  ,CASE WHEN [Lieferdatum Zugesagt] < [dbo].[SG_REPORT_DATE_TODAY]() AND [Belegart] = 1	
			THEN [Restauftragsmenge]
			ELSE 0 
			END AS [Rückstandsmenge]
	  ,CASE [Storno Flag]
			WHEN 1 THEN [Menge]
			ELSE 0
			END AS [Stornomenge]
		--StornoBetrag
	  ,CASE WHEN [Storno Flag] = 1
			THEN [Betrag]
			ELSE 0
			END AS [Stornobetrag] 
		--Umsatz
	  ,CASE WHEN [Storno Flag] = 0 AND [Belegart] IN (-1,-2)
			THEN CASE WHEN [Belegart] IN (-2) THEN  [Betrag] * (-1) ELSE [Betrag] END
			ELSE 0
			END AS [Umsatz]
		--Absatz
	  ,CASE WHEN [Storno Flag] = 0 AND [Belegart] IN (-1,-2)
			THEN CASE WHEN [Belegart] IN (-2) THEN  [Menge] * (-1) ELSE [Menge] END
			ELSE 0
			END AS [Absatz]
		--Absatz (Basis)
	  ,CASE WHEN [Storno Flag] = 0 AND [Belegart] IN (-1,-2)
			THEN CASE WHEN [Belegart] IN (-2) THEN  [Menge (Basis)] * (-1) ELSE [Menge (Basis)] END
			ELSE 0
			END AS [Absatz (Basis)]
		--AuftragseingangsmengeHistorisch
	  ,CASE WHEN [Belegart] = 1
			THEN [Menge]
			ELSE 0
			END AS [Auftragseingangsmenge (Historisch)]
		--AuftragseingangsbetragHistorisch
	  ,CASE WHEN [Belegart] = 1
			THEN [Zeilenbetrag]
			ELSE 0
			END AS [Auftragseingangsbetrag (Historisch)]
		--Angebotsmenge
	  ,CASE WHEN [Belegart] = 0
			THEN [Menge]
			ELSE 0
			END AS [Angebotsmenge]
		--Angebotswert
	  ,CASE WHEN [Belegart] = 0
			THEN [Betrag]
			ELSE 0
			END AS [Angebotswert]

  FROM [ver].[fVerkaufscontrolling70_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz60_2_Verschmelzung]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fBilanz60_2_Verschmelzung
























CREATE VIEW

[fin].[fBilanz60_2_Verschmelzung]

AS


SELECT [fin].[fBilanz65_2_Bewegung].[Mandant Code]
	  ,[fin].[fBilanz65_2_Bewegung].[Bundesland]
	  ,[fin].[fBilanz65_2_Bewegung].[Sachkontonummer]
	  ,[fin].[fBilanz65_2_Bewegung].[Kostenstelle Code]
      ,[fin].[fBilanz65_2_Bewegung].[Datum (Zeit)]												AS [Buchungsdatum]
	  ,YEAR([fin].[fBilanz65_2_Bewegung].[Datum (Zeit)])										AS [Jahr]
	  ,MONTH([fin].[fBilanz65_2_Bewegung].[Datum (Zeit)])										AS [Monat]
	  ,CAST(ISNULL([fin].[fBilanz65_2_Bewegung].[Bewegung],0) AS NUMERIC(18,5))				AS [Betrag Bewegung]
	  ,CAST(ISNULL([fin].[fBilanz65_2_Schlussbilanz].[Endsaldo],0) AS NUMERIC(18,5))		AS [Betrag Endsaldo]
  FROM [fin].[fBilanz65_2_Bewegung]

INNER JOIN [fin].[fBilanz65_2_Schlussbilanz]
ON  [fin].[fBilanz65_2_Bewegung].[Mandant Code]	  = [fin].[fBilanz65_2_Schlussbilanz].[Mandant Code]	
AND [fin].[fBilanz65_2_Bewegung].[Bundesland]			= [fin].[fBilanz65_2_Schlussbilanz].[Bundesland]			
AND [fin].[fBilanz65_2_Bewegung].[Sachkontonummer]	  = [fin].[fBilanz65_2_Schlussbilanz].[Sachkontonummer]
AND [fin].[fBilanz65_2_Bewegung].[Kostenstelle Code]  = [fin].[fBilanz65_2_Schlussbilanz].[Kostenstelle Code]
AND [fin].[fBilanz65_2_Bewegung].[Datum (Zeit)]		  = [fin].[fBilanz65_2_Schlussbilanz].[Datum (Zeit)]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005802_Wertposten95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005802_Wertposten95_2










CREATE VIEW [vv].[vBC_t0005802_Wertposten95_2] AS						  
SELECT [Entry No_]					AS [Wertposten Lfd. Nr.]						-- Wertposten Lfd. Nr.
      ,[Posting Date]				AS [Buchungsdatum]								-- Buchungsdatum
	  ,[Valuation Date]				AS [Validierungsdatum]							-- Validierungsdatum
      ,[Document No_]				AS [Belegnummer]								-- Belegnummer
      ,[Item No_]					AS [Artikelnummer]								-- Artikelnummer
      ,[Source No_]					AS [Herkunftsnummer]							-- Herkunftsnummer
      ,[Description]				AS [Wertpostenbezeichnung]						-- Wertpostenbezeichnung
      ,[Invoiced Quantity]			AS [Fakturierte Menge]							-- fakturierte Menge
      ,[Source Type]				AS [Herkunftsart]								-- Herkunftsart
	  ,[Location Code]				AS [Lagerort Code]								-- Lagerort Code
      ,[Item Ledger Entry Type]		AS [Artikelpostenart]							-- Artikelpostenart
      ,[Item Ledger Entry No_]		AS [Artikelposten Lfd. Nr.]					-- Artikelposten Lfd. Nr.
	  ,[Item Ledger Entry Quantity] AS [Artikelposten Menge]						-- Artikelposten Menge
      ,[Sales Amount (Actual)]		AS [Verkaufsbetrag (Tatsächlich)]				-- Verkaufsbetrag (Tatsächlich)
      ,[Salespers__Purch_ Code]		AS [Einkäufer/Verkäufer Code]					-- Einkäufer/Verkäufer Code
      ,[Cost Amount (Actual)]		AS [Einstandsbetrag (Tatsächlich)]				-- Einstandsbetrag (Tatsächlich)
      ,[Drop Shipment]				AS [Direktlieferung]							-- Direktlieferung
      ,[Purchase Amount (Actual)]	AS [Einkaufsbetrag (Tatsächlich)]				-- Einkaufsbetrag (Tatsächlich)
      ,[Purchase Amount (Expected)]	AS [Einkaufsbetrag (Erwartet)]					-- Einkaufsbetrag (Erwartet)
      ,[Sales Amount (Expected)]	AS [Verkaufsbetrag (Erwartet)]					-- Verkaufsbetrag (Erwartet)
      ,[Cost Amount (Expected)]		AS [Einstandsbetrag (Erwartet)]					-- Einstandsbetrag (Erwartet)
      ,[Cost Amount (Non-Invtbl_)]	AS [Einstandsbetrag (Lagerwertunabhängig)]		-- Einstandsbetrag (Lagerwertunabhängig)
      ,[SG_MandantCode]				AS [Mandant Code]								-- Mandant ID
      ,[SG_Bundesland]					AS [Bundesland]									-- Bundesland
  FROM [log].[BC_t0005802_Value_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005802_Wertposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005802_Wertposten




CREATE VIEW  [vv].[vBC_t0005802_Wertposten] AS 
SELECT [Wertposten Lfd. Nr.]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])			AS [Buchungsdatum]
	  ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Validierungsdatum])		AS [Validierungsdatum]
      ,[Belegnummer]
      ,[Artikelnummer]
      ,[Herkunftsnummer]
      ,[Wertpostenbezeichnung]
      ,[Fakturierte Menge]
      ,[Herkunftsart]
      ,[Lagerort Code]
      ,[Artikelpostenart]
      ,[Artikelposten Lfd. Nr.]
      ,[Artikelposten Menge]
      ,[Verkaufsbetrag (Tatsächlich)]
      ,[Einkäufer/Verkäufer Code]
      ,[Einstandsbetrag (Tatsächlich)]
      ,[Direktlieferung]
      ,[Einkaufsbetrag (Tatsächlich)]
      ,[Einkaufsbetrag (Erwartet)]
      ,[Verkaufsbetrag (Erwartet)]
      ,[Einstandsbetrag (Erwartet)]
      ,[Einstandsbetrag (Lagerwertunabhängig)]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [vv].[vBC_t0005802_Wertposten95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling60_2_Wertposten3]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling60_2_Wertposten3
















CREATE VIEW [ver].[fVerkaufscontrolling60_2_Wertposten3] AS 

SELECT
   [Mandant Code]
  ,[Artikelnummer]
  ,[Belegnummer]
  ,[Einstandsbetrag (Erwartet)]
  ,[Einstandsbetrag (Tatsächlich)]
  ,[Artikelposten Menge]
FROM [vv].[vBC_t0005802_Wertposten]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz55_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fBilanz55_2_CONCAT

CREATE VIEW [fin].[fBilanz55_2_CONCAT] AS 
SELECT [Mandant Code]
      ,[Bundesland]
      ,[Sachkontonummer]
      ,[Kostenstelle Code]
      ,[Buchungsdatum]
      ,[Jahr]
      ,[Monat]
      ,[Betrag Bewegung]
      ,[Betrag Endsaldo]
	  --PK for PowerBI
	  ,[Mandant Code]																									AS [PK dMandant]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenstelle Code],''NULL'')															AS [PK dKostenstelleDimension]
	  ,[Mandant Code] +''_''+ ISNULL([Sachkontonummer],''NULL'')															AS [PK dSachkonto]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Buchungsdatum],21),''NULL'')												AS [PK dZeit (Buchungsdatum)]
  FROM [fin].[fBilanz60_2_Verschmelzung]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling60_2_Wertposten2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling60_2_Wertposten2























CREATE VIEW [ver].[fVerkaufscontrolling60_2_Wertposten2] AS 
SELECT
   [Mandant Code]
  ,[Artikelnummer]
  ,[Belegnummer]
  ,CAST(SUM([Einstandsbetrag (Erwartet)])* -1 AS NUMERIC(38,20))		AS [Einstandsbetrag (Erwartet) (Summe)]
  ,CAST(SUM([Einstandsbetrag (Tatsächlich)])* -1 AS NUMERIC(38,20))			AS [Einstandsbetrag (Tatsächlich) (Summe)]
  ,CAST(SUM([Artikelposten Menge])* -1 AS NUMERIC(38,20))	AS [Artikelposten Menge (Summe)]
 
FROM [ver].[fVerkaufscontrolling60_2_Wertposten3]

GROUP BY [Mandant Code]
    	,[Artikelnummer]
		,[Belegnummer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0001104_Kostenposten95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0001104_Kostenposten95_2














/****** Skript für SelectTopNRows-Befehl aus SSMS ******/
CREATE view [vv].[vBC_t0001104_Kostenposten95_2] AS
SELECT [Amount]					AS [Betrag]					-- Betrag
      ,[Entry No_]				AS [Lfd. Nr.]			-- Lfd. Nr.
      ,[Description]			AS [Beschreibung]			-- Beschreibung
      ,[Cost Type No_]			AS [Kostenartnummer]			-- Kostenartcode
      ,[Posting Date]			AS [Buchungsdatum]			-- Buchungsdatum
      ,[Document No_]			AS [Belegnummer]			-- Belegnummer
      ,[Debit Amount]			AS [Sollbetrag]				-- Soll-Betrag
      ,[Credit Amount]			AS [Habenbetrag]			-- Haben-Betrag
      ,[Cost Center Code]		AS [Kostenstelle Code]		-- Kostenstellencode
      ,[Cost Object Code]		AS [Kostenträger Code]		-- Kostenträgercode
      ,[G_L Account]			AS [Sachkontonummer]		-- Sachkontonummer
      ,[G_L Entry No_]			AS [Sachposten Lfd. Nr.]	-- Sachposten Lfd.
      ,[SG_MandantCode]			AS [Mandant Code]			-- Mandant ID
      ,[SG_Bundesland]				AS [Bundesland]				-- Bundesland
  FROM [fin].[BC_t0001104_Cost_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0001104_Kostenposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0001104_Kostenposten



CREATE VIEW [vv].[vBC_t0001104_Kostenposten] AS
SELECT [Betrag]
      ,[Lfd. Nr.]
      ,[Beschreibung]
      ,[Kostenartnummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])			AS [Buchungsdatum]
      ,[Belegnummer]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Sachkontonummer]
      ,[Sachposten Lfd. Nr.]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [vv].[vBC_t0001104_Kostenposten95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fKostenrechnung95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fKostenrechnung95_2









CREATE VIEW [fin].[fKostenrechnung95_2] AS
SELECT [Betrag]
      ,[Lfd. Nr.]
      ,[Beschreibung]
      ,[Kostenartnummer]
      ,[Buchungsdatum]
      ,[Belegnummer]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Sachkontonummer]
      ,[Sachposten Lfd. Nr.]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [vv].[vBC_t0001104_Kostenposten]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fKostenrechnung]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fKostenrechnung









CREATE VIEW [fin].[fKostenrechnung] AS
SELECT [Betrag]
      ,[Lfd. Nr.]
      ,[Beschreibung]
      ,[Kostenartnummer]
      ,[Buchungsdatum]
      ,[Belegnummer]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Sachkontonummer]
      ,[Sachposten Lfd. Nr.]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [fin].fKostenrechnung95_2
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling60_2_Wertposten1]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling60_2_Wertposten1























CREATE VIEW [ver].[fVerkaufscontrolling60_2_Wertposten1] AS 
SELECT
   [Mandant Code]
  ,[Artikelnummer]
  ,[Belegnummer]
  ,CAST(CASE [Artikelposten Menge (Summe)]
		WHEN 0 THEN 0 
		ELSE ([Einstandsbetrag (Erwartet) (Summe)] + [Einstandsbetrag (Tatsächlich) (Summe)]) / [Artikelposten Menge (Summe)] 
	END AS NUMERIC(38,20)) AS [Einstandspreis]
   ,[Einstandsbetrag (Erwartet) (Summe)]
   ,[Einstandsbetrag (Tatsächlich) (Summe)]
FROM [ver].[fVerkaufscontrolling60_2_Wertposten2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000013_Verkäufer_Einkäufer]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000013_Verkäufer_Einkäufer














CREATE VIEW [vv].[vBC_t0000013_Verkäufer_Einkäufer] AS
SELECT [Name]						AS [Verkäufer/Einkäufername]	 -- Einkäufer/Verkäuferbezeichnung
      ,[Code]						AS [Verkäufer/Einkäufer Code]	 -- Einkäufer/Verkäufer Code
	  ,[Global Dimension 1 Code]	AS [Kostenstellencode]	 -- Global Dimension 1 Code (entweder Kostenstelle o. Kostenträger)
	  ,[Global Dimension 2 Code]	AS [Kostenträgercode]	 -- Global Dimension 2 Code (entweder Kostenstelle o. Kostenträger)
	  ,[Job Title]					AS [Funktion]					 -- Funktion
      ,[SG_MandantCode]				AS [Mandant Code]				 -- Mandant ID
  FROM [com].[BC_t0000013_Salesperson_Purchaser]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dVerkäuferEinkäufer95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dVerkäuferEinkäufer95_2











CREATE VIEW [dim].[dVerkäuferEinkäufer95_2] AS 
SELECT [vv].[vBC_t0000013_Verkäufer_Einkäufer].[Verkäufer/Einkäufername]	AS [Verkäufer/Einkäufername]
      ,[vv].[vBC_t0000013_Verkäufer_Einkäufer].[Verkäufer/Einkäufer Code]	AS [Verkäufer/Einkäufer Code]
	  --in der General Ledger Setup Tabelle ist definiert in welchem Global Dim Code welcher Dimensionswert steht
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenstellencode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenstelle Code]
																					,[vv].[vBC_t0000013_Verkäufer_Einkäufer].[Kostenstellencode]
																					,[vv].[vBC_t0000013_Verkäufer_Einkäufer].[Kostenträgercode]) 
		AS [Kostenstelle Code]
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenträgercode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenträger Code]
																					,[vv].[vBC_t0000013_Verkäufer_Einkäufer].[Kostenträgercode]
																					,[vv].[vBC_t0000013_Verkäufer_Einkäufer].[Kostenstellencode]) 
		AS [Kostenträger Code]
	  ,[vv].[vBC_t0000013_Verkäufer_Einkäufer].[Funktion]					AS [Funktion]
      ,[vv].[vBC_t0000013_Verkäufer_Einkäufer].[Mandant Code]				AS [Mandant Code]
  FROM [vv].[vBC_t0000013_Verkäufer_Einkäufer]

  
  LEFT JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON [vv].[vBC_t0000013_Verkäufer_Einkäufer].[Mandant Code] = [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code] = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000349_Dimensionswert]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000349_Dimensionswert














CREATE VIEW [vv].[vBC_t0000349_Dimensionswert] AS
SELECT [Name]			  AS [Dimensionswertbezeichnung]   -- Dimensionswertbezeichnung
      ,[Blocked]		  AS [Gesperrt Code]				-- Gesperrt Code
      ,[Code]			  AS [Dimensionswert]				-- Dimensionswert
      ,[Dimension Code]	  AS [Dimensionswertart]			-- Dimensionswertart
      ,[SG_MandantCode]	  AS [Mandant Code]					-- Mandant ID
  FROM [com].[BC_t0000349_Dimension_Value]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dVerkäuferEinkäufer90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dVerkäuferEinkäufer90_2













CREATE VIEW [dim].[dVerkäuferEinkäufer90_2]AS 
SELECT [dim].[dVerkäuferEinkäufer95_2].[Verkäufer/Einkäufername]
      ,[dim].[dVerkäuferEinkäufer95_2].[Verkäufer/Einkäufer Code]
	  ,[dim].[dVerkäuferEinkäufer95_2].[Kostenstelle Code]
	  ,[Kostenstelle].[Dimensionswertbezeichnung] AS [Kostenstellenbezeichnung]
	  ,[dim].[dVerkäuferEinkäufer95_2].[Kostenträger Code]
	  ,[Kostenträger].[Dimensionswertbezeichnung] AS [Kostenträgerbezeichnung]
	  ,[dim].[dVerkäuferEinkäufer95_2].[Funktion]
      ,[dim].[dVerkäuferEinkäufer95_2].[Mandant Code]
  FROM [dim].[dVerkäuferEinkäufer95_2]

  INNER JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [dim].[dVerkäuferEinkäufer95_2].[Mandant Code] = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]
  
  LEFT JOIN [vv].[vBC_t0000349_Dimensionswert] AS [Kostenstelle]
  ON [dim].[dVerkäuferEinkäufer95_2].[Mandant Code]		= [Kostenstelle].[Mandant Code]
  AND [dim].[dVerkäuferEinkäufer95_2].[Kostenstelle Code]	= [Kostenstelle].[Dimensionswert]
  AND [Kostenstelle].[Dimensionswertart]						= [vv].[vSNCt_Aktiver_Mandant].[Kostenstelle Code]

  LEFT JOIN [vv].[vBC_t0000349_Dimensionswert] AS [Kostenträger]
  ON [dim].[dVerkäuferEinkäufer95_2].[Mandant Code]		= [Kostenträger].[Mandant Code]
  AND [dim].[dVerkäuferEinkäufer95_2].[Kostenstelle Code]	= [Kostenträger].[Dimensionswert]
  AND [Kostenträger].[Dimensionswertart]						= [vv].[vSNCt_Aktiver_Mandant].[Kostenträger Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dVerkäuferEinkäufer85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dVerkäuferEinkäufer85_2_CONCAT














CREATE VIEW [dim].[dVerkäuferEinkäufer85_2_CONCAT] AS
SELECT [Mandant Code]
	  ,[Verkäufer/Einkäufername]
      ,[Verkäufer/Einkäufer Code]
	  ,[Kostenstelle Code]
	  ,[Kostenstellenbezeichnung]
	  ,[Kostenträger Code]
	  ,[Kostenträgerbezeichnung]
	  ,[Funktion]
	  ,CAST(ISNULL([Verkäufer/Einkäufername],'''') AS NVARCHAR(50)) + '' ('' + CAST([Verkäufer/Einkäufer Code] AS NVARCHAR(20)) + '')'' AS [Verkäufer/Einkäufername (Code)]
      ,CAST(ISNULL([Verkäufer/Einkäufer Code],'''') AS NVARCHAR(20)) + '' '' + CAST([Verkäufer/Einkäufername] AS NVARCHAR(50)) AS [Verkäufer/Einkäufer Code Bezeichnung]
	  ,[Mandant Code] +''_''+ [Verkäufer/Einkäufer Code] AS [PK dVerkäuferEinkäufer]
  FROM [dim].[dVerkäuferEinkäufer90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dVerkäuferEinkäufer]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dVerkäuferEinkäufer














CREATE VIEW [dim].[dVerkäuferEinkäufer] as

SELECT [Mandant Code]
      ,[Verkäufer/Einkäufername]
      ,[Verkäufer/Einkäufer Code]
      ,[Kostenstelle Code]
      ,[Kostenstellenbezeichnung]
      ,[Kostenträger Code]
      ,[Kostenträgerbezeichnung]
      ,[Funktion]
      ,[Verkäufer/Einkäufername (Code)]
      ,[Verkäufer/Einkäufer Code Bezeichnung]
      ,[PK dVerkäuferEinkäufer]
  FROM [dim].[dVerkäuferEinkäufer85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling55_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling55_2











































CREATE VIEW [ver].[fVerkaufscontrolling55_2]

 AS  

SELECT [ver].[fVerkaufscontrolling65_2].[Mandant Code]
      ,[ver].[fVerkaufscontrolling65_2].[Belegnummer]
	  ,[ver].[fVerkaufscontrolling65_2].[Belegnummer Häufigkeit]
      ,[ver].[fVerkaufscontrolling65_2].[Artikelnummer]
	  ,[ver].[fVerkaufscontrolling65_2].[Produktnummer]
	  ,[ver].[fVerkaufscontrolling65_2].[Belegart]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')					AS [Belegartbezeichnung DE]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')						AS [Belegartbezeichnung EN]
      ,[ver].[fVerkaufscontrolling65_2].[Buchungsdatum]
      ,[ver].[fVerkaufscontrolling65_2].[Belegdatum]
      ,[ver].[fVerkaufscontrolling65_2].[Währung Code]
      ,[ver].[fVerkaufscontrolling65_2].[Währungsfaktor]
      ,[ver].[fVerkaufscontrolling65_2].[Verkäufer Code]
      ,[ver].[fVerkaufscontrolling65_2].[Zeilennummer]
      ,[ver].[fVerkaufscontrolling65_2].[Verkauf an Debitornummer]
	  --in der General Ledger Setup Tabelle ist defineirt on welchem Shortcut Dim Code welcher Dimensionswert steht
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenstellencode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenstelle Code]
																					,[ver].[fVerkaufscontrolling65_2].[Kostenstellencode]
																					,[ver].[fVerkaufscontrolling65_2].[Kostenträgercode]) 
		AS [Kostenstelle Code]
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenträgercode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenträger Code]
																					,[ver].[fVerkaufscontrolling65_2].[Kostenträgercode]
																					,[ver].[fVerkaufscontrolling65_2].[Kostenstellencode]) 
		AS [Kostenträger Code]
      ,[ver].[fVerkaufscontrolling65_2].[Produktart]
      ,[ver].[fVerkaufscontrolling65_2].[Zeilenrabattbetrag]
      ,[ver].[fVerkaufscontrolling65_2].[Rechnung an Debitornummer]
      ,[ver].[fVerkaufscontrolling65_2].[Rechnungsrabattbetrag]
	  ,[ver].[fVerkaufscontrolling65_2].[Bundesland]
	  ,[ver].[fVerkaufscontrolling65_2].[Warenausgangsdatum]  		
	  ,[ver].[fVerkaufscontrolling65_2].[Externe Belegnummer]     		
	  ,[ver].[fVerkaufscontrolling65_2].[Auftragsdatum]    			
	  ,[ver].[fVerkaufscontrolling65_2].[Fälligkeitsdatum]    				
	  ,[ver].[fVerkaufscontrolling65_2].[Gewünschtes Lieferdatum]   
	  ,[ver].[fVerkaufscontrolling65_2].[Verkauf an Kontakt]    		    					
	  ,[ver].[fVerkaufscontrolling65_2].[Beschreibung]    	
	  ,[ver].[fVerkaufscontrolling65_2].[Lagerort Code]    		
	  ,[ver].[fVerkaufscontrolling65_2].[MwSt. in Prozent]
	  ,[ver].[fVerkaufscontrolling65_2].[Ist Archivbeleg]
	  ,[ver].[fVerkaufscontrolling65_2].[Einheitencode]    	
	  ,[ver].[fVerkaufscontrolling65_2].[Geplantes Lieferdatum]   	
	  ,[ver].[fVerkaufscontrolling65_2].[Geplantes Warenausgangsdatum]   				
	  ,[ver].[fVerkaufscontrolling65_2].[Skonto]    	
	  ,[ver].[fVerkaufscontrolling65_2].[Skontodatum]    	
	  ,[ver].[fVerkaufscontrolling65_2].[Zlg.-Bedingung Code]
	  ,[ver].[fVerkaufscontrolling65_2].[Storno Flag] AS [Storno Code]
	  ,ISNULL([Stornobezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')					AS [Stornobezeichnung DE]
	  ,ISNULL([Stornobezeichnung].[Optionsfeldbezeichnung EN],''not defined'')						AS [Stornobezeichnung EN]
      ,[ver].[fVerkaufscontrolling65_2].[Zeilenbetrag]
      ,[ver].[fVerkaufscontrolling65_2].[Menge (Basis)]
	  ,[ver].[fVerkaufscontrolling65_2].[Menge]
      ,[ver].[fVerkaufscontrolling65_2].[Einheit Betrag]
      ,[ver].[fVerkaufscontrolling65_2].[Einstandspreis]
	  ,[ver].[fVerkaufscontrolling65_2].[Verkaufspreis (MW)]
      ,[ver].[fVerkaufscontrolling65_2].[Deckungsbeitrag]
      ,[ver].[fVerkaufscontrolling65_2].[Auftragseingangsmenge (Aktuell)]
      ,[ver].[fVerkaufscontrolling65_2].[Auftragseingangsbetrag (Aktuell)]
      ,[ver].[fVerkaufscontrolling65_2].[Restbetrag]
      ,[ver].[fVerkaufscontrolling65_2].[Restmenge]
	  ,[ver].[fVerkaufscontrolling65_2].[Restmenge (Basis)]
      ,[ver].[fVerkaufscontrolling65_2].[Auftragbestandsbetrag (Aktuell)]
      ,[ver].[fVerkaufscontrolling65_2].[Auftragbestandsmenge (Aktuell)]
      ,[ver].[fVerkaufscontrolling65_2].[Rückstandsbetrag]
      ,[ver].[fVerkaufscontrolling65_2].[Rückstandsmenge]
      ,[ver].[fVerkaufscontrolling65_2].[Stornomenge]
      ,[ver].[fVerkaufscontrolling65_2].[Stornobetrag]
      ,[ver].[fVerkaufscontrolling65_2].[Umsatz] 
	  ,[ver].[fVerkaufscontrolling65_2].[Absatz]
	  ,[ver].[fVerkaufscontrolling65_2].[Absatz (Basis)]
	  ,[ver].[fVerkaufscontrolling65_2].[Betrag] 
	  ,[ver].[fVerkaufscontrolling65_2].[Angebotsmenge]
	  ,[ver].[fVerkaufscontrolling65_2].[Angebotswert]
	  ,[ver].[fVerkaufscontrolling60_2_Wertposten1].[Einstandspreis] * [ver].[fVerkaufscontrolling65_2].[Menge]	AS [Einstandsbetragsvorrat]
	  ,[ver].[fVerkaufscontrolling65_2].[Auftragseingangsbetrag (Historisch)]
	  ,[ver].[fVerkaufscontrolling65_2].[Auftragseingangsmenge (Historisch)]
	  --Auftragsanfangsbestand Menge/Betrag
	  ,[ver].[fVerkaufscontrolling65_2].[Auftragseingangsmenge (Aktuell)] - 
		[ver].[fVerkaufscontrolling65_2].[Auftragseingangsmenge (Historisch)] + 
		[ver].[fVerkaufscontrolling65_2].[Absatz]													AS [Auftragsanfangsbestand Menge]
	  ,[ver].[fVerkaufscontrolling65_2].[Auftragbestandsbetrag (Aktuell)] - 
		[ver].[fVerkaufscontrolling65_2].[Auftragseingangsbetrag (Historisch)] + 
		[ver].[fVerkaufscontrolling65_2].[Umsatz]														AS [Auftragsanfangsbestand Betrag]
      ,[ver].[fVerkaufscontrolling65_2].[Auftrag veröffentlicht]
  FROM [ver].[fVerkaufscontrolling65_2]

  LEFT JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON [ver].[fVerkaufscontrolling65_2].[Mandant Code] = [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [ver].[fVerkaufscontrolling65_2].[Mandant Code] = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]

  LEFT JOIN [ver].[fVerkaufscontrolling60_2_Wertposten1] 
  ON  [ver].[fVerkaufscontrolling65_2].[Mandant Code]	= [ver].[fVerkaufscontrolling60_2_Wertposten1].[Mandant Code]
  AND [ver].[fVerkaufscontrolling65_2].[Belegnummer]	= [ver].[fVerkaufscontrolling60_2_Wertposten1].[Belegnummer]
  AND [ver].[fVerkaufscontrolling65_2].[Artikelnummer]		= [ver].[fVerkaufscontrolling60_2_Wertposten1].[Artikelnummer]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Belegartbezeichnung]
  ON [ver].[fVerkaufscontrolling65_2].[Belegart]	= [Belegartbezeichnung].[Optionsfeld Code]
  AND [Belegartbezeichnung].[Tabellenname]			= ''Verkauf''
  AND [Belegartbezeichnung].[Spaltenbezeichnung]				= ''Belegartbezeichnung''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Stornobezeichnung]
  ON [ver].[fVerkaufscontrolling65_2].[Storno Flag]	= [Stornobezeichnung].[Optionsfeld Code]
  AND [Stornobezeichnung].[Tabellenname]			= ''Global''
  AND [Stornobezeichnung].[Spaltenbezeichnung]				= ''Ja/Nein''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz75_2_Zeit_Sachkonto]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fBilanz75_2_Zeit_Sachkonto






















CREATE VIEW

[fin].[fBilanz75_2_Zeit_Sachkonto]

AS


SELECT [Sachkontonummer]
      ,[Bundesland]
      ,MIN([Buchungsdatum]) AS [Start Datum]
	  ,CAST(DATEFROMPARTS (YEAR(MIN([dbo].[SG_REPORT_DATE_TODAY]())), 12, 31) AS DATETIME) AS [Ende Datum]
  FROM [fin].[fBilanz80_2]

  GROUP BY 
        [Sachkontonummer]
	   ,[Bundesland]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling50_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling50_2








































CREATE VIEW [ver].[fVerkaufscontrolling50_2] AS 

SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Belegnummer Häufigkeit]
      ,[Artikelnummer]
      ,[Produktnummer]
      ,[Belegart]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Buchungsdatum]
      ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[Zeilennummer]
      ,[Verkauf an Debitornummer]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Produktart]
	  ,[Externe Belegnummer]
      ,[Auftragsdatum]
      ,[Fälligkeitsdatum]
      ,[Gewünschtes Lieferdatum]
      ,[Verkauf an Kontakt]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[MwSt. in Prozent]
      ,[Ist Archivbeleg]
      ,[Einheitencode]	
	  ,[Geplantes Lieferdatum]
      ,[Geplantes Warenausgangsdatum]
      ,[Skonto]
      ,[Skontodatum]
      ,[Zlg.-Bedingung Code]
	  ,[Storno Code]
	  ,[Stornobezeichnung DE]
	  ,[Stornobezeichnung EN]
      ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
	  ,[Menge]
      ,[Einheit Betrag]
      ,[Einstandspreis]
	  ,[Verkaufspreis (MW)]
	  ,[Warenausgangsdatum]
      ,[Deckungsbeitrag]
      ,[Auftragseingangsmenge (Aktuell)]
      ,[Auftragseingangsbetrag (Aktuell)]
      ,[Restbetrag]
      ,[Restmenge]
	  ,[Restmenge (Basis)]
      ,[Auftragbestandsbetrag (Aktuell)]
      ,[Auftragbestandsmenge (Aktuell)]
      ,[Rückstandsbetrag]
      ,[Rückstandsmenge]
      ,[Stornomenge]
      ,[Stornobetrag]
      ,[Umsatz]
	  ,[Absatz]
	  ,[Absatz (Basis)]
	  ,[Angebotsmenge]
	  ,[Angebotswert]
	  ,[Betrag] 
      ,ISNULL([Einstandsbetragsvorrat],[Einheit Betrag]) AS [Einstandsbetragsvorrat]
	  ,[Auftragseingangsbetrag (Historisch)]
	  ,[Auftragseingangsmenge (Historisch)]
	  ,[Auftrag veröffentlicht]
	  ,[Bundesland]
  FROM [ver].[fVerkaufscontrolling55_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenstelleDimension95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenstelleDimension95_2
























CREATE VIEW [dim].[dKostenstelleDimension95_2] AS 
SELECT [vBC_t0000349_Dimensionswert].[Dimensionswertbezeichnung]						AS [Kostenstellenbezeichnung]
      ,[vBC_t0000349_Dimensionswert].[Dimensionswert]									AS [Kostenstelle Code]
	  ,[vBC_t0000349_Dimensionswert].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Gesperrtbezeichnung EN]
      ,[vBC_t0000349_Dimensionswert].[Mandant Code]
  FROM [vv].[vBC_t0000349_Dimensionswert]

  INNER JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vBC_t0000349_Dimensionswert].[Mandant Code] = [vSNCt_Aktiver_Mandant].[Mandant Code]
  AND [vBC_t0000349_Dimensionswert].[Dimensionswertart] = [vSNCt_Aktiver_Mandant].[Kostenstelle Code]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vBC_t0000349_Dimensionswert].[Gesperrt Code]  = [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]			= ''Global''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]				= ''Gesperrtbezeichnung''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling45_2_Anfangsbestand]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling45_2_Anfangsbestand

























CREATE VIEW [ver].[fVerkaufscontrolling45_2_Anfangsbestand] AS 

SELECT
	   [Mandant Code]
	  ,[Bundesland]
      ,[Artikelnummer]
      ,[Währung Code]
      ,[Verkäufer Code]
      ,[Verkauf an Debitornummer]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
	  ,[Produktart]
      ,[Zeilennummer]
      ,[Rechnung an Debitornummer]
	  ,SUM([Auftragbestandsbetrag (Aktuell)] + [Umsatz] - [Auftragseingangsbetrag (Historisch)]) AS [Auftragseingangsbetrag (Historisch)]
      ,SUM([Auftragbestandsmenge (Aktuell)] + [Absatz] - [Auftragseingangsmenge (Historisch)]) AS [Auftragseingangsmenge (Historisch)] 

  FROM [ver].[fVerkaufscontrolling50_2]

  GROUP BY [Mandant Code]
		  ,[Bundesland]
          ,[Artikelnummer]
          ,[Währung Code]
          ,[Verkäufer Code]
          ,[Verkauf an Debitornummer]
          ,[Kostenstelle Code]
		  ,[Kostenträger Code]
	      ,[Produktart]
          ,[Zeilennummer]
          ,[Rechnung an Debitornummer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenstelleDimension90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenstelleDimension90_2



















CREATE VIEW [dim].[dKostenstelleDimension90_2] AS 
SELECT [Kostenstellenbezeichnung]
      ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Kostenstelle Code]
      ,[Mandant Code]
  FROM [dim].[dKostenstelleDimension95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling40_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling40_2









































CREATE VIEW [ver].[fVerkaufscontrolling40_2] AS 

SELECT [Mandant Code]
	  ,[Belegnummer]
	  ,[Belegnummer Häufigkeit]
      ,[Artikelnummer]
	  ,[Produktnummer]
	  ,[Belegart]
	  ,[Belegartbezeichnung DE]
	  ,[Belegartbezeichnung EN]
	  ,[Buchungsdatum]
	  ,[Belegdatum]
	  ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
	  ,[Zeilennummer]
      ,[Verkauf an Debitornummer]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Produktart]
	  ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
	  ,[Storno Code]
	  ,[Stornobezeichnung DE]
	  ,[Stornobezeichnung EN]
	  ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
	  ,[Menge]
      ,[Einheit Betrag]
      ,[Einstandspreis]
	  ,[Verkaufspreis (MW)]
	  ,[Warenausgangsdatum]
      ,[Deckungsbeitrag]
      ,[Auftragseingangsmenge (Aktuell)]
      ,[Auftragseingangsbetrag (Aktuell)]
      ,[Restbetrag]
      ,[Restmenge]
	  ,[Restmenge (Basis)]
      ,[Auftragbestandsbetrag (Aktuell)]
      ,[Auftragbestandsmenge (Aktuell)]
      ,[Rückstandsbetrag]
      ,[Rückstandsmenge]
      ,[Stornomenge]
      ,[Stornobetrag]
      ,[Umsatz]
      ,[Absatz]
	  ,[Absatz (Basis)]
	  ,[Angebotsmenge]
	  ,[Angebotswert]
	  ,[Betrag]
      ,[Einstandsbetragsvorrat]
      ,[Auftragseingangsbetrag (Historisch)]
      ,[Auftragseingangsmenge (Historisch)]
      ,[Auftrag veröffentlicht]
	  ,[Externe Belegnummer]     		
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,[Gewünschtes Lieferdatum]   
	  ,[Verkauf an Kontakt]    		    					
	  ,[Beschreibung]    	
	  ,[Lagerort Code]    
	  ,[Einheitencode]    	
	  ,[Geplantes Lieferdatum]   	
	  ,[Geplantes Warenausgangsdatum]   				
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,[Zlg.-Bedingung Code]
	  ,[MwSt. in Prozent]
	  ,[Ist Archivbeleg]
	  ,[Bundesland]
  FROM [ver].[fVerkaufscontrolling50_2]

UNION ALL

SELECT [Mandant Code]
	  ,CAST(''xxxxxxxxxx'' AS NVARCHAR(20))						AS [Belegnummer]
	  ,CAST(1 AS INT)											AS [Belegnummer Häufigkeit]
      ,[Artikelnummer]
	  ,CAST('''' AS NVARCHAR(20))									AS [Produktnummer]
	  ,CAST(-5 AS INT)											AS [Belegart]
	  ,CAST(''Historisch'' AS NVARCHAR(50))						AS [Belegartbezeichnung DE]
	  ,CAST(''Historical'' AS NVARCHAR(50))						AS [Belegartbezeichnung EN]
	  ,CAST(NULL AS DATETIME)									AS [Buchungsdatum]
	  ,CAST(NULL AS DATETIME)									AS [Belegdatum]
	  ,[Währung Code]
      ,CAST(0 AS NUMERIC(38,20))								AS [Währungsfaktor]
      ,[Verkäufer Code]
	  ,ROW_NUMBER() OVER(ORDER BY [Artikelnummer])					AS [Zeilennummer]
      ,[Verkauf an Debitornummer]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Produktart]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
	  ,CAST(0 AS TINYINT)										AS [Storno Code]
	  ,CAST(NULL AS NVARCHAR(50))								AS [Stornobezeichnung DE]
	  ,CAST(NULL AS NVARCHAR(50))								AS [Stornobezeichnung EN]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Rechnungsrabattbetrag]
      ,CAST(0 AS NUMERIC(38,20))								AS [Zeilenbetrag]
      ,CAST(0 AS NUMERIC(38,20))								AS [Menge (Basis)]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Menge]
      ,CAST(0 AS NUMERIC(38,20))								AS [Einheit Betrag]
      ,CAST(0 AS NUMERIC(38,20))								AS [Einstandspreis]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Verkaufspreis (MW)]
	  ,CAST(NULL AS DATETIME)									AS [Warenausgangsdatum]
      ,CAST(0 AS NUMERIC(38,20))								AS [Deckungsbeitrag]
      ,CAST(0 AS NUMERIC(38,20))								AS [Auftragseingangsmenge (Aktuell)]
      ,CAST(0 AS NUMERIC(38,20))								AS [Auftragseingangsbetrag (Aktuell)]
      ,CAST(0 AS NUMERIC(38,20))								AS [Restbetrag]
      ,CAST(0 AS NUMERIC(38,20))								AS [Restmenge]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Restmenge (Basis)]
      ,CAST(0 AS NUMERIC(38,20))								AS [Auftragbestandsbetrag (Aktuell)]
      ,CAST(0 AS NUMERIC(38,20))								AS [Auftragbestandsmenge (Aktuell)]
      ,CAST(0 AS NUMERIC(38,20))								AS [Rückstandsbetrag]
      ,CAST(0 AS NUMERIC(38,20))								AS [Rückstandsmenge]
      ,CAST(0 AS NUMERIC(38,20))								AS [Stornomenge]
      ,CAST(0 AS NUMERIC(38,20))								AS [Stornobetrag]
      ,CAST(0 AS NUMERIC(38,20))								AS [Umsatz]
      ,CAST(0 AS NUMERIC(38,20))								AS [Absatz]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Absatz (Basis)]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Angebotsmenge]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Angebotswert]
	  ,CAST(0 AS NUMERIC(38,20))								AS [Betrag]
      ,CAST(0 AS NUMERIC(38,20))								AS [Einstandsbetragsvorrat]
      ,[Auftragseingangsbetrag (Historisch)]
      ,[Auftragseingangsmenge (Historisch)]
      ,CAST(0 AS TINYINT)										AS [Auftrag veröffentlicht]
	  ,CAST(NULL AS NVARCHAR(35))								AS [Externe Belegnummer]     		
	  ,CAST(NULL AS DATETIME)									AS [Auftragsdatum]    			
	  ,CAST(NULL AS DATETIME)									AS [Fälligkeitsdatum]    				
	  ,CAST(NULL AS DATETIME)									AS [Gewünschtes Lieferdatum]   
	  ,CAST(NULL AS NVARCHAR(100))								AS [Verkauf an Kontakt]    		    					
	  ,CAST(NULL AS NVARCHAR(100))								AS [Beschreibung]    	
	  ,CAST(NULL AS NVARCHAR(10))								AS [Lagerort Code]    
	  ,CAST(NULL AS NVARCHAR(10))								AS [Einheitencode]    	
	  ,CAST(NULL AS DATETIME)									AS [Geplantes Lieferdatum]   	
	  ,CAST(NULL AS DATETIME)									AS [Geplantes Warenausgangsdatum]   				
	  ,CAST(0 AS NUMERIC(38,20))								AS [Skonto]    	
	  ,CAST(NULL AS DATETIME)									AS [Skontodatum]    	
	  ,CAST(NULL AS NVARCHAR(10))								AS [Zlg.-Bedingung Code]
	  ,CAST(0 AS NUMERIC(38,20))								AS [MwSt. in Prozent]
	  ,CAST(0 AS INT)											AS [Ist Archivbeleg]
	  ,[Bundesland]
  FROM [ver].[fVerkaufscontrolling45_2_Anfangsbestand]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenstelleDimension85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenstelleDimension85_2_CONCAT












CREATE VIEW [dim].[dKostenstelleDimension85_2_CONCAT] AS
SELECT [Kostenstellenbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Kostenstelle Code]
      ,[Mandant Code]
	  ,CAST(ISNULL([Kostenstellenbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Kostenstelle Code] AS NVARCHAR(20)) + '')'' AS [Kostenstellenbezeichnung (Code)]
      ,CAST(ISNULL([Kostenstelle Code],'''') AS NVARCHAR(20)) + '' '' + CAST([Kostenstellenbezeichnung] AS NVARCHAR(100)) AS [Kostenstelle Code Bezeichnung]
	  ,[Mandant Code] +''_''+ [Kostenstelle Code] AS [PK dKostenstelleDimension]
  FROM [dim].[dKostenstelleDimension90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000009_Land]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000009_Land














CREATE VIEW [vv].[vBC_t0000009_Land] AS
SELECT [Name]					AS [Länderbezeichnung]		-- Bundeslandscode
      ,[Code]					AS [Länder Code]				-- Bundeslandsbezeichnung
      ,[EU Country_Region Code]	AS [EU-Flag]				-- EU-Flag
      ,[SG_MandantCode]			AS [Mandant Code]			-- Mandant ID
  FROM [com].[BC_t0000009_Country_Region]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000014_Lagerort]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000014_Lagerort















CREATE VIEW [vv].[vBC_t0000014_Lagerort] AS
SELECT [Code]				  AS [Lagerort Code]					-- Lagerortcode
      ,[Name]				  AS [Lagerortbezeichnung]				-- Lagerortname
      ,[Name 2]				  AS [Lagerortbezeichnung 2]			-- Lagerortname 2
      ,[Address]			  AS [Adresse]							-- Adresse
      ,[Address 2]			  AS [Adresse 2]						-- Adresse 2
      ,[City]				  AS [Ort]								-- Stadt
      ,[Post Code]			  AS [Postleitzahl]						-- Postleitzahl
      ,[Country_Region Code]  AS [Länder Code]						-- Bundesland
      ,[Use As In-Transit]	  AS [Verwendung Transit Code]			-- Als Transitlager verwenden
	  ,[SG_MandantCode]		  AS [Mandant Code]						-- Mandant ID
  FROM [log].[BC_t0000014_Location]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dLagerort95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLagerort95_2












CREATE VIEW [dim].[dLagerort95_2] AS
SELECT [vv].[vBC_t0000014_Lagerort].[Lagerort Code]
      ,[vv].[vBC_t0000014_Lagerort].[Lagerortbezeichnung]
      ,[vv].[vBC_t0000014_Lagerort].[Lagerortbezeichnung 2]
      ,[vv].[vBC_t0000014_Lagerort].[Adresse]
      ,[vv].[vBC_t0000014_Lagerort].[Adresse 2]
      ,[vv].[vBC_t0000014_Lagerort].[Ort]
      ,[vv].[vBC_t0000014_Lagerort].[Postleitzahl]
      ,[vv].[vBC_t0000014_Lagerort].[Länder Code]
	  ,[vv].[vBC_t0000009_Land].[Länderbezeichnung]
      ,[vv].[vBC_t0000014_Lagerort].[Verwendung Transit Code]
	  ,ISNULL([Verwendung Transit Bezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Verwendung Transit Bezeichnung DE]
	  ,ISNULL([Verwendung Transit Bezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Verwendung Transit Bezeichnung EN]
      ,[vv].[vBC_t0000014_Lagerort].[Mandant Code]
  FROM [vv].[vBC_t0000014_Lagerort]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Verwendung Transit Bezeichnung]
  ON [vv].[vBC_t0000014_Lagerort].[Verwendung Transit Code]	= [Verwendung Transit Bezeichnung].[Optionsfeld Code]
  AND [Verwendung Transit Bezeichnung].[Tabellenname]			= ''Global''
  AND [Verwendung Transit Bezeichnung].[Spaltenbezeichnung]				= ''Yes/No''

  LEFT JOIN [vv].[vBC_t0000009_Land]
  ON [vv].[vBC_t0000014_Lagerort].[Mandant Code] = [vv].[vBC_t0000009_Land].[Mandant Code]
  AND [vv].[vBC_t0000014_Lagerort].[Länder Code] = [vv].[vBC_t0000009_Land].[Länder Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fBilanz























CREATE VIEW [fin].[fBilanz]

AS 

SELECT [Mandant Code]
      ,[Bundesland]
      ,[Sachkontonummer]
      ,[Kostenstelle Code]
      ,[Buchungsdatum]
      ,[Jahr]
      ,[Monat]
      ,[Betrag Bewegung]
      ,[Betrag Endsaldo]
      ,[PK dMandant]
      ,[PK dKostenstelleDimension]
      ,[PK dSachkonto]
      ,[PK dZeit (Buchungsdatum)]
  FROM [fin].[fBilanz55_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dLagerort90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLagerort90_2












CREATE VIEW [dim].[dLagerort90_2] AS
SELECT [Lagerort Code]
      ,[Lagerortbezeichnung]
      ,[Lagerortbezeichnung 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,[Postleitzahl]
      ,[Länder Code]
      ,[Länderbezeichnung]
      ,[Verwendung Transit Code]
      ,[Verwendung Transit Bezeichnung DE]
      ,[Verwendung Transit Bezeichnung EN]
      ,[Mandant Code]
  FROM [dim].[dLagerort95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dLagerort85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLagerort85_2_CONCAT













CREATE VIEW [dim].[dLagerort85_2_CONCAT] AS
SELECT [Lagerort Code]
      ,[Lagerortbezeichnung]
      ,[Lagerortbezeichnung 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,[Postleitzahl]
      ,[Länder Code]
      ,[Länderbezeichnung]
      ,[Verwendung Transit Code]
      ,[Verwendung Transit Bezeichnung DE]
      ,[Verwendung Transit Bezeichnung EN]
      ,[Mandant Code]
	  ,CAST(ISNULL([Lagerortbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Lagerort Code] AS NVARCHAR(10)) + '')'' AS [Lagerortbezeichnung (Code)]
      ,CAST(ISNULL([Lagerort Code],'''') AS NVARCHAR(10)) + '' '' + CAST([Lagerortbezeichnung] AS NVARCHAR(100)) AS [Lagerort Code Bezeichnung]
	  ,[Mandant Code] +''_''+ [Lagerort Code] AS [PK dLagerort]
  FROM [dim].[dLagerort90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling35_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling35_2_CONCAT



CREATE VIEW [ver].[fVerkaufscontrolling35_2_CONCAT] AS
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Belegnummer Häufigkeit]
      ,[Artikelnummer]
      ,[Produktnummer]
      ,[Belegart]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Buchungsdatum]
      ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[Zeilennummer]
      ,[Verkauf an Debitornummer]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Produktart]
      ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
      ,[Storno Code]
      ,[Stornobezeichnung DE]
      ,[Stornobezeichnung EN]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[Menge]
      ,[Einheit Betrag]
      ,[Einstandspreis]
      ,[Verkaufspreis (MW)]
      ,[Warenausgangsdatum]
      ,[Deckungsbeitrag]
      ,[Auftragseingangsmenge (Aktuell)]
      ,[Auftragseingangsbetrag (Aktuell)]
      ,[Restbetrag]
      ,[Restmenge]
      ,[Restmenge (Basis)]
      ,[Auftragbestandsbetrag (Aktuell)]
      ,[Auftragbestandsmenge (Aktuell)]
      ,[Rückstandsbetrag]
      ,[Rückstandsmenge]
      ,[Stornomenge]
      ,[Stornobetrag]
      ,[Umsatz]
      ,[Absatz]
      ,[Absatz (Basis)]
      ,[Angebotsmenge]
      ,[Angebotswert]
      ,[Betrag]
      ,[Einstandsbetragsvorrat]
      ,[Auftragseingangsbetrag (Historisch)]
      ,[Auftragseingangsmenge (Historisch)]
      ,[Auftrag veröffentlicht]
      ,[Externe Belegnummer]
      ,[Auftragsdatum]
      ,[Fälligkeitsdatum]
      ,[Gewünschtes Lieferdatum]
      ,[Verkauf an Kontakt]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[Einheitencode]
      ,[Geplantes Lieferdatum]
      ,[Geplantes Warenausgangsdatum]
      ,[Skonto]
      ,[Skontodatum]
      ,[Zlg.-Bedingung Code]
      ,[MwSt. in Prozent]
      ,[Ist Archivbeleg]
      ,[Bundesland]

	  --PK for PowerBI
	  ,[Mandant Code]																									AS [PK dMandant]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenstelle Code],''NULL'')															AS [PK dKostenstelle]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenträger Code],''NULL'')															AS [PK dKostenträger]
	  ,[Mandant Code] +''_''+ ISNULL([Verkauf an Debitornummer],''NULL'')														AS [PK dDebitor (Verkauf)]
	  ,[Mandant Code] +''_''+ ISNULL([Rechnung an Debitornummer],''NULL'')														AS [PK dDebitor (Rechnung)]
	  ,[Mandant Code] +''_''+ ISNULL([Artikelnummer],''NULL'')																	AS [PK dArtikel]
	  ,[Mandant Code] +''_''+ ISNULL([Lagerort Code],''NULL'')																AS [PK dLagerort]
	  ,[Mandant Code] +''_''+ ISNULL(CONVERT(NVARCHAR(2),[Produktart]),''NULL'') +''_''+ ISNULL([Produktnummer],''NULL'')	AS [PK dProdukt]
	  ,[Mandant Code] +''_''+ ISNULL([Verkäufer Code],''NULL'')															AS [PK dVerkäuferEinkäufer]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Belegdatum],21),''NULL'')											AS [PK dZeit (Belegdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Auftragsdatum],21),''NULL'')												AS [PK dZeit (Auftragsdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Buchungsdatum],21),''NULL'')												AS [PK dZeit (Buchungsdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Warenausgangsdatum],21),''NULL'')											AS [PK dZeit (Warenausgangsdatum)]
  FROM [ver].[fVerkaufscontrolling40_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ver].[fVerkaufscontrolling]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fVerkaufscontrolling















































CREATE VIEW [ver].[fVerkaufscontrolling] AS 

SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Belegnummer Häufigkeit]
      ,[Artikelnummer]
      ,[Produktnummer]
      ,[Belegart]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Buchungsdatum]
      ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Verkäufer Code]
      ,[Zeilennummer]
      ,[Verkauf an Debitornummer]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Produktart]
      ,[Zeilenrabattbetrag]
      ,[Rechnung an Debitornummer]
      ,[Storno Code]
      ,[Stornobezeichnung DE]
      ,[Stornobezeichnung EN]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[Menge]
      ,[Einheit Betrag]
      ,[Einstandspreis]
      ,[Verkaufspreis (MW)]
      ,[Warenausgangsdatum]
      ,[Deckungsbeitrag]
      ,[Auftragseingangsmenge (Aktuell)]
      ,[Auftragseingangsbetrag (Aktuell)]
      ,[Restbetrag]
      ,[Restmenge]
      ,[Restmenge (Basis)]
      ,[Auftragbestandsbetrag (Aktuell)]
      ,[Auftragbestandsmenge (Aktuell)]
      ,[Rückstandsbetrag]
      ,[Rückstandsmenge]
      ,[Stornomenge]
      ,[Stornobetrag]
      ,[Umsatz]
      ,[Absatz]
      ,[Absatz (Basis)]
      ,[Angebotsmenge]
      ,[Angebotswert]
      ,[Betrag]
      ,[Einstandsbetragsvorrat]
      ,[Auftragseingangsbetrag (Historisch)]
      ,[Auftragseingangsmenge (Historisch)]
      ,[Auftrag veröffentlicht]
      ,[Externe Belegnummer]
      ,[Auftragsdatum]
      ,[Fälligkeitsdatum]
      ,[Gewünschtes Lieferdatum]
      ,[Verkauf an Kontakt]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[Einheitencode]
      ,[Geplantes Lieferdatum]
      ,[Geplantes Warenausgangsdatum]
      ,[Skonto]
      ,[Skontodatum]
      ,[Zlg.-Bedingung Code]
      ,[MwSt. in Prozent]
      ,[Ist Archivbeleg]
      ,[Bundesland]
      ,[PK dMandant]
      ,[PK dKostenstelle]
      ,[PK dKostenträger]
      ,[PK dDebitor (Verkauf)]
      ,[PK dDebitor (Rechnung)]
      ,[PK dArtikel]
      ,[PK dLagerort]
      ,[PK dProdukt]
      ,[PK dVerkäuferEinkäufer]
      ,[PK dZeit (Belegdatum)]
      ,[PK dZeit (Auftragsdatum)]
      ,[PK dZeit (Buchungsdatum)]
      ,[PK dZeit (Warenausgangsdatum)]
  FROM [ver].[fVerkaufscontrolling35_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000027_Artikel]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View vBC_t0000027_Artikel




















CREATE VIEW [vv].[vBC_t0000027_Artikel] AS
SELECT [No_]					  AS [Artikelnummer]							-- Artikelnummer
      ,[No_ 2]					  AS [Artikelnummer 2]							-- Artikelnummer 2
      ,[Description]			  AS [Artikelbezeichnung]						-- Artikelbeschreibung
      ,[Search Description]		  AS [Suchbezeichnung]								-- Suchbegriff
      ,[Description 2]			  AS [Artikelbezeichnung 2]					-- Artikelbeschreibung 2
      ,[Type]					  AS [Artikeltyp Code]								-- Artikeltyp
      ,[Inventory Posting Group]  AS [Lagerbuchungsgruppe Code]					-- 
      ,[Gen_ Prod_ Posting Group] AS [Produktbuchungsgruppe Code]				-- 
      ,[Base Unit of Measure]	  AS [Basiseinheit]								-- 
      ,[Price Unit Conversion]	  AS [Umrechnungsfaktor]						-- 
      ,[Shelf No_]				  AS [Regalnummer]								-- 
      ,[Unit Price]				  AS [Verkaufspreis (MW)]							--
      ,[Profit _]				  AS [Deckungsbeitrag %]						-- 
      ,[Costing Method]			  AS [Lagerabgangsmethode]						-- 
      ,[Unit Cost]				  AS [Einstandspreis]							-- 
      ,[Standard Cost]			  AS [Einstandspreis (fest)]					-- 
      ,[Last Direct Cost]		  AS [Letzter Einstandspreis]					-- 
      ,[Indirect Cost _]		  AS [Indirekte Kosten %]						-- 
      ,[Vendor No_]				  AS [Lieferantnummer]							-- Lieferantennummer
      ,[Vendor Item No_]		  AS [Lieferant-Artikelnummer]					-- Lieferantenartikelnummer
      ,[Reorder Point]			  AS [Meldebestand]								-- 
      ,[Maximum Inventory]		  AS [Maximalbestand]							-- maximal Bestand
      ,[Reorder Quantity]		  AS [Bestellmenge]								-- 
      ,[Alternative Item No_]	  AS [Alternative Artikelnummer]				-- alterantive Artikelnummer
      ,[Unit List Price]		  AS [Verkaufslistenpreis]						-- 
      ,[Gross Weight]			  AS [Bruttogewicht]							-- Bruttogewicht
      ,[Net Weight]				  AS [Nettogewicht]								-- Nettogewicht
      ,[Blocked]				  AS [Gesperrt Code]							-- Gesperrt
      ,[Block Reason]			  AS [Sperrgrund]								-- Sperrgrund
      ,[Low-Level Code]			  AS [Standard Abgrenzung Code]					-- 
      ,[Lot Size]				  AS [Losgröße]									-- 
      ,[Sales Unit of Measure]	  AS [Verkaufseinheit]							-- 
      ,[Purch_ Unit of Measure]	  AS [Einkaufseinheit]							-- 
      ,[Manufacturer Code]		  AS [Hersteller Code]							-- Hersteller
      ,[Item Category Code]		  AS [Artikelkategorie Code]					-- Artikelkategorie
      ,[Unit of Measure Id]		  AS [Einheit Code]								-- 
      ,[Common Item No_]		  AS [Allgemeine Artikelnummer]				-- 
      ,[SG_MandantCode]			  AS [Mandant Code]								-- Mandantn ID
  FROM [com].[BC_t0000027_Item]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005720_Hersteller]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005720_Hersteller











CREATE VIEW [vv].[vBC_t0005720_Hersteller]AS
SELECT [Code]			AS [Hersteller Code] 	-- Hersteller Code
      ,[Name]			AS [Herstellerbezeichnung]		-- Herstellerbezeichnung
      ,[SG_MandantCode]	AS [Mandant Code]		-- Mandant ID
  FROM [com].[BC_t0005720_Manufacturer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005722_Artikelkategorie]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005722_Artikelkategorie











CREATE VIEW [vv].[vBC_t0005722_Artikelkategorie] AS	
SELECT [Code]			AS [Artikelkategorie Code]			-- Artikelkategorie Code
      ,[Description]	AS [Artikelkategoriebezeichnung]	-- Artikelkategoriebezeichnung
      ,[SG_MandantCode]	AS [Mandant Code]					-- Mandant ID
  FROM [com].[BC_t0005722_Item_Category]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000023_Lieferant]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000023_Lieferant






















CREATE VIEW [vv].[vBC_t0000023_Lieferant] AS						
SELECT [Name]								AS [Lieferantname]					-- Lieferantenbezeichnung
      ,[Name 2]								AS [Lieferantname 2]				-- Lieferantenbezeichnung 2
      ,[Address]							AS [Adresse]						-- Adresse
      ,[Address 2]							AS [Adresse 2]						-- Adresse 2
      ,[City]								AS [Ort]							-- Stadt
      ,[Country_Region Code]				AS [Länder Code]						-- Bundeslandscode
      ,[No_]								AS [Lieferantnummer]				-- Kundennummer
      ,[Search Name]						AS [Suchbezeichnung]					-- Suchbegriff
      ,[Budgeted Amount]					AS [Budgetierter Betrag]			-- Budgetbetrag
      ,[Vendor Posting Group]				AS [Lieferantenbuchungsgruppe Code]	-- Lieferantenbuchungsgruppe
      ,[Currency Code]						AS [Währung Code]					-- Währungscode
      ,[Language Code]						AS [Sprache Code]						-- Sprachcode
      ,[Payment Terms Code]					AS [Zlg.-Bedingung Code]			-- Zahlungsbedinungscode
      ,[Blocked]							AS [Gesperrt Code]					-- Gesperrtcode
      ,[Purchaser Code]						AS [Einkäufer Code]					-- Einkauefercode
	  ,[SG_MandantCode]						AS [Mandant Code]					-- Mandant ID
      ,[Contact]							AS [Kontaktbezeichnung]					-- Kontakname
      ,[Primary Contact No_]				AS [Kontakt Code]					-- Kontakcode
      ,[Territory Code]						AS [Gebiet Code]					-- Gebietscode
      ,[Post Code]							AS [Postleitzahl]					-- Postleitzahl
      ,[Prepayment _]						AS [Vorauszahlung %]				-- Vorauszahlung %
      ,[Location Code]						AS [Lagerort Code]					-- Lagerortcode
      ,[Shipment Method Code]				AS [Lieferbedingung Code]			-- Lieferbedinungscode
      ,[Prices Including VAT]				AS [Preise inkl. MwST]				-- Preise inkl. MwST
      ,[Cash Flow Payment Terms Code]		AS [Cashflow-Zlg.-Bedingung Code]	-- Cashflow-Zlg.-Bedingung Code
      ,[Block Payment Tolerance]			AS [Zahlungstoleranz]				-- Zahlungstoleranz
  FROM [com].[BC_t0000023_Vendor]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dArtikel95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dArtikel95_2














CREATE VIEW [dim].[dArtikel95_2] AS
SELECT [vv].[vBC_t0000027_Artikel].[Artikelnummer]
      ,[vv].[vBC_t0000027_Artikel].[Artikelnummer 2]
      ,[vv].[vBC_t0000027_Artikel].[Artikelbezeichnung]
      ,[vv].[vBC_t0000027_Artikel].[Suchbezeichnung]
      ,[vv].[vBC_t0000027_Artikel].[Artikelbezeichnung 2]
      ,[vv].[vBC_t0000027_Artikel].[Artikeltyp Code]
	  ,ISNULL([Typ Code Bezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Typbezeichnung DE]
	  ,ISNULL([Typ Code Bezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Typbezeichnung EN]
      ,[vv].[vBC_t0000027_Artikel].[Lagerbuchungsgruppe Code]
      ,[vv].[vBC_t0000027_Artikel].[Produktbuchungsgruppe Code]
      ,[vv].[vBC_t0000027_Artikel].[Basiseinheit]
      ,[vv].[vBC_t0000027_Artikel].[Umrechnungsfaktor]
      ,[vv].[vBC_t0000027_Artikel].[Regalnummer]
      ,[vv].[vBC_t0000027_Artikel].[Verkaufspreis (MW)]
      ,[vv].[vBC_t0000027_Artikel].[Deckungsbeitrag %]
      ,[vv].[vBC_t0000027_Artikel].[Lagerabgangsmethode]
      ,[vv].[vBC_t0000027_Artikel].[Einstandspreis]
      ,[vv].[vBC_t0000027_Artikel].[Einstandspreis (fest)]
      ,[vv].[vBC_t0000027_Artikel].[Letzter Einstandspreis]
      ,[vv].[vBC_t0000027_Artikel].[Indirekte Kosten %]
      ,[vv].[vBC_t0000027_Artikel].[Lieferantnummer]
	  ,[vv].[vBC_t0000023_Lieferant].[Lieferantname]
      ,[vv].[vBC_t0000027_Artikel].[Lieferant-Artikelnummer]
      ,[vv].[vBC_t0000027_Artikel].[Meldebestand]
      ,[vv].[vBC_t0000027_Artikel].[Maximalbestand]
      ,[vv].[vBC_t0000027_Artikel].[Bestellmenge]
      ,[vv].[vBC_t0000027_Artikel].[Alternative Artikelnummer]
      ,[vv].[vBC_t0000027_Artikel].[Verkaufslistenpreis]
      ,[vv].[vBC_t0000027_Artikel].[Bruttogewicht]
      ,[vv].[vBC_t0000027_Artikel].[Nettogewicht]
      ,[vv].[vBC_t0000027_Artikel].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Gesperrtbezeichnung EN]
      ,[vv].[vBC_t0000027_Artikel].[Sperrgrund]
      ,[vv].[vBC_t0000027_Artikel].[Standard Abgrenzung Code]
      ,[vv].[vBC_t0000027_Artikel].[Losgröße]
      ,[vv].[vBC_t0000027_Artikel].[Verkaufseinheit]
      ,[vv].[vBC_t0000027_Artikel].[Einkaufseinheit]
      ,[vv].[vBC_t0000027_Artikel].[Hersteller Code]
	  ,[vv].[vBC_t0005720_Hersteller].[Herstellerbezeichnung]
      ,[vv].[vBC_t0000027_Artikel].[Artikelkategorie Code]
	  ,[vv].[vBC_t0005722_Artikelkategorie].[Artikelkategoriebezeichnung]
      ,[vv].[vBC_t0000027_Artikel].[Einheit Code]
      ,[vv].[vBC_t0000027_Artikel].[Allgemeine Artikelnummer]
      ,[vv].[vBC_t0000027_Artikel].[Mandant Code]
  FROM [vv].[vBC_t0000027_Artikel]

  LEFT JOIN [vv].[vBC_t0005722_Artikelkategorie]
  ON [vv].[vBC_t0000027_Artikel].[Mandant Code] = [vv].[vBC_t0005722_Artikelkategorie].[Mandant Code]
  AND [vv].[vBC_t0000027_Artikel].[Artikelkategorie Code] = [vv].[vBC_t0005722_Artikelkategorie].[Artikelkategorie Code]

  LEFT JOIN [vv].[vBC_t0005720_Hersteller]
  ON [vv].[vBC_t0000027_Artikel].[Mandant Code] = [vv].[vBC_t0005720_Hersteller].[Mandant Code]
  AND [vv].[vBC_t0000027_Artikel].[Hersteller Code] = [vv].[vBC_t0005720_Hersteller].[Hersteller Code]	

  LEFT JOIN [vv].[vBC_t0000023_Lieferant]
  ON [vv].[vBC_t0000027_Artikel].[Mandant Code] = [vv].[vBC_t0000023_Lieferant].[Mandant Code]
  AND [vv].[vBC_t0000027_Artikel].[Lieferantnummer]	 = [vv].[vBC_t0000023_Lieferant].[Lieferantnummer]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vv].[vBC_t0000027_Artikel].[Gesperrt Code]		= [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]			= ''Global''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]				= ''Gesperrtbezeichnung''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Typ Code Bezeichnung]
  ON [vv].[vBC_t0000027_Artikel].[Gesperrt Code]		= [Typ Code Bezeichnung].[Optionsfeld Code]
  AND [Typ Code Bezeichnung].[Tabellenname]			= ''BC_t0000027_Item''
  AND [Typ Code Bezeichnung].[Spaltenbezeichnung]				= ''Typ Code Bezeichnung''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dArtikel90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dArtikel90_2













CREATE VIEW [dim].[dArtikel90_2] AS
SELECT [Artikelnummer]
      ,[Artikelnummer 2]
      ,[Artikelbezeichnung]
      ,[Suchbezeichnung]
      ,[Artikelbezeichnung 2]
      ,[Artikeltyp Code]
      ,[Typbezeichnung DE]
      ,[Typbezeichnung EN]
      ,[Lagerbuchungsgruppe Code]
      ,[Produktbuchungsgruppe Code]
      ,[Basiseinheit]
      ,[Umrechnungsfaktor]
      ,[Regalnummer]
      ,[Verkaufspreis (MW)]
      ,[Deckungsbeitrag %]
      ,[Lagerabgangsmethode]
      ,[Einstandspreis]
      ,[Einstandspreis (fest)]
      ,[Letzter Einstandspreis]
      ,[Indirekte Kosten %]
      ,[Lieferantnummer]
      ,[Lieferantname]
      ,[Lieferant-Artikelnummer]
      ,[Meldebestand]
      ,[Maximalbestand]
      ,[Bestellmenge]
      ,[Alternative Artikelnummer]
      ,[Verkaufslistenpreis]
      ,[Bruttogewicht]
      ,[Nettogewicht]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Sperrgrund]
      ,[Standard Abgrenzung Code]
      ,[Losgröße]
      ,[Verkaufseinheit]
      ,[Einkaufseinheit]
      ,[Hersteller Code]
      ,[Herstellerbezeichnung]
      ,[Artikelkategorie Code]
      ,[Artikelkategoriebezeichnung]
      ,[Einheit Code]
      ,[Allgemeine Artikelnummer]
      ,[Mandant Code]
  FROM [dim].[dArtikel95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000379_Detaillierte_Debitorenposten95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000379_Detaillierte_Debitorenposten95_2















CREATE VIEW [vv].[vBC_t0000379_Detaillierte_Debitorenposten95_2] AS										
SELECT [Entry No_]						 AS [detallierte Debitorenposten Lfd. Nr.]									-- detallierte Debitorenposten Lfd. Nr.
      ,[Customer No_]					 AS [Debitornummer]															-- Debitornummer
      ,[Posting Date]					 AS [Buchungsdatum]																-- Buchungsdatum
      ,[Document Type]					 AS [Belegartcode]																-- Belegartcode
      ,[Document No_]					 AS [Belegnummer]																-- Belegnummer
      ,[Currency Code]					 AS [Währung Code]																-- Wärhungscode							   -- 
      ,[Reason Code]					 AS [Grund]																		-- Grund
      ,[Transaction No_]				 AS [Transaktionnummer]														-- Transaktionsnummer
      ,[Remaining Pmt_ Disc_ Possible]	 AS [Restskonto möglich]														-- Restskonto möglich							   -- 
      ,[Cust_ Ledger Entry No_]			 AS [Debitorenposten Lfd. Nr.]												-- Debitorenposten Lfd. Nr.
      ,[Entry Type]						 AS [Detaillierte Debitorposten Art]											-- Detaillierte Debitorposten Art
      ,[Amount]							 AS [Betrag]																	-- Betrag
      ,[Amount (LCY)]					 AS [Betrag (MW)]																-- Betrag (MW)							   -- 
      ,[Debit Amount]					 AS [Sollbetrag]																-- Soll-Betrag
      ,[Credit Amount]					 AS [Habenbetrag]																-- Haben-Betrag
      ,[Debit Amount (LCY)]				 AS [Sollbetrag (MW)]															-- Soll-Betrag (MW)
      ,[Credit Amount (LCY)]			 AS [Habenbetrag (MW)]															-- Haben-Betrag (MW)
      ,[Initial Entry Due Date]			 AS [Urspr. Fälligkeitsdatum]													-- Urspr. Fälligkeitsdatum
      ,[Initial Entry Global Dim_ 1]	 AS [Urspr. Kostenstellencode]	-- Urspr. Global Dimension Code 1 (entweder Kostenstelle o. Kostenträger)
      ,[Initial Entry Global Dim_ 2]	 AS [Urspr. Kostenträgercode]	-- Urspr. Global Dimension Code 2 (entweder Kostenstelle o. Kostenträger)					   -- 
      ,[Applied Cust_ Ledger Entry No_]	 AS [ausgegl. Debitorposten Lfd. Nr.]										-- ausgegl. Debitorposten Lfd. Nr. 								  
      ,[SG_MandantCode]					 AS [Mandant Code]																-- Mandant ID
      ,[SG_Bundesland]						 AS [Bundesland]																-- Bundesland
  FROM [fin].[BC_t0000379_Detailed_Cust_Ledg_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000379_Detaillierte_Debitorenposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000379_Detaillierte_Debitorenposten



CREATE VIEW [vv].[vBC_t0000379_Detaillierte_Debitorenposten]AS 
SELECT [detallierte Debitorenposten Lfd. Nr.]
      ,[Debitornummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum]) AS [Buchungsdatum]
      ,[Belegartcode]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Grund]
      ,[Transaktionnummer]
      ,[Restskonto möglich]
      ,[Debitorenposten Lfd. Nr.]
      ,[Detaillierte Debitorposten Art]
      ,[Betrag]
      ,[Betrag (MW)]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Sollbetrag (MW)]
      ,[Habenbetrag (MW)]
      ,[Urspr. Fälligkeitsdatum]
      ,[Urspr. Kostenstellencode]
      ,[Urspr. Kostenträgercode]
      ,[ausgegl. Debitorposten Lfd. Nr.]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [vv].[vBC_t0000379_Detaillierte_Debitorenposten95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dArtikel85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dArtikel85_2_CONCAT















CREATE VIEW [dim].[dArtikel85_2_CONCAT] AS
SELECT [Artikelnummer]
      ,[Artikelnummer 2]
      ,[Artikelbezeichnung]
      ,[Suchbezeichnung]
      ,[Artikelbezeichnung 2]
      ,[Artikeltyp Code]
      ,[Typbezeichnung DE]
      ,[Typbezeichnung EN]
      ,[Lagerbuchungsgruppe Code]
      ,[Produktbuchungsgruppe Code]
      ,[Basiseinheit]
      ,[Umrechnungsfaktor]
      ,[Regalnummer]
      ,[Verkaufspreis (MW)]
      ,[Deckungsbeitrag %]
      ,[Lagerabgangsmethode]
      ,[Einstandspreis]
      ,[Einstandspreis (fest)]
      ,[Letzter Einstandspreis]
      ,[Indirekte Kosten %]
      ,[Lieferantnummer]
      ,[Lieferantname]
      ,[Lieferant-Artikelnummer]
      ,[Meldebestand]
      ,[Maximalbestand]
      ,[Bestellmenge]
      ,[Alternative Artikelnummer]
      ,[Verkaufslistenpreis]
      ,[Bruttogewicht]
      ,[Nettogewicht]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Sperrgrund]
      ,[Standard Abgrenzung Code]
      ,[Losgröße]
      ,[Verkaufseinheit]
      ,[Einkaufseinheit]
      ,[Hersteller Code]
      ,[Herstellerbezeichnung]
      ,[Artikelkategorie Code]
      ,[Artikelkategoriebezeichnung]
      ,[Einheit Code]
      ,[Allgemeine Artikelnummer]
      ,[Mandant Code]
	  ,CAST(ISNULL([Artikelbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Artikelnummer] AS NVARCHAR(20)) + '')'' AS [Artikelbezeichnung (Nummer)]
      ,CAST(ISNULL([Artikelnummer],'''') AS NVARCHAR(20)) + '' '' + CAST([Artikelbezeichnung] AS NVARCHAR(100)) AS [Artikelnummer Bezeichnung]
	  ,CAST(ISNULL([Artikelkategoriebezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Artikelkategorie Code] AS NVARCHAR(10)) + '')'' AS [Artikelkategoriebezeichnung (Code)]
      ,CAST(ISNULL([Artikelkategorie Code],'''') AS NVARCHAR(10)) + '' '' + CAST([Artikelkategoriebezeichnung] AS NVARCHAR(100)) AS [Artikelkategorie Code Bezeichnung]
	  ,[Mandant Code] +''_''+ [Artikelnummer]AS [PK dArtikel]
  FROM [dim].[dArtikel90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor95_2_Betrag]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor95_2_Betrag














CREATE VIEW [fin].[fOPDebitor95_2_Betrag] AS 
SELECT
   [Mandant Code]
  ,[Debitorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Betrag (MW)]
  ,CAST(SUM([Sollbetrag (MW)]) AS NUMERIC(18,5)) AS [Sollbetrag (MW)]
  ,CAST(SUM([Habenbetrag (MW)]) AS NUMERIC(18,5)) AS [Habenbetrag (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Betrag]
  ,CAST(SUM([Sollbetrag]) AS NUMERIC(18,5)) AS [Sollbetrag]
  ,CAST(SUM([Habenbetrag]) AS NUMERIC(18,5)) AS [Habenbetrag]
FROM
  [vv].[vBC_t0000379_Detaillierte_Debitorenposten]
--Ermittlung BetragMW zu einem Posten
  WHERE [Detaillierte Debitorposten Art] IN (1,3,4,5,6,7,8,9,12,13,14,15,16,17) 
--Urspr. Posten / Unrealisierter Verlust / Unrealisierter Gewinn / Realisierter Verlust / Realisierter Gewinn / Skonto / Skonto (ohne MwSt.) / Skonto (MwSt.-Regulierung) / Zahlungstoleranz / Skontotoleranz / Zahlungstoleranz (ohne MwSt.) / Zahlungstoleranz (MwSt.-Regulierung) / Skontotoleranz (ohne MwSt.) / Skontotoleranz (MwSt.-Regulierung)
  GROUP BY [Mandant Code], [Debitorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dArtikel]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dArtikel















CREATE VIEW [dim].[dArtikel] AS

SELECT [Artikelnummer]
      ,[Artikelnummer 2]
      ,[Artikelbezeichnung]
      ,[Suchbezeichnung]
      ,[Artikelbezeichnung 2]
      ,[Artikeltyp Code]
      ,[Typbezeichnung DE]
      ,[Typbezeichnung EN]
      ,[Lagerbuchungsgruppe Code]
      ,[Produktbuchungsgruppe Code]
      ,[Basiseinheit]
      ,[Umrechnungsfaktor]
      ,[Regalnummer]
      ,[Verkaufspreis (MW)]
      ,[Deckungsbeitrag %]
      ,[Lagerabgangsmethode]
      ,[Einstandspreis]
      ,[Einstandspreis (fest)]
      ,[Letzter Einstandspreis]
      ,[Indirekte Kosten %]
      ,[Lieferantnummer]
      ,[Lieferantname]
      ,[Lieferant-Artikelnummer]
      ,[Meldebestand]
      ,[Maximalbestand]
      ,[Bestellmenge]
      ,[Alternative Artikelnummer]
      ,[Verkaufslistenpreis]
      ,[Bruttogewicht]
      ,[Nettogewicht]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Sperrgrund]
      ,[Standard Abgrenzung Code]
      ,[Losgröße]
      ,[Verkaufseinheit]
      ,[Einkaufseinheit]
      ,[Hersteller Code]
      ,[Herstellerbezeichnung]
      ,[Artikelkategorie Code]
      ,[Artikelkategoriebezeichnung]
      ,[Einheit Code]
      ,[Allgemeine Artikelnummer]
      ,[Mandant Code]
      ,[Artikelbezeichnung (Nummer)]
      ,[Artikelnummer Bezeichnung]
      ,[Artikelkategoriebezeichnung (Code)]
      ,[Artikelkategorie Code Bezeichnung]
      ,[PK dArtikel]
  FROM [dim].[dArtikel85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dProdukt95_2_Artikel]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dProdukt95_2_Artikel














CREATE VIEW [dim].[dProdukt95_2_Artikel] AS

SELECT
   [Mandant Code]
  ,CAST(2 AS TINYINT) AS [Produkttyp Code]
  ,CAST(''Item'' AS NVARCHAR(20)) AS [Produkttypbezeichnung]
  ,[Artikelnummer]
  ,[Artikelbezeichnung]
  ,[Artikelbezeichnung (Nummer)]
  ,[Artikelnummer Bezeichnung]
FROM [dim].[dArtikel]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor95_2_BetragInklMwSt]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor95_2_BetragInklMwSt

















CREATE VIEW [fin].[fOPDebitor95_2_BetragInklMwSt] AS 
--Umsatz inkl. MWST
SELECT
   [Mandant Code]
  ,[Debitorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Betrag inkl. MwSt. (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Betrag inkl. MwSt.]
FROM [vv].[vBC_t0000379_Detaillierte_Debitorenposten]
--Beträge die durch unberechtigte Skonto gewährt wurden
WHERE [Detaillierte Debitorposten Art] IN (1)
--Urspr. Posten
GROUP BY [Mandant Code]
        ,[Debitorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000156_Ressource]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000156_Ressource










CREATE VIEW [vv].[vBC_t0000156_Ressource] AS
SELECT [No_]			  AS [Ressourcennummer]			-- Ressourcennummer
      ,[Type]			  AS [Ressourcentyp]	-- Ressourcentyp
      ,[Name]			  AS [Ressourcenbezeichnung]		-- Ressourcenbezeichnung
      ,[SG_MandantCode]	  AS [Mandant Code]			-- Mandant ID
  FROM [com].[BC_t0000156_Resource]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dProdukt95_2_Ressource]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dProdukt95_2_Ressource















CREATE VIEW [dim].[dProdukt95_2_Ressource] AS

SELECT
	   [Mandant Code]
	  ,CAST(3 AS TINYINT) AS [Produkttyp Code]
	  ,CAST(''Ressource'' as varchar(20)) AS [Produkttypbezeichnung]
	  ,[Ressourcennummer]
	  ,[Ressourcenbezeichnung]
	  ,CAST(ISNULL([Ressourcenbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Ressourcennummer] AS NVARCHAR(20)) + '')'' AS [Ressourcenbezeichnung (Nummer)]
      ,CAST(ISNULL([Ressourcennummer],'''') AS NVARCHAR(20)) + '' '' + CAST([Ressourcenbezeichnung] AS NVARCHAR(100)) AS [Ressourcennummer Bezeichnung]
FROM [vv].[vBC_t0000156_Ressource]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung95_2























CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung95_2] AS
SELECT [Schedule Name]			 AS [Strukturbezeichnung]
      ,[Line No_]				 AS [Zeilennummer]
      ,[Row No_]				 AS [Parent Code]
      ,[Description]			 AS [Beschreibung]
      ,[Totaling]				 AS [Zusammenzählung]
      ,[Totaling Type]			 AS [Zusammenzählungstyp]
      ,[SG_MandantCode]			 AS [Mandant Code]
	  ,[Show Opposite Sign]		 AS [Umkehr Code]
  FROM [fin].[BC_t0000085_Acc_Schedule_Line]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung90_2_FILTER]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung90_2_FILTER





























CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung90_2_FILTER] AS
SELECT [vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Strukturbezeichnung]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Zeilennummer]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Parent Code]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Beschreibung]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Zusammenzählung]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Zusammenzählungstyp]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Mandant Code]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Umkehr Code]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung95_2]

  --es sollen nur die Strukturen für aktive Mandanten geladen werden, dazu kommt noch die Anofrderung das die Bilanzstruktur für den Hauptmandanten
  --geladen wird. (JH - 2020-02-02 - #7988)
  INNER JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Mandant Code]	=	[vSNCt_Aktiver_Mandant].[Mandant Code]
  AND [vSNCt_Aktiver_Mandant].[Hauptmandant] = 1

  LEFT JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON  [vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Mandant Code]	  =	[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]
  WHERE ([vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Strukturbezeichnung] = [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Name des Bilanz-Reports]
  OR [vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Strukturbezeichnung] = [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Name des GuV-Reports]
  OR [vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Strukturbezeichnung] = [vSNCt_Aktiver_Mandant].[Schemabezeichnung BWA])

  AND
  --Knoten die keine Unterknoten haben werden abgefiltert, da es ansonsten zu Problemen im rekursiven Aufruf kommt
  --gleiche Funktionsweise wie im Integrator
  [vBC_t0000085_Kontenplanzeilenaufteilung95_2].[Zusammenzählung] <> ''''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dGuVParentChild95_3_Rekursiv]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dGuVParentChild95_3_Rekursiv













CREATE VIEW [dim].[dGuVParentChild95_3_Rekursiv]AS 
  WITH [CTE_TABLE] AS (

SELECT [Parent].[Strukturbezeichnung]
      ,[Parent].[Mandant Code]
      ,[Parent].[Parent Zeilennummer]
      ,[Parent].[Parent Code Original]
      ,[Parent].[Parent Code]
      ,[Parent].[Parentbezeichnung]
      ,[Parent].[Child Zeilennummer]
      ,[Parent].[Child Code Original]
      ,[Parent].[Child Code]
      ,[Parent].[Childbezeichnung]
      ,[Parent].[Sachkontonummer]
      ,[Parent].[Sachkontobezeichnung]
      ,[Parent].[Ist Sachkonto]
      ,[Parent].[Aktiva Code]
      ,[Parent].[Passiva Code]
      ,[Parent].[Sachkontobezeichnung (Nummer)]
      ,[Parent].[Sachkontonummer Bezeichnung]
      ,[Parent].[Umkehr Code]
	  ,[Parent].[Elementbezeichnung]
  FROM [ZdbSNCDatawarehouse].[dim].[dBilanzParentChild] AS [Parent]

  --Abfilterung auf GuV Bereich
  INNER JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON  ([Parent].[Parent Code Original]	= [vSNCt_Aktiver_Mandant].[GuV Code]
  AND [vSNCt_Aktiver_Mandant].[Hauptmandant] = 1)

  --hinzukommt der Knoten für die Nicht zugeordneten Sachkonten
  OR  ([Parent].[Child Code Original] = ''9999999999'' 
  AND [vSNCt_Aktiver_Mandant].[Hauptmandant] = 1)

    UNION ALL

    SELECT [Child].[Strukturbezeichnung]
      ,[Child].[Mandant Code]
      ,[Child].[Parent Zeilennummer]
      ,[Child].[Parent Code Original]
      ,[Child].[Parent Code]
      ,[Child].[Parentbezeichnung]
      ,[Child].[Child Zeilennummer]
      ,[Child].[Child Code Original]
      ,[Child].[Child Code]
      ,[Child].[Childbezeichnung]
      ,[Child].[Sachkontonummer]
      ,[Child].[Sachkontobezeichnung]
      ,[Child].[Ist Sachkonto]
      ,[Child].[Aktiva Code]
      ,[Child].[Passiva Code]
      ,[Child].[Sachkontobezeichnung (Nummer)]
      ,[Child].[Sachkontonummer Bezeichnung]
      ,[Child].[Umkehr Code]
	  ,[Child].[Elementbezeichnung]
  FROM [ZdbSNCDatawarehouse].[dim].[dBilanzParentChild] AS [Child]
      
	 JOIN [CTE_TABLE]
	 ON  [CTE_TABLE].[Strukturbezeichnung]	= [Child].[Strukturbezeichnung]
	 AND [CTE_TABLE].[Child Code]		= [Child].[Parent Code]
)

SELECT DISTINCT 
       [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code Original]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code Original]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
      ,[Aktiva Code]
      ,[Passiva Code]
      ,[Sachkontobezeichnung (Nummer)]
      ,[Sachkontonummer Bezeichnung]
      ,[Umkehr Code]
	  ,[Elementbezeichnung]
FROM [CTE_TABLE];
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor95_2_LetzteZahlung]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor95_2_LetzteZahlung














CREATE VIEW [fin].[fOPDebitor95_2_LetzteZahlung] AS 
SELECT
   [Mandant Code]
  ,[Debitorenposten Lfd. Nr.]
  ,MAX([Buchungsdatum]) AS [Letztes Zahlungsdatum]
FROM [vv].[vBC_t0000379_Detaillierte_Debitorenposten]
-- Ein Posten kann durch mehrere Zahlungen ausgeglichen werden. Hier wird die letzte Zahlung ermitellt
 WHERE [Detaillierte Debitorposten Art] IN (2) 
  -- Zahlung
GROUP BY [Mandant Code]
        ,[Debitorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000015_Sachkonto]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000015_Sachkonto




















CREATE VIEW [vv].[vBC_t0000015_Sachkonto] AS 							
SELECT [Name]						  AS [Sachkontobezeichnung]				-- Sachkontoname
      ,[No_]						  AS [Sachkontonummer]						-- Sachkontonummer
      ,[Account Type]				  AS [Sachkontotyp Code]					-- Sachkontotyp
      ,[Income_Balance]				  AS [GuV/Bilanz Code]						-- GuV/Bilanz Flag
      ,[Global Dimension 1 Code]	  AS [Kostenstellencode]				-- Global Dimension Code 1 (entweder Kostenstelle o. Kostenträger)
      ,[Global Dimension 2 Code]	  AS [Kostenträgercode]				-- Global Dimension Code 2 (entweder Kostenstelle o. Kostenträger)
      ,[No_ 2]						  AS [Sachkontonummer 2]					-- Sachkontonummer 2
      ,[Blocked]					  AS [Gesperrt Code]						-- Gesperrt Code
      ,[SG_MandantCode]				  AS [Mandant Code]							-- Mandant ID
  FROM [fin].[BC_t0000015_G_L_Account]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dSachkonto95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dSachkonto95_2






















CREATE   VIEW [dim].[dSachkonto95_2] AS 
SELECT [vBC_t0000015_Sachkonto].[Sachkontobezeichnung]
      ,[vBC_t0000015_Sachkonto].[Sachkontonummer]
      ,[vBC_t0000015_Sachkonto].[Sachkontotyp Code]
	  ,ISNULL([Sachkontotypbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')		AS [Sachkontotypbezeichnung DE]
	  ,ISNULL([Sachkontotypbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')			AS [Sachkontotypbezeichnung EN]
	  ,[vBC_t0000015_Sachkonto].[GuV/Bilanz Code]
	  ,ISNULL([GuV/Bilanz Bezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')			AS [GuV/Bilanz Bezeichnung DE]
	  ,ISNULL([GuV/Bilanz Bezeichnung].[Optionsfeldbezeichnung EN],''not defined'')				AS [GuV/Bilanz Bezeichnung EN]
      ,[vBC_t0000015_Sachkonto].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')			AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')				AS [Gesperrtbezeichnung EN]
      ,[vBC_t0000015_Sachkonto].[Mandant Code]
  FROM [vv].[vBC_t0000015_Sachkonto]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [GuV/Bilanz Bezeichnung]
  ON [vBC_t0000015_Sachkonto].[GuV/Bilanz Code]  = [GuV/Bilanz Bezeichnung].[Optionsfeld Code]
  AND [GuV/Bilanz Bezeichnung].[Tabellenname]	  = ''BC_t0000015_G_L_Account''
  AND [GuV/Bilanz Bezeichnung].[Spaltenbezeichnung]		  = ''Income/Balance Description''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vBC_t0000015_Sachkonto].[Gesperrt Code]  = [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]		= ''Global''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]			= ''Gesperrtbezeichnung''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Sachkontotypbezeichnung]
  ON [vBC_t0000015_Sachkonto].[Sachkontotyp Code]	= [Sachkontotypbezeichnung].[Optionsfeld Code]
  AND [Sachkontotypbezeichnung].[Tabellenname]		= ''BC_t0000015_G_L_Account''
  AND [Sachkontotypbezeichnung].[Spaltenbezeichnung]			= ''Sachkontotypbezeichnung''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dSachkonto90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dSachkonto90_2



















CREATE VIEW [dim].[dSachkonto90_2] AS 
SELECT [Sachkontobezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontotyp Code]
      ,[Sachkontotypbezeichnung DE]
      ,[Sachkontotypbezeichnung EN]
      ,[GuV/Bilanz Code]
      ,[GuV/Bilanz Bezeichnung DE]
      ,[GuV/Bilanz Bezeichnung EN]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
  FROM [dim].[dSachkonto95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dSachkonto85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dSachkonto85_2_CONCAT
















CREATE VIEW [dim].[dSachkonto85_2_CONCAT] AS
SELECT [Sachkontobezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontotyp Code]
      ,[Sachkontotypbezeichnung DE]
      ,[Sachkontotypbezeichnung EN]
      ,[GuV/Bilanz Code]
      ,[GuV/Bilanz Bezeichnung DE]
      ,[GuV/Bilanz Bezeichnung EN]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
	  ,CAST(ISNULL([Sachkontobezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Sachkontonummer] AS NVARCHAR(20)) + '')'' AS [Sachkontobezeichnung (Nummer)]
      ,CAST(ISNULL([Sachkontonummer],'''') AS NVARCHAR(20)) + '' '' + CAST([Sachkontobezeichnung] AS NVARCHAR(100)) AS [Sachkontonummer Bezeichnung]
	  ,[Mandant Code] +''_''+ [Sachkontonummer] AS [PK dSachkonto]
  FROM [dim].[dSachkonto90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dSachkonto]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dSachkonto























CREATE VIEW [dim].[dSachkonto] AS 

SELECT [Sachkontobezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontotyp Code]
      ,[Sachkontotypbezeichnung DE]
      ,[Sachkontotypbezeichnung EN]
      ,[GuV/Bilanz Code]
      ,[GuV/Bilanz Bezeichnung DE]
      ,[GuV/Bilanz Bezeichnung EN]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
      ,[Sachkontobezeichnung (Nummer)]
      ,[Sachkontonummer Bezeichnung]
      ,[PK dSachkonto]
  FROM [dim].[dSachkonto85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dProdukt95_2_Sachkonto]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dProdukt95_2_Sachkonto
















CREATE VIEW [dim].[dProdukt95_2_Sachkonto] AS

SELECT
   [Mandant Code]
  ,CAST(1 AS TINYINT) AS [Produkttyp Code]
  ,CAST(''G/L Account'' AS NVARCHAR(20)) AS [Produkttypbezeichnung]
  ,[Sachkontonummer]
  ,[Sachkontobezeichnung]
  ,[Sachkontobezeichnung (Nummer)]
  ,[Sachkontonummer Bezeichnung]
FROM [dim].[dSachkonto]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung85_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung85_2





























CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung85_2] AS
SELECT [Strukturbezeichnung]
      ,[Zeilennummer]
	  ,[Parent Code]
      ,[Beschreibung]
	  --defining the start and endpoint for summary
      ,[dbo].[SG_SPLIT_TOTALING_STRINGS]([Pipe seperation].value,''start'')	AS [Zusammenzählung Start]
	  ,[dbo].[SG_SPLIT_TOTALING_STRINGS]([Pipe seperation].value,''end'')		AS [Zusammenzählung Ende]
      ,[Zusammenzählung]
      ,[Zusammenzählungstyp]
      ,[Mandant Code]
	  ,[Umkehr Code]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung90_2_FILTER]
  --ALTER rows for each pipe seperation in totaling
  CROSS APPLY STRING_SPLIT([Zusammenzählung],''|'') AS [Pipe seperation]
  
  WHERE 1=1  
 -- AND [Parent Code] <> ''''
  --delete empty rows for reporting
  AND [Beschreibung] <> ''''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000079_Mandantinformationen]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000079_Mandantinformationen





















CREATE   VIEW [vv].[vBC_t0000079_Mandantinformationen] AS
SELECT [Name]					AS [Mandantname]			-- Mandantname
      ,[Name 2]					AS [Mandantname 2]			-- Mandantname 2
      ,[Address]				AS [Adresse]						-- Adresse
      ,[Address 2]				AS [Adresse 2]						-- Adresse 2
      ,[City]					AS [Ort]							-- Stadt
      ,[Phone No_]				AS [Telefonnummer]					-- Telefonnummer
      ,[VAT Registration No_]	AS [Steueridentifikationsnummer]	-- Steueridentifikationsnummer
      ,[Post Code]				AS [Postleitzahl]					-- Postleitzahl
      ,[County]					AS [Bundesland]						-- 
      ,[E-Mail]					AS [E-Mail]							-- E-Mail
      ,[Country_Region Code]	AS [Länder Code]						-- Bundesland
      ,[SG_MandantCode]			AS [Mandant Code]					-- Mandant ID
  FROM com.[BC_t0000079_Company_Information]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMandant95_2]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dim].[dMandant95_2] AS 
SELECT [vSNCt_Aktiver_Mandant].[Mandant Code]
	  ,[vSNCt_Aktiver_Mandant].[Sortierreihenfolge]
      ,[vBC_t0000079_Mandantinformationen].[Mandantname]
	  ,[vBC_t0000079_Mandantinformationen].[Mandantname 2]
	  ,[vBC_t0000079_Mandantinformationen].[Ort]
	  ,[vBC_t0000079_Mandantinformationen].[Adresse]
	  ,[vBC_t0000079_Mandantinformationen].[Adresse 2]
	  ,[vBC_t0000079_Mandantinformationen].[Postleitzahl]
	  ,[vBC_t0000079_Mandantinformationen].[Bundesland]
	  ,[vBC_t0000079_Mandantinformationen].[E-Mail]
	  ,[vBC_t0000079_Mandantinformationen].[Telefonnummer]
	  ,[vBC_t0000079_Mandantinformationen].[Steueridentifikationsnummer]
  FROM [vv].[vSNCt_Aktiver_Mandant]

  INNER JOIN [vv].[vBC_t0000079_Mandantinformationen]
  ON [vSNCt_Aktiver_Mandant].[Mandant Code] = [vBC_t0000079_Mandantinformationen].[Mandant Code]

  WHERE
  --only active companies are available in the DWH
  [vSNCt_Aktiver_Mandant].[Aktives Kennzeichen Verkauf] = ''TRUE'' 
  OR [vSNCt_Aktiver_Mandant].[Aktives Kennzeichen Finanzen] = ''TRUE''
  OR [vSNCt_Aktiver_Mandant].[Aktives Kennzeichen Einkauf] = ''TRUE''' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMandant90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dMandant90_2


















CREATE VIEW [dim].[dMandant90_2] AS
SELECT [Mandant Code]
      ,[Sortierreihenfolge]
      ,[Mandantname]
      ,[Mandantname 2]
      ,[Ort]
      ,[Adresse]
      ,[Adresse 2]
      ,[Postleitzahl]
      ,[Bundesland]
      ,[E-Mail]
      ,[Telefonnummer]
      ,[Steueridentifikationsnummer]
  FROM [dim].[dMandant95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMandant85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dMandant85_2_CONCAT




CREATE VIEW [dim].[dMandant85_2_CONCAT] AS
SELECT [Mandant Code]
      ,[Sortierreihenfolge]
      ,[Mandantname]
      ,[Mandantname 2]
      ,[Ort]
      ,[Adresse]
      ,[Adresse 2]
      ,[Postleitzahl]
      ,[Bundesland]
      ,[E-Mail]
      ,[Telefonnummer]
      ,[Steueridentifikationsnummer]
	  ,CAST(ISNULL([Mandantname],'''') AS NVARCHAR(100)) + '' ('' + CAST([Mandant Code] AS NVARCHAR(20)) + '')'' AS [Mandantname (Code)]
      ,CAST(ISNULL([Mandant Code],'''') AS NVARCHAR(20)) + '' '' + CAST([Mandantname] AS NVARCHAR(100)) AS [Mandant Code Bezeichnung]
	  ,[Mandant Code] AS [PK dMandant]
  FROM [dim].[dMandant90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor95_2_OffenerBetrag]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor95_2_OffenerBetrag





CREATE VIEW [fin].[fOPDebitor95_2_OffenerBetrag] AS 
--Alle Posten summiert bis zum Stichtag ergeben den Restbetrag
SELECT
   [Mandant Code]
  ,[Debitorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Offener Betrag (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Offener Betrag]
FROM [vv].[vBC_t0000379_Detaillierte_Debitorenposten]

GROUP BY [Mandant Code]
        ,[Debitorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMandant]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dMandant



















CREATE VIEW [dim].[dMandant] AS 
SELECT [Mandant Code]
      ,[Sortierreihenfolge]
      ,[Mandantname]
      ,[Mandantname 2]
      ,[Ort]
      ,[Adresse]
      ,[Adresse 2]
      ,[Postleitzahl]
      ,[Bundesland]
      ,[E-Mail]
      ,[Telefonnummer]
      ,[Steueridentifikationsnummer]
      ,[Mandantname (Code)]
      ,[Mandant Code Bezeichnung]
      ,[PK dMandant]
  FROM [dim].[dMandant85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung80_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung80_2












CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung80_2] AS
SELECT [Parent].[Strukturbezeichnung]
	--aufgrund der Thematik, das nur noch die Bilanz des Hauptmandanten geladen wird, muss wird ihr im Falle einer Sachkontozuordnung der Mandant vom Sachkonto genommen,
	--ansonsten der Mandant von den Strukturelementen (JH - 2020-02-02 - #7988)
      ,ISNULL([dSachkonto].[Mandant Code], [Parent].[Mandant Code])									AS [Mandant Code]
      ,ISNULL([Child].[Zeilennummer], NULL)															AS [Parent Zeilennummer]
	  ,ISNULL([Child].[Parent Code], NULL)															AS [Parent Code]
	  ,ISNULL([Child].[Beschreibung], NULL)															AS [Parentbezeichnung]
	  ,[Parent].[Zeilennummer]																		AS [Child Zeilennummer]
      ,[Parent].[Parent Code]																		AS [Child Code]
      ,[Parent].[Beschreibung]																		AS [Childbezeichnung]
	  ,[dSachkonto].[Sachkontonummer]
	  ,[dSachkonto].[Sachkontobezeichnung]
	  ,[dSachkonto].[Sachkontobezeichnung (Nummer)]
	  ,[dSachkonto].[Sachkontonummer Bezeichnung]
	  ,CAST(IIF([Parent].[Parent Code] = [dSachkonto].[Sachkontonummer],''True'',''False'') AS BIT) AS [Ist Blattknoten]
      ,[Parent].[Zusammenzählung Start]
      ,[Parent].[Zusammenzählung Ende]
      ,[Parent].[Zusammenzählungstyp]
	  ,[Parent].[Umkehr Code]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung85_2] AS [Parent]

  --der Root Knoten bekommt keinen Vater Knoten zugewiesen
  
  LEFT JOIN [vv].[vBC_t0000085_Kontenplanzeilenaufteilung85_2] AS [Child]
  ON  [Parent].[Strukturbezeichnung]	= [Child].[Strukturbezeichnung]
  AND [Parent].[Parent Code]	BETWEEN	 [Child].[Zusammenzählung Start] AND	 [Child].[Zusammenzählung Ende]

  -- es darf nicht mehr über den Company Code verknpüft werden, da alle Sachkonten von allen Mandanten an die Struktur geschrieben werden (JH - 2020-02-02 - #7988)
  LEFT JOIN [dim].[dSachkonto]
  ON [dSachkonto].[Sachkontonummer]	BETWEEN	[Parent].[Zusammenzählung Start] AND [Parent].[Zusammenzählung Ende]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dGuVParentChild90_2_Wurzel]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dGuVParentChild90_2_Wurzel




































CREATE VIEW [dim].[dGuVParentChild90_2_Wurzel]

AS

SELECT [dim].[dGuVParentChild95_3_Rekursiv].[Mandant Code]
      ,[dim].[dGuVParentChild95_3_Rekursiv].[Strukturbezeichnung]
      ,[dim].[dGuVParentChild95_3_Rekursiv].[Parent Code]			AS [Child Code]
      ,[dim].[dGuVParentChild95_3_Rekursiv].[Parentbezeichnung]		AS [Childbezeichnung]
	  ,[dim].[dGuVParentChild95_3_Rekursiv].[Parent Code Original]	AS [Child Code Original]
      ,[dim].[dGuVParentChild95_3_Rekursiv].[Parent Zeilennummer]		AS [Child Zeilennummer]
      ,[dim].[dGuVParentChild95_3_Rekursiv].[Sachkontonummer]
      ,[dim].[dGuVParentChild95_3_Rekursiv].[Sachkontobezeichnung]
      ,[dim].[dGuVParentChild95_3_Rekursiv].[Sachkontobezeichnung (Nummer)]
      ,[dim].[dGuVParentChild95_3_Rekursiv].[Sachkontonummer Bezeichnung]

	  --für die Root Knoten der Struktur, werden die jeweiligen Mandanten als Parent-Knoten eingetragen
	  ,CAST(''_''+ ISNULL(CAST([dim].[dMandant].[Sortierreihenfolge] AS NVARCHAR(10)),''0'') +''_L_''+ ISNULL([dim].[dMandant].[Mandant Code],''ROOT'') AS NVARCHAR(40)) AS [Parent Code]
      ,[dim].[dMandant].[Mandantname]		AS [Parentbezeichnung]
      ,[dim].[dMandant].[Sortierreihenfolge]		AS [Parent Zeilennummer]
	  ,CAST(NULL AS NVARCHAR(10))		    AS [Parent Code Original]

      ,[dim].[dGuVParentChild95_3_Rekursiv].[Ist Sachkonto]
	  ,[dim].[dGuVParentChild95_3_Rekursiv].[Umkehr Code]
	  ,[dim].[dGuVParentChild95_3_Rekursiv].[Elementbezeichnung]
  FROM [dim].[dGuVParentChild95_3_Rekursiv]

  LEFT JOIN [dim].[dMandant]
  ON [dim].[dGuVParentChild95_3_Rekursiv].[Mandant Code] = [dMandant].[Mandant Code]

  --Abfilterung auf GuV Bereich
  INNER JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [dim].[dGuVParentChild95_3_Rekursiv].[Mandant Code]				= [vSNCt_Aktiver_Mandant].[Mandant Code]
  AND [dim].[dGuVParentChild95_3_Rekursiv].[Parent Code Original]	= [vSNCt_Aktiver_Mandant].[GuV Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor95_2_ZlgRabatt]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor95_2_ZlgRabatt














CREATE VIEW [fin].[fOPDebitor95_2_ZlgRabatt] AS 
SELECT
   [Mandant Code]
  ,[Debitorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Betrag Zahlungsrabatt (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Betrag Zahlungsrabatt]
FROM [vv].[vBC_t0000379_Detaillierte_Debitorenposten]
--BetrÃ¤ge durch berechtigte Skonto 
 WHERE [Detaillierte Debitorposten Art] IN (8,9) -- Skonto (ohne MwSt.) / Skonto (MwSt.-Regulierung)
  -- Ausgleich / Restbetrag Korrektur
GROUP BY [Mandant Code]
        ,[Debitorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dProdukt90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dProdukt90_2













CREATE VIEW [dim].[dProdukt90_2] AS

SELECT
   [Mandant Code]
  ,[Produkttyp Code]
  ,[Produkttypbezeichnung]
  ,[Sachkontonummer]				AS [Produktnummer]
  ,[Sachkontobezeichnung]				AS [Produktbezeichnung]
  ,[Sachkontobezeichnung (Nummer)]			AS [Produktbezeichnung (Nummer)]
  ,[Sachkontonummer Bezeichnung]			AS [Produktnummer Bezeichnung]
FROM [dim].[dProdukt95_2_Sachkonto]

UNION ALL 

SELECT
   [Mandant Code]
  ,[Produkttyp Code]
  ,[Produkttypbezeichnung]
  ,[Artikelnummer]						AS [Produktnummer]
  ,[Artikelbezeichnung (Nummer)]				AS [Produktbezeichnung]
  ,[Artikelbezeichnung (Nummer)]				AS [Produktbezeichnung (Nummer)]
  ,[Artikelnummer Bezeichnung]					AS [Produktnummer Bezeichnung]
FROM [dim].[dProdukt95_2_Artikel]

UNION ALL 

SELECT
   [Mandant Code]
  ,[Produkttyp Code]
  ,[Produkttypbezeichnung]
  ,[Ressourcennummer]					AS [Produktnummer]
  ,[Ressourcenbezeichnung]					AS [Produktbezeichnung]
  ,[Ressourcenbezeichnung (Nummer)]			AS [Produktbezeichnung (Nummer)]
  ,[Ressourcennummer Bezeichnung]				AS [Produktnummer Bezeichnung]
FROM [dim].[dProdukt95_2_Ressource]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dGuVParentChild80_2_UNION]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dGuVParentChild80_2_UNION












CREATE VIEW [dim].[dGuVParentChild80_2_UNION] AS 

  SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
	  ,[Child Code Original]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
	  ,[Sachkontobezeichnung (Nummer)]
      ,[Sachkontonummer Bezeichnung]
      ,[Umkehr Code]
      ,[Child Zeilennummer]
      ,[Parent Code]
	  ,[Parent Code Original]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
      ,[Ist Sachkonto]
	  ,[Elementbezeichnung]
  FROM [dim].[dGuVParentChild90_2_Wurzel]


  UNION ALL

SELECT [Mandant Code]	
      ,[Strukturbezeichnung]
      ,[Child Code]
	  ,[Child Code Original]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
	  ,[Sachkontobezeichnung (Nummer)]
      ,[Sachkontonummer Bezeichnung]
      ,[Umkehr Code]
      ,[Child Zeilennummer]
      ,[Parent Code]
	  ,[Parent Code Original]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
      ,[Ist Sachkonto]
	  ,[Elementbezeichnung]
  FROM [dim].[dGuVParentChild95_3_Rekursiv]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000380_Detaillierte_Kreditorenposten95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000380_Detaillierte_Kreditorenposten95_2








CREATE VIEW [vv].[vBC_t0000380_Detaillierte_Kreditorenposten95_2] AS										
SELECT [Entry No_]						 AS [detallierte Kreditorenposten Lfd. Nr.]									-- detallierte Kreditorenposten Lfd. Nr.
      ,[Vendor No_]					     AS [Kreditornummer]															-- Kreditornummer
      ,[Posting Date]					 AS [Buchungsdatum]																-- Buchungsdatum
      ,[Document Type]					 AS [Belegartcode]																-- Belegartcode
      ,[Document No_]					 AS [Belegnummer]																-- Belegnummer
      ,[Currency Code]					 AS [Währungscode]																-- Wärhungscode							   -- 
      ,[Reason Code]					 AS [Grund]																		-- Grund
      ,[Transaction No_]				 AS [Transaktionsnummer]														-- Transaktionsnummer
      ,[Remaining Pmt_ Disc_ Possible]	 AS [Restskonto möglich]														-- Restskonto möglich							   -- 
      ,[Vendor Ledger Entry No_]		 AS [Kreditorenposten Lfd. Nr.]												-- Kreditorenposten Lfd. Nr.
      ,[Entry Type]						 AS [Detaillierte Kreditorposten Art]											-- Detaillierte Kreditorposten Art
      ,[Amount]							 AS [Betrag]																	-- Betrag
      ,[Amount (LCY)]					 AS [Betrag (MW)]																-- Betrag (MW)							   -- 
      ,[Debit Amount]					 AS [Sollbetrag]																-- Soll-Betrag
      ,[Credit Amount]					 AS [Habenbetrag]																-- Haben-Betrag
      ,[Debit Amount (LCY)]				 AS [Sollbetrag (MW)]															-- Soll-Betrag (MW)
      ,[Credit Amount (LCY)]			 AS [Habenbetrag (MW)]															-- Haben-Betrag (MW)
      ,[Initial Entry Due Date]			 AS [Urspr. Fälligkeitsdatum]													-- Urspr. Fälligkeitsdatum
      ,[Initial Entry Global Dim_ 1]	 AS [Urspr. Kostenstellencode]	-- Urspr. Global Dimension Code 1 (entweder Kostenstelle o. Kostenträger)
      ,[Initial Entry Global Dim_ 2]	 AS [Urspr. Kostenträgercode]	-- Urspr. Global Dimension Code 2 (entweder Kostenstelle o. Kostenträger)					   -- 
      ,[Applied Vend_ Ledger Entry No_]	 AS [ausgegl. Kreditorposten Lfd. Nr.]										-- ausgegl. Kreditorposten Lfd. Nr. 								  
      ,[SG_MandantCode]					 AS [Mandant Code]																-- Mandant ID
      ,[SG_Bundesland]						 AS [Bundesland]																-- Bundesland
  FROM [fin].[BC_t0000380_Detailed_Vendor_Ledg_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000380_Detaillierte_Kreditorenposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000380_Detaillierte_Kreditorenposten


CREATE VIEW [vv].[vBC_t0000380_Detaillierte_Kreditorenposten] AS 
SELECT [detallierte Kreditorenposten Lfd. Nr.]
      ,[Kreditornummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])			AS [Buchungsdatum]
      ,[Belegartcode]
      ,[Belegnummer]
      ,[Währungscode]
      ,[Grund]
      ,[Transaktionsnummer]
      ,[Restskonto möglich]
      ,[Kreditorenposten Lfd. Nr.]
      ,[Detaillierte Kreditorposten Art]
      ,[Betrag]
      ,[Betrag (MW)]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Sollbetrag (MW)]
      ,[Habenbetrag (MW)]
      ,[Urspr. Fälligkeitsdatum]
      ,[Urspr. Kostenstellencode]
      ,[Urspr. Kostenträgercode]
      ,[ausgegl. Kreditorposten Lfd. Nr.]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [vv].[vBC_t0000380_Detaillierte_Kreditorenposten95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dProdukt85_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dProdukt85_2


CREATE VIEW [dim].[dProdukt85_2] AS
SELECT [dProdukt90_2].[Mandant Code]
      ,[dProdukt90_2].[Produkttyp Code]
	  ,ISNULL([Produkttypbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Produkttypbezeichnung DE]
	  ,ISNULL([Produkttypbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Produkttypbezeichnung EN]
      ,[dProdukt90_2].[Produktnummer]
      ,[dProdukt90_2].[Produktbezeichnung]
      ,[dProdukt90_2].[Produktbezeichnung (Nummer)]
      ,[dProdukt90_2].[Produktnummer Bezeichnung]
  FROM [dim].[dProdukt90_2]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Produkttypbezeichnung]
  ON [dProdukt90_2].[Produkttyp Code]  = [Produkttypbezeichnung].[Optionsfeld Code]
  AND [Produkttypbezeichnung].[Tabellenname]	= ''Produkt''
  AND [Produkttypbezeichnung].[Spaltenbezeichnung]		= ''Produkttypbezeichnung''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor95_2_ZlgRabattUngerechtfertigt]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPKreditor95_2_ZlgRabattUngerechtfertigt















CREATE VIEW [fin].[fOPKreditor95_2_ZlgRabattUngerechtfertigt] AS 
SELECT
   [Mandant Code]
  ,[Kreditorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Betrag Zahlungsrabatt (ungerechtfertigt)]
FROM [vv].[vBC_t0000380_Detaillierte_Kreditorenposten]
--BetrÃ¤ge die durch unberechtigte Skonto gewÃ¤hrt wurden
 WHERE [Detaillierte Kreditorposten Art] IN (14,15,16,17)
	--Zahlungstoleranz (MwSt.-Regulierung) / Zahlungstoleranz (ohne MwSt.) /  Skontotoleranz (ohne MwSt.) / Skontotoleranz (MwSt.-Regulierung)
GROUP BY [Mandant Code]
        ,[Kreditorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dGuVParentChild75_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dGuVParentChild75_2_CONCAT

CREATE VIEW [dim].[dGuVParentChild75_2_CONCAT] AS
SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
      ,[Child Code Original]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Sachkontobezeichnung (Nummer)]
      ,[Sachkontonummer Bezeichnung]
      ,[Umkehr Code]
      ,[Child Zeilennummer]
      ,[Parent Code]
      ,[Parent Code Original]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
      ,[Ist Sachkonto]
      ,[Elementbezeichnung]
	  ,[Mandant Code] +''_''+ [Child Code] AS [PK dGuVParentChild]
  FROM [dim].[dGuVParentChild80_2_UNION]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor95_2_ZlgRabattUngerechtfertigt]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor95_2_ZlgRabattUngerechtfertigt














CREATE VIEW [fin].[fOPDebitor95_2_ZlgRabattUngerechtfertigt] AS 
SELECT
   [Mandant Code]
  ,[Debitorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Betrag Zahlungsrabatt (ungerechtfertigt)]
FROM [vv].[vBC_t0000379_Detaillierte_Debitorenposten]
--BetrÃ¤ge die durch unberechtigte Skonto gewÃ¤hrt wurden
 WHERE [Detaillierte Debitorposten Art] IN (14,15,16,17)
	--Zahlungstoleranz (MwSt.-Regulierung) / Zahlungstoleranz (ohne MwSt.) /  Skontotoleranz (ohne MwSt.) / Skontotoleranz (MwSt.-Regulierung)
GROUP BY [Mandant Code]
        ,[Debitorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dProdukt80_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dProdukt80_2_CONCAT


CREATE VIEW [dim].[dProdukt80_2_CONCAT] AS
SELECT [Mandant Code]
      ,[Produkttyp Code]
      ,[Produkttypbezeichnung DE]
      ,[Produkttypbezeichnung EN]
      ,[Produktnummer]
      ,[Produktbezeichnung]
      ,[Produktbezeichnung (Nummer)]
      ,[Produktnummer Bezeichnung]
	  ,[Mandant Code] +''_''+ CONVERT(NVARCHAR(3),[Produkttyp Code]) +''_''+ [Produktnummer] AS [PK dProdukt]
  FROM [dim].[dProdukt85_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dGuVParentChild]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dGuVParentChild






























CREATE VIEW [dim].[dGuVParentChild] AS

SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code Original]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code Original]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
      ,[Sachkontobezeichnung (Nummer)]
      ,[Sachkontonummer Bezeichnung]
      ,[Umkehr Code]
	  ,[Elementbezeichnung]
	  ,[PK dGuVParentChild]
  FROM [dim].[dGuVParentChild75_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000021_Debitorenposten95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000021_Debitorenposten95_2























CREATE   VIEW [vv].[vBC_t0000021_Debitorenposten95_2] AS					  
SELECT [Entry No_]					   AS [Debitorenposten Lfd.]												-- Debitorenposten Lfd. 
      ,[Description]				   AS [Beschreibung]														-- Beschreibung
      ,[Customer No_]				   AS [Debitornummer]														-- Debitornummer
      ,[Posting Date]				   AS [Buchungsdatum]														-- Buchungsdatum 
      ,[Document Type]				   AS [Belegartcode]														-- Belegartcode
      ,[Document No_]				   AS [Belegnummer]															-- Belehnummer
      ,[Currency Code]				   AS [Währung Code]														-- Währungscode
      ,[Inv_ Discount (LCY)]		   AS [Rechnungsrabatt (MW)]												-- Rechnungsrabatt (MW)
      ,[Sell-to Customer No_]		   AS [Verkauf an Debitornummer]											-- Verkauf an Debitornummer
      ,[Customer Posting Group]		   AS [Debitorenbuchungsgruppe Code]										-- Kundenbuchungsgruppe Code
      ,[Salesperson Code]			   AS [Verkäufer Code]														-- Verkäufer Code
      ,[On Hold]					   AS [Abwarten]															-- Abwarten
      ,[Applies-to Doc_ Type]		   AS [Ausgeglichen mit Belegart]											-- Ausgeglichen mit Belegart
      ,[Applies-to Doc_ No_]		   AS [Ausgeglichen mit Belegnummer]										-- Ausgeglichen mit Belegnummer
      ,[Open]						   AS [Offen]															-- Offen Flag
      ,[Due Date]					   AS [Fälligkeitsdatum]													-- Fälligkeitsdatum
      ,[Pmt_ Discount Date]			   AS [Skontodatum]															-- Skontodatum
      ,[Pmt_ Disc_ Given (LCY)]		   AS [Zahlungsrabatt gewährt (MW)]											-- Skonto gewährt (MW) 
      ,[Closed by Amount (LCY)]		   AS [Geschlossen mit Betrag (MW)]											-- Geschlossen mit Betrag (MW)
      ,[Document Date]				   AS [Belegdatum]															-- Belegdatum
      ,[External Document No_]		   AS [Externe Belegnummer]													-- externe Belegnummer
      ,[Last Issued Reminder Level]	   AS [letzte registrierte Mahnstufe] 										-- letzte registrierte Mahnstufe
      ,[Applying Entry]				   AS [Ausgleichposten]														-- Ausgleichposten
      ,[Reversed]					   AS [storniert]															-- storniert
      ,[Prepayment]					   AS [im vorraus bezahlt]													-- im vorraus bezahlt
      ,[Global Dimension 1 Code]	   AS [Kostenstellencode]	-- Global Dimension Code 1 (entweder Kostenstelle o. Kostenträger)
      ,[Global Dimension 2 Code]	   AS [Kostenträgercode]	-- Global Dimension Code 2 (entweder Kostenstelle o. Kostenträger)
	  ,[Closed by Entry No_]		   AS [Geschlossen von Lfd. Nr.]		  									-- Geschlossen von Lfd. Nr.
      ,[Closed at Date]				   AS [Geschlossen am]														-- Geschlossen am
	  ,[Bal_ Account Type]			   AS [Bilanzkontotyp]													-- Bilanzkontotyp 
	  ,[Reason Code]				   AS [Ursache Code]				  											-- Ursachecode
	  ,[Applies-to ID]				   AS [Gehört zu ID]														-- Gehört zu ID
	  ,[Pmt_ Disc_ Tolerance Date]	   AS [Skontotoleranzdatum]													-- Skontotoleranzdatum
	  ,[Payment Method Code]		   AS [Zahlungsbedingung Code]												-- Zahlungsbedinungscode
      ,[SG_MandantCode]				   AS [Mandant Code]														-- Mandant ID
      ,[SG_Bundesland]					   AS [Bundesland]															-- Bundesland
  FROM [fin].[BC_t0000021_Cust_Ledger_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000021_Debitorenposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000021_Debitorenposten










CREATE VIEW [vv].[vBC_t0000021_Debitorenposten] AS
SELECT [Debitorenposten Lfd.]
      ,[Beschreibung]
      ,[Debitornummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])					AS [Buchungsdatum]
      ,[Belegartcode]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Rechnungsrabatt (MW)]
      ,[Verkauf an Debitornummer]
      ,[Debitorenbuchungsgruppe Code]
      ,[Verkäufer Code]
      ,[Abwarten]
      ,[Ausgeglichen mit Belegart]
      ,[Ausgeglichen mit Belegnummer]
      ,[Offen]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])				AS [Fälligkeitsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])						AS [Skontodatum]
      ,[Zahlungsrabatt gewährt (MW)]
      ,[Geschlossen mit Betrag (MW)]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])						AS [Belegdatum]
      ,[Externe Belegnummer]
      ,[letzte registrierte Mahnstufe]
      ,[Ausgleichposten]
      ,[storniert]
      ,[im vorraus bezahlt]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Geschlossen von Lfd. Nr.]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Geschlossen am])					AS [Geschlossen am]
      ,[Bilanzkontotyp]
      ,[Ursache Code]
      ,[Gehört zu ID]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontotoleranzdatum])				AS [Skontotoleranzdatum]
      ,[Zahlungsbedingung Code]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [vv].[vBC_t0000021_Debitorenposten95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenstelleDimension]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenstelleDimension





















CREATE VIEW [dim].[dKostenstelleDimension] AS 
SELECT [Kostenstellenbezeichnung]
      ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Kostenstelle Code]
      ,[Mandant Code]
      ,[Kostenstellenbezeichnung (Code)]
      ,[Kostenstelle Code Bezeichnung]
	  ,[PK dKostenstelleDimension]
  FROM [dim].[dKostenstelleDimension85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dProdukt]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dProdukt
















CREATE VIEW [dim].[dProdukt] AS

SELECT [Mandant Code]
      ,[Produkttyp Code]
      ,[Produkttypbezeichnung DE]
      ,[Produkttypbezeichnung EN]
      ,[Produktnummer]
      ,[Produktbezeichnung]
      ,[Produktbezeichnung (Nummer)]
      ,[Produktnummer Bezeichnung]
      ,[PK dProdukt]
  FROM [dim].[dProdukt80_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vSNCt_Kalender95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vSNCt_Kalender95_2

















CREATE VIEW [vv].[vSNCt_Kalender95_2] AS


SELECT [Datum]                          AS [Datum (Zeit)]
      ,[Datumint]                       AS [Datum (Zahl)]
      ,[Wochentag]                      AS [Wochentag]
      ,[Kalenderwoche]                  AS [Kalenderwoche]
      ,[Jahrwocheint]                   AS [Jahr Kalenderwoche (Zahl)]					    
      ,[Monat]                          AS [Monat]
      ,[JahrMonatint]                   AS [Jahr Monat (Zahl)]
      ,[Quartal]                        AS [Quartal]
      ,[Halbjahr]                       AS [Halbjahr]
      ,[Jahr]                           AS [Jahr]
      ,[GJMonat]                        AS [Geschäftsmonat]
      ,[GJJahrMonatint]                 AS [Geschäftsmonat (Zahl)]
      ,[GJQuartal]						AS [Geschäftsquartal]
      ,[GJJahrQuartalint]               AS [Geschäftsquartal (Zahl)]
      ,[GJHalbjahr]                     AS [Geschäftshalbjahr]
      ,[GJJahrHalbjahrint]              AS [Geschäftsjahr Halbjahr (Zahl)]
      ,[GJJahr]                         AS [Geschäftsjahr]
      ,[Faktoranteiltaganjahr]			AS [Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[Faktoranteiltaganmonatjahr]		AS [Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[Arbeitstagemonat]               AS [Anzahl Arbeitstage im Monat]
      ,[IstArbeitstag]                  AS [Arbeitstageszähler]
      ,[Tageszaehler]                   AS [Tageszähler]
      ,[ArbeitstagnrJahr]               AS [Arbeitstag im Jahr]
      ,[Arbeitstagnrmonat]              AS [Arbeitstag im Monat]
      ,[Bundesland]                     AS [Bundesland]
      ,[IstFeiertag]                    AS [Feiertageszähler]
      ,[Feiertagsbezeichnung]           AS [Feiertag (J/N) Beschreibung]
      ,[IstWerktag]                     AS [Werktageszähler]
      ,[Tag]                            AS [Tag im Monat]
  FROM [control].[SNCt_Kalender]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vSNCt_Kalender]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vSNCt_Kalender








CREATE VIEW [vv].[vSNCt_Kalender] AS
SELECT [Datum (Zeit)]
      ,[Datum (Zahl)]
      ,[Wochentag]
      ,[Kalenderwoche]
      ,[Jahr Kalenderwoche (Zahl)]
      ,[Monat]
      ,[Jahr Monat (Zahl)]
      ,[Quartal]
      ,[Halbjahr]
      ,[Jahr]
      ,[Geschäftsmonat]
      ,[Geschäftsmonat (Zahl)]
      ,[Geschäftsquartal]
      ,[Geschäftsquartal (Zahl)]
      ,[Geschäftshalbjahr]
      ,[Geschäftsjahr Halbjahr (Zahl)]
      ,[Geschäftsjahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[Anzahl Arbeitstage im Monat]
      ,[Arbeitstageszähler]
      ,[Tageszähler]
      ,[Arbeitstag im Jahr]
      ,[Arbeitstag im Monat]
      ,CAST([Bundesland] AS NVARCHAR(50)) AS [Bundesland]
      ,[Feiertageszähler]
      ,[Feiertag (J/N) Beschreibung]
      ,[Werktageszähler]
      ,[Tag im Monat]
  FROM [vv].[vSNCt_Kalender95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vSNCt_Konfiguration]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vSNCt_Konfiguration












CREATE VIEW [vv].[vSNCt_Konfiguration] AS
SELECT [Wert]			AS [Parameterwert]					-- Parameterwert
      ,[Bezeichnung]	AS [Parameterbeschreibung]			-- Parameterbeschreibung
      ,[Parameter]		AS [Parametername]					-- Parametername
  FROM [control].[SNCt_Konfiguration]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit98_2_FILTER]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit98_2_FILTER
















CREATE VIEW [dim].[dZeit98_2_FILTER] as
SELECT [vSNCt_Kalender].[Datum (Zeit)]
      ,[vSNCt_Kalender].[Datum (Zahl)]
      ,[vSNCt_Kalender].[Wochentag]
      ,[vSNCt_Kalender].[Kalenderwoche]
      ,[vSNCt_Kalender].[Jahr Kalenderwoche (Zahl)]
      ,[vSNCt_Kalender].[Monat]
      ,[vSNCt_Kalender].[Jahr Monat (Zahl)]
      ,[vSNCt_Kalender].[Quartal]
      ,[vSNCt_Kalender].[Halbjahr]
      ,[vSNCt_Kalender].[Jahr]
      ,[vSNCt_Kalender].[Geschäftsmonat]
      ,[vSNCt_Kalender].[Geschäftsmonat (Zahl)]
      ,[vSNCt_Kalender].[Geschäftsquartal]
      ,[vSNCt_Kalender].[Geschäftsquartal (Zahl)]
      ,[vSNCt_Kalender].[Geschäftshalbjahr]
      ,[vSNCt_Kalender].[Geschäftsjahr Halbjahr (Zahl)]
      ,[vSNCt_Kalender].[Geschäftsjahr]
      ,[vSNCt_Kalender].[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[vSNCt_Kalender].[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[vSNCt_Kalender].[Anzahl Arbeitstage im Monat]
      ,[vSNCt_Kalender].[Arbeitstageszähler]
      ,[vSNCt_Kalender].[Tageszähler]
      ,[vSNCt_Kalender].[Arbeitstag im Jahr]
      ,[vSNCt_Kalender].[Arbeitstag im Monat]
      ,[vSNCt_Kalender].[Bundesland]
      ,[vSNCt_Kalender].[Feiertageszähler]
      ,[vSNCt_Kalender].[Feiertag (J/N) Beschreibung]
      ,[vSNCt_Kalender].[Werktageszähler]
      ,[vSNCt_Kalender].[Tag im Monat]
  FROM [vv].[vSNCt_Kalender]

  LEFT JOIN [vv].[vSNCt_Konfiguration] AS [PARAM_Zeit_Jahre_rückwärts]
  ON [PARAM_Zeit_Jahre_rückwärts].[Parametername] = ''PARAM_Zeit_Jahre_rückwärts''

  LEFT JOIN [vv].[vSNCt_Konfiguration] AS [PARAM_Zeit_Jahre_vorwärts]
  ON [PARAM_Zeit_Jahre_vorwärts].[Parametername] = ''PARAM_Zeit_Jahre_vorwärts''

  --shifting the year range dynamically
  WHERE [vSNCt_Kalender].[Jahr] 
  BETWEEN YEAR(DATEADD(YY,ABS(ISNULL([PARAM_Zeit_Jahre_rückwärts].[Parameterwert],150))*-1,GETDATE()))
  AND	  YEAR(DATEADD(YY,ABS(ISNULL([PARAM_Zeit_Jahre_vorwärts].[Parameterwert],150)),GETDATE()))
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit95_2



























CREATE VIEW

[dim].[dZeit95_2]

AS



SELECT [Datum (Zeit)]
      ,CAST([Datum (Zeit)] AS DATE) AS [Datum]
      ,CONVERT(VARCHAR(10),[Datum (Zeit)],20) AS [Datum (Text:JJJJ-MM-TT)]
	  ,CONVERT(varchar(10),[Datum (Zeit)],104) AS [Datum (Text)]
      ,[Datum (Zahl)]
      ,[Wochentag]
	  ,CAST(CASE [Wochentag] WHEN 1 THEN ''Montag''
						WHEN 2 THEN ''Dienstag''
						WHEN 3 THEN ''Mittwoch''
						WHEN 4 THEN ''Donnerstag''
						WHEN 5 THEN ''Freitag''
						WHEN 6 THEN ''Samstag''
						WHEN 7 THEN ''Sonntag''
            END
		AS NVARCHAR(50)) AS [Wochentagsbezeichnung DE]
	  ,CAST(CASE [Wochentag] WHEN 1 THEN ''Monday''
						   WHEN 2 THEN ''Tuesday''
						   WHEN 3 THEN ''Wednesday''
						   WHEN 4 THEN ''Thursday''
						   WHEN 5 THEN ''Friday''
						   WHEN 6 THEN ''Saturday''
						   WHEN 7 THEN ''Sunday''
			END
		AS NVARCHAR(50)) AS [Wochentagsbezeichnung EN]
	  ,CAST(CASE [Wochentag] WHEN 1 THEN ''Mo.''
						   WHEN 2 THEN ''Di.''
						   WHEN 3 THEN ''Mi.''
						   WHEN 4 THEN ''Do.''
						   WHEN 5 THEN ''Fr.''
						   WHEN 6 THEN ''Sa.''
						   WHEN 7 THEN ''So.''
       		END
	   AS NVARCHAR(50)) AS [Wochentagsbezeichnung (kurz) DE]
  	  ,CAST(CASE [Wochentag] WHEN 1 THEN ''Mo.''
						   WHEN 2 THEN ''Tu.''
						   WHEN 3 THEN ''We.''
						   WHEN 4 THEN ''Th.''
						   WHEN 5 THEN ''Fr.''
						   WHEN 6 THEN ''Sa.''
						   WHEN 7 THEN ''Su.''
			END
	   AS NVARCHAR(50)) AS [Wochentagsbezeichnung (kurz) EN]
	  ,[Kalenderwoche]
	   ,CAST(
			REPLICATE(0,2-LEN([Kalenderwoche])) + CAST([Kalenderwoche] AS NVARCHAR(2)) + ''. KW. '' + CAST([Jahr] AS NVARCHAR(4))
	   AS NVARCHAR(50)) AS [Kalenderwochenbezeichnung Jahr DE]
	  ,CAST(
			REPLICATE(0,2-LEN([Kalenderwoche])) + CAST([Kalenderwoche] AS NVARCHAR(2)) + ''. CW  '' + CAST([Jahr] AS NVARCHAR(4))
	   AS NVARCHAR(50)) AS [Kalenderwochenbezeichnung Jahr EN]
      ,[Jahr Kalenderwoche (Zahl)]
      ,[Monat]
	  ,CAST(CASE [Monat] WHEN 1 THEN ''Januar''
						 WHEN 2 THEN ''Februar''
						 WHEN 3 THEN ''März''
						 WHEN 4 THEN ''April''
						 WHEN 5 THEN ''Mai''
						 WHEN 6 THEN ''Juni''
						 WHEN 7 THEN ''Juli''
						 WHEN 8 THEN ''August''
						 WHEN 9 THEN ''September''
						 WHEN 10 THEN ''Oktober''
						 WHEN 11 THEN ''November''
						 WHEN 12 THEN ''Dezember''
			END
	   AS NVARCHAR(50)) AS [Monatsbezeichnung DE]
	  ,CAST(CASE [Monat] WHEN 1 THEN ''January''
						 WHEN 2 THEN ''February''
						 WHEN 3 THEN ''March''
						 WHEN 4 THEN ''April''
						 WHEN 5 THEN ''May''
						 WHEN 6 THEN ''June''
						 WHEN 7 THEN ''July''
						 WHEN 8 THEN ''August''
						 WHEN 9 THEN ''September''
						 WHEN 10 THEN ''October''
						 WHEN 11 THEN ''November''
						 WHEN 12 THEN ''December''
			END
	   AS NVARCHAR(50)) AS [Monatsbezeichnung EN]
	  ,CAST(CASE [Monat] WHEN 1 THEN ''Jan.''
						 WHEN 2 THEN ''Feb.''
						 WHEN 3 THEN ''Mrz.''
						 WHEN 4 THEN ''Apr.''
						 WHEN 5 THEN ''Mai''
						 WHEN 6 THEN ''Jun.''
						 WHEN 7 THEN ''Jul.''
						 WHEN 8 THEN ''Aug.''
						 WHEN 9 THEN ''Sep.''
						 WHEN 10 THEN ''Okt.''
						 WHEN 11 THEN ''Nov.''
						 WHEN 12 THEN ''Dez.''
			END
	   AS NVARCHAR(50)) AS [Monatsbezeichnung (kurz) DE]
	  ,CAST(CASE [Monat] WHEN 1 THEN ''Jan.''
						 WHEN 2 THEN ''Feb.''
						 WHEN 3 THEN ''Mar.''
						 WHEN 4 THEN ''Apr.''
						 WHEN 5 THEN ''May''
						 WHEN 6 THEN ''Jun.''
						 WHEN 7 THEN ''Jul.''
						 WHEN 8 THEN ''Aug.''
						 WHEN 9 THEN ''Sept.''
						 WHEN 10 THEN ''Oct.''
						 WHEN 11 THEN ''Nov.''
						 WHEN 12 THEN ''Dec.''
			END
	   AS NVARCHAR(50)) AS [Monatsbezeichnung (kurz) EN]
      ,[Jahr Monat (Zahl)]
	  ,[Jahr Monat (Zahl)] AS [Buchungsperiode]
      ,[Quartal]
	  ,CAST(CAST([Quartal] AS NVARCHAR(1)) + ''. Q. '' + CAST([Jahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Quartalsbezeichnung Jahr DE]
	  ,CAST(CAST([Quartal] AS NVARCHAR(1)) + ''Q '' + CAST([Jahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Quartalsbezeichnung Jahr EN]
	  ,[Jahr]*100 +[Quartal] AS [Jahr Quartal (Zahl)]
	  ,[Halbjahr]
      ,CAST(CAST([Halbjahr] AS NVARCHAR(1)) + ''. HJ. '' + CAST([Jahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Halbjahresbezeichnung Jahr DE]
	  ,CAST(CAST([Halbjahr] AS NVARCHAR(1)) + ''H '' + CAST([Jahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Halbjahresbezeichnung Jahr EN]
	  ,[Jahr]*100 + [Halbjahr] AS [Jahr Halbjahr (Zahl)]
	  ,[Jahr]
      ,[Geschäftsmonat]
	  ,CAST(CASE [Monat] WHEN 1 THEN ''Januar''
						 WHEN 2 THEN ''Februar''
						 WHEN 3 THEN ''März''
						 WHEN 4 THEN ''April''
						 WHEN 5 THEN ''Mai''
						 WHEN 6 THEN ''Juni''
						 WHEN 7 THEN ''Juli''
						 WHEN 8 THEN ''August''
						 WHEN 9 THEN ''September''
						 WHEN 10 THEN ''Oktober''
						 WHEN 11 THEN ''November''
						 WHEN 12 THEN ''Dezember''
			END
	   AS NVARCHAR(50)) AS [Geschäftsmonat (Text) DE]
	  ,CAST(CASE [Monat] WHEN 1 THEN ''January''
						 WHEN 2 THEN ''February''
						 WHEN 3 THEN ''March''
						 WHEN 4 THEN ''April''
						 WHEN 5 THEN ''May''
						 WHEN 6 THEN ''June''
						 WHEN 7 THEN ''July''
						 WHEN 8 THEN ''August''
						 WHEN 9 THEN ''September''
						 WHEN 10 THEN ''October''
						 WHEN 11 THEN ''November''
						 WHEN 12 THEN ''December''
			END
	   AS NVARCHAR(50)) AS [Geschäftsmonat (Text) EN]
	  ,CAST(CASE [Monat] WHEN 1 THEN ''Jan.''
						 WHEN 2 THEN ''Feb.''
						 WHEN 3 THEN ''Mrz.''
						 WHEN 4 THEN ''Apr.''
						 WHEN 5 THEN ''Mai''
						 WHEN 6 THEN ''Jun.''
						 WHEN 7 THEN ''Jul.''
						 WHEN 8 THEN ''Aug.''
						 WHEN 9 THEN ''Sep.''
						 WHEN 10 THEN ''Okt.''
						 WHEN 11 THEN ''Nov.''
						 WHEN 12 THEN ''Dez.''
			END
	   AS NVARCHAR(50)) AS [Geschäftsmonatsbezeichnung (kurz) DE]
	  ,CAST(CASE [Monat] WHEN 1 THEN ''Jan.''
						 WHEN 2 THEN ''Feb.''
						 WHEN 3 THEN ''Mar.''
						 WHEN 4 THEN ''Apr.''
						 WHEN 5 THEN ''May''
						 WHEN 6 THEN ''Jun.''
						 WHEN 7 THEN ''Jul.''
						 WHEN 8 THEN ''Aug.''
						 WHEN 9 THEN ''Sept.''
						 WHEN 10 THEN ''Oct.''
						 WHEN 11 THEN ''Nov.''
						 WHEN 12 THEN ''Dec.''
			END
	   AS NVARCHAR(50)) AS [Geschäftsmonatsbezeichnung (kurz) EN]
      ,[Geschäftsmonat (Zahl)]
      ,CAST(REPLICATE(''0'',2-LEN([Geschäftsmonat])) + CAST([Geschäftsmonat] AS NVARCHAR(2)) + CAST([Geschäftsmonat] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Geschäftsmonat Jahr (Text)]
      ,[Geschäftsquartal]
      ,[Geschäftsquartal (Zahl)]
      ,CAST(CAST([Geschäftsquartal] AS NVARCHAR(1)) + ''. GQ. '' + CAST([Geschäftsjahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Geschäftsquartalsbezeichnung Jahr DE]
	  ,CAST(CAST([Geschäftsquartal] AS NVARCHAR(1)) + ''Q FY '' + CAST([Geschäftsjahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Geschäftsquartalsbezeichnung Jahr EN]
      ,[Geschäftshalbjahr]
      ,[Geschäftsjahr Halbjahr (Zahl)]
	  ,CAST(CAST([Geschäftshalbjahr] AS NVARCHAR(1)) + ''. GHJ. '' + CAST([Geschäftsjahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Geschäftshalbjahresbezeichnung Jahr DE]
	  ,CAST(CAST([Geschäftshalbjahr] AS NVARCHAR(1)) + ''H FY '' + CAST([Geschäftsjahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Geschäftshalbjahresbezeichnung Jahr EN]
      ,[Geschäftsjahr]
	  ,DATEPART(ISO_WEEK, [Datum (Zeit)]) AS [ISO Kalenderwoche]
	  ,CASE WHEN MONTH([Datum (Zeit)]) = 1 AND DATEPART(ISO_WEEK, [Datum (Zeit)]) > 50 THEN [Jahr]-1 
            WHEN DATEPART(ISO_WEEK, [Datum (Zeit)]) = 1 AND MONTH([Datum (Zeit)]) <> 1 THEN [Jahr]+1
            ELSE [Jahr] 
	   END AS  [ISO Jahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[Anzahl Arbeitstage im Monat]
      ,[Arbeitstageszähler]
	  ,CAST(CASE [Arbeitstageszähler] 
				WHEN 0 THEN ''Nein''
				WHEN 1 THEN ''Ja''
			END	
	   AS NVARCHAR(50)) AS [Arbeitstag (J/N) DE]
	  ,CAST(CASE [Arbeitstageszähler] 
				WHEN 0 THEN ''No''
				WHEN 1 THEN ''Yes''
			END	
	   AS NVARCHAR(50)) AS [Arbeitstag (J/N) EN]
	  ,[Tageszähler]
      ,[Arbeitstag im Jahr]
      ,[Arbeitstag im Monat]
      ,[Bundesland]
      ,[Feiertageszähler] 
	  ,CAST(CASE [Feiertageszähler] 
				WHEN 0 THEN ''Nein''
				WHEN 1 THEN ''Ja''
			END	
	   AS NVARCHAR(50)) AS [Feiertag (J/N) DE]
	  ,CAST(CASE [Feiertageszähler] 
				WHEN 0 THEN ''No''
				WHEN 1 THEN ''Yes''
			END	
	   AS NVARCHAR(50)) AS [Feiertag (J/N) EN]
      ,[Feiertag (J/N) Beschreibung]
      ,[Werktageszähler]
	  ,CAST(CASE [Werktageszähler] 
				WHEN 0 THEN ''Nein''
				WHEN 1 THEN ''Ja''
			END	
	   AS NVARCHAR(50)) AS [Werktag (J/N) DE]
	  ,CAST(CASE [Werktageszähler] 
				WHEN 0 THEN ''No''
				WHEN 1 THEN ''Yes''
			END	
	   AS NVARCHAR(50)) AS [Werktag (J/N) EN]
      ,[Tag im Monat]
	  -- Sonderbehandlung vom 29.2. entspricht für Rangberechnungen dem 28.02
	  ,CAST(CASE WHEN [Datum (Zeit)] = DATEADD(DAY, -(DAY(DATEADD(MONTH, 1, [Datum (Zeit)]))),DATEADD(MONTH, 1, [Datum (Zeit)]))
				 THEN 1
				 ELSE 0 
			END AS NVARCHAR(50)) AS [Letzter Tag des Monats Code]
	  ,CAST(CASE WHEN [Datum (Zeit)] = DATEADD(DAY, -(DAY(DATEADD(MONTH, 1, [Datum (Zeit)]))),DATEADD(MONTH, 1, [Datum (Zeit)]))
				 THEN ''Ja''
				 ELSE ''Nein'' 
			END AS NVARCHAR(50)) AS [Letzter Tag des Monats Bezeichnung DE]
	  ,CAST(CASE WHEN [Datum (Zeit)] = DATEADD(DAY, -(DAY(DATEADD(MONTH, 1, [Datum (Zeit)]))),DATEADD(MONTH, 1, [Datum (Zeit)]))
				 THEN ''Yes''
				 ELSE ''No'' 
			END AS NVARCHAR(50)) AS [Letzter Tag des Monats Bezeichnung EN]



	  ,CASE WHEN DAY([Datum (Zeit)]) = 29 AND MONTH([Datum (Zeit)]) = 2 THEN DATEADD(D,-1,[Datum (Zeit)]) ELSE [Datum (Zeit)] END AS [Datum (Zeit) Schaltjahr]
  FROM [dim].[dZeit98_2_FILTER]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit90_2

























CREATE VIEW

[dim].[dZeit90_2]

AS
SELECT [Datum (Zeit)]
      ,[Datum]
      ,[Datum (Text:JJJJ-MM-TT)]
      ,[Datum (Text)]
      ,[Datum (Zahl)]
      ,[Wochentag]
      ,[Wochentagsbezeichnung DE]
      ,[Wochentagsbezeichnung EN]
      ,[Wochentagsbezeichnung (kurz) DE]
      ,[Wochentagsbezeichnung (kurz) EN]
      ,[Kalenderwoche]
      ,[Kalenderwochenbezeichnung Jahr DE]
      ,[Kalenderwochenbezeichnung Jahr EN]
      ,[Jahr Kalenderwoche (Zahl)]
      ,[Monat]
      ,[Monatsbezeichnung DE]
      ,[Monatsbezeichnung EN]
      ,[Monatsbezeichnung (kurz) DE]
      ,[Monatsbezeichnung (kurz) EN]
	  ,CAST([Monatsbezeichnung (kurz) DE] + '' '' + CAST([Jahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Monatsbezeichnung Jahr DE]
	  ,CAST([Monatsbezeichnung (kurz) EN] + '' '' + CAST([Jahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Monatsbezeichnung Jahr EN]
	  ,[Jahr Monat (Zahl)]
	  ,[Buchungsperiode]
      ,[Quartal]
      ,[Quartalsbezeichnung Jahr DE]
      ,[Quartalsbezeichnung Jahr EN]
      ,[Jahr Quartal (Zahl)]
      ,[Halbjahr]
      ,[Halbjahresbezeichnung Jahr DE]
      ,[Halbjahresbezeichnung Jahr EN]
      ,[Jahr Halbjahr (Zahl)]
      ,[Jahr]
      ,[Geschäftsmonat]
      ,[Geschäftsmonat (Text) DE]
	  ,[Geschäftsmonat (Text) EN]
	  ,[Geschäftsmonatsbezeichnung (kurz) DE]
	  ,[Geschäftsmonatsbezeichnung (kurz) EN]
	  ,CAST([Geschäftsmonatsbezeichnung (kurz) DE] + '' '' + CAST([Geschäftsjahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Geschäftsjahr Monatsbezeichnung Jahr DE]
	  ,CAST([Geschäftsmonatsbezeichnung (kurz) EN] + '' '' + CAST([Geschäftsjahr] AS NVARCHAR(4)) AS NVARCHAR(50)) AS [Geschäftsjahr Monatsbezeichnung Jahr EN]
      ,[Geschäftsmonat (Zahl)]
      ,[Geschäftsmonat Jahr (Text)]
      ,[Geschäftsquartal]
      ,[Geschäftsquartal (Zahl)]
      ,[Geschäftsquartalsbezeichnung Jahr DE]
      ,[Geschäftsquartalsbezeichnung Jahr EN]
      ,[Geschäftshalbjahr]
      ,[Geschäftsjahr Halbjahr (Zahl)]
      ,[Geschäftshalbjahresbezeichnung Jahr DE]
      ,[Geschäftshalbjahresbezeichnung Jahr EN]
      ,[Geschäftsjahr]
	  ,[ISO Kalenderwoche]
      ,CAST(
			REPLICATE(0,2-LEN([ISO Kalenderwoche])) + CAST([ISO Kalenderwoche] AS NVARCHAR(2)) + ''. KW. '' + CAST([ISO Jahr] AS NVARCHAR(4))
	   AS NVARCHAR(50)) AS [ISO Kalenderwochenbezeichnung ISO Jahr DE]
	  ,CAST(
			REPLICATE(0,2-LEN([ISO Kalenderwoche])) + CAST([ISO Kalenderwoche] AS NVARCHAR(2)) + ''. CW. '' + CAST([ISO Jahr] AS NVARCHAR(4))
	   AS NVARCHAR(50)) AS [ISO Kalenderwochenbezeichnung ISO Jahr EN]
	  ,[ISO Jahr]
	  ,[ISO Jahr]*100 + [ISO Kalenderwoche] AS [ISO Jahr ISO Kalenderwoche (Zahl)]
      ,[Tag im Monat]
	  ,[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[Anzahl Arbeitstage im Monat]
      ,[Arbeitstageszähler]
      ,[Arbeitstag (J/N) DE]
      ,[Arbeitstag (J/N) EN]
      ,[Tageszähler]
      ,[Arbeitstag im Jahr]
      ,[Arbeitstag im Monat]
      ,[Bundesland]
      ,[Feiertageszähler]
      ,[Feiertag (J/N) DE]
      ,[Feiertag (J/N) EN]
      ,[Feiertag (J/N) Beschreibung]
      ,[Werktageszähler]
      ,[Werktag (J/N) DE]
      ,[Werktag (J/N) EN]
      ,[Letzter Tag des Monats Code]
      ,[Letzter Tag des Monats Bezeichnung DE]
      ,[Letzter Tag des Monats Bezeichnung EN]
	  --[Date (Time) Leap Year] Wird nur für Berechnungen der Ränge verwendet, siehe vorherige Sicht
	  -- Sonderbehandlung vom 29.2. dieser Tag bekommt den selben Rang wie der Vortag (28.02)
	  ,DATEPART(dy, [Datum (Zeit) Schaltjahr]) AS [Tag im Jahr]
	  -- Sonderbehandlung vom 29.2. dieser Tag bekommt den selben Rang wie der Vortag (28.02)
	  ,DENSE_RANK() OVER(ORDER BY [Datum (Zeit) Schaltjahr]) AS [Rang Tag]
	  -- Sonderbehandlung vom 29.2. dieser Tag bekommt den selben Rang wie der Vortag (28.02)
	  ,DENSE_RANK() OVER(PARTITION BY [Jahr] ORDER BY [Datum (Zeit) Schaltjahr]) AS [Rang Tag innerhalb Jahr]
      ,DENSE_RANK() OVER(ORDER BY [Jahr],[Monat]) AS [Rang Monat]
	  ,DENSE_RANK() OVER(PARTITION BY [Jahr] ORDER BY [Jahr],[Monat]) AS [Rang Monat innerhalb Jahr]    
	  ,DENSE_RANK() OVER(ORDER BY [Jahr],[Quartal]) AS [Rang Quartal]
      ,DENSE_RANK() OVER(ORDER BY [Jahr]) AS [Rang Jahr]
      ,DENSE_RANK() OVER(ORDER BY [ISO Jahr],[ISO Kalenderwoche]) AS [Rang ISO Kalenderwoche]
	  ,DENSE_RANK() OVER(PARTITION BY [ISO Jahr] ORDER BY [ISO Jahr],[ISO Kalenderwoche]) AS [Rang ISO Kalenderwoche innerhalb ISO Jahr]
	  --Geschäftsjahr
	  ,DENSE_RANK() OVER(ORDER BY [Geschäftsjahr]) AS [Rang Geschäftsjahr]
	  ,DENSE_RANK() OVER(ORDER BY [Geschäftsjahr],[Geschäftsmonat]) AS [Rang Geschäftsmonat]
	  ,DENSE_RANK() OVER(PARTITION BY [Geschäftsjahr] ORDER BY [Geschäftsjahr],[Geschäftsmonat]) AS [Rang Geschäftsmonat innerhalb Geschäftsjahr]
	  ,DENSE_RANK() OVER(PARTITION BY [Geschäftsjahr] ORDER BY [Datum (Zeit) Schaltjahr]) AS [Rang Tag innerhalb Geschäftsjahr]
FROM [dim].[dZeit95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit85_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit85_2




























CREATE VIEW

[dim].[dZeit85_2]

AS

SELECT [dZeit90_2].[Datum (Zeit)]
      ,[dZeit90_2].[Datum]
      ,[dZeit90_2].[Datum (Text:JJJJ-MM-TT)]
      ,[dZeit90_2].[Datum (Text)]
      ,[dZeit90_2].[Datum (Zahl)]
      ,[dZeit90_2].[Wochentag]
      ,[dZeit90_2].[Wochentagsbezeichnung DE]
      ,[dZeit90_2].[Wochentagsbezeichnung EN]
      ,[dZeit90_2].[Wochentagsbezeichnung (kurz) DE]
      ,[dZeit90_2].[Wochentagsbezeichnung (kurz) EN]
      ,[dZeit90_2].[Kalenderwoche]
      ,[dZeit90_2].[Kalenderwochenbezeichnung Jahr DE]
      ,[dZeit90_2].[Kalenderwochenbezeichnung Jahr EN]
      ,[dZeit90_2].[Jahr Kalenderwoche (Zahl)]
      ,[dZeit90_2].[Monat]
      ,[dZeit90_2].[Monatsbezeichnung DE]
      ,[dZeit90_2].[Monatsbezeichnung EN]
      ,[dZeit90_2].[Monatsbezeichnung (kurz) DE]
      ,[dZeit90_2].[Monatsbezeichnung (kurz) EN]
      ,[dZeit90_2].[Monatsbezeichnung Jahr DE]
      ,[dZeit90_2].[Monatsbezeichnung Jahr EN]
      ,[dZeit90_2].[Jahr Monat (Zahl)]
	  ,[dZeit90_2].[Buchungsperiode]
      ,[dZeit90_2].[Quartal]
      ,[dZeit90_2].[Quartalsbezeichnung Jahr DE]
      ,[dZeit90_2].[Quartalsbezeichnung Jahr EN]
      ,[dZeit90_2].[Jahr Quartal (Zahl)]
      ,[dZeit90_2].[Halbjahr]
      ,[dZeit90_2].[Halbjahresbezeichnung Jahr DE]
      ,[dZeit90_2].[Halbjahresbezeichnung Jahr EN]
      ,[dZeit90_2].[Jahr Halbjahr (Zahl)]
      ,[dZeit90_2].[Jahr]
      ,[dZeit90_2].[Geschäftsmonat]
      ,[dZeit90_2].[Geschäftsmonat (Text) DE]
	  ,[dZeit90_2].[Geschäftsmonat (Text) EN]
	  ,[dZeit90_2].[Geschäftsmonatsbezeichnung (kurz) DE]
      ,[dZeit90_2].[Geschäftsmonatsbezeichnung (kurz) EN]
      ,[dZeit90_2].[Geschäftsjahr Monatsbezeichnung Jahr DE]
      ,[dZeit90_2].[Geschäftsjahr Monatsbezeichnung Jahr EN]
      ,[dZeit90_2].[Geschäftsmonat (Zahl)]
      ,[dZeit90_2].[Geschäftsmonat Jahr (Text)]
      ,[dZeit90_2].[Geschäftsquartal]
      ,[dZeit90_2].[Geschäftsquartal (Zahl)]
      ,[dZeit90_2].[Geschäftsquartalsbezeichnung Jahr DE]
      ,[dZeit90_2].[Geschäftsquartalsbezeichnung Jahr EN]
      ,[dZeit90_2].[Geschäftshalbjahr]
      ,[dZeit90_2].[Geschäftsjahr Halbjahr (Zahl)]
      ,[dZeit90_2].[Geschäftshalbjahresbezeichnung Jahr DE]
      ,[dZeit90_2].[Geschäftshalbjahresbezeichnung Jahr EN]
      ,[dZeit90_2].[Geschäftsjahr]
      ,[dZeit90_2].[ISO Kalenderwoche]
      ,[dZeit90_2].[ISO Kalenderwochenbezeichnung ISO Jahr DE]
      ,[dZeit90_2].[ISO Kalenderwochenbezeichnung ISO Jahr EN]
      ,[dZeit90_2].[ISO Jahr]
      ,[dZeit90_2].[ISO Jahr ISO Kalenderwoche (Zahl)]
      ,[dZeit90_2].[Tag im Monat]
      ,[dZeit90_2].[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[dZeit90_2].[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[dZeit90_2].[Anzahl Arbeitstage im Monat]
      ,[dZeit90_2].[Arbeitstageszähler]
      ,[dZeit90_2].[Arbeitstag (J/N) DE]
      ,[dZeit90_2].[Arbeitstag (J/N) EN]
      ,[dZeit90_2].[Tageszähler]
      ,[dZeit90_2].[Arbeitstag im Jahr]
      ,[dZeit90_2].[Arbeitstag im Monat]
      ,[dZeit90_2].[Bundesland]
      ,[dZeit90_2].[Feiertageszähler]
      ,[dZeit90_2].[Feiertag (J/N) DE]
      ,[dZeit90_2].[Feiertag (J/N) EN]
      ,[dZeit90_2].[Feiertag (J/N) Beschreibung]
      ,[dZeit90_2].[Werktageszähler]
      ,[dZeit90_2].[Werktag (J/N) DE]
      ,[dZeit90_2].[Werktag (J/N) EN]
      ,[dZeit90_2].[Letzter Tag des Monats Code]
      ,[dZeit90_2].[Letzter Tag des Monats Bezeichnung DE]
      ,[dZeit90_2].[Letzter Tag des Monats Bezeichnung EN]
      ,[dZeit90_2].[Tag im Jahr]
      ,[dZeit90_2].[Rang Tag] - [dTime90_2_Today].[Rang Tag] AS [Rang Tag]
      ,[dZeit90_2].[Rang Tag innerhalb Jahr] - [dTime90_2_Today].[Rang Tag innerhalb Jahr] AS [Rang Tag innerhalb Jahr]
      ,[dZeit90_2].[Rang Monat] - [dTime90_2_Today].[Rang Monat] AS [Rang Monat]
      ,[dZeit90_2].[Rang Monat innerhalb Jahr] - [dTime90_2_Today].[Rang Monat innerhalb Jahr] AS [Rang Monat innerhalb Jahr]
      ,[dZeit90_2].[Rang Jahr] - [dTime90_2_Today].[Rang Jahr] AS [Rang Jahr]
      ,[dZeit90_2].[Rang ISO Kalenderwoche innerhalb ISO Jahr] - [dTime90_2_Today].[Rang ISO Kalenderwoche innerhalb ISO Jahr] AS [Rang ISO Kalenderwoche innerhalb ISO Jahr]
      ,[dZeit90_2].[Rang ISO Kalenderwoche] - [dTime90_2_Today].[Rang ISO Kalenderwoche] AS [Rang ISO Kalenderwoche]
      ,[dZeit90_2].[Rang Geschäftsjahr] - [dTime90_2_Today].[Rang Geschäftsjahr] AS [Rang Geschäftsjahr]
      ,[dZeit90_2].[Rang Geschäftsmonat] - [dTime90_2_Today].[Rang Geschäftsmonat] AS [Rang Geschäftsmonat]
      ,[dZeit90_2].[Rang Geschäftsmonat innerhalb Geschäftsjahr] - [dTime90_2_Today].[Rang Geschäftsmonat innerhalb Geschäftsjahr] AS [Rang Geschäftsmonat innerhalb Geschäftsjahr]
	  ,[dZeit90_2].[Rang Tag innerhalb Geschäftsjahr] - [dTime90_2_Today].[Rang Tag innerhalb Geschäftsjahr] AS [Rang Tag innerhalb Geschäftsjahr]
	  ,[dZeit90_2].[Rang Quartal] - [dTime90_2_Today].[Rang Quartal] AS [Rang Quartal]
  FROM [dim].[dZeit90_2]
  
  LEFT JOIN [dim].[dZeit90_2] AS [dTime90_2_Today]
  ON [dZeit90_2].[Bundesland]					= [dTime90_2_Today].[Bundesland]
  AND  [dTime90_2_Today].[Datum (Zeit)]	= [dbo].[SG_REPORT_DATE_TODAY]()
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit80_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit80_2



















































CREATE VIEW

[dim].[dZeit80_2]

AS

SELECT [dZeit85_2].[Datum (Zeit)]
      ,[dZeit85_2].[Datum]
      ,[dZeit85_2].[Datum (Text:JJJJ-MM-TT)]
      ,[dZeit85_2].[Datum (Text)]
      ,[dZeit85_2].[Datum (Zahl)]
      ,[dZeit85_2].[Wochentag]
      ,[dZeit85_2].[Wochentagsbezeichnung DE]
      ,[dZeit85_2].[Wochentagsbezeichnung EN]
      ,[dZeit85_2].[Wochentagsbezeichnung (kurz) DE]
      ,[dZeit85_2].[Wochentagsbezeichnung (kurz) EN]
      ,[dZeit85_2].[Kalenderwoche]
      ,[dZeit85_2].[Kalenderwochenbezeichnung Jahr DE]
      ,[dZeit85_2].[Kalenderwochenbezeichnung Jahr EN]
      ,[dZeit85_2].[Jahr Kalenderwoche (Zahl)]
      ,[dZeit85_2].[Monat]
      ,[dZeit85_2].[Monatsbezeichnung DE]
      ,[dZeit85_2].[Monatsbezeichnung EN]
      ,[dZeit85_2].[Monatsbezeichnung (kurz) DE]
      ,[dZeit85_2].[Monatsbezeichnung (kurz) EN]
      ,[dZeit85_2].[Monatsbezeichnung Jahr DE]
      ,[dZeit85_2].[Monatsbezeichnung Jahr EN]
      ,[dZeit85_2].[Jahr Monat (Zahl)]
	  ,[dZeit85_2].[Buchungsperiode]
      ,[dZeit85_2].[Quartal]
      ,[dZeit85_2].[Quartalsbezeichnung Jahr DE]
      ,[dZeit85_2].[Quartalsbezeichnung Jahr EN]
      ,[dZeit85_2].[Jahr Quartal (Zahl)]
      ,[dZeit85_2].[Halbjahr]
      ,[dZeit85_2].[Halbjahresbezeichnung Jahr DE]
      ,[dZeit85_2].[Halbjahresbezeichnung Jahr EN]
      ,[dZeit85_2].[Jahr Halbjahr (Zahl)]
      ,[dZeit85_2].[Jahr]
      ,[dZeit85_2].[Geschäftsmonat]
      ,[dZeit85_2].[Geschäftsmonat (Text) DE]
	  ,[dZeit85_2].[Geschäftsmonat (Text) EN]
	  ,[dZeit85_2].[Geschäftsmonatsbezeichnung (kurz) DE]
      ,[dZeit85_2].[Geschäftsmonatsbezeichnung (kurz) EN]
      ,[dZeit85_2].[Geschäftsjahr Monatsbezeichnung Jahr DE]
      ,[dZeit85_2].[Geschäftsjahr Monatsbezeichnung Jahr EN]
      ,[dZeit85_2].[Geschäftsmonat (Zahl)]
      ,[dZeit85_2].[Geschäftsmonat Jahr (Text)]
      ,[dZeit85_2].[Geschäftsquartal]
      ,[dZeit85_2].[Geschäftsquartal (Zahl)]
      ,[dZeit85_2].[Geschäftsquartalsbezeichnung Jahr DE]
      ,[dZeit85_2].[Geschäftsquartalsbezeichnung Jahr EN]
      ,[dZeit85_2].[Geschäftshalbjahr]
      ,[dZeit85_2].[Geschäftsjahr Halbjahr (Zahl)]
      ,[dZeit85_2].[Geschäftshalbjahresbezeichnung Jahr DE]
      ,[dZeit85_2].[Geschäftshalbjahresbezeichnung Jahr EN]
      ,[dZeit85_2].[Geschäftsjahr]
      ,[dZeit85_2].[ISO Kalenderwoche]
      ,[dZeit85_2].[ISO Kalenderwochenbezeichnung ISO Jahr DE]
      ,[dZeit85_2].[ISO Kalenderwochenbezeichnung ISO Jahr EN]
      ,[dZeit85_2].[ISO Jahr]
      ,[dZeit85_2].[ISO Jahr ISO Kalenderwoche (Zahl)]
      ,[dZeit85_2].[Tag im Monat]
      ,[dZeit85_2].[Tag im Jahr]
      ,[dZeit85_2].[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[dZeit85_2].[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[dZeit85_2].[Anzahl Arbeitstage im Monat]
      ,[dZeit85_2].[Arbeitstageszähler]
      ,[dZeit85_2].[Arbeitstag (J/N) DE]
      ,[dZeit85_2].[Arbeitstag (J/N) EN]
      ,[dZeit85_2].[Tageszähler]
      ,[dZeit85_2].[Arbeitstag im Jahr]
      ,[dZeit85_2].[Arbeitstag im Monat]
      ,[dZeit85_2].[Bundesland]
      ,[dZeit85_2].[Feiertageszähler]
      ,[dZeit85_2].[Feiertag (J/N) DE]
      ,[dZeit85_2].[Feiertag (J/N) EN]
      ,[dZeit85_2].[Feiertag (J/N) Beschreibung]
      ,[dZeit85_2].[Werktageszähler]
      ,[dZeit85_2].[Werktag (J/N) DE]
      ,[dZeit85_2].[Werktag (J/N) EN]
      ,[dZeit85_2].[Letzter Tag des Monats Code]
      ,[dZeit85_2].[Letzter Tag des Monats Bezeichnung DE]
      ,[dZeit85_2].[Letzter Tag des Monats Bezeichnung EN]
      ,[dZeit85_2].[Rang Tag]
      ,[dZeit85_2].[Rang Tag innerhalb Jahr]
      ,[dZeit85_2].[Rang Monat]
      ,[dZeit85_2].[Rang Monat innerhalb Jahr]
      ,[dZeit85_2].[Rang Jahr]
      ,[dZeit85_2].[Rang ISO Kalenderwoche]
      ,[dZeit85_2].[Rang ISO Kalenderwoche innerhalb ISO Jahr]
      ,[dZeit85_2].[Rang Geschäftsjahr]
      ,[dZeit85_2].[Rang Geschäftsmonat]
      ,[dZeit85_2].[Rang Geschäftsmonat innerhalb Geschäftsjahr]
      ,[dZeit85_2].[Rang Tag innerhalb Geschäftsjahr]
	  ,[dZeit85_2].[Rang Quartal]
	  -- Wenn wir uns im ersten Kalendermonat befinden, dann bekommt das komplette Vorjahr den Rang 0
	  -- Sonst wird [Rank Year] für die "abgeschlossenen" Monate übernommen
	  ,CASE WHEN (SELECT MAX([dZeit85_2].[Monat]) FROM [dim].[dZeit85_2] WHERE [dZeit85_2].[Rang Monat] = 0) = 1 
			THEN [dZeit85_2].[Rang Jahr]+1
			WHEN [dZeit85_2].[Rang Monat innerhalb Jahr] < 0 
			THEN [dZeit85_2].[Rang Jahr]
			ELSE NULL
       END AS [Rang Jahresanfang bis Vormonat]
	  -- Wenn wir uns im ersten Kalendermonat am ersten Tag befinden, dann bekommt das komplette Vorjahr den Rang 0
	  -- Sonst wird [Rank Year] für die "abgeschlossenen" Tage übernommen
	  ,CASE WHEN     (SELECT MAX([dZeit85_2].[Monat]) FROM [dim].[dZeit85_2] WHERE [dZeit85_2].[Rang Monat] = 0) = 1
				 AND (SELECT MAX([dZeit85_2].[Tag im Monat]) FROM [dim].[dZeit85_2] WHERE [dZeit85_2].[Rang Tag] = 0) = 1
			THEN [dZeit85_2].[Rang Jahr]+1
			WHEN [dZeit85_2].[Rang Tag innerhalb Jahr] < 0 
			THEN [dZeit85_2].[Rang Jahr]
			ELSE NULL
       END AS [Rang Jahresanfang bis Vortag]
	  -- Wenn wir uns im ersten Geschäftsmonat befinden, dann bekommt das komplette Geschäftsvorjahr den Rang 0
	  -- Sonst wird [[Rank Fiscal Year]] für die "abgeschlossenen" Monate übernommen
	  ,CASE WHEN (SELECT MAX([dZeit85_2].[Geschäftsmonat]) FROM [dim].[dZeit85_2] WHERE [dZeit85_2].[Rang Geschäftsmonat] = 0) = 1 
			THEN [dZeit85_2].[Rang Geschäftsjahr]+1
			WHEN [dZeit85_2].[Rang Geschäftsmonat innerhalb Geschäftsjahr] < 0 
			THEN [dZeit85_2].[Rang Geschäftsjahr]
			ELSE NULL
       END AS [Rang Geschäftsjahresanfang bis Vormonat]
	  -- Wenn wir uns im ersten Geschäftsjahr am ersten Tag befinden, dann bekommt das komplette Geschäftsvorjahr den Rang 0
	  -- Sonst wird [Rank Fiscal Year] für die "abgeschlossenen" Geschäftstage übernommen
	  ,CASE WHEN     (SELECT MAX([dZeit85_2].[Geschäftsmonat]) FROM [dim].[dZeit85_2] WHERE [dZeit85_2].[Rang Geschäftsmonat] = 0) = 1 
				 AND (SELECT MAX([dZeit85_2].[Tag im Monat]) FROM [dim].[dZeit85_2] WHERE [dZeit85_2].[Rang Tag] = 0) = 1
			THEN [dZeit85_2].[Rang Geschäftsjahr]+1
			WHEN [dZeit85_2].[Rang Tag innerhalb Geschäftsjahr] < 0 
			THEN [dZeit85_2].[Rang Geschäftsjahr]
			ELSE NULL
       END AS [Rang Geschäftsjahresanfang bis Vortag]
	FROM [dim].[dZeit85_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit75_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit75_2






























CREATE VIEW

[dim].[dZeit75_2]

AS

SELECT [Datum (Zeit)]
      ,[Datum]
      ,[Datum (Text:JJJJ-MM-TT)]
      ,[Datum (Text)]
      ,[Datum (Zahl)]
      ,[Wochentag]
      ,[Wochentagsbezeichnung DE]
      ,[Wochentagsbezeichnung EN]
      ,[Wochentagsbezeichnung (kurz) DE]
      ,[Wochentagsbezeichnung (kurz) EN]
      ,[Kalenderwoche]
      ,[Kalenderwochenbezeichnung Jahr DE]
      ,[Kalenderwochenbezeichnung Jahr EN]
      ,[Jahr Kalenderwoche (Zahl)]
      ,[Monat]
      ,[Monatsbezeichnung DE]
      ,[Monatsbezeichnung EN]
      ,[Monatsbezeichnung (kurz) DE]
      ,[Monatsbezeichnung (kurz) EN]
      ,[Monatsbezeichnung Jahr DE]
      ,[Monatsbezeichnung Jahr EN]
      ,[Jahr Monat (Zahl)]
	  ,[Buchungsperiode]
      ,[Quartal]
      ,[Quartalsbezeichnung Jahr DE]
      ,[Quartalsbezeichnung Jahr EN]
      ,[Jahr Quartal (Zahl)]
      ,[Halbjahr]
      ,[Halbjahresbezeichnung Jahr DE]
      ,[Halbjahresbezeichnung Jahr EN]
      ,[Jahr Halbjahr (Zahl)]
      ,[Jahr]
      ,[Geschäftsmonat]
      ,[Geschäftsmonat (Text) DE]
	  ,[Geschäftsmonat (Text) EN]
	  ,[Geschäftsmonatsbezeichnung (kurz) DE]
      ,[Geschäftsmonatsbezeichnung (kurz) EN]
      ,[Geschäftsjahr Monatsbezeichnung Jahr DE]
      ,[Geschäftsjahr Monatsbezeichnung Jahr EN]
      ,[Geschäftsmonat (Zahl)]
      ,[Geschäftsmonat Jahr (Text)]
      ,[Geschäftsquartal]
      ,[Geschäftsquartal (Zahl)]
      ,[Geschäftsquartalsbezeichnung Jahr DE]
      ,[Geschäftsquartalsbezeichnung Jahr EN]
      ,[Geschäftshalbjahr]
      ,[Geschäftsjahr Halbjahr (Zahl)]
      ,[Geschäftshalbjahresbezeichnung Jahr DE]
      ,[Geschäftshalbjahresbezeichnung Jahr EN]
      ,[Geschäftsjahr]
      ,[ISO Kalenderwoche]
      ,[ISO Kalenderwochenbezeichnung ISO Jahr DE]
      ,[ISO Kalenderwochenbezeichnung ISO Jahr EN]
      ,[ISO Jahr]
      ,[ISO Jahr ISO Kalenderwoche (Zahl)]
      ,[Tag im Monat]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[Anzahl Arbeitstage im Monat]
      ,[Arbeitstageszähler]
      ,[Arbeitstag (J/N) DE]
      ,[Arbeitstag (J/N) EN]
      ,[Tageszähler]
      ,[Arbeitstag im Jahr]
      ,[Arbeitstag im Monat]
      ,[Bundesland]
      ,[Feiertageszähler]
      ,[Feiertag (J/N) DE]
      ,[Feiertag (J/N) EN]
      ,[Feiertag (J/N) Beschreibung]
      ,[Werktageszähler]
      ,[Werktag (J/N) DE]
      ,[Werktag (J/N) EN]
      ,[Tag im Jahr]
      ,[Letzter Tag des Monats Code]
      ,[Letzter Tag des Monats Bezeichnung DE]
      ,[Letzter Tag des Monats Bezeichnung EN]
      ,CAST([Rang Tag] AS INT) AS [Rang Tag]
      ,CAST([Rang Tag innerhalb Jahr] AS INT) AS [Rang Tag innerhalb Jahr]
      ,CAST([Rang Monat] AS INT) AS [Rang Monat]
      ,CAST([Rang Monat innerhalb Jahr] AS INT) AS [Rang Monat innerhalb Jahr]
      ,CAST([Rang Jahr] AS INT) AS [Rang Jahr]
      ,CAST([Rang ISO Kalenderwoche] AS INT) AS [Rang ISO Kalenderwoche]
      ,CAST([Rang ISO Kalenderwoche innerhalb ISO Jahr] AS INT) AS [Rang ISO Kalenderwoche innerhalb ISO Jahr]
      ,CAST([Rang Geschäftsjahr] AS INT) AS [Rang Geschäftsjahr]
      ,CAST([Rang Geschäftsmonat] AS INT) AS [Rang Geschäftsmonat]
      ,CAST([Rang Geschäftsmonat innerhalb Geschäftsjahr] AS INT) AS [Rang Geschäftsmonat innerhalb Geschäftsjahr]
      ,CAST([Rang Tag innerhalb Geschäftsjahr] AS INT) AS [Rang Tag innerhalb Geschäftsjahr]
      ,CAST([Rang Jahresanfang bis Vormonat] AS INT) AS [Rang Jahresanfang bis Vormonat]
      ,CAST([Rang Jahresanfang bis Vortag] AS INT) AS [Rang Jahresanfang bis Vortag]
      ,CAST([Rang Geschäftsjahresanfang bis Vormonat] AS INT) AS [Rang Geschäftsjahresanfang bis Vormonat]
      ,CAST([Rang Geschäftsjahresanfang bis Vortag] AS INT) AS [Rang Geschäftsjahresanfang bis Vortag]
	  ,CAST([Rang Quartal] AS INT) AS [Rang Quartal]
  FROM [dim].[dZeit80_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit70_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit70_2















CREATE VIEW [dim].[dZeit70_2] AS 
SELECT [Datum (Zeit)]
      ,[Datum]
      ,[Datum (Text:JJJJ-MM-TT)]
      ,[Datum (Text)]
      ,[Datum (Zahl)]
      ,[Wochentag]
      ,[Wochentagsbezeichnung DE]
      ,[Wochentagsbezeichnung EN]
      ,[Wochentagsbezeichnung (kurz) DE]
      ,[Wochentagsbezeichnung (kurz) EN]
      ,[Kalenderwoche]
      ,[Kalenderwochenbezeichnung Jahr DE]
      ,[Kalenderwochenbezeichnung Jahr EN]
      ,[Jahr Kalenderwoche (Zahl)]
      ,[Monat]
      ,[Monatsbezeichnung DE]
      ,[Monatsbezeichnung EN]
      ,[Monatsbezeichnung (kurz) DE]
      ,[Monatsbezeichnung (kurz) EN]
      ,[Monatsbezeichnung Jahr DE]
      ,[Monatsbezeichnung Jahr EN]
      ,[Jahr Monat (Zahl)]
      ,[Buchungsperiode]
      ,[Quartal]
      ,[Quartalsbezeichnung Jahr DE]
      ,[Quartalsbezeichnung Jahr EN]
      ,[Jahr Quartal (Zahl)]
      ,[Halbjahr]
      ,[Halbjahresbezeichnung Jahr DE]
      ,[Halbjahresbezeichnung Jahr EN]
      ,[Jahr Halbjahr (Zahl)]
      ,[Jahr]
      ,[Geschäftsmonat]
      ,[Geschäftsmonat (Text) DE]
	  ,[Geschäftsmonat (Text) EN]
	  ,[Geschäftsmonatsbezeichnung (kurz) DE]
      ,[Geschäftsmonatsbezeichnung (kurz) EN]
      ,[Geschäftsjahr Monatsbezeichnung Jahr DE]
      ,[Geschäftsjahr Monatsbezeichnung Jahr EN]
      ,[Geschäftsmonat (Zahl)]
      ,[Geschäftsmonat Jahr (Text)]
      ,[Geschäftsquartal]
      ,[Geschäftsquartal (Zahl)]
      ,[Geschäftsquartalsbezeichnung Jahr DE]
      ,[Geschäftsquartalsbezeichnung Jahr EN]
      ,[Geschäftshalbjahr]
      ,[Geschäftsjahr Halbjahr (Zahl)]
      ,[Geschäftshalbjahresbezeichnung Jahr DE]
      ,[Geschäftshalbjahresbezeichnung Jahr EN]
      ,[Geschäftsjahr]
      ,[ISO Kalenderwoche]
      ,[ISO Kalenderwochenbezeichnung ISO Jahr DE]
      ,[ISO Kalenderwochenbezeichnung ISO Jahr EN]
      ,[ISO Jahr]
      ,[ISO Jahr ISO Kalenderwoche (Zahl)]
      ,[Tag im Monat]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[Anzahl Arbeitstage im Monat]
      ,[Arbeitstageszähler]
      ,[Arbeitstag (J/N) DE]
      ,[Arbeitstag (J/N) EN]
      ,[Tageszähler]
      ,[Arbeitstag im Jahr]
      ,[Arbeitstag im Monat]
      ,[Bundesland]
      ,[Feiertageszähler]
      ,[Feiertag (J/N) DE]
      ,[Feiertag (J/N) EN]
      ,[Feiertag (J/N) Beschreibung]
      ,[Werktageszähler]
      ,[Werktag (J/N) DE]
      ,[Werktag (J/N) EN]
      ,[Tag im Jahr]
      ,[Letzter Tag des Monats Code]
      ,[Letzter Tag des Monats Bezeichnung DE]
      ,[Letzter Tag des Monats Bezeichnung EN]
      ,[Rang Tag]
      ,[Rang Tag innerhalb Jahr]
      ,[Rang Monat]
      ,[Rang Monat innerhalb Jahr]
      ,[Rang Jahr]
      ,[Rang ISO Kalenderwoche]
      ,[Rang ISO Kalenderwoche innerhalb ISO Jahr]
      ,[Rang Geschäftsjahr]
      ,[Rang Geschäftsmonat]
      ,[Rang Geschäftsmonat innerhalb Geschäftsjahr]
      ,[Rang Tag innerhalb Geschäftsjahr]
      ,[Rang Jahresanfang bis Vormonat]
      ,[Rang Jahresanfang bis Vortag]
      ,[Rang Geschäftsjahresanfang bis Vormonat]
      ,[Rang Geschäftsjahresanfang bis Vortag]
      ,[Rang Quartal]
	  	  
	--SSAS relative Categories
	  ,CAST(IIF([Rang Monat] = 0, ''Aktueller Monat'', NULL) AS NVARCHAR(50))																				AS [Aktueller Monat]
	  ,CAST(IIF([Rang Monat] = -1, ''Vormonat'', NULL) AS NVARCHAR(50))																				AS [Vormonat]
	  ,CAST(IIF([Rang Quartal] = 0 AND [Rang Tag] <= 0, ''Quartal bis heute'', NULL) AS NVARCHAR(50))														AS [Quartal bis heute]
	  ,CAST(IIF([Rang Quartal] IN (-1,0) AND [Rang Tag] <= 0, ''Vorheriges Quartal bis heute'', NULL) AS NVARCHAR(50))										AS [Vorheriges Quartal bis heute]
	  ,CAST(IIF([Rang Jahr] = 0 AND [Rang Tag] <= 0, ''Bisheriges Jahr'', NULL) AS NVARCHAR(50))																AS [Bisheriges Jahr]
	  ,CAST(IIF([Rang Jahr] = -1 AND [Datum (Zeit)] <= DATEADD(YY,-1,[dbo].[SG_REPORT_DATE_TODAY]()), ''Vorheriges Jahr bis heute'', NULL) AS NVARCHAR(50))	AS [Vorheriges Jahr bis heute]
	  ,CAST(IIF([Jahr] = YEAR(DATEADD(MM,-1,[dbo].[SG_REPORT_DATE_TODAY]())) AND [Datum (Zeit)] <= DATEADD(MM, DATEDIFF(MM, 0, [dbo].[SG_REPORT_DATE_TODAY]()), -1), ''Jahr bis zum Vormonat'', NULL) AS NVARCHAR(50))													AS [Jahr bis zum Vormonat]
	  ,CAST(IIF([Jahr] = YEAR(DATEADD(MM,-1,[dbo].[SG_REPORT_DATE_TODAY]()))-1 AND [Datum (Zeit)] <= DATEADD(YY,-1,DATEADD(MM, DATEDIFF(MM, 0, [dbo].[SG_REPORT_DATE_TODAY]()), -1)), ''Vorheriges Jahr zum Vormonat'', NULL) AS NVARCHAR(50))											AS [Vorheriges Jahr zum Vormonat]

  FROM [dim].[dZeit75_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit65_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit65_2_CONCAT

CREATE VIEW [dim].[dZeit65_2_CONCAT] AS
SELECT [Datum (Zeit)]
      ,[Datum]
      ,[Datum (Text:JJJJ-MM-TT)]
      ,[Datum (Text)]
      ,[Datum (Zahl)]
      ,[Wochentag]
      ,[Wochentagsbezeichnung DE]
      ,[Wochentagsbezeichnung EN]
      ,[Wochentagsbezeichnung (kurz) DE]
      ,[Wochentagsbezeichnung (kurz) EN]
      ,[Kalenderwoche]
      ,[Kalenderwochenbezeichnung Jahr DE]
      ,[Kalenderwochenbezeichnung Jahr EN]
      ,[Jahr Kalenderwoche (Zahl)]
      ,[Monat]
      ,[Monatsbezeichnung DE]
      ,[Monatsbezeichnung EN]
      ,[Monatsbezeichnung (kurz) DE]
      ,[Monatsbezeichnung (kurz) EN]
      ,[Monatsbezeichnung Jahr DE]
      ,[Monatsbezeichnung Jahr EN]
      ,[Jahr Monat (Zahl)]
      ,[Buchungsperiode]
      ,[Quartal]
      ,[Quartalsbezeichnung Jahr DE]
      ,[Quartalsbezeichnung Jahr EN]
      ,[Jahr Quartal (Zahl)]
      ,[Halbjahr]
      ,[Halbjahresbezeichnung Jahr DE]
      ,[Halbjahresbezeichnung Jahr EN]
      ,[Jahr Halbjahr (Zahl)]
      ,[Jahr]
      ,[Geschäftsmonat]
      ,[Geschäftsmonat (Text) DE]
      ,[Geschäftsmonat (Text) EN]
      ,[Geschäftsmonatsbezeichnung (kurz) DE]
      ,[Geschäftsmonatsbezeichnung (kurz) EN]
      ,[Geschäftsjahr Monatsbezeichnung Jahr DE]
      ,[Geschäftsjahr Monatsbezeichnung Jahr EN]
      ,[Geschäftsmonat (Zahl)]
      ,[Geschäftsmonat Jahr (Text)]
      ,[Geschäftsquartal]
      ,[Geschäftsquartal (Zahl)]
      ,[Geschäftsquartalsbezeichnung Jahr DE]
      ,[Geschäftsquartalsbezeichnung Jahr EN]
      ,[Geschäftshalbjahr]
      ,[Geschäftsjahr Halbjahr (Zahl)]
      ,[Geschäftshalbjahresbezeichnung Jahr DE]
      ,[Geschäftshalbjahresbezeichnung Jahr EN]
      ,[Geschäftsjahr]
      ,[ISO Kalenderwoche]
      ,[ISO Kalenderwochenbezeichnung ISO Jahr DE]
      ,[ISO Kalenderwochenbezeichnung ISO Jahr EN]
      ,[ISO Jahr]
      ,[ISO Jahr ISO Kalenderwoche (Zahl)]
      ,[Tag im Monat]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[Anzahl Arbeitstage im Monat]
      ,[Arbeitstageszähler]
      ,[Arbeitstag (J/N) DE]
      ,[Arbeitstag (J/N) EN]
      ,[Tageszähler]
      ,[Arbeitstag im Jahr]
      ,[Arbeitstag im Monat]
      ,[Bundesland]
      ,[Feiertageszähler]
      ,[Feiertag (J/N) DE]
      ,[Feiertag (J/N) EN]
      ,[Feiertag (J/N) Beschreibung]
      ,[Werktageszähler]
      ,[Werktag (J/N) DE]
      ,[Werktag (J/N) EN]
      ,[Tag im Jahr]
      ,[Letzter Tag des Monats Code]
      ,[Letzter Tag des Monats Bezeichnung DE]
      ,[Letzter Tag des Monats Bezeichnung EN]
      ,[Rang Tag]
      ,[Rang Tag innerhalb Jahr]
      ,[Rang Monat]
      ,[Rang Monat innerhalb Jahr]
      ,[Rang Jahr]
      ,[Rang ISO Kalenderwoche]
      ,[Rang ISO Kalenderwoche innerhalb ISO Jahr]
      ,[Rang Geschäftsjahr]
      ,[Rang Geschäftsmonat]
      ,[Rang Geschäftsmonat innerhalb Geschäftsjahr]
      ,[Rang Tag innerhalb Geschäftsjahr]
      ,[Rang Jahresanfang bis Vormonat]
      ,[Rang Jahresanfang bis Vortag]
      ,[Rang Geschäftsjahresanfang bis Vormonat]
      ,[Rang Geschäftsjahresanfang bis Vortag]
      ,[Rang Quartal]
      ,[Aktueller Monat]
      ,[Vormonat]
      ,[Quartal bis heute]
      ,[Vorheriges Quartal bis heute]
      ,[Bisheriges Jahr]
      ,[Vorheriges Jahr bis heute]
      ,[Jahr bis zum Vormonat]
      ,[Vorheriges Jahr zum Vormonat]
	  ,[Bundesland] +''_''+ CONVERT(NVARCHAR(25), [Datum (Zeit)], 21) AS [PK dZeit]
  FROM [dim].[dZeit70_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeit]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeit


















































CREATE VIEW

[dim].[dZeit]

AS

SELECT [Datum (Zeit)]
      ,[Datum]
      ,[Datum (Text:JJJJ-MM-TT)]
      ,[Datum (Text)]
      ,[Datum (Zahl)]
      ,[Wochentag]
      ,[Wochentagsbezeichnung DE]
      ,[Wochentagsbezeichnung EN]
      ,[Wochentagsbezeichnung (kurz) DE]
      ,[Wochentagsbezeichnung (kurz) EN]
      ,[Kalenderwoche]
      ,[Kalenderwochenbezeichnung Jahr DE]
      ,[Kalenderwochenbezeichnung Jahr EN]
      ,[Jahr Kalenderwoche (Zahl)]
      ,[Monat]
      ,[Monatsbezeichnung DE]
      ,[Monatsbezeichnung EN]
      ,[Monatsbezeichnung (kurz) DE]
      ,[Monatsbezeichnung (kurz) EN]
      ,[Monatsbezeichnung Jahr DE]
      ,[Monatsbezeichnung Jahr EN]
      ,[Jahr Monat (Zahl)]
      ,[Buchungsperiode]
      ,[Quartal]
      ,[Quartalsbezeichnung Jahr DE]
      ,[Quartalsbezeichnung Jahr EN]
      ,[Jahr Quartal (Zahl)]
      ,[Halbjahr]
      ,[Halbjahresbezeichnung Jahr DE]
      ,[Halbjahresbezeichnung Jahr EN]
      ,[Jahr Halbjahr (Zahl)]
      ,[Jahr]
      ,[Geschäftsmonat]
      ,[Geschäftsmonat (Text) DE]
	  ,[Geschäftsmonat (Text) EN]
	  ,[Geschäftsmonatsbezeichnung (kurz) DE]
      ,[Geschäftsmonatsbezeichnung (kurz) EN]
      ,[Geschäftsjahr Monatsbezeichnung Jahr DE]
      ,[Geschäftsjahr Monatsbezeichnung Jahr EN]
      ,[Geschäftsmonat (Zahl)]
      ,[Geschäftsmonat Jahr (Text)]
      ,[Geschäftsquartal]
      ,[Geschäftsquartal (Zahl)]
      ,[Geschäftsquartalsbezeichnung Jahr DE]
      ,[Geschäftsquartalsbezeichnung Jahr EN]
      ,[Geschäftshalbjahr]
      ,[Geschäftsjahr Halbjahr (Zahl)]
      ,[Geschäftshalbjahresbezeichnung Jahr DE]
      ,[Geschäftshalbjahresbezeichnung Jahr EN]
      ,[Geschäftsjahr]
      ,[ISO Kalenderwoche]
      ,[ISO Kalenderwochenbezeichnung ISO Jahr DE]
      ,[ISO Kalenderwochenbezeichnung ISO Jahr EN]
      ,[ISO Jahr]
      ,[ISO Jahr ISO Kalenderwoche (Zahl)]
      ,[Tag im Monat]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Jahr]
      ,[Anteil Arbeitstag an Gesamtarbeitstagen im Monat]
      ,[Anzahl Arbeitstage im Monat]
      ,[Arbeitstageszähler]
      ,[Arbeitstag (J/N) DE]
      ,[Arbeitstag (J/N) EN]
      ,[Tageszähler]
      ,[Arbeitstag im Jahr]
      ,[Arbeitstag im Monat]
      ,[Bundesland]
      ,[Feiertageszähler]
      ,[Feiertag (J/N) DE]
      ,[Feiertag (J/N) EN]
      ,[Feiertag (J/N) Beschreibung]
      ,[Werktageszähler]
      ,[Werktag (J/N) DE]
      ,[Werktag (J/N) EN]
      ,[Tag im Jahr]
      ,[Letzter Tag des Monats Code]
      ,[Letzter Tag des Monats Bezeichnung DE]
      ,[Letzter Tag des Monats Bezeichnung EN]
      ,[Rang Tag]
      ,[Rang Tag innerhalb Jahr]
      ,[Rang Monat]
      ,[Rang Monat innerhalb Jahr]
      ,[Rang Jahr]
      ,[Rang ISO Kalenderwoche]
      ,[Rang ISO Kalenderwoche innerhalb ISO Jahr]
      ,[Rang Geschäftsjahr]
      ,[Rang Geschäftsmonat]
      ,[Rang Geschäftsmonat innerhalb Geschäftsjahr]
      ,[Rang Tag innerhalb Geschäftsjahr]
      ,[Rang Jahresanfang bis Vormonat]
      ,[Rang Jahresanfang bis Vortag]
      ,[Rang Geschäftsjahresanfang bis Vormonat]
      ,[Rang Geschäftsjahresanfang bis Vortag]
	  ,[Rang Quartal]
      ,[Aktueller Monat]
      ,[Vormonat]
      ,[Quartal bis heute]
      ,[Vorheriges Quartal bis heute]
      ,[Bisheriges Jahr]
      ,[Vorheriges Jahr bis heute]
      ,[Jahr bis zum Vormonat]
      ,[Vorheriges Jahr zum Vormonat]
	  ,[PK dZeit]
  FROM [dim].[dZeit65_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fBilanz70_2_Zeit_Sachkonto]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fBilanz70_2_Zeit_Sachkonto






















CREATE VIEW
[fin].[fBilanz70_2_Zeit_Sachkonto]

AS

SELECT [fBilanz75_2_Zeit_Sachkonto].[Sachkontonummer]
	  ,[dZeit].[Datum (Zeit)]
	  ,[dZeit].[Bundesland]
  FROM [dim].[dZeit]

  INNER JOIN [fin].[fBilanz75_2_Zeit_Sachkonto]
  ON [dim].[dZeit].[Bundesland] = [fin].[fBilanz75_2_Zeit_Sachkonto].[Bundesland]
  AND [dZeit].[Datum (Zeit)] BETWEEN [fBilanz75_2_Zeit_Sachkonto].[Start Datum]
						   AND     [fBilanz75_2_Zeit_Sachkonto].[Ende Datum]

  -- Es werden nur die Monatsletzten Datumswerte benötigt
  WHERE DAY(DATEADD(D,1,[dZeit].[Datum (Zeit)])) = 1
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000018_Kunde]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000018_Kunde





















CREATE VIEW [vv].[vBC_t0000018_Kunde] AS						
SELECT [Name]								AS [Kundenname]					-- Kundenname
      ,[Name 2]								AS [Kundenname 2]					-- Kundenname 2
      ,[Address]							AS [Adresse]						-- Adresse
      ,[Address 2]							AS [Adresse 2]						-- Adresse 2
      ,[City]								AS [Ort]							-- Stadt
      ,[Country_Region Code]				AS [Länder Code]						-- Bundeslandscode
      ,[No_]								AS [Kundennummer]					-- Kundennummer
      ,[Search Name]						AS [Suchbezeichnung]					-- Suchbegriff
      ,[Budgeted Amount]					AS [Budgetierter Betrag]			-- Budgetbetrag
      ,[Credit Limit (LCY)]					AS [Kreditlimit (MW)]	-- Kreditlimit (MW)
      ,[Customer Posting Group]				AS [Debitorenbuchungsgruppe Code]	-- Kundenbuchungsgruppe
      ,[Currency Code]						AS [Währung Code]					-- Währungscode
      ,[Language Code]						AS [Sprache Code]						-- Sprachcode
      ,[Payment Terms Code]					AS [Zahlungsbedingung Code]			-- Zahlungsbedinungscode
      ,[Customer Disc_ Group]				AS [Debitorenrabattgruppe Code]	-- Kundenrabattgruppe
      ,[Blocked]							AS [Gesperrt Code]					-- Gesperrtcode
      ,[Salesperson Code]					AS [Verkäufer Code]					-- Verkäufercode
	  ,[Reminder Terms Code]				AS [Mahnmethode Code]				-- Mahnmethodencode
	  ,[SG_MandantCode]						AS [Mandant Code]					-- Mandant ID
      ,[Contact]							AS [Kontaktbezeichnung]					-- Kontakname
      ,[Primary Contact No_]				AS [Kontaktnummer]					-- Kontakcode
      ,[Territory Code]						AS [Gebiet Code]					-- Gebietscode
      ,[Post Code]							AS [Postleitzahl]					-- Postleitzahl
      ,[Prepayment _]						AS [Vorauszahlung %]				-- Vorauszahlung %
      ,[Location Code]						AS [Lagerort Code]					-- Lagerortcode
      ,[Shipment Method Code]				AS [Lieferbedingung Code]			-- Lieferbedinungscode
      ,[Prices Including VAT]				AS [Preise inkl. MwST]				-- Preise inkl. MwST
      ,[Cash Flow Payment Terms Code]		AS [Cashflow-Zlg.-Bedingung Code]	-- Cashflow-Zlg.-Bedingung Code
      ,[Block Payment Tolerance]			AS [Zahlungstoleranz]				-- Zahlungstoleranz
  FROM [com].[BC_t0000018_Customer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000231_Ursache_Code]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000231_Ursache_Code


CREATE VIEW [vv].[vBC_t0000231_Ursache_Code] AS
SELECT [Code]				 AS [Ursache Code]			 -- Grundcode
      ,[Description]		 AS [Ursachenbezeichnung]	 -- Grundbezeichnung
      ,[SG_MandantCode]		 AS [Mandant Code]			 -- Mandant ID
  FROM [com].[BC_t0000231_Reason_Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor90_2





























CREATE VIEW [fin].[fOPDebitor90_2] AS
SELECT [vv].[vBC_t0000021_Debitorenposten].[Debitorenposten Lfd.]
      ,[vv].[vBC_t0000021_Debitorenposten].[Beschreibung]
	  --in der General Ledger Setup Tabelle ist definiert on welchem Global Dim Code welcher Dimensionswert steht
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenstellencode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenstelle Code]
																				,[vv].[vBC_t0000021_Debitorenposten].[Kostenstellencode]
																				,[vv].[vBC_t0000021_Debitorenposten].[Kostenträgercode]) 
		AS [Kostenstelle Code]
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenträgercode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenträger Code]
																				,[vv].[vBC_t0000021_Debitorenposten].[Kostenträgercode]
																				,[vv].[vBC_t0000021_Debitorenposten].[Kostenstellencode]) 
		AS [Kostenträger Code]
      ,[vv].[vBC_t0000021_Debitorenposten].[Debitornummer]
      ,[vv].[vBC_t0000021_Debitorenposten].[Buchungsdatum]
      ,[vv].[vBC_t0000021_Debitorenposten].[Belegartcode]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Belegartbezeichnung DE]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Belegartbezeichnung EN]
      ,[vv].[vBC_t0000021_Debitorenposten].[Belegnummer]
      ,[vv].[vBC_t0000021_Debitorenposten].[Währung Code]
      ,[vv].[vBC_t0000021_Debitorenposten].[Rechnungsrabatt (MW)]
      ,[vv].[vBC_t0000021_Debitorenposten].[Verkauf an Debitornummer]
	  ,[Verkauf an Debitor].[Kundenname]											AS [Verkauf an Debitorbezeichnung]
      ,[vv].[vBC_t0000021_Debitorenposten].[Debitorenbuchungsgruppe Code]
      ,[vv].[vBC_t0000021_Debitorenposten].[Verkäufer Code]
      ,[vv].[vBC_t0000021_Debitorenposten].[Abwarten]
      ,[vv].[vBC_t0000021_Debitorenposten].[Ausgeglichen mit Belegart]
      ,[vv].[vBC_t0000021_Debitorenposten].[Ausgeglichen mit Belegnummer]
      ,[vv].[vBC_t0000021_Debitorenposten].[Offen]
	  ,ISNULL([Offenbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Offenbezeichnung DE]
	  ,ISNULL([Offenbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Offenbezeichnung EN]
      ,[vv].[vBC_t0000021_Debitorenposten].[Fälligkeitsdatum]
      ,[vv].[vBC_t0000021_Debitorenposten].[Skontodatum]
      ,[vv].[vBC_t0000021_Debitorenposten].[Zahlungsrabatt gewährt (MW)]
      ,[vv].[vBC_t0000021_Debitorenposten].[Geschlossen mit Betrag (MW)]
      ,[vv].[vBC_t0000021_Debitorenposten].[Belegdatum]
      ,[vv].[vBC_t0000021_Debitorenposten].[Externe Belegnummer]
      ,[vv].[vBC_t0000021_Debitorenposten].[letzte registrierte Mahnstufe]
	  ,[vv].[vBC_t0000018_Kunde].[Mahnmethode Code]
      ,[vv].[vBC_t0000021_Debitorenposten].[Ausgleichposten]
      ,[vv].[vBC_t0000021_Debitorenposten].[storniert]
      ,[vv].[vBC_t0000021_Debitorenposten].[im vorraus bezahlt]
	  ,[vv].[vBC_t0000021_Debitorenposten].[Geschlossen von Lfd. Nr.]
      ,[vv].[vBC_t0000021_Debitorenposten].[Geschlossen am]
	  ,[vv].[vBC_t0000021_Debitorenposten].[Bilanzkontotyp]
	  ,ISNULL([Bilanzkontotypbezeichnung ].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Bilanzkontotypbezeichnung  DE]
	  ,ISNULL([Bilanzkontotypbezeichnung ].[Optionsfeldbezeichnung EN],''not defined'')		AS [Bilanzkontotypbezeichnung  EN]
	  ,[vv].[vBC_t0000021_Debitorenposten].[Ursache Code]
	  ,[vv].[vBC_t0000231_Ursache_Code].[Ursachenbezeichnung]
	  ,[vv].[vBC_t0000021_Debitorenposten].[Gehört zu ID]
	  ,[vv].[vBC_t0000021_Debitorenposten].[Skontotoleranzdatum]
	  ,[vv].[vBC_t0000021_Debitorenposten].[Zahlungsbedingung Code]
      ,[vv].[vBC_t0000021_Debitorenposten].[Mandant Code]
      ,[vv].[vBC_t0000021_Debitorenposten].[Bundesland]
	  --Datum dient der Überfälligkeitsberechnung, wenn es keine Zahlung gibt muss vom ReportDatum ausgegangen werden
	  ,[fin].[fOPDebitor95_2_LetzteZahlung].[Letztes Zahlungsdatum]																							AS [Letztes Zahlungsdatum]
	  ,[vv].[vBC_t0000112_Verkaufsrechnungkopf].[Zlg.-Bedingung Code] AS [Zahlungsbedingung Code (Rechnung)]
	  --die spätere Berechnung von überfälligkeiten darf nur für Posten erfolgen die noch offen sind
	  ,IIF([vv].[vBC_t0000021_Debitorenposten].[Offen] = 0, [fin].[fOPDebitor95_2_LetzteZahlung].[Letztes Zahlungsdatum], [dbo].[SG_REPORT_DATE_TODAY]())   AS [Berechnungsdatum]
	  --detailierte Debitorenposten
	  ,ISNULL([fin].[fOPDebitor95_2_Betrag].[Sollbetrag (MW)], 0)																					AS [Sollbetrag (MW)]
	  ,ISNULL([fin].[fOPDebitor95_2_Betrag].[Habenbetrag (MW)], 0)																					AS [Habenbetrag (MW)]
	  ,ISNULL([fin].[fOPDebitor95_2_OffenerBetrag].[Offener Betrag (MW)], 0)																		AS [Offener Betrag (MW)]
	  ,ISNULL([fin].[fOPDebitor95_2_ZlgRabatt].[Betrag Zahlungsrabatt (MW)],0)																			AS [Betrag Zahlungsrabatt (MW)]
	  ,ISNULL([fin].[fOPDebitor95_2_ZlgRabattUngerechtfertigt].[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)], 0)														AS [Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
	  ,IIF([vv].[vBC_t0000021_Debitorenposten].[Belegartcode] IN (2,3),ISNULL([fin].[fOPDebitor95_2_BetragInklMwSt].[Betrag inkl. MwSt. (MW)], 0),0)	AS [Betrag inkl. MwSt. (MW)]
	  ,IIF([vv].[vBC_t0000021_Debitorenposten].[Belegartcode] IN (2,3),ISNULL([fin].[fOPDebitor95_2_Betrag].[Betrag (MW)], 0),0)					AS [Betrag (MW)]
      --Mandantenwährung
	  ,ISNULL([fin].[fOPDebitor95_2_Betrag].[Sollbetrag], 0)																							AS [Sollbetrag]
	  ,ISNULL([fin].[fOPDebitor95_2_Betrag].[Habenbetrag], 0)																						AS [Habenbetrag]
	  ,ISNULL([fin].[fOPDebitor95_2_OffenerBetrag].[Offener Betrag], 0)																			AS [Offener Betrag]
	  ,ISNULL([fin].[fOPDebitor95_2_ZlgRabatt].[Betrag Zahlungsrabatt],0)																					AS [Betrag Zahlungsrabatt]
	  ,ISNULL([fin].[fOPDebitor95_2_ZlgRabattUngerechtfertigt].[Betrag Zahlungsrabatt (ungerechtfertigt)], 0)															AS [Betrag Zahlungsrabatt (ungerechtfertigt)]
	  ,IIF([vv].[vBC_t0000021_Debitorenposten].[Belegartcode] IN (2,3),ISNULL([fin].[fOPDebitor95_2_BetragInklMwSt].[Betrag inkl. MwSt.], 0),0)		AS [Betrag inkl. MwSt.]
	  ,IIF([vv].[vBC_t0000021_Debitorenposten].[Belegartcode] IN (2,3),ISNULL([fin].[fOPDebitor95_2_Betrag].[Betrag], 0),0)							AS [Betrag]
  FROM [vv].[vBC_t0000021_Debitorenposten]

  LEFT JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code] = [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code] = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Belegartbezeichnung]
  ON [vv].[vBC_t0000021_Debitorenposten].[Belegartcode]  = [Belegartbezeichnung].[Optionsfeld Code]
  AND [Belegartbezeichnung].[Tabellenname]	= ''Finanzen''
  AND [Belegartbezeichnung].[Spaltenbezeichnung]		= ''Belegartbezeichnung''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Offenbezeichnung]
  ON [vv].[vBC_t0000021_Debitorenposten].[Offen]  = [Offenbezeichnung].[Optionsfeld Code]
  AND [Offenbezeichnung].[Tabellenname]				= ''Global''
  AND [Offenbezeichnung].[Spaltenbezeichnung]					= ''Ja/Nein''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Bilanzkontotypbezeichnung ]
  ON [vv].[vBC_t0000021_Debitorenposten].[Bilanzkontotyp]	= [Bilanzkontotypbezeichnung ].[Optionsfeld Code]
  AND [Bilanzkontotypbezeichnung ].[Tabellenname]				= ''Finanzen''
  AND [Bilanzkontotypbezeichnung ].[Spaltenbezeichnung]					= ''Bilanzkontotypbezeichnung ''

  LEFT JOIN [vv].[vBC_t0000018_Kunde]
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code]  = [vv].[vBC_t0000018_Kunde].[Mandant Code]
  AND [vv].[vBC_t0000021_Debitorenposten].[Debitornummer] = [vv].[vBC_t0000018_Kunde].[Kundennummer]
  
  LEFT JOIN [vv].[vBC_t0000018_Kunde] AS [Verkauf an Debitor]
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code]			= [Verkauf an Debitor].[Mandant Code]
  AND [vv].[vBC_t0000021_Debitorenposten].[Verkauf an Debitornummer]	= [Verkauf an Debitor].[Kundennummer]

  LEFT JOIN [fin].[fOPDebitor95_2_Betrag] 
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code] = [fin].[fOPDebitor95_2_Betrag].[Mandant Code]
  AND[vv].[vBC_t0000021_Debitorenposten].[Debitorenposten Lfd.] = [fin].[fOPDebitor95_2_Betrag].[Debitorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPDebitor95_2_LetzteZahlung]
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code] = [fin].[fOPDebitor95_2_LetzteZahlung].[Mandant Code]
  AND [vv].[vBC_t0000021_Debitorenposten].[Debitorenposten Lfd.] = [fin].[fOPDebitor95_2_LetzteZahlung].[Debitorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPDebitor95_2_OffenerBetrag] 
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code] = [fin].[fOPDebitor95_2_OffenerBetrag].[Mandant Code]
  AND [vv].[vBC_t0000021_Debitorenposten].[Debitorenposten Lfd.] = [fin].[fOPDebitor95_2_OffenerBetrag].[Debitorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPDebitor95_2_ZlgRabatt]
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code] = [fin].[fOPDebitor95_2_ZlgRabatt].[Mandant Code]
  AND [vv].[vBC_t0000021_Debitorenposten].[Debitorenposten Lfd.] = [fin].[fOPDebitor95_2_ZlgRabatt].[Debitorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPDebitor95_2_ZlgRabattUngerechtfertigt] 
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code] = [fin].[fOPDebitor95_2_ZlgRabattUngerechtfertigt].[Mandant Code]
  AND [vv].[vBC_t0000021_Debitorenposten].[Debitorenposten Lfd.] = [fin].[fOPDebitor95_2_ZlgRabattUngerechtfertigt].[Debitorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPDebitor95_2_BetragInklMwSt] 
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code] = [fin].[fOPDebitor95_2_BetragInklMwSt].[Mandant Code]
  AND[vv].[vBC_t0000021_Debitorenposten].[Debitorenposten Lfd.] = [fin].[fOPDebitor95_2_BetragInklMwSt].[Debitorenposten Lfd. Nr.]

   LEFT JOIN [vv].[vBC_t0000112_Verkaufsrechnungkopf]
  ON  [vv].[vBC_t0000021_Debitorenposten].[Mandant Code] = [vv].[vBC_t0000112_Verkaufsrechnungkopf].[Mandant Code]
  AND [vv].[vBC_t0000021_Debitorenposten].[Belegnummer] = [vv].[vBC_t0000112_Verkaufsrechnungkopf].[Belegnummer]
  --Rechnung
  AND [vv].[vBC_t0000021_Debitorenposten].[Belegartcode] = 2

  LEFT JOIN [vv].[vBC_t0000231_Ursache_Code]
  ON [vv].[vBC_t0000021_Debitorenposten].[Mandant Code]  = [vv].[vBC_t0000231_Ursache_Code].[Mandant Code]
  AND [vv].[vBC_t0000021_Debitorenposten].[Ursache Code]	= [vv].[vBC_t0000231_Ursache_Code].[Ursache Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vSNCt_Zeitkategorie]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vSNCt_Zeitkategorie















CREATE VIEW [vv].[vSNCt_Zeitkategorie] AS 
SELECT [ID]			  AS [Zeitkategorie Code]								-- Zeitkategorie Code (dient auch der Sortierung)
      ,[Zeitkategorie] AS [Zeitkategoriebezeichnung]								-- Zeitkategorie Name
  FROM [control].[SNCt_Zeitkategorie]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeitRelativeKategorie95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeitRelativeKategorie95_2









CREATE VIEW [dim].[dZeitRelativeKategorie95_2] AS
SELECT [Zeitkategorie Code]
      ,[Zeitkategoriebezeichnung]
  FROM [vv].[vSNCt_Zeitkategorie]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0001103_Kostenart95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0001103_Kostenart95_2











CREATE VIEW [vv].[vBC_t0001103_Kostenart95_2] AS
SELECT [Name]					AS [Kostenartbezeichnung]						-- Kostenartbezeichnung
      ,[Totaling]				AS [Summierungselemente]						-- Summierungselemente
      ,[No_]					AS [Kostenartnummer]							-- Kostenartcode
      ,[Cost Center Code]		AS [Kostenstelle Code]							-- Kostenstellencode
      ,[Cost Object Code]		AS [Kostenträger Code]							-- Kostenträgercode
      ,[Blocked]				AS [Gesperrt Code]								-- Gesperrt Code
      ,[SG_MandantCode]			AS [Mandant Code]								-- Mandant ID
	  ,[G_L Account Range]		AS [Sachkontobereich (Summierung von/bis)]		-- Sachkontobereich (Summierung von/bis)
	  ,[Cost Classification]	AS [Kostenklassifizierung]						-- Kostenklassifizierung
  FROM [fin].[BC_t0001103_Cost_Type]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0001103_Kostenart]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0001103_Kostenart

















CREATE VIEW [vv].[vBC_t0001103_Kostenart] AS
SELECT [Kostenartbezeichnung]
      ,[Summierungselemente]
      ,[Kostenartnummer]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Gesperrt Code]
      ,[Mandant Code]
      ,[Sachkontobereich (Summierung von/bis)]
      ,[Kostenklassifizierung]
  FROM [vv].[vBC_t0001103_Kostenart95_2]
  
  --wihout summary elements
  WHERE [Summierungselemente] = ''''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000038_Einkaufsbelegkopf95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000038_Einkaufsbelegkopf95_2












CREATE VIEW [vv].[vBC_t0000038_Einkaufsbelegkopf95_2]

AS

SELECT [SG_MandantCode]				  AS [Mandant Code]							-- Mandant ID
      ,[Document Type]				  AS [Belegart]								-- Belegart
      ,[No_]						  AS [Belegnummer]							-- Belegnummer
      ,[Buy-from Vendor No_]		  AS [Kauf von Kreditornummer]				-- Kauf von Kreditornummer
      ,[Pay-to Vendor No_]			  AS [Zahlung an Kreditornummer]			-- Zahlung an Kreditornummer
      ,[Posting Date]				  AS [Buchungsdatum]						-- Buchungsdatum
      ,[Currency Code]				  AS [Währung Code]							-- Währungscode
      ,[Currency Factor]			  AS [Währungsfaktor]						-- Währungsfaktor
      ,[Purchaser Code]				  AS [Einkäufer Code]						-- Einkäufercode
      ,[Correction]					  AS [Storno]								-- Storno
	  ,[Document Date]				  AS [Belegdatum]							-- Belegdatum
      ,[Promised Receipt Date]		  AS [Anlieferungsdatum Zugesagt]			-- Anlieferungsdatum Zugesagt
	  ,[Status]						  AS [Status]								-- Status
	  ,[SG_Bundesland]					  AS [Bundesland]							-- Bundesland
      ,[Order Date]					  AS [Auftragsdatum]						-- Auftragsdatum
      ,[Due Date]					  AS [Fälligkeitsdatum]						-- Fällgikeitsdatun
      ,[Requested Receipt Date]		  AS [Gewünschtes Anlieferungsdatum]		-- Gewünschtes Anlieferungsdatum
      ,[Buy-from Contact]			  AS [Kauf von Kontakt]								-- Kontakt
      ,[Posting Description]		  AS [Beschreibung]							-- Beschreibung
      ,[Location Code]				  AS [Lagerort Code]						-- Lagerort Code
      ,[Payment Discount _]			  AS [Zahlungsrabatt %]						-- Skonto %
      ,[Pmt_ Discount Date]			  AS [Skontodatum]							-- Skontodatum
      ,[Payment Terms Code]			  AS [Zlg.-Bedingungscode]					-- Zahlungsbedinungscode
	  ,[Vendor Invoice No_]			  AS [Kreditor Rechnungsnummer]				-- Kreditor Rechnungsnummer
	  ,[Vendor Order No_]			  AS [Kreditor Bestellnummer]				-- Kreditor Bestellnummer
	  ,[Vendor Shipment No_]		  AS [Kreditor Liefernummer]				-- Kreditor Liefernummer
	  ,[Responsibility Center]		  AS [Zuständigkeitseinheiten Code]			-- Zuständigkeitseinheiten Code
	  ,[VAT Bus_ Posting Group]		  AS [MwSt.-Geschäftsbuchungsgruppe Code]	-- MwSt.-Geschäftsbuchungsgruppe Code
	  ,[Shipment Method Code]		  AS [Lieferbedingungscode]					-- Lieferbedinungscode
	  ,[Buy-from Contact No_]		  AS [Kauf von Kontaktnummer]					-- Kauf von Kontakt Nr.
	  ,[Invoice Discount Value]		  AS [Rabattwert]							-- Rabattwert
	  ,[Invoice Discount Calculation] AS [Berechnungsart Rabatt]				-- Berechnungsart Rabatt
  FROM [ein].[BC_t0000038_Purchase_Header]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000038_Einkaufsbelegkopf]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000038_Einkaufsbelegkopf
-- Alter View vBC_t0000038_Einkaufsbeleg



CREATE VIEW [vv].[vBC_t0000038_Einkaufsbelegkopf] AS
SELECT [Mandant Code]
      ,[Belegart]
      ,[Belegnummer]
      ,[Kauf von Kreditornummer]
      ,[Zahlung an Kreditornummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])					AS [Buchungsdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[Storno]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])						AS [Belegdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Anlieferungsdatum Zugesagt])		AS [Anlieferungsdatum Zugesagt]
      ,[Status]
      ,[Bundesland]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Auftragsdatum])					AS [Auftragsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])				AS [Fälligkeitsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Gewünschtes Anlieferungsdatum])	AS [Gewünschtes Anlieferungsdatum]
      ,[Kauf von Kontakt]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[Zahlungsrabatt %]
      ,[Skontodatum]
      ,[Zlg.-Bedingungscode]
      ,[Kreditor Rechnungsnummer]
      ,[Kreditor Bestellnummer]
      ,[Kreditor Liefernummer]
      ,[Zuständigkeitseinheiten Code]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
      ,[Lieferbedingungscode]
      ,[Kauf von Kontaktnummer]
      ,[Rabattwert]
      ,[Berechnungsart Rabatt]
  FROM [vv].[vBC_t0000038_Einkaufsbelegkopf95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZeitRelativeKategorie]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZeitRelativeKategorie








CREATE VIEW [dim].[dZeitRelativeKategorie] AS
SELECT [Zeitkategorie Code]
      ,[Zeitkategoriebezeichnung]
  FROM [dim].[dZeitRelativeKategorie95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0001113_Kostenträger]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0001113_Kostenträger














CREATE VIEW [vv].[vBC_t0001113_Kostenträger] AS
SELECT [Name]				AS [Kostenträgerbezeichnung]		-- Kostenträgerbezeichnung
      ,[Blocked]			AS [Gesperrt Code]					-- Gesperrt Code
      ,[Code]				AS [Kostenträger Code]				-- Kostentragercode
      ,[SG_MandantCode]		AS [Mandant Code]					-- Mandant ID
	  ,[Sorting Order]		AS [Sortierreihenfolge]				-- Sortierung
  FROM [fin].[BC_t0001113_Cost_Object]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenträger95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenträger95_2


















CREATE VIEW  [dim].[dKostenträger95_2] AS
SELECT [vBC_t0001113_Kostenträger].[Kostenträgerbezeichnung]
      ,[vBC_t0001113_Kostenträger].[Kostenträger Code]
	  ,[vBC_t0001113_Kostenträger].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Gesperrtbezeichnung EN]
      ,[vBC_t0001113_Kostenträger].[Mandant Code]
	  ,[vBC_t0001113_Kostenträger].[Sortierreihenfolge]
  FROM [vv].[vBC_t0001113_Kostenträger]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vBC_t0001113_Kostenträger].[Gesperrt Code]  = [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]			= ''Global''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]				= ''Gesperrtbezeichnung''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0001112_Kostenstelle]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0001112_Kostenstelle














CREATE VIEW [vv].[vBC_t0001112_Kostenstelle] AS
SELECT [Name]				AS [Kostenstelle Code]			-- Kostenstellencode
      ,[Blocked]			AS [Gesperrt Code]				-- Gesperrt Code
      ,[Code]				AS [Kostenstellenbezeichnung]	-- Costenstellenbezeichnung
	  ,[Cost Subtype]		AS [Kostenunterart Code]		-- Kostenunterart
	  ,[Responsible Person]	AS [Zuständige Person]			-- verantwortliche Person
	  ,[Sorting Order]		AS [Sortierreihenfolge]			-- Sortierung
      ,[SG_MandantCode]		AS [Mandant Code]				-- Mandant ID
  FROM [fin].[BC_t0001112_Cost_Center]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenart95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenart95_2


















CREATE VIEW [dim].[dKostenart95_2] AS
SELECT [vBC_t0001103_Kostenart].[Kostenartbezeichnung]
      ,[vBC_t0001103_Kostenart].[Kostenartnummer]
      ,[vBC_t0001103_Kostenart].[Kostenstelle Code]
	  ,[vBC_t0001112_Kostenstelle].[Kostenstellenbezeichnung]
      ,[vBC_t0001103_Kostenart].[Kostenträger Code]
	  ,[vBC_t0001113_Kostenträger].[Kostenträgerbezeichnung]
      ,[vBC_t0001103_Kostenart].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'') AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')	 AS [Gesperrtbezeichnung EN]
      ,[vBC_t0001103_Kostenart].[Mandant Code]
	  ,[vBC_t0001103_Kostenart].[Sachkontobereich (Summierung von/bis)]
	  ,[vBC_t0001103_Kostenart].[Kostenklassifizierung]
  FROM [vv].[vBC_t0001103_Kostenart]

  LEFT JOIN [vv].[vBC_t0001112_Kostenstelle]
  ON [vBC_t0001103_Kostenart].[Mandant Code]	  = [vBC_t0001112_Kostenstelle].[Mandant Code]
  AND [vBC_t0001103_Kostenart].[Kostenstelle Code] = [vBC_t0001112_Kostenstelle].[Kostenstelle Code]

  LEFT JOIN [vv].[vBC_t0001113_Kostenträger]
  ON [vBC_t0001103_Kostenart].[Mandant Code]	  = [vBC_t0001113_Kostenträger].[Mandant Code]
  AND [vBC_t0001103_Kostenart].[Kostenträger Code] = [vBC_t0001113_Kostenträger].[Kostenträger Code]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vBC_t0001103_Kostenart].[Gesperrt Code]	= [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]		= ''Global''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]			= ''Gesperrtbezeichnung''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000039_Einkaufsbelegzeile95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000039_Einkaufsbelegzeile95_2



























CREATE VIEW [vv].[vBC_t0000039_Einkaufsbelegzeile95_2]

AS

SELECT [SG_MandantCode]					AS [Mandant Code]													-- Mandant ID
      ,[Document Type]					AS [Belegart]														-- Belegart
      ,[Document No_]					AS [Belegnummer]													-- Belegnummer
      ,[Line No_]						AS [Zeilennummer]													-- Zeilennummer
      ,[Buy-from Vendor No_]			AS [Kauf von Kreditornummer]										-- Kauf von Kreditornummer
      ,[Type]							AS [Produktart]														-- Produktart
      ,[No_]							AS [Produktnummer]													-- Produktnummer
      ,[Quantity]						AS [Menge]															-- Menge
      ,[Outstanding Quantity]			AS [Restauftragsmenge]												-- Restauftragsmenge
      ,[Unit Price (LCY)]				AS [Einkaufspreis (MW)]													-- Einkaufspreis (MW)
      ,[Line Discount Amount]			AS [Zeilenrabattbetrag]												-- Zeilenrabattbetrag
      ,[Amount]							AS [Betrag]															-- Betrag
      ,[Shortcut Dimension 1 Code]		AS [Kostenstellencode]												-- Kostenstellencode
      ,[Shortcut Dimension 2 Code]		AS [Kostenträgercode]												-- Kostenträgercode
      ,[Outstanding Amount]				AS [Restauftragsbetrag]												-- Restauftragsbetrag
      ,[Pay-to Vendor No_]				AS [Zahlung an Kreditornummer]										-- Zahlung an Kreditornummer
      ,[Inv_ Discount Amount]			AS [Rechnungsrabattbetrag]											-- Rechnungsrabattbetrag
      ,[Unit Cost]						AS [Einstandspreis]													-- Einstandspreis
      ,[Line Amount]					AS [Zeilenbetrag]													-- Zeilenbetrag
      ,[Quantity (Base)]				AS [Menge (Basis)]													-- Menge (Basis)
      ,[Promised Receipt Date]			AS [Anlieferungsdatum Zugesagt]										-- Anlieferungsdatum Zugesagt
      ,[Location Code]					AS [Lagerort Code]													-- Lagerort Code
      ,[Requested Receipt Date]			AS [Gewünschtes Anlieferungsdatum]									-- gewünschtes Anlieferungsdatum
      ,[Description]					AS [Beschreibung]													-- Beschreibung
      ,[Unit of Measure Code]			AS [Einheitencode]													-- Einheitencode
      ,[Planned Receipt Date]			AS [Geplantes Anlieferungsdatum]									-- geplantes Anlieferungsdatum
      ,[Dimension Set ID]				AS [Dimension Set ID]		-- Dimension Set ID Link zur Tabelle [Dimension Set Entry]
	  ,[SG_Bundesland]						AS [Bundesland]														-- Bundesland
	  ,[Bin Code]						AS [Lagerplatz Code]												-- Lagerplatzcode
	  ,[Responsibility Center]			AS [Zuständigkeitseinheiten Code]									-- Zuständigkeitseinheiten Code
	  ,[VAT Bus_ Posting Group]			AS [MwSt.-Geschäftsbuchungsgruppe Code]								-- MwSt.-Geschäftsbuchungsgruppe Code
	  ,[Direct Unit Cost]			    AS [EK-Preis ohne MwSt.]											-- EK-Preis ohne MwSt.
	  ,[Qty_ to Invoice]			    AS [Menge akt. Rechnung]											-- Menge akt. Rechnung
	  ,[Qty_ to Receive]			    AS [Menge akt. Lieferung]											-- Menge akt. Lieferung
	  ,[Quantity Received]			    AS [Bereits gelieferte Menge]										-- Bereits gelieferte Menge
	  ,[Quantity Invoiced]			    AS [Bereits berechnete Menge] 										-- Bereits berechnete Menge
  FROM [ein].[BC_t0000039_Purchase_Line]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000039_Einkaufsbelegzeile]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000039_Einkaufsbelegzeile


CREATE VIEW [vv].[vBC_t0000039_Einkaufsbelegzeile] AS
SELECT [Mandant Code]
      ,[Belegart]
      ,[Belegnummer]
      ,[Zeilennummer]
      ,[Kauf von Kreditornummer]
      ,[Produktart]
      ,[Produktnummer]
      ,[Menge]
      ,[Restauftragsmenge]
      ,[Einkaufspreis (MW)]
      ,[Zeilenrabattbetrag]
      ,[Betrag]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Restauftragsbetrag]
      ,[Zahlung an Kreditornummer]
      ,[Rechnungsrabattbetrag]
      ,[Einstandspreis]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Anlieferungsdatum Zugesagt])			AS [Anlieferungsdatum Zugesagt]
      ,[Lagerort Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Gewünschtes Anlieferungsdatum])		AS [Gewünschtes Anlieferungsdatum]
      ,[Beschreibung]
      ,[Einheitencode]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Geplantes Anlieferungsdatum])			AS [Geplantes Anlieferungsdatum]
      ,[Dimension Set ID]
      ,[Bundesland]
      ,[Lagerplatz Code]
      ,[Zuständigkeitseinheiten Code]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
      ,[EK-Preis ohne MwSt.]
      ,[Menge akt. Rechnung]
      ,[Menge akt. Lieferung]
      ,[Bereits gelieferte Menge]
      ,[Bereits berechnete Menge]
  FROM [vv].[vBC_t0000039_Einkaufsbelegzeile95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenträger90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenträger90_2


















CREATE VIEW  [dim].[dKostenträger90_2] AS
SELECT [Kostenträgerbezeichnung]
      ,[Kostenträger Code]
	  ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
	  ,[Sortierreihenfolge]
  FROM [dim].[dKostenträger95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor85_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor85_2





























CREATE VIEW [fin].[fOPDebitor85_2] AS
SELECT [Debitorenposten Lfd.]
      ,[Beschreibung]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Debitornummer]
      ,[Buchungsdatum]
      ,[Belegartcode]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Rechnungsrabatt (MW)]
      ,[Verkauf an Debitornummer]
      ,[Verkauf an Debitorbezeichnung]
      ,[Debitorenbuchungsgruppe Code]
      ,[Verkäufer Code]
      ,[Abwarten]
      ,[Ausgeglichen mit Belegart]
      ,[Ausgeglichen mit Belegnummer]
      ,[Offen]
      ,[Offenbezeichnung DE]
      ,[Offenbezeichnung EN]
      ,[Fälligkeitsdatum]
      ,[Skontodatum]
      ,[Zahlungsrabatt gewährt (MW)]
      ,[Geschlossen mit Betrag (MW)]
      ,[Belegdatum]
      ,[Externe Belegnummer]
      ,[letzte registrierte Mahnstufe]
      ,[Mahnmethode Code]
      ,[Ausgleichposten]
      ,[storniert]
      ,[im vorraus bezahlt]
      ,[Geschlossen von Lfd. Nr.]
      ,[Geschlossen am]
      ,[Bilanzkontotyp]
      ,[Bilanzkontotypbezeichnung  DE]
      ,[Bilanzkontotypbezeichnung  EN]
	  ,[Ursache Code]
      ,[Ursachenbezeichnung]
      ,[Gehört zu ID]
      ,[Skontotoleranzdatum]
	  ,[Zahlungsbedingung Code]
      ,[Mandant Code]
      ,[Bundesland]
	  ,[Zahlungsbedingung Code (Rechnung)]
	  ,[Berechnungsdatum]
	  --Tagesberechnungen
	  ,CAST(DATEDIFF(DAY,[dbo].[SG_REPORT_DATE_TODAY](), [Belegdatum]) AS INT)									AS [Alter offener Posten]
	  ,CAST(DATEDIFF(DAY,[Berechnungsdatum],[Fälligkeitsdatum]) AS INT)													AS [Anzahl Tage fällig] -- JH - 2021-02-05 - #8028 #8161
	  ,CAST(DATEDIFF(DAY,[Letztes Zahlungsdatum], [Berechnungsdatum]) AS INT)										AS [Anzahl Tage letzte Zahlung]
	  ,CAST(DATEDIFF(DAY,[Buchungsdatum], [Berechnungsdatum]) AS INT)											AS [Anzahl Tage Zahlungsdauer]
	  ,CAST(DATEDIFF(DAY,[Buchungsdatum], [Fälligkeitsdatum]) AS INT)														AS [Anzahl Tage Zahlungsfrist]
	  ,CAST(DATEDIFF(DAY,[Buchungsdatum], [Skontodatum]) AS INT)												AS [Anzahl Tage Rabattperiode]
	  ,CAST(IIF([Offen] = 1, 1, 0) AS INT)																			AS [Anzahl offene Posten] 
	  ,CAST(IIF([Offen] = 0, 1, 0) AS INT)																			AS [Anzahl geschlossener Posten] 
	  ,CAST(1 AS INT)																								AS [Anzahl Posten] 
	  --detailierte Debitorenposten
      ,[Betrag (MW)]
	  ,[Sollbetrag (MW)]
	  ,[Habenbetrag (MW)]
      ,[Letztes Zahlungsdatum]
      ,[Offener Betrag (MW)]
      ,[Betrag Zahlungsrabatt (MW)]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
      ,[Betrag inkl. MwSt. (MW)]
	  ,[Betrag]
	  ,[Sollbetrag]
	  ,[Habenbetrag]
      ,[Offener Betrag]
      ,[Betrag Zahlungsrabatt]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt)]
      ,[Betrag inkl. MwSt.]
  FROM [fin].[fOPDebitor90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling95_2_Auftrag]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fEinkaufscontrolling95_2_Auftrag





























CREATE view [ein].[fEinkaufscontrolling95_2_Auftrag] AS 
SELECT [vv].[vBC_t0000038_Einkaufsbelegkopf].[Mandant Code]
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Belegnummer]
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Belegart]
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Buchungsdatum]
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Belegdatum]
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Währung Code]
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Währungsfaktor]
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Einkäufer Code]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Storno]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Status]    		 
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Lagerort Code]    		
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Auftragsdatum]    			
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Fälligkeitsdatum]    				
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Gewünschtes Anlieferungsdatum]   				
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Kauf von Kontakt]  
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Kauf von Kontaktnummer]
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Beschreibung]    	   				
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Zahlungsrabatt %]    	
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Skontodatum]    	
      ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Zlg.-Bedingungscode]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Kreditor Rechnungsnummer]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Kreditor Bestellnummer]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Kreditor Liefernummer]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Zuständigkeitseinheiten Code]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Lieferbedingungscode]		
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Rabattwert]	
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Berechnungsart Rabatt]
	  ,[vv].[vBC_t0000038_Einkaufsbelegkopf].[Bundesland]
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[EK-Preis ohne MwSt.]		
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Menge akt. Rechnung]		
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Menge akt. Lieferung]		
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Bereits gelieferte Menge]		
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Bereits berechnete Menge] 
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Lagerplatz Code]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Zeilennummer]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Anlieferungsdatum Zugesagt]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Menge]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Kauf von Kreditornummer]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Kostenstellencode]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Kostenträgercode]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Produktart]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Produktnummer]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Zeilenrabattbetrag]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Betrag]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Zahlung an Kreditornummer]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Rechnungsrabattbetrag]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Zeilenbetrag]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Restauftragsbetrag]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Restauftragsmenge]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Einkaufspreis (MW)]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Menge (Basis)]
      ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Einstandspreis]
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Einheitencode]    	
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Geplantes Anlieferungsdatum]   	
	  ,[vv].[vBC_t0000039_Einkaufsbelegzeile].[Dimension Set ID]
  FROM [vv].[vBC_t0000038_Einkaufsbelegkopf]

LEFT JOIN [vv].[vBC_t0000039_Einkaufsbelegzeile]
ON	[vv].[vBC_t0000038_Einkaufsbelegkopf].[Mandant Code]				= [vv].[vBC_t0000039_Einkaufsbelegzeile].[Mandant Code]
AND	[vv].[vBC_t0000038_Einkaufsbelegkopf].[Belegnummer]	= [vv].[vBC_t0000039_Einkaufsbelegzeile].[Belegnummer]
AND	[vv].[vBC_t0000038_Einkaufsbelegkopf].[Belegart]		= [vv].[vBC_t0000039_Einkaufsbelegzeile].[Belegart]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenträger85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenträger85_2_CONCAT












CREATE VIEW [dim].[dKostenträger85_2_CONCAT] AS
SELECT [Kostenträgerbezeichnung]
      ,[Kostenträger Code]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
      ,[Sortierreihenfolge]
	  ,CAST(ISNULL([Kostenträgerbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Kostenträger Code] AS NVARCHAR(20)) + '')'' AS [Kostenträgerbezeichnung (Code)]
      ,CAST(ISNULL([Kostenträger Code],'''') AS NVARCHAR(20)) + '' '' + CAST([Kostenträgerbezeichnung] AS NVARCHAR(100)) AS [Kostenträger Code Bezeichnung]
	  ,[Mandant Code] +''_''+ [Kostenträger Code] AS [PK dKostenträger]
  FROM [dim].[dKostenträger90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenart90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenart90_2

















CREATE VIEW [dim].[dKostenart90_2] AS
SELECT [Kostenartbezeichnung]
      ,[Kostenartnummer]
      ,[Kostenstelle Code]
	  ,[Kostenstellenbezeichnung]
      ,[Kostenträger Code]
	  ,[Kostenträgerbezeichnung]
      ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
  FROM [dim].[dKostenart95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenträger]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenträger




















CREATE VIEW  [dim].[dKostenträger] AS
SELECT [Kostenträgerbezeichnung]
      ,[Kostenträger Code]
      ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
	  ,[Sortierreihenfolge]
	  ,[Kostenträgerbezeichnung (Code)]
	  ,[Kostenträger Code Bezeichnung]
	  ,[PK dKostenträger]
  FROM [dim].[dKostenträger85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vSNCt_Fälligkeitsklasse]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vSNCt_Fälligkeitsklasse


















CREATE VIEW [vv].[vSNCt_Fälligkeitsklasse] AS
SELECT [Fälligkeitsklasse Code]				AS [Fälligkeitsklasse Code]							-- Fälligkeitsklasse Code
      ,[Fälligkeitsklasse Start]			AS [Fälligkeitsklasse Start]						-- Fälligkeitsklasse untere Grenze
      ,[Fälligkeitsklasse Ende]					AS [Fälligkeitsklasse Ende]							-- Fälligkeitsklasse obere Grenze
	  ,[Fälligkeitsklassenbezeichnung DE]		AS [Fälligkeitsklassenbezeichnung DE]				-- Fälligkeitsklasse deutsche Bezeichnung
	  ,[Fälligkeitsklassenbezeichnung EN]		AS [Fälligkeitsklassenbezeichnung EN]				-- Fälligkeitsklasse englische Bezeichnung
	  ,[Fällgkeitskategoriebezeichnung DE]	AS [Fälligkeitskategorienbezeichnung DE]			-- Fälligkeits Kategorie deutsche Bezeichnung
	  ,[Fälligkeitskategoriebezeichnung EN]	AS [Fälligkeitskategorienbezeichnung EN]			-- Fälligkeits Kategorie englische Bezeichnung
  FROM [control].[SNCt_Fälligkeitsklasse]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dFälligkeitsklasse95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dFälligkeitsklasse95_2





















CREATE VIEW [dim].[dFälligkeitsklasse95_2] AS
SELECT [Fälligkeitsklasse Code]
	  ,CAST(REPLACE(REPLACE([Fälligkeitsklassenbezeichnung DE],''%1'',ABS(ISNULL([Fälligkeitsklasse Start],0))),''%2'',ABS(ISNULL([Fälligkeitsklasse Ende],0))) AS NVARCHAR(50)) AS [Fälligkeitsklassenbezeichnung DE]
	  ,CAST(REPLACE(REPLACE([Fälligkeitsklassenbezeichnung EN],''%1'',ABS(ISNULL([Fälligkeitsklasse Start],0))),''%2'',ABS(ISNULL([Fälligkeitsklasse Ende],0))) AS NVARCHAR(50)) AS [Fälligkeitsklassenbezeichnung EN]
      ,[Fälligkeitsklasse Start]
      ,[Fälligkeitsklasse Ende]
	  ,[Fälligkeitskategorienbezeichnung DE]
	  ,[Fälligkeitskategorienbezeichnung EN]
  FROM [vv].[vSNCt_Fälligkeitsklasse]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenstelle95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenstelle95_2





















CREATE VIEW [dim].[dKostenstelle95_2] AS 
SELECT [vv].[vBC_t0001112_Kostenstelle].[Kostenstellenbezeichnung]
      ,[vv].[vBC_t0001112_Kostenstelle].[Kostenstelle Code]
	  ,[vv].[vBC_t0001112_Kostenstelle].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'') AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')	 AS [Gesperrtbezeichnung EN]
      ,[vv].[vBC_t0001112_Kostenstelle].[Mandant Code]
      ,[vv].[vBC_t0001112_Kostenstelle].[Zuständige Person]
      ,[vv].[vBC_t0001112_Kostenstelle].[Sortierreihenfolge]
	  ,[vv].[vBC_t0001112_Kostenstelle].[Kostenunterart Code]
	  ,ISNULL([Kostenunterartbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'') AS [Kostenunterartbezeichnung DE]
	  ,ISNULL([Kostenunterartbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')	  AS [Kostenunterartbezeichnung EN]
  FROM [vv].[vBC_t0001112_Kostenstelle]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vBC_t0001112_Kostenstelle].[Gesperrt Code]  = [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]		= ''Global''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]	= ''Gesperrtbezeichnung''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Kostenunterartbezeichnung]
  ON [vBC_t0001112_Kostenstelle].[Kostenunterart Code]  = [Kostenunterartbezeichnung].[Optionsfeld Code]
  AND [Kostenunterartbezeichnung].[Tabellenname]		 = ''BC_t0001112_Cost_Center''
  AND [Kostenunterartbezeichnung].[Spaltenbezeichnung]			 = ''Cost Subtype Description''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dFälligkeitsklasse90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dFälligkeitsklasse90_2





















CREATE VIEW [dim].[dFälligkeitsklasse90_2] AS
SELECT [Fälligkeitsklasse Code]
      ,[Fälligkeitsklasse Start]
      ,[Fälligkeitsklasse Ende]
	  ,[Fälligkeitsklassenbezeichnung DE]
	  ,[Fälligkeitsklassenbezeichnung EN]
	  ,[Fälligkeitskategorienbezeichnung DE]
	  ,[Fälligkeitskategorienbezeichnung EN]
  FROM [dim].[dFälligkeitsklasse95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dFälligkeitsklasse85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dFälligkeitsklasse85_2_CONCAT























CREATE VIEW [dim].[dFälligkeitsklasse85_2_CONCAT] AS
SELECT [Fälligkeitsklasse Code]
      ,[Fälligkeitsklasse Start]
      ,[Fälligkeitsklasse Ende]
	  ,[Fälligkeitsklassenbezeichnung DE]
	  ,[Fälligkeitsklassenbezeichnung EN]
	  ,[Fälligkeitskategorienbezeichnung DE]
	  ,[Fälligkeitskategorienbezeichnung EN]
	  ,[Fälligkeitsklasse Code] AS [PK dFälligkeitsklasse]
  FROM [dim].[dFälligkeitsklasse90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005109_Einkaufskopfarchiv95_2]'))
EXEC dbo.sp_executesql @statement = N'


-- Alter View vBC_t0005109_Einkaufskopfarchiv95_2

























CREATE VIEW [vv].[vBC_t0005109_Einkaufskopfarchiv95_2]

AS

SELECT [SG_MandantCode]			        	AS [Mandant Code]						-- Mandant ID		
      ,[Document Type]						AS [Belegart]							-- Belegart
      ,[No_]								AS [Belegnummer]						-- Belegnummer
      ,[Doc_ No_ Occurrence]				AS [Belegnummer Häufigkeit]				-- Belegnummer Häufgkeit
      ,[Version No_]						AS [Versionsnummer]						-- Versionsnummer
      ,[Buy-from Vendor No_]				AS [Kauf von Kreditornummer]			-- Kauf von Kreditornummer
      ,[Pay-to Vendor No_]					AS [Zahlung an Kreditornummer]			-- Zahlung an Kreditornummer
	  ,[Posting Date]						AS [Buchungsdatum]						-- Buchungsdatum
      ,[Currency Code]						AS [Währung Code]						-- Währungscode
      ,[Currency Factor]					AS [Währungsfaktor]					-- Währungsfaktor
      ,[Purchaser Code]						AS [Einkäufer Code]						-- Einkäufercode
      ,[Document Date]						AS [Belegdatum]							-- Belegdatum
      ,[Promised Receipt Date]				AS [Anlieferungsdatum Zugesagt]			-- Anlieferungsdatum Zugesagt
	  ,[Correction]				         	AS [Storno]								-- Storno
      ,[Order Date]							AS [Auftragsdatum]						-- Auftragsdatum
      ,[Due Date]							AS [Fälligkeitsdatum]					-- Fälligkeitsdatum
      ,[Requested Receipt Date]				AS [Gewünschtes Anlieferungsdatum]		-- gewünschtes Anlieferungsdatum
      ,[Status]								AS [Status]								-- Status
      ,[Buy-from Contact]					AS [Kauf von Kontakt]							-- Kontakt
	  ,[Buy-from Contact No_]				AS [Kauf von Kontaktnummer]				-- Kauf von Kontakt Nr.
      ,[Posting Description]				AS [Buchungsbeschreibung]						-- Beschreibung
      ,[Location Code]						AS [Lagerort Code]						-- Lagerort Code  
      ,[Payment Discount _]					AS [Skonto]								-- Skonto
      ,[Pmt_ Discount Date]					AS [Skontodatum]						-- Skontodatum
      ,[Payment Terms Code]					AS [Zahlungsbedingungscode]				-- Zahlungsbedingungscode
	  ,[SG_Bundesland]							AS [Bundesland]							-- Bundesland
	  ,[Vendor Invoice No_]					AS [Kreditor Rechnungsnummer]			-- Kreditor Rechnungsnummer
	  ,[Vendor Order No_]					AS [Kreditor Bestellnummer]				-- Kreditor Bestellnummer
	  ,[Vendor Shipment No_]				AS [Kreditor Liefernummer]				-- Kreditor Liefernummer
	  ,[Responsibility Center]				AS [Zuständigkeitseinheiten Code]		-- Zuständigkeitseinheiten Code
	  ,[VAT Bus_ Posting Group]				AS [MwSt.-Geschäftsbuchungsgruppe Code]	-- MwSt.-Geschäftsbuchungsgruppe Code
	  ,[Shipment Method Code]				AS [Lieferbedingungscode]				-- Lieferbedinungscode
	  ,[Invoice Discount Value]				AS [Rabattwert]							-- Rabattwert
	  ,[Invoice Discount Calculation]		AS [Berechnungsart Rabatt]				-- Berechnungsart Rabatt
  FROM [ein].[BC_t0005109_Purchase_Header_Archive]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005109_Einkaufskopfarchiv]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005109_Einkaufskopfarchiv





CREATE VIEW [vv].[vBC_t0005109_Einkaufskopfarchiv] AS
SELECT [Mandant Code]
      ,[Belegart]
      ,[Belegnummer]
      ,[Belegnummer Häufigkeit]
      ,[Versionsnummer]
      ,[Kauf von Kreditornummer]
      ,[Zahlung an Kreditornummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])			AS [Buchungsdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])			AS [Belegdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Anlieferungsdatum Zugesagt])	AS [Anlieferungsdatum Zugesagt]
      ,[Storno]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Auftragsdatum])				AS [Auftragsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])				AS [Fälligkeitsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Gewünschtes Anlieferungsdatum])	AS [Gewünschtes Anlieferungsdatum]
      ,[Status]
      ,[Kauf von Kontakt]
      ,[Kauf von Kontaktnummer]
      ,[Buchungsbeschreibung]
      ,[Lagerort Code]
      ,[Skonto]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])		AS [Skontodatum]
      ,[Zahlungsbedingungscode]
      ,[Bundesland]
      ,[Kreditor Rechnungsnummer]
      ,[Kreditor Bestellnummer]
      ,[Kreditor Liefernummer]
      ,[Zuständigkeitseinheiten Code]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
      ,[Lieferbedingungscode]
      ,[Rabattwert]
      ,[Berechnungsart Rabatt]
  FROM [vv].[vBC_t0005109_Einkaufskopfarchiv95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dFälligkeitsklasse]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dFälligkeitsklasse























CREATE VIEW [dim].[dFälligkeitsklasse] AS
SELECT [Fälligkeitsklasse Code]
      ,[Fälligkeitsklasse Start]
      ,[Fälligkeitsklasse Ende]
      ,[Fälligkeitsklassenbezeichnung DE]
      ,[Fälligkeitsklassenbezeichnung EN]
	  ,[Fälligkeitskategorienbezeichnung DE]
	  ,[Fälligkeitskategorienbezeichnung EN]
	  ,[PK dFälligkeitsklasse]
  FROM [dim].[dFälligkeitsklasse85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005110_Einkaufszeilenarchiv95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005110_Einkaufszeilenarchiv95_2
























CREATE VIEW [vv].[vBC_t0005110_Einkaufszeilenarchiv95_2]

AS

SELECT [SG_MandantCode]					AS [Mandant Code]												-- Mandant ID
      ,[Document Type]					AS [Belegart]													-- Belegart
      ,[Document No_]					AS [Belegnummer]												-- Belegnummer
      ,[Doc_ No_ Occurrence]			AS [Belegnummer Häufigkeit]										-- Belegnummer Häufgkeit
      ,[Version No_]					AS [Versionsnummer]												-- Versionsnummer
      ,[Line No_]						AS [Zeilennummer]												-- Zeilennummer
      ,[Buy-from Vendor No_]			AS [Einkauf bei Kreditor Code]									-- Einkauf bei Kreditor Code
      ,[Type]							AS [Produktart]													-- Produktart
      ,[No_]							AS [Produktnummer]												-- Produktnummer
      ,[Quantity]						AS [Menge]														-- Menge
      ,[Outstanding Quantity]			AS [Restauftragsmenge]											-- Restauftragsmenge
      ,[Unit Price (LCY)]				AS [Einkaufsspreis]												-- Einkaufsspreis
      ,[Line Discount Amount]			AS [Zeilenrabattbetrag]											-- Zeilenrabattbetrag
      ,[Amount]							AS [Betrag]														-- Betrag
      ,[Outstanding Amount]				AS [Restauftragsbetrag]											-- Restauftragsbetrag
      ,[Pay-to Vendor No_]				AS [Zahlung an Kreditornummer]									-- Zahlung an Kreditornummer
      ,[Inv_ Discount Amount]			AS [Rechnungsrabattbetrag]										-- Rechnungsrabattbetrag
      ,[Line Amount]					AS [Zeilenbetrag]												-- Zeilenbetrag
      ,[Quantity (Base)]				AS [Menge (Basis)]												-- Menge (Basis)
      ,[Promised Receipt Date]			AS [Anlieferungsdatum Zugesagt]									-- Anlieferungsdatum Zugesagt
      ,[Shortcut Dimension 1 Code]		AS [Kostenstellencode]											-- Kostenstellencode
      ,[Shortcut Dimension 2 Code]		AS [Kostenträgercode]											-- Kostenträgercode
      ,[Unit Cost]						AS [Einstandspreis]												-- Einstandspreis
      ,[Location Code]					AS [Lagerort Code]												-- Lagerort Code
      ,[Requested Receipt Date]			AS [Gewünschtes Warenausgangsdatum]								-- Gewünschtes Warenausgangsdatum
      ,[Description]					AS [Beschreibung]												-- Beschreibung
      ,[Unit of Measure Code]			AS [Einheitencode]												-- Einheitencode
      ,[Planned Receipt Date]			AS [Geplantes Anlieferungsdatum]								-- geplantes Anlieferungsdatum
      ,[Dimension Set ID]				AS [Dimension Set ID]	-- Dimension Set ID Link zur Tabelle [Dimension Set Entry]
	  ,[SG_Bundesland]						AS [Bundesland]													-- Bundeland
	  ,[Bin Code]						AS [Lagerplatz Code]											-- Lagerplatzcode
	  ,[Responsibility Center]			AS [Zuständigkeitseinheiten Code]								-- Zuständigkeitseinheiten Code
	  ,[VAT Bus_ Posting Group]			AS [MwSt.-Geschäftsbuchungsgruppe Code]							-- MwSt.-Geschäftsbuchungsgruppe Code
	  ,[Direct Unit Cost]			    AS [EK-Preis ohne MwSt.]											-- [Direct Unit Cost]
	  ,[Qty_ to Invoice]			    AS [Menge akt. Rechnung]										-- Menge akt. Rechnung
	  ,[Qty_ to Receive]			    AS [Menge akt. Lieferung]										-- Menge akt. Lieferung
	  ,[Quantity Received]			    AS [Bereits gelieferte Menge]									-- Bereits gelieferte Menge
	  ,[Quantity Invoiced]			    AS [Bereits berechnete Menge] 									-- Bereits berechnete Menge
  FROM [ein].[BC_t0005110_Purchase_Line_Archive]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005110_Einkaufszeilenarchiv]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005110_Einkaufszeilenarchiv



CREATE VIEW [vv].[vBC_t0005110_Einkaufszeilenarchiv] AS
SELECT [Mandant Code]
      ,[Belegart]
      ,[Belegnummer]
      ,[Belegnummer Häufigkeit]
      ,[Versionsnummer]
      ,[Zeilennummer]
      ,[Einkauf bei Kreditor Code]
      ,[Produktart]
      ,[Produktnummer]
      ,[Menge]
      ,[Restauftragsmenge]
      ,[Einkaufsspreis]
      ,[Zeilenrabattbetrag]
      ,[Betrag]
      ,[Restauftragsbetrag]
      ,[Zahlung an Kreditornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Anlieferungsdatum Zugesagt])			AS [Anlieferungsdatum Zugesagt]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Einstandspreis]
      ,[Lagerort Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Gewünschtes Warenausgangsdatum])			AS [Gewünschtes Warenausgangsdatum]
      ,[Beschreibung]
      ,[Einheitencode]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Geplantes Anlieferungsdatum])			AS [Geplantes Anlieferungsdatum]
      ,[Dimension Set ID]
      ,[Bundesland]
      ,[Lagerplatz Code]
      ,[Zuständigkeitseinheiten Code]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
      ,[EK-Preis ohne MwSt.]
      ,[Menge akt. Rechnung]
      ,[Menge akt. Lieferung]
      ,[Bereits gelieferte Menge]
      ,[Bereits berechnete Menge]
  FROM [vv].[vBC_t0005110_Einkaufszeilenarchiv95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vSNCt_Altersstruktur]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vSNCt_Altersstruktur















CREATE VIEW [vv].[vSNCt_Altersstruktur] AS
SELECT [Altersstruktur Code]				AS [Altersstruktur Code]						-- Altersstruktur Code
      ,[Altersstruktur Start]			AS [Altersstruktur Start]				-- Altersstruktur untere Grenze
      ,[Altersstruktur Ende]				AS [Altersstruktur Ende]				-- Altersstruktur obere Grenze
	  ,[Altersstrukturbezeichnung DE]	AS [Altersstrukturbezeichnung DE]		-- Altersstruktur deutsche Bezeichnung 
	  ,[Altersstrukturbezeichnung EN]	AS [Altersstrukturbezeichnung EN]		-- Altersstruktur englische Bezeichnug
  FROM [control].[SNCt_Altersstruktur]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dAltersstruktur95_2]'))
EXEC dbo.sp_executesql @statement = N'



























CREATE VIEW [dim].[dAltersstruktur95_2] AS
SELECT [Altersstruktur Code]
	  ,CAST(REPLACE(REPLACE([Altersstrukturbezeichnung DE],''%1'',ABS(ISNULL([Altersstruktur Start],0))),''%2'',ABS(ISNULL([Altersstruktur Ende],0))) AS NVARCHAR(50)) AS [Altersstrukturbezeichnung DE]
	  ,CAST(REPLACE(REPLACE([Altersstrukturbezeichnung EN],''%1'',ABS(ISNULL([Altersstruktur Start],0))),''%2'',ABS(ISNULL([Altersstruktur Ende],0))) AS NVARCHAR(50)) AS [Altersstrukturbezeichnung EN]
      ,[Altersstruktur Start]
      ,[Altersstruktur Ende]
  FROM [vv].[vSNCt_Altersstruktur]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling95_2_Archiv]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fEinkaufscontrolling95_2_Archiv




























CREATE view [ein].[fEinkaufscontrolling95_2_Archiv] AS 
SELECT [vv].[vBC_t0005109_Einkaufskopfarchiv].[Mandant Code]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Belegnummer]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Belegart]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Versionsnummer]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Belegnummer Häufigkeit]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Buchungsdatum]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Belegdatum]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Währung Code]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Währungsfaktor]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Einkäufer Code]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Storno]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Auftragsdatum]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Fälligkeitsdatum]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Gewünschtes Anlieferungsdatum]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Status]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Kauf von Kontakt]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Kauf von Kontaktnummer]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Buchungsbeschreibung]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Lagerort Code]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Skonto]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Skontodatum]
      ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Zahlungsbedingungscode]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Kreditor Rechnungsnummer]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Kreditor Bestellnummer]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Kreditor Liefernummer]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Zuständigkeitseinheiten Code]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Lieferbedingungscode]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Rabattwert]	
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Berechnungsart Rabatt]
	  ,[vv].[vBC_t0005109_Einkaufskopfarchiv].[Bundesland]
	  ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[EK-Preis ohne MwSt.]		
	  ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Menge akt. Rechnung]		
	  ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Menge akt. Lieferung]		
	  ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Bereits gelieferte Menge]		
	  ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Bereits berechnete Menge] 
	  ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Lagerplatz Code]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Zeilennummer]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Anlieferungsdatum Zugesagt]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Menge]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Einkauf bei Kreditor Code]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Kostenstellencode]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Kostenträgercode]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Produktart]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Produktnummer]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Zeilenrabattbetrag]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Betrag]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Zahlung an Kreditornummer]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Rechnungsrabattbetrag]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Zeilenbetrag]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Restauftragsbetrag]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Restauftragsmenge]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Einkaufsspreis]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Menge (Basis)]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Einstandspreis]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Beschreibung]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Einheitencode]
      ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Geplantes Anlieferungsdatum]
	  ,[vv].[vBC_t0005110_Einkaufszeilenarchiv].[Dimension Set ID]
  FROM [vv].[vBC_t0005109_Einkaufskopfarchiv]

LEFT JOIN [vv].[vBC_t0005110_Einkaufszeilenarchiv]
ON	[vv].[vBC_t0005109_Einkaufskopfarchiv].[Mandant Code]						= [vv].[vBC_t0005110_Einkaufszeilenarchiv].[Mandant Code]
AND	[vv].[vBC_t0005109_Einkaufskopfarchiv].[Belegnummer]	= [vv].[vBC_t0005110_Einkaufszeilenarchiv].[Belegnummer]
AND	[vv].[vBC_t0005109_Einkaufskopfarchiv].[Belegart]				= [vv].[vBC_t0005110_Einkaufszeilenarchiv].[Belegart]
AND	[vv].[vBC_t0005109_Einkaufskopfarchiv].[Versionsnummer]						= [vv].[vBC_t0005110_Einkaufszeilenarchiv].[Versionsnummer]
AND	[vv].[vBC_t0005109_Einkaufskopfarchiv].[Belegnummer Häufigkeit]				= [vv].[vBC_t0005110_Einkaufszeilenarchiv].[Belegnummer Häufigkeit]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dAltersstruktur90_2]'))
EXEC dbo.sp_executesql @statement = N'























CREATE VIEW [dim].[dAltersstruktur90_2] AS
SELECT [Altersstruktur Code]
      ,[Altersstruktur Start]
      ,[Altersstruktur Ende]
	  ,[Altersstrukturbezeichnung DE]
      ,[Altersstrukturbezeichnung EN]
  FROM [dim].[dAltersstruktur95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling90_2_ArchivBelegAusschließen













--laut Nschuette werden bei aktuellen Belegen die archivierten Belege nicht benötigt. daher werden diese hier rausgefilter. (09.03.2020 - JW)

CREATE view [ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen] AS 
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Belegart]
  FROM [ein].[fEinkaufscontrolling95_2_Archiv]
  EXCEPT 
  SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Belegart]
  FROM [ein].[fEinkaufscontrolling95_2_Auftrag]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dAltersstruktur85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'
























CREATE VIEW [dim].[dAltersstruktur85_2_CONCAT] AS
SELECT [Altersstruktur Code]
      ,[Altersstruktur Start]
      ,[Altersstruktur Ende]
      ,[Altersstrukturbezeichnung DE]
      ,[Altersstrukturbezeichnung EN]
	  ,[Altersstruktur Code] AS [PK dAltersstruktur]
  FROM [dim].[dAltersstruktur90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling85_2_MaxVersion]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling85_2_MaxVersion






















CREATE view [ein].[fEinkaufscontrolling85_2_MaxVersion] AS 

SELECT [ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Mandant Code]
      ,[ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Belegnummer]
      ,[ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Belegart]
      ,MAX([ein].[fEinkaufscontrolling95_2_Archiv].[Belegnummer Häufigkeit]) AS [Belegnummer Häufigkeit]
      ,MAX([ein].[fEinkaufscontrolling95_2_Archiv].[Versionsnummer]) AS [Versionsnummer (Max)]
  FROM [ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen]

  LEFT JOIN [ein].[fEinkaufscontrolling95_2_Archiv]
  ON  [ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Mandant Code]					= [ein].[fEinkaufscontrolling95_2_Archiv].[Mandant Code]
  AND [ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Belegnummer]	= [ein].[fEinkaufscontrolling95_2_Archiv].[Belegnummer]
  AND [ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Belegart]			= [ein].[fEinkaufscontrolling95_2_Archiv].[Belegart]

GROUP BY   [ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Mandant Code]
          ,[ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Belegart]
		  ,[ein].[fEinkaufscontrolling90_2_ArchivBelegAusschließen].[Belegnummer]
		  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Belegnummer Häufigkeit]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dAltersstruktur]'))
EXEC dbo.sp_executesql @statement = N'
























CREATE VIEW [dim].[dAltersstruktur] AS
SELECT [Altersstruktur Code]
      ,[Altersstruktur Start]
      ,[Altersstruktur Ende]
      ,[Altersstrukturbezeichnung DE]
      ,[Altersstrukturbezeichnung EN]
      ,[PK dAltersstruktur]
  FROM [dim].[dAltersstruktur85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling80_2_ArchivMaxVersion]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling80_2_ArchivMaxVersion

























CREATE VIEW [ein].[fEinkaufscontrolling80_2_ArchivMaxVersion] AS 
SELECT [ein].[fEinkaufscontrolling95_2_Archiv].[Mandant Code]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Belegnummer]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Belegart]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Versionsnummer]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Belegnummer Häufigkeit]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Buchungsdatum]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Belegdatum]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Währung Code]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Währungsfaktor]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Einkäufer Code]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Storno]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Auftragsdatum]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Fälligkeitsdatum]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Gewünschtes Anlieferungsdatum]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Status]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Kauf von Kontakt]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Kauf von Kontaktnummer]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Buchungsbeschreibung]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Lagerort Code]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Skonto]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Skontodatum]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Zahlungsbedingungscode]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Kreditor Rechnungsnummer]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Kreditor Bestellnummer]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Kreditor Liefernummer]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Zuständigkeitseinheiten Code]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Lieferbedingungscode]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Rabattwert]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Berechnungsart Rabatt]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[EK-Preis ohne MwSt.]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Menge akt. Rechnung]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Menge akt. Lieferung]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Bereits gelieferte Menge]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Bereits berechnete Menge]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Lagerplatz Code]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Zeilennummer]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Anlieferungsdatum Zugesagt]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Menge]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Einkauf bei Kreditor Code]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Kostenstellencode]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Kostenträgercode]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Produktart]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Produktnummer]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Zeilenrabattbetrag]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Betrag]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Zahlung an Kreditornummer]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Rechnungsrabattbetrag]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Zeilenbetrag]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Restauftragsbetrag]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Restauftragsmenge]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Einkaufsspreis]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Menge (Basis)]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Einstandspreis]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Beschreibung]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Einheitencode]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Geplantes Anlieferungsdatum]
	  ,[ein].[fEinkaufscontrolling95_2_Archiv].[Dimension Set ID]
      ,[ein].[fEinkaufscontrolling95_2_Archiv].[Bundesland]
  FROM [ein].[fEinkaufscontrolling85_2_MaxVersion]

LEFT JOIN [ein].[fEinkaufscontrolling95_2_Archiv] 
ON  [ein].[fEinkaufscontrolling85_2_MaxVersion].[Mandant Code]					= [ein].[fEinkaufscontrolling95_2_Archiv].[Mandant Code]
AND [ein].[fEinkaufscontrolling85_2_MaxVersion].[Belegart]				= [ein].[fEinkaufscontrolling95_2_Archiv].[Belegart]
AND [ein].[fEinkaufscontrolling85_2_MaxVersion].[Belegnummer]	= [ein].[fEinkaufscontrolling95_2_Archiv].[Belegnummer]
AND [ein].[fEinkaufscontrolling85_2_MaxVersion].[Belegnummer Häufigkeit]				= [ein].[fEinkaufscontrolling95_2_Archiv].[Belegnummer Häufigkeit]
AND [ein].[fEinkaufscontrolling85_2_MaxVersion].[Versionsnummer (Max)]				= [ein].[fEinkaufscontrolling95_2_Archiv].[Versionsnummer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor80_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPDebitor80_2






























CREATE VIEW [fin].[fOPDebitor80_2] AS
SELECT [fin].[fOPDebitor85_2].[Debitorenposten Lfd.]
      ,[fin].[fOPDebitor85_2].[Kostenstelle Code]
      ,[fin].[fOPDebitor85_2].[Beschreibung]
      ,[fin].[fOPDebitor85_2].[Kostenträger Code]
      ,[fin].[fOPDebitor85_2].[Debitornummer]
      ,[fin].[fOPDebitor85_2].[Buchungsdatum]
      ,[fin].[fOPDebitor85_2].[Belegartcode]
      ,[fin].[fOPDebitor85_2].[Belegartbezeichnung DE]
      ,[fin].[fOPDebitor85_2].[Belegartbezeichnung EN]
      ,[fin].[fOPDebitor85_2].[Belegnummer]
      ,[fin].[fOPDebitor85_2].[Währung Code]
      ,[fin].[fOPDebitor85_2].[Rechnungsrabatt (MW)]
      ,[fin].[fOPDebitor85_2].[Verkauf an Debitornummer]
	  ,[fin].[fOPDebitor85_2].[Verkauf an Debitorbezeichnung]
      ,[fin].[fOPDebitor85_2].[Debitorenbuchungsgruppe Code]
      ,[fin].[fOPDebitor85_2].[Verkäufer Code]
      ,[fin].[fOPDebitor85_2].[Abwarten]
      ,[fin].[fOPDebitor85_2].[Ausgeglichen mit Belegart]
      ,[fin].[fOPDebitor85_2].[Ausgeglichen mit Belegnummer]
      ,[fin].[fOPDebitor85_2].[Offen]
      ,[fin].[fOPDebitor85_2].[Offenbezeichnung DE]
      ,[fin].[fOPDebitor85_2].[Offenbezeichnung EN]
      ,[fin].[fOPDebitor85_2].[Fälligkeitsdatum]
      ,[fin].[fOPDebitor85_2].[Skontodatum]
      ,[fin].[fOPDebitor85_2].[Zahlungsrabatt gewährt (MW)]
      ,[fin].[fOPDebitor85_2].[Geschlossen mit Betrag (MW)]
      ,[fin].[fOPDebitor85_2].[Belegdatum]
      ,[fin].[fOPDebitor85_2].[Externe Belegnummer]
      ,[fin].[fOPDebitor85_2].[letzte registrierte Mahnstufe]
	  ,[fin].[fOPDebitor85_2].[Mahnmethode Code]
      ,[fin].[fOPDebitor85_2].[Ausgleichposten]
      ,[fin].[fOPDebitor85_2].[storniert]
      ,[fin].[fOPDebitor85_2].[im vorraus bezahlt]
	  ,[fin].[fOPDebitor85_2].[Geschlossen von Lfd. Nr.]
      ,[fin].[fOPDebitor85_2].[Geschlossen am]
	  ,[fin].[fOPDebitor85_2].[Bilanzkontotyp]
	  ,[fin].[fOPDebitor85_2].[Bilanzkontotypbezeichnung  DE]
	  ,[fin].[fOPDebitor85_2].[Bilanzkontotypbezeichnung  EN]
	  ,[fin].[fOPDebitor85_2].[Ursache Code]
	  ,[fin].[fOPDebitor85_2].[Ursachenbezeichnung]
	  ,[fin].[fOPDebitor85_2].[Gehört zu ID]
	  ,[fin].[fOPDebitor85_2].[Skontotoleranzdatum]
	  ,[fin].[fOPDebitor85_2].[Zahlungsbedingung Code]
      ,[fin].[fOPDebitor85_2].[Mandant Code]
      ,[fin].[fOPDebitor85_2].[Bundesland]
	  ,[fin].[fOPDebitor85_2].[Zahlungsbedingung Code (Rechnung)]
	  ,[fin].[fOPDebitor85_2].[Alter offener Posten]
	  ,[dim].[dAltersstruktur].[Altersstruktur Code]
	  ,[dim].[dFälligkeitsklasse].[Fälligkeitsklasse Code]
	  ,[fin].[fOPDebitor85_2].[Berechnungsdatum]
	  ,[fin].[fOPDebitor85_2].[Anzahl Tage fällig]
      ,[fin].[fOPDebitor85_2].[Anzahl Tage letzte Zahlung]
      ,[fin].[fOPDebitor85_2].[Anzahl Tage Zahlungsdauer]
      ,[fin].[fOPDebitor85_2].[Anzahl Tage Zahlungsfrist]
      ,[fin].[fOPDebitor85_2].[Anzahl Tage Rabattperiode]
      ,[fin].[fOPDebitor85_2].[Anzahl offene Posten]
      ,[fin].[fOPDebitor85_2].[Anzahl geschlossener Posten]
      ,[fin].[fOPDebitor85_2].[Anzahl Posten]
      ,[fin].[fOPDebitor85_2].[Betrag (MW)]
	  ,[fin].[fOPDebitor85_2].[Sollbetrag (MW)]
	  ,[fin].[fOPDebitor85_2].[Habenbetrag (MW)]
      ,[fin].[fOPDebitor85_2].[Letztes Zahlungsdatum]
      ,[fin].[fOPDebitor85_2].[Offener Betrag (MW)]
      ,[fin].[fOPDebitor85_2].[Betrag Zahlungsrabatt (MW)]
      ,[fin].[fOPDebitor85_2].[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
      ,[fin].[fOPDebitor85_2].[Betrag inkl. MwSt. (MW)]
      ,[fin].[fOPDebitor85_2].[Betrag]
	  ,[fin].[fOPDebitor85_2].[Sollbetrag]
	  ,[fin].[fOPDebitor85_2].[Habenbetrag]
      ,[fin].[fOPDebitor85_2].[Offener Betrag]
      ,[fin].[fOPDebitor85_2].[Betrag Zahlungsrabatt]
      ,[fin].[fOPDebitor85_2].[Betrag Zahlungsrabatt (ungerechtfertigt)]
      ,[fin].[fOPDebitor85_2].[Betrag inkl. MwSt.]
  FROM [fin].[fOPDebitor85_2]

  --Strukturanbindung
  --in der Altersttruktur haben wir negative Grenzen, daher muss auch Start und Ende vertauscht werden
  LEFT JOIN [dim].[dAltersstruktur]
  ON [fin].[fOPDebitor85_2].[Alter offener Posten] BETWEEN [dim].[dAltersstruktur].[Altersstruktur Ende] AND [dim].[dAltersstruktur].[Altersstruktur Start]

  LEFT JOIN [dim].[dFälligkeitsklasse]
  ON [fin].[fOPDebitor85_2].[Anzahl Tage fällig] BETWEEN [dim].[dFälligkeitsklasse].[Fälligkeitsklasse Start] AND [dim].[dFälligkeitsklasse].[Fälligkeitsklasse Ende]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenart85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenart85_2_CONCAT













CREATE VIEW [dim].[dKostenart85_2_CONCAT] AS
SELECT [Kostenartbezeichnung]
      ,[Kostenartnummer]
      ,[Kostenstelle Code]
	  ,[Kostenstellenbezeichnung]
      ,[Kostenträger Code]
	  ,[Kostenträgerbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
	  ,CAST(ISNULL([Kostenartbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Kostenartnummer] AS NVARCHAR(20)) + '')'' AS [Kostenartbezeichnung (Nummer)]
      ,CAST(ISNULL([Kostenartnummer],'''') AS NVARCHAR(20)) + '' '' + CAST([Kostenartbezeichnung] AS NVARCHAR(100)) AS [Kostenartnummer Bezeichnung]
	  ,[Mandant Code] +''_''+ [Kostenartnummer] AS [PK dKostenart]
  FROM [dim].[dKostenart90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor75_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fOPDebitor75_2_CONCAT


CREATE VIEW [fin].[fOPDebitor75_2_CONCAT] AS
SELECT [Debitorenposten Lfd.]
      ,[Kostenstelle Code]
      ,[Beschreibung]
      ,[Kostenträger Code]
      ,[Debitornummer]
      ,[Buchungsdatum]
      ,[Belegartcode]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Rechnungsrabatt (MW)]
      ,[Verkauf an Debitornummer]
      ,[Verkauf an Debitorbezeichnung]
      ,[Debitorenbuchungsgruppe Code]
      ,[Verkäufer Code]
      ,[Abwarten]
      ,[Ausgeglichen mit Belegart]
      ,[Ausgeglichen mit Belegnummer]
      ,[Offen]
      ,[Offenbezeichnung DE]
      ,[Offenbezeichnung EN]
      ,[Fälligkeitsdatum]
      ,[Skontodatum]
      ,[Zahlungsrabatt gewährt (MW)]
      ,[Geschlossen mit Betrag (MW)]
      ,[Belegdatum]
      ,[Externe Belegnummer]
      ,[letzte registrierte Mahnstufe]
      ,[Mahnmethode Code]
      ,[Ausgleichposten]
      ,[storniert]
      ,[im vorraus bezahlt]
      ,[Geschlossen von Lfd. Nr.]
      ,[Geschlossen am]
      ,[Bilanzkontotyp]
      ,[Bilanzkontotypbezeichnung  DE]
      ,[Bilanzkontotypbezeichnung  EN]
      ,[Ursache Code]
      ,[Ursachenbezeichnung]
      ,[Gehört zu ID]
      ,[Skontotoleranzdatum]
      ,[Zahlungsbedingung Code]
      ,[Mandant Code]
      ,[Bundesland]
      ,[Zahlungsbedingung Code (Rechnung)]
      ,[Alter offener Posten]
      ,[Altersstruktur Code]
      ,[Fälligkeitsklasse Code]
      ,[Berechnungsdatum]
      ,[Anzahl Tage fällig]
      ,[Anzahl Tage letzte Zahlung]
      ,[Anzahl Tage Zahlungsdauer]
      ,[Anzahl Tage Zahlungsfrist]
      ,[Anzahl Tage Rabattperiode]
      ,[Anzahl offene Posten]
      ,[Anzahl geschlossener Posten]
      ,[Anzahl Posten]
      ,[Betrag (MW)]
      ,[Sollbetrag (MW)]
      ,[Habenbetrag (MW)]
      ,[Letztes Zahlungsdatum]
      ,[Offener Betrag (MW)]
      ,[Betrag Zahlungsrabatt (MW)]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
      ,[Betrag inkl. MwSt. (MW)]
      ,[Betrag]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Offener Betrag]
      ,[Betrag Zahlungsrabatt]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt)]
      ,[Betrag inkl. MwSt.]
	  --PK for PowerBI
	  ,[Mandant Code]																									AS [PK dMandant]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenstelle Code],''NULL'')															AS [PK dKostenstelleDimension]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenträger Code],''NULL'')															AS [PK dKostenträgerDimension]
	  ,[Mandant Code] +''_''+ ISNULL([Debitornummer],''NULL'')																AS [PK dDebitor]
	  ,[Mandant Code] +''_''+ ISNULL([Zahlungsbedingung Code (Rechnung)],''NULL'')												AS [PK dZahlungsbedingungen]
	  ,[Mandant Code] +''_''+ ISNULL(CONVERT(NVARCHAR(1),[letzte registrierte Mahnstufe]),''NULL'') +''_''+ ISNULL([Mahnmethode Code],''NULL'')		AS [PK dMahnstufe]
	  ,[Mandant Code] +''_''+ ISNULL([Verkäufer Code],''NULL'')															AS [PK dSalesperson]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Buchungsdatum],21),''NULL'')												AS [PK dZeit (Buchungsdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Belegdatum],21),''NULL'')											AS [PK dZeit (Belegdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Fälligkeitsdatum],21),''NULL'')													AS [PK dZeit (Fälligkeitsdatum)]
	  ,ISNULL([Altersstruktur Code],''NULL'')																				AS [PK dAltersstruktur]
	  ,ISNULL([Fälligkeitsklasse Code],''NULL'')																				AS [PK dFälligkeitsklasse]
  FROM [fin].[fOPDebitor80_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Baum]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung75_2_Baum



















CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Baum] AS
SELECT DISTINCT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Ist Blattknoten]
      ,[Zusammenzählung Start]
      ,[Zusammenzählung Ende]
      ,[Zusammenzählungstyp]
      ,[Umkehr Code]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung80_2]
  --nur die Struktur Elemente, keine Blattknoten
  WHERE [Ist Blattknoten] = ''FALSE''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPDebitor]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fOPDebitor



























CREATE VIEW [fin].[fOPDebitor] AS
SELECT [Debitorenposten Lfd.]
      ,[Kostenstelle Code]
      ,[Beschreibung]
      ,[Kostenträger Code]
      ,[Debitornummer]
      ,[Buchungsdatum]
      ,[Belegartcode]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Rechnungsrabatt (MW)]
      ,[Verkauf an Debitornummer]
      ,[Verkauf an Debitorbezeichnung]
      ,[Debitorenbuchungsgruppe Code]
      ,[Verkäufer Code]
      ,[Abwarten]
      ,[Ausgeglichen mit Belegart]
      ,[Ausgeglichen mit Belegnummer]
      ,[Offen]
      ,[Offenbezeichnung DE]
      ,[Offenbezeichnung EN]
      ,[Fälligkeitsdatum]
      ,[Skontodatum]
      ,[Zahlungsrabatt gewährt (MW)]
      ,[Geschlossen mit Betrag (MW)]
      ,[Belegdatum]
      ,[Externe Belegnummer]
      ,[letzte registrierte Mahnstufe]
      ,[Mahnmethode Code]
      ,[Ausgleichposten]
      ,[storniert]
      ,[im vorraus bezahlt]
      ,[Geschlossen von Lfd. Nr.]
      ,[Geschlossen am]
      ,[Bilanzkontotyp]
      ,[Bilanzkontotypbezeichnung  DE]
      ,[Bilanzkontotypbezeichnung  EN]
      ,[Ursache Code]
      ,[Ursachenbezeichnung]
      ,[Gehört zu ID]
      ,[Skontotoleranzdatum]
      ,[Zahlungsbedingung Code]
      ,[Mandant Code]
      ,[Bundesland]
      ,[Zahlungsbedingung Code (Rechnung)]
      ,[Alter offener Posten]
      ,[Altersstruktur Code]
      ,[Fälligkeitsklasse Code]
      ,[Berechnungsdatum]
      ,[Anzahl Tage fällig]
      ,[Anzahl Tage letzte Zahlung]
      ,[Anzahl Tage Zahlungsdauer]
      ,[Anzahl Tage Zahlungsfrist]
      ,[Anzahl Tage Rabattperiode]
      ,[Anzahl offene Posten]
      ,[Anzahl geschlossener Posten]
      ,[Anzahl Posten]
      ,[Betrag (MW)]
      ,[Sollbetrag (MW)]
      ,[Habenbetrag (MW)]
      ,[Letztes Zahlungsdatum]
      ,[Offener Betrag (MW)]
      ,[Betrag Zahlungsrabatt (MW)]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
      ,[Betrag inkl. MwSt. (MW)]
      ,[Betrag]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Offener Betrag]
      ,[Betrag Zahlungsrabatt]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt)]
      ,[Betrag inkl. MwSt.]
      ,[PK dMandant]
      ,[PK dKostenstelleDimension]
      ,[PK dKostenträgerDimension]
      ,[PK dDebitor]
      ,[PK dZahlungsbedingungen]
      ,[PK dMahnstufe]
      ,[PK dSalesperson]
      ,[PK dZeit (Buchungsdatum)]
      ,[PK dZeit (Belegdatum)]
      ,[PK dZeit (Fälligkeitsdatum)]
      ,[PK dAltersstruktur]
      ,[PK dFälligkeitsklasse]
  FROM [fin].[fOPDebitor75_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Sachkonto]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung75_2_Sachkonto


















CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Sachkonto] AS
SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
	  ,[Sachkontobezeichnung (Nummer)]
	  ,[Sachkontonummer Bezeichnung]
      ,[Zusammenzählung Start]
      ,[Zusammenzählung Ende]
      ,[Zusammenzählungstyp]
      ,[Umkehr Code]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung80_2]
  --nur die Mappings zwischen einen Blattknoten und den Sachkonten
  WHERE [Sachkontonummer] IS NOT NULL
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dLagerort]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLagerort













CREATE VIEW [dim].[dLagerort] AS
SELECT [Lagerort Code]
      ,[Lagerortbezeichnung]
      ,[Lagerortbezeichnung 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,[Postleitzahl]
      ,[Länder Code]
      ,[Länderbezeichnung]
      ,[Verwendung Transit Code]
      ,[Verwendung Transit Bezeichnung DE]
      ,[Verwendung Transit Bezeichnung EN]
      ,[Mandant Code]
      ,[Lagerortbezeichnung (Code)]
      ,[Lagerort Code Bezeichnung]
      ,[PK dLagerort]
  FROM [dim].[dLagerort85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt]'))
EXEC dbo.sp_executesql @statement = N'







-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt





CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt] AS
--Erzeugnen eine Knotens zur Sammlung von nicht zugeordneten Sachkonten (JH - 2020-02-03 - #8006)
SELECT [Name des Bilanz-Reports]					AS [Strukturbezeichnung]
      ,[vSNCt_Aktiver_Mandant].[Mandant Code]		AS [Mandant Code]
      ,CAST(NULL AS INT)							AS [Parent Zeilennummer]
      ,CAST(NULL AS NVARCHAR(10))					AS [Parent Code]
      ,CAST(NULL AS NVARCHAR(100))					AS [Parentbezeichnung]
      ,CAST(''99999''	AS INT)							AS [Child Zeilennummer]
      ,CAST(''9999999999'' AS NVARCHAR(10))			AS [Child Code]
      ,CAST(''Nicht Zugeordnet'' AS NVARCHAR(100))	AS [Childbezeichnung]
      ,CAST(0 AS BIT)								AS [Ist Blattknoten]
      ,CAST(''9999999999'' AS NVARCHAR(15))			AS [Zusammenzählung Start]
      ,CAST(''9999999999'' AS NVARCHAR(15))			AS [Zusammenzählung Ende]
      ,CAST(2 AS INT)								AS [Zusammenzählungstyp]
      ,CAST(0 AS TINYINT)							AS [Umkehr Code]
FROM [vv].[vSNCt_Aktiver_Mandant]

  INNER JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON  [vSNCt_Aktiver_Mandant].[Mandant Code]	  =	[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]

  WHERE [vSNCt_Aktiver_Mandant].[Hauptmandant] = 1
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenträgerDimension95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenträgerDimension95_2























CREATE VIEW [dim].[dKostenträgerDimension95_2] AS 
SELECT [vBC_t0000349_Dimensionswert].[Dimensionswertbezeichnung]							AS [Kostenträgerbezeichnung]
      ,[vBC_t0000349_Dimensionswert].[Dimensionswert]											AS [Kostenträger Code]
	  ,[vBC_t0000349_Dimensionswert].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Gesperrtbezeichnung EN]
      ,[vBC_t0000349_Dimensionswert].[Mandant Code]
  FROM [vv].[vBC_t0000349_Dimensionswert]

  INNER JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vBC_t0000349_Dimensionswert].[Mandant Code] = [vSNCt_Aktiver_Mandant].[Mandant Code]
  AND [vBC_t0000349_Dimensionswert].[Dimensionswertart] = [vSNCt_Aktiver_Mandant].[Kostenträger Code]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vBC_t0000349_Dimensionswert].[Gesperrt Code]  = [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]			= ''Global''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]				= ''Gesperrtbezeichnung''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenträgerDimension90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLagerplatz95_2







-- Alter View dLagerplatz90_2











-- Alter View dKostenträgerDimension90_2

















CREATE VIEW  [dim].[dKostenträgerDimension90_2] AS
SELECT [Kostenträgerbezeichnung]
      ,[Kostenträger Code]
	  ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
  FROM [dim].[dKostenträgerDimension95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenträgerDimension85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenträgerDimension85_2_CONCAT












CREATE VIEW [dim].[dKostenträgerDimension85_2_CONCAT] AS
SELECT [Kostenträgerbezeichnung]
      ,[Kostenträger Code]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
	  ,CAST(ISNULL([Kostenträgerbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Kostenträger Code] AS NVARCHAR(20)) + '')'' AS [Kostenträgerbezeichnung (Code)]
      ,CAST(ISNULL([Kostenträger Code],'''') AS NVARCHAR(20)) + '' '' + CAST([Kostenträgerbezeichnung] AS NVARCHAR(100)) AS [Kostenträger Code Bezeichnung]
	  ,[Mandant Code] +''_''+ [Kostenträger Code] AS [PK dKostenträgerDimension]
  FROM [dim].[dKostenträgerDimension90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung70_2_UNION]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung70_2_UNION


























CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung70_2_UNION] AS
SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code]
      ,[Childbezeichnung]
      ,NULL						AS [Sachkontonummer]
      ,NULL						AS [Sachkontobezeichnung]
      ,[Zusammenzählung Start]
      ,[Zusammenzählung Ende]
      ,[Zusammenzählungstyp]
      ,[Umkehr Code]
	  ,CAST(''Tree'' AS NVARCHAR(50)) AS [Union Teil]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Baum]

  UNION ALL


  SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Child Zeilennummer]																							AS [Parent Zeilennummer]
      ,[Child Code]																									AS [Parent Code]
      ,[Childbezeichnung]																							AS [Parentbezeichnung]
      ,CAST(DENSE_RANK() OVER (PARTITION BY [Mandant Code],[Sachkontonummer] ORDER BY [Sachkontonummer]) AS INT)	AS [Child Zeilennummer]
      ,[Sachkontonummer]																							AS [Child Code]
      ,[Sachkontonummer Bezeichnung]																				AS [Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Zusammenzählung Start]
      ,[Zusammenzählung Ende]
      ,[Zusammenzählungstyp]
      ,[Umkehr Code]
	  ,CAST(''G/L Account'' AS NVARCHAR(50)) AS [Union Teil]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Sachkonto]

  UNION ALL

SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code]
      ,[Childbezeichnung]
      ,NULL						AS [Sachkontonummer]
      ,NULL						AS [Sachkonto Name]
      ,[Zusammenzählung Start]
      ,[Zusammenzählung Ende]
      ,[Zusammenzählungstyp]
      ,[Umkehr Code]
	  ,CAST(''Unmapped Leaf'' AS NVARCHAR(50)) AS [Union Teil]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000003_Zahlungsbedingungen]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000003_Zahlungsbedingungen












CREATE VIEW [vv].[vBC_t0000003_Zahlungsbedingungen] AS
SELECT [Code]			 AS [Zahlungsbedingung Code]
      ,[Description]	 AS [Zahlungsbedingungsbezeichnung]
      ,[SG_MandantCode]	 AS [Mandant Code]
FROM [com].[BC_t0000003_Payment_Terms]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000004_Währung]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000004_Währung














CREATE VIEW [vv].[vBC_t0000004_Währung] AS
SELECT [Code]			AS [Währung Code]			-- Währungscode
      ,[ISO Code]		AS [ISO Währung Code]		-- ISO Währungscode
      ,[Description]	AS [Währungsbezeichnung]	-- Währungsbeschreibung
      ,[Symbol]			AS [Währung Symbol]			-- Währungssymbol
      ,[SG_MandantCode]	AS [Mandant Code]				-- Mandant ID
  FROM [com].[BC_t0000004_Currency]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000008_Sprache]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000008_Sprache












CREATE VIEW [vv].[vBC_t0000008_Sprache]AS
SELECT [Code]			AS [Sprache Code]		-- Sprachcode
      ,[Name]			AS [Sprachenbezeichnung]		-- Sprachbezeichnung
      ,[SG_MandantCode]	AS [Mandant Code]	-- Mandant ID
  FROM [com].[BC_t0000008_Language]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000010_Lieferbedingung]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000010_Lieferbedingung










CREATE VIEW [vv].[vBC_t0000010_Lieferbedingung] AS
SELECT [Code]			   AS [Lieferbedingung Code] 			-- Lieferbedingung Code
      ,[Description]	   AS [Lieferbedingungsbezeichnung]		-- Lieferbedinung Bezeichnung
      ,[SG_MandantCode]	   AS [Mandant Code]					-- Mandant ID
  FROM [com].[BC_t0000010_Shipment_Method]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000093_Kreditorenbuchungsgruppe]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000093_Kreditorenbuchungsgruppe











CREATE VIEW [vv].[vBC_t0000093_Kreditorenbuchungsgruppe] AS
SELECT [Code]			AS [Lieferantenbuchungsgruppe Code]
      ,[Description]	AS [Lieferantenbuchungsgruppenbezeichnung]
      ,[SG_MandantCode]	AS [Mandant Code]
  FROM [com].[BC_t0000093_Vendor_Posting_Group]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000286_Gebiet]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000286_Gebiet










CREATE VIEW [vv].[vBC_t0000286_Gebiet] AS 
SELECT [Code]			   AS [Gebiet Code]	-- Gebietscode
      ,[Name]			   AS [Gebietsbezeichnung]	-- Gebietsname
      ,[SG_MandantCode]	   AS [Mandant Code]	-- Mandant ID
  FROM [com].[BC_t0000286_Territory]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dLieferant95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLieferant95_2
-- Alter View dKreditor95_2


















CREATE VIEW [dim].[dLieferant95_2] AS 
SELECT [vv].[vBC_t0000023_Lieferant].[Lieferantname]
      ,[vv].[vBC_t0000023_Lieferant].[Lieferantname 2]
      ,[vv].[vBC_t0000023_Lieferant].[Adresse]
      ,[vv].[vBC_t0000023_Lieferant].[Adresse 2]
      ,[vv].[vBC_t0000023_Lieferant].[Ort]
      ,[vv].[vBC_t0000023_Lieferant].[Länder Code]
	  ,[vv].[vBC_t0000009_Land].[Länderbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Lieferantnummer]
      ,[vv].[vBC_t0000023_Lieferant].[Suchbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Budgetierter Betrag]
      ,[vv].[vBC_t0000023_Lieferant].[Lieferantenbuchungsgruppe Code]
	  ,[vv].[vBC_t0000093_Kreditorenbuchungsgruppe].[Lieferantenbuchungsgruppenbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Währung Code]
	  ,[vv].[vBC_t0000004_Währung].[Währungsbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Sprache Code]
	  ,[vv].[vBC_t0000008_Sprache].[Sprachenbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Zlg.-Bedingung Code]
	  ,[vv].[vBC_t0000003_Zahlungsbedingungen].[Zahlungsbedingungsbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Gesperrtbezeichnung EN]
      ,[vv].[vBC_t0000023_Lieferant].[Einkäufer Code]				
	  ,[Einkäufer].[Verkäufer/Einkäufername]									AS [Einkäufername]
      ,[vv].[vBC_t0000023_Lieferant].[Mandant Code]
      ,[vv].[vBC_t0000023_Lieferant].[Kontaktbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Kontakt Code]
      ,[vv].[vBC_t0000023_Lieferant].[Gebiet Code]
	  ,[vv].[vBC_t0000286_Gebiet].[Gebietsbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Postleitzahl]
      ,[vv].[vBC_t0000023_Lieferant].[Vorauszahlung %]
      ,[vv].[vBC_t0000023_Lieferant].[Lagerort Code]
	  ,[vv].[vBC_t0000014_Lagerort].[Lagerortbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Lieferbedingung Code]
	  ,[vv].[vBC_t0000010_Lieferbedingung].[Lieferbedingungsbezeichnung]
      ,[vv].[vBC_t0000023_Lieferant].[Preise inkl. MwST]
      ,[vv].[vBC_t0000023_Lieferant].[Cashflow-Zlg.-Bedingung Code]
      ,[vv].[vBC_t0000023_Lieferant].[Zahlungstoleranz]
  FROM [vv].[vBC_t0000023_Lieferant]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vv].[vBC_t0000023_Lieferant].[Gesperrt Code]   = [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]			= ''Kreditor''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]				= ''Gesperrtbezeichnung''

  LEFT JOIN [vv].[vBC_t0000009_Land]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]			= [vv].[vBC_t0000009_Land].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Länder Code]	= [vv].[vBC_t0000009_Land].[Länder Code]

  LEFT JOIN [vv].[vBC_t0000013_Verkäufer_Einkäufer] AS [Einkäufer]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]		= [Einkäufer].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Einkäufer Code]	= [Einkäufer].[Verkäufer/Einkäufer Code]

  LEFT JOIN [vv].[vBC_t0000003_Zahlungsbedingungen]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]		= [vv].[vBC_t0000003_Zahlungsbedingungen].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Zlg.-Bedingung Code]	= [vv].[vBC_t0000003_Zahlungsbedingungen].[Zahlungsbedingung Code]

  LEFT JOIN [vv].[vBC_t0000093_Kreditorenbuchungsgruppe]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]					= [vv].[vBC_t0000093_Kreditorenbuchungsgruppe].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Lieferantenbuchungsgruppe Code]	= [vv].[vBC_t0000093_Kreditorenbuchungsgruppe].[Lieferantenbuchungsgruppe Code]

  LEFT JOIN [vv].[vBC_t0000004_Währung]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]	= [vv].[vBC_t0000004_Währung].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Währung Code]	= [vv].[vBC_t0000004_Währung].[Währung Code]

  LEFT JOIN [vv].[vBC_t0000008_Sprache]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]	= [vv].[vBC_t0000008_Sprache].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Sprache Code]	= [vv].[vBC_t0000008_Sprache].[Sprache Code]

  LEFT JOIN [vv].[vBC_t0000010_Lieferbedingung]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]			= [vv].[vBC_t0000010_Lieferbedingung].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Lieferbedingung Code]	= [vv].[vBC_t0000010_Lieferbedingung].[Lieferbedingung Code]

  LEFT JOIN [vv].[vBC_t0000286_Gebiet]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]		= [vv].[vBC_t0000286_Gebiet].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Gebiet Code]	= [vv].[vBC_t0000286_Gebiet].[Gebiet Code]

  LEFT JOIN [vv].[vBC_t0000014_Lagerort]
  ON [vv].[vBC_t0000023_Lieferant].[Mandant Code]		= [vv].[vBC_t0000014_Lagerort].[Mandant Code]
  AND [vv].[vBC_t0000023_Lieferant].[Lagerort Code]	= [vv].[vBC_t0000014_Lagerort].[Lagerort Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenträgerDimension]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View dLagerplatz85_2_CONCAT





























CREATE VIEW  [dim].[dKostenträgerDimension] AS
SELECT [Kostenträgerbezeichnung]
      ,[Kostenträger Code]
      ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
	  ,[Kostenträgerbezeichnung (Code)]
      ,[Kostenträger Code Bezeichnung]
	  ,[PK dKostenträgerDimension]
  FROM [dim].[dKostenträgerDimension85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000122_Einkaufsrechnungkopf95_2]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View vBC_t0000122_Einkaufsrechnungkopf95_2























CREATE VIEW [vv].[vBC_t0000122_Einkaufsrechnungkopf95_2]

AS

SELECT [SG_MandantCode]			        	AS [Mandant Code]						-- Mandant ID
      ,[No_]								AS [Belegnummer]						-- Belegnummer
      ,[Buy-from Vendor No_]				AS [Kauf von Kreditornummer]			-- Kauf von Kreditornummer
      ,[Pay-to Vendor No_]					AS [Zahlung an Kreditornummer]			-- Zahlung an Kreditornummer
      ,[Ship-to Code]						AS [Lieferung an Kreditornummer]		-- Zahlung an Kreditornummer
      ,[Ship-to Name]						AS [Lieferung an Name]					-- Lieferung an Name
      ,[Ship-to City]						AS [Lieferung an Ort]					-- Lieferung an Ort  
	  ,[Posting Date]						AS [Buchungsdatum]						-- Buchungsdatum
      ,[Payment Terms Code]					AS [Zahlungsbedingung Code]				-- Zahlungsbedingungcode
      ,[Currency Code]						AS [Währung Code]						-- Währungcode
      ,[Currency Factor]					AS [Währungsfaktor]					-- Währungfaktor
      ,[Purchaser Code]						AS [Einkäufer Code]						-- Verkäufercode
      ,[Document Date]						AS [Belegdatum]							-- Belegdatum
	  ,[Correction]				         	AS [Storno Flag]						-- Storno Flag
      ,[Order Date]							AS [Auftragsdatum]						-- Auftragsdatum
      ,[Due Date]							AS [Fälligkeitsdatum]					-- Fälligkeitsdatum
      ,[Buy-from Contact]					AS [Kauf von Kontakt]							-- Kontakt
	  ,[Buy-from Contact No_]				AS [Kauf von Kontaktnummer]				-- Kauf von Kontakt Nr.
      ,[Posting Description]				AS [Beschreibung]						-- Beschreibung
      ,[Location Code]						AS [Lagerort Code]						-- Lagerortcode
      ,[Payment Discount _]					AS [Skonto]								-- Skonto
      ,[Pmt_ Discount Date]					AS [Skontodatum]						-- Skontodatum
	  ,[SG_Bundesland]							AS [Bundesland]							-- Bundesland
	  ,[Vendor Invoice No_]					AS [Kreditor Rechnungsnummer]			-- Kreditor Rechnungsnummer
	  ,[Vendor Order No_]					AS [Kreditor Bestellnummer]				-- Kreditor Bestellnummer
	  ,[Responsibility Center]				AS [Zuständigkeitseinheiten Code]		-- Zuständigkeitseinheiten Code
	  ,[VAT Bus_ Posting Group]				AS [MwSt.-Geschäftsbuchungsgruppe Code]	-- MwSt.-Geschäftsbuchungsgruppe Code
	  ,[Shipment Method Code]				AS [Lieferbedingung Code]				-- Lieferbedinungscode
  FROM [ein].[BC_t0000122_Purch_Inv_Header]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000122_Einkaufsrechnungkopf]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000122_Einkaufsrechnungkopf




CREATE VIEW [vv].[vBC_t0000122_Einkaufsrechnungkopf] AS 
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Kauf von Kreditornummer]
      ,[Zahlung an Kreditornummer]
      ,[Lieferung an Kreditornummer]
      ,[Lieferung an Name]
      ,[Lieferung an Ort]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])			AS [Buchungsdatum]
      ,[Zahlungsbedingung Code]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])				AS [Belegdatum]
      ,[Storno Flag]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Auftragsdatum])			AS [Auftragsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])		AS [Fälligkeitsdatum]
      ,[Kauf von Kontakt]
      ,[Kauf von Kontaktnummer]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[Skonto]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])				AS [Skontodatum]
	  ,[Bundesland]
      ,[Kreditor Rechnungsnummer]
      ,[Kreditor Bestellnummer]
      ,[Zuständigkeitseinheiten Code]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
      ,[Lieferbedingung Code]
  FROM [vv].[vBC_t0000122_Einkaufsrechnungkopf95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000123_Einkaufsrechnungzeile]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000123_Einkaufsrechnungzeile


























CREATE VIEW [vv].[vBC_t0000123_Einkaufsrechnungzeile]

AS

SELECT [SG_MandantCode]					AS [Mandant Code]												-- Mandant ID
      ,[Document No_]					AS [Belegnummer]												-- Belegnummer
      ,[Line No_]						AS [Zeilennummer]												-- Zeilennummer
      ,[Buy-from Vendor No_]			AS [Kauf von Kreditornummer]									-- Kauf von Kreditornummer
      ,[Type]							AS [Produktart]													-- Produktart
      ,[No_]							AS [Produktnummer]												-- ProduktNnmmer
      ,[Quantity]						AS [Menge]														-- Menge
      ,[Unit Price (LCY)]				AS [Verkaufspreis (MW)]												-- Verkaufspreis
      ,[Unit Cost (LCY)]				AS [Einstandspreis (MW)]										-- Einstandspreis (MW)
      ,[Line Discount Amount]			AS [Zeilenrabattbetrag]											-- ZeilenrabattBetrag
      ,[Amount]							AS [Betrag]														-- Betrag
      ,[Shortcut Dimension 1 Code]		AS [Kostenstellencode]											-- Kostenstellencode
      ,[Shortcut Dimension 2 Code]		AS [Kostenträgercode]											-- Kostenträgercode
      ,[Pay-to Vendor No_]				AS [Zahlung an Kreditornummer]									-- Zahlung an Kreditornummer
      ,[Inv_ Discount Amount]			AS [Rechnungsrabattbetrag]										-- Rechnungsrabattbetrag
      ,[Unit Cost]						AS [Einstandspreis]												-- Einstandspreis
      ,[Line Amount]					AS [Zeilenbetrag]												-- Zeilenbetrag
      ,[Quantity (Base)]				AS [Menge (Basis)]												-- Menge (Basis)
      ,[Location Code]					AS [Lagerort Code]												-- Lagerort Code
      ,[Description]					AS [Beschreibung]												-- Beschreibung
      ,[Unit of Measure Code]			AS [Einheitencode]												-- Einheitencode
      ,[Dimension Set ID]				AS [Dimension Set ID]	-- Dimension Set ID Link zur Tabelle [Dimension Set Entry]
	  ,[SG_Bundesland]						AS [Bundesland]													-- Bundesland
	  ,[Bin Code]						AS [Lagerplatz Code]											-- Lagerplatzcode
	  ,[Responsibility Center]			AS [Zuständigkeitseinheiten Code]								-- Zuständigkeitseinheiten Code
	  ,[VAT Bus_ Posting Group]			AS [MwSt.-Geschäftsbuchungsgruppe Code]							-- MwSt.-Geschäftsbuchungsgruppe Code
	  ,[Direct Unit Cost]				AS [EK-Preis ohne MwSt.]											-- [Direct Unit Cost]

  FROM [ein].[BC_t0000123_Purch_Inv_Line]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling95_2_Rechnung]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fEinkaufscontrolling95_2_Rechnung





























CREATE view [ein].[fEinkaufscontrolling95_2_Rechnung] AS 

SELECT [vv].[vBC_t0000122_Einkaufsrechnungkopf].[Mandant Code]
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Belegnummer]
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Buchungsdatum]
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Währung Code]
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Währungsfaktor]
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Einkäufer Code]
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Belegdatum]
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Storno Flag] 
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Lagerort Code]    		
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Auftragsdatum]    			
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Fälligkeitsdatum]    								
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Kauf von Kontakt] 
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Kauf von Kontaktnummer]
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Beschreibung]    	  					
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Skonto]    	
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Skontodatum]    	
      ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Zahlungsbedingung Code]   
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Kreditor Rechnungsnummer]
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Kreditor Bestellnummer]
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Zuständigkeitseinheiten Code]
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Lieferbedingung Code]
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Bundesland]
	  ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[EK-Preis ohne MwSt.]		
	  ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Lagerplatz Code]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Zeilennummer]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Kauf von Kreditornummer]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Kostenstellencode]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Kostenträgercode]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Produktart]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Produktnummer]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Zeilenrabattbetrag]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Zahlung an Kreditornummer]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Rechnungsrabattbetrag]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Zeilenbetrag]
	  ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Menge]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Menge (Basis)]
      ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Einstandspreis] 
	  ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Betrag]
	  ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Verkaufspreis (MW)] 
	  ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Einheitencode]    	 	
	  ,[vv].[vBC_t0000123_Einkaufsrechnungzeile].[Dimension Set ID]  
  FROM [vv].[vBC_t0000122_Einkaufsrechnungkopf]

LEFT JOIN [vv].[vBC_t0000123_Einkaufsrechnungzeile]

ON  [vv].[vBC_t0000122_Einkaufsrechnungkopf].[Mandant Code]						= [vv].[vBC_t0000123_Einkaufsrechnungzeile].[Mandant Code]
AND	[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Belegnummer]	= [vv].[vBC_t0000123_Einkaufsrechnungzeile].[Belegnummer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dLieferant90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLieferant90_2
-- Alter View dKreditor90_2















CREATE VIEW [dim].[dLieferant90_2] AS
SELECT [Lieferantname]
      ,[Lieferantname 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,[Länder Code]
      ,[Länderbezeichnung]
      ,[Lieferantnummer]
      ,[Suchbezeichnung]
      ,[Budgetierter Betrag]
      ,[Lieferantenbuchungsgruppe Code]
      ,[Lieferantenbuchungsgruppenbezeichnung]
      ,[Währung Code]
      ,[Währungsbezeichnung]
      ,[Sprache Code]
      ,[Sprachenbezeichnung]
      ,[Zlg.-Bedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Einkäufer Code]
      ,[Einkäufername]
      ,[Mandant Code]
      ,[Kontaktbezeichnung]
      ,[Kontakt Code]
      ,[Gebiet Code]
      ,[Gebietsbezeichnung]
      ,[Postleitzahl]
      ,[Vorauszahlung %]
      ,[Lagerort Code]
      ,[Lagerortbezeichnung]
      ,[Lieferbedingung Code]
      ,[Lieferbedingungsbezeichnung]
      ,[Preise inkl. MwST]
      ,[Cashflow-Zlg.-Bedingung Code]
      ,[Zahlungstoleranz]
  FROM [dim].[dLieferant95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000092_Debitorenbuchungsgruppe]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000092_Debitorenbuchungsgruppe










CREATE VIEW [vv].[vBC_t0000092_Debitorenbuchungsgruppe] AS
SELECT [Code]			AS [Debitorenbuchungsgruppe Code]
      ,[Description]	AS [Debitorenbuchungsgruppenbezeichnung]
      ,[SG_MandantCode]	AS [Mandant Code]
  FROM [com].[BC_t0000092_Customer_Posting_Group]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000340_Debitorenrabattgruppe]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000340_Debitorenrabattgruppe











CREATE VIEW [vv].[vBC_t0000340_Debitorenrabattgruppe] AS
SELECT [Code]			AS [Debitorenrabattgruppe Code]
      ,[Description]	AS [Debitorenrabattsgruppenbezeichnung]
      ,[SG_MandantCode]	AS [Mandant Code]
  FROM [com].[BC_t0000340_Customer_Discount_Group]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKunde95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKunde95_2
-- Alter View dDebitor95_2








/****** Object:  View [dim].[dCustomer]    Script Date: 04.11.2020 09:05:03 ******/






CREATE VIEW [dim].[dKunde95_2] AS 
SELECT [vv].[vBC_t0000018_Kunde].[Kundenname]
      ,[vv].[vBC_t0000018_Kunde].[Kundenname 2]
      ,[vv].[vBC_t0000018_Kunde].[Adresse]
      ,[vv].[vBC_t0000018_Kunde].[Adresse 2]
      ,[vv].[vBC_t0000018_Kunde].[Ort]
      ,[vv].[vBC_t0000018_Kunde].[Länder Code]
	  ,[vv].[vBC_t0000009_Land].[Länderbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Kundennummer]
      ,[vv].[vBC_t0000018_Kunde].[Suchbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Budgetierter Betrag]
      ,[vv].[vBC_t0000018_Kunde].[Kreditlimit (MW)]
      ,[vv].[vBC_t0000018_Kunde].[Debitorenbuchungsgruppe Code]
	  ,[vv].[vBC_t0000092_Debitorenbuchungsgruppe].[Debitorenbuchungsgruppenbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Währung Code]
	  ,[vv].[vBC_t0000004_Währung].[Währungsbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Sprache Code]
	  ,[vv].[vBC_t0000008_Sprache].[Sprachenbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Zahlungsbedingung Code]
	  ,[vv].[vBC_t0000003_Zahlungsbedingungen].[Zahlungsbedingungsbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Debitorenrabattgruppe Code]
	  ,[vv].[vBC_t0000340_Debitorenrabattgruppe].[Debitorenrabattsgruppenbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Gesperrt Code]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Gesperrtbezeichnung DE]
	  ,ISNULL([Gesperrtbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Gesperrtbezeichnung EN]
      ,[vv].[vBC_t0000018_Kunde].[Verkäufer Code]				
	  ,[Verkäufer].[Verkäufer/Einkäufer Code]										AS [Verkäuferbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Mandant Code]
      ,[vv].[vBC_t0000018_Kunde].[Kontaktbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Kontaktnummer]
      ,[vv].[vBC_t0000018_Kunde].[Gebiet Code]
	  ,[vv].[vBC_t0000286_Gebiet].[Gebietsbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Postleitzahl]
      ,[vv].[vBC_t0000018_Kunde].[Vorauszahlung %]
      ,[vv].[vBC_t0000018_Kunde].[Lagerort Code]
	  ,[vv].[vBC_t0000014_Lagerort].[Lagerortbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Lieferbedingung Code]
	  ,[vv].[vBC_t0000010_Lieferbedingung].[Lieferbedingungsbezeichnung]
      ,[vv].[vBC_t0000018_Kunde].[Preise inkl. MwST]
      ,[vv].[vBC_t0000018_Kunde].[Cashflow-Zlg.-Bedingung Code]
      ,[vv].[vBC_t0000018_Kunde].[Zahlungstoleranz]
  FROM [vv].[vBC_t0000018_Kunde]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Gesperrtbezeichnung]
  ON [vv].[vBC_t0000018_Kunde].[Gesperrt Code]   = [Gesperrtbezeichnung].[Optionsfeld Code]
  AND [Gesperrtbezeichnung].[Tabellenname]			= ''Debitor''
  AND [Gesperrtbezeichnung].[Spaltenbezeichnung]				= ''Gesperrtbezeichnung''

  LEFT JOIN [vv].[vBC_t0000009_Land]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]			= [vv].[vBC_t0000009_Land].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Länder Code]	= [vv].[vBC_t0000009_Land].[Länder Code]

  LEFT JOIN [vv].[vBC_t0000013_Verkäufer_Einkäufer] AS [Verkäufer]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]		= [Verkäufer].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Verkäufer Code]	= [Verkäufer].[Verkäufer/Einkäufer Code]

  LEFT JOIN [vv].[vBC_t0000003_Zahlungsbedingungen]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]		= [vv].[vBC_t0000003_Zahlungsbedingungen].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Zahlungsbedingung Code]	= [vv].[vBC_t0000003_Zahlungsbedingungen].[Zahlungsbedingung Code]

  LEFT JOIN [vv].[vBC_t0000340_Debitorenrabattgruppe]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]				= [vv].[vBC_t0000340_Debitorenrabattgruppe].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Debitorenrabattgruppe Code]	= [vv].[vBC_t0000340_Debitorenrabattgruppe].[Debitorenrabattgruppe Code]

  LEFT JOIN [vv].[vBC_t0000092_Debitorenbuchungsgruppe]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]					= [vv].[vBC_t0000092_Debitorenbuchungsgruppe].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Debitorenbuchungsgruppe Code]	= [vv].[vBC_t0000092_Debitorenbuchungsgruppe].[Debitorenbuchungsgruppe Code]

  LEFT JOIN [vv].[vBC_t0000004_Währung]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]	= [vv].[vBC_t0000004_Währung].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Währung Code]	= [vv].[vBC_t0000004_Währung].[Währung Code]

  LEFT JOIN [vv].[vBC_t0000008_Sprache]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]	= [vv].[vBC_t0000008_Sprache].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Sprache Code]	= [vv].[vBC_t0000008_Sprache].[Sprache Code]

  LEFT JOIN [vv].[vBC_t0000010_Lieferbedingung]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]			= [vv].[vBC_t0000010_Lieferbedingung].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Lieferbedingung Code]	= [vv].[vBC_t0000010_Lieferbedingung].[Lieferbedingung Code]

  LEFT JOIN [vv].[vBC_t0000286_Gebiet]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]		= [vv].[vBC_t0000286_Gebiet].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Gebiet Code]		= [vv].[vBC_t0000286_Gebiet].[Gebiet Code]

  LEFT JOIN [vv].[vBC_t0000014_Lagerort]
  ON [vv].[vBC_t0000018_Kunde].[Mandant Code]		= [vv].[vBC_t0000014_Lagerort].[Mandant Code]
  AND [vv].[vBC_t0000018_Kunde].[Lagerort Code]		= [vv].[vBC_t0000014_Lagerort].[Lagerort Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000124_Einkaufsgutschriftkopf95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000124_Einkaufsgutschriftkopf95_2



















CREATE VIEW [vv].[vBC_t0000124_Einkaufsgutschriftkopf95_2]

AS

SELECT [SG_MandantCode]			        	AS [Mandant Code]							-- Mandant ID
      ,[No_]								AS [Belegnummer]							-- Belegnummer
      ,[Buy-from Vendor No_]				AS [Kauf von Kreditornummer]				-- Kauf von Kreditornummer
      ,[Pay-to Vendor No_]					AS [Zahlung an Kreditornummer]				-- Zahlung an Kreditornummer
      ,[Ship-to Code]						AS [Lieferung an Kreditornummer]			-- Zahlung an Kreditornummer
      ,[Ship-to Name]						AS [Lieferung an Name]						-- Lieferung an Name
      ,[Ship-to City]						AS [Lieferung an Ort]						-- Lieferung an Ort
	  ,[Posting Date]						AS [Buchungsdatum]							-- Buchungsdatum
      ,[Payment Terms Code]					AS [Zahlungsbedingungscode]					-- Zahlungsbedingungscode
      ,[Currency Code]						AS [Währung Code]							-- Währungscode
      ,[Currency Factor]					AS [Währungsfaktor]						-- Währungsfaktor
      ,[Purchaser Code]						AS [Einkäufer Code]							-- Einkäufercode
      ,[Document Date]						AS [Belegdatum]								-- Belegdatum
	  ,[Correction]				         	AS [Storno]									-- Storno
      ,[Due Date]							AS [Fälligkeitsdatum]						-- Fälligkeitsdatum
      ,[Buy-from Contact]					AS [Kauf von Kontakt]								-- Kontakt
	  ,[Buy-from Contact No_]				AS [Kauf von Kontaktnummer]					-- Kauf von Kontakt Nr.
      ,[Posting Description]				AS [Buchungsbeschreibung]							-- Beschreibung
      ,[Location Code]						AS [Lagerort Code]							-- Lagerort Code
      ,[Payment Discount _]					AS [Skonto]									-- Skonto
      ,[Pmt_ Discount Date]					AS [Skontodatum]							-- Skontodatum
	  ,[SG_Bundesland]							AS [Bundesland]								-- Bundesland
	  ,[Responsibility Center]				AS [Zuständigkeitseinheiten Code]			-- Zuständigkeitseinheiten Code
	  ,[VAT Bus_ Posting Group]				AS [MwSt.-Geschäftsbuchungsgruppe Code]		-- MwSt.-Geschäftsbuchungsgruppe Code
	  ,[Shipment Method Code]				AS [Lieferbedingungscode]					-- Lieferbedinungscode
  FROM [ein].[BC_t0000124_Purch_Cr_Memo_Hdr]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000124_Einkaufsgutschriftkopf]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000124_Einkaufsgutschriftkopf
-- Alter View vBC_t0000124_Einkaufsgutschriftzeile



CREATE VIEW [vv].[vBC_t0000124_Einkaufsgutschriftkopf] AS
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Kauf von Kreditornummer]
      ,[Zahlung an Kreditornummer]
      ,[Lieferung an Kreditornummer]
      ,[Lieferung an Name]
      ,[Lieferung an Ort]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])			AS [Buchungsdatum]
      ,[Zahlungsbedingungscode]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])			AS [Belegdatum]
      ,[Storno]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])				AS [Fälligkeitsdatum]
      ,[Kauf von Kontakt]
      ,[Kauf von Kontaktnummer]
      ,[Buchungsbeschreibung]
      ,[Lagerort Code]
      ,[Skonto]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])		AS [Skontodatum]
      ,[Bundesland]
      ,[Zuständigkeitseinheiten Code]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
      ,[Lieferbedingungscode]
  FROM [vv].[vBC_t0000124_Einkaufsgutschriftkopf95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000293_Mahnstufe95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000293_Mahnstufe95_2












CREATE VIEW [vv].[vBC_t0000293_Mahnstufe95_2] AS
SELECT [No_]				  AS [Mahnstufe]		  -- Mahnstufe
      ,[Reminder Terms Code]  AS [Mahnmethode Code]	  -- Mahnmethodencode
      ,[SG_MandantCode]		  AS [Mandant Code]			  -- Mandant ID
  FROM [fin].[BC_t0000293_Reminder_Level]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000293_Mahnstufe]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000293_Mahnstufe









CREATE VIEW [vv].[vBC_t0000293_Mahnstufe] AS
SELECT CAST([Mahnstufe] AS INT) AS [Mahnstufe]
      ,[Mahnmethode Code]
      ,[Mandant Code]
  FROM [vv].[vBC_t0000293_Mahnstufe95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000125_Einkaufsgutschriftzeile]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000125_Einkaufsgutschriftzeile

























CREATE VIEW [vv].[vBC_t0000125_Einkaufsgutschriftzeile]

AS

SELECT [SG_MandantCode]					AS [Mandant Code]												-- Mandant ID
      ,[Document No_]					AS [Belegnummer]												-- Belegnummer
      ,[Line No_]						AS [Zeilennummer]												-- Zeilennummer
      ,[Buy-from Vendor No_]			AS [Einkauf bei Kreditor Code]									-- Einkauf bei Kreditor Code
      ,[Type]							AS [Produktart]													-- Produktart
      ,[No_]							AS [Produktnummer]												-- Produktnummer
      ,[Quantity]						AS [Menge]														-- Menge
      ,[Unit Price (LCY)]				AS [Verkaufspreis (MW)]												-- Verkaufspreis
      ,[Unit Cost (LCY)]				AS [Einstandspreis (MW)]										-- Einstandspreis (MW)
      ,[Line Discount Amount]			AS [Zeilenrabattbetrag]											-- Zeilenrabattbetrag
      ,[Amount]							AS [Betrag]														-- Betrag
      ,[Shortcut Dimension 1 Code]		AS [Kostenstellencode]											-- Kostenstellencode
      ,[Shortcut Dimension 2 Code]		AS [Kostenträgercode]											-- Kostenträgercode
      ,[Pay-to Vendor No_]				AS [Zahlung an Kreditornummer]								-- Zahlung an Kreditornummer
      ,[Inv_ Discount Amount]			AS [Rechnungsrabattbetrag]										-- Rechnungsrabattbetrag
      ,[Unit Cost]						AS [Einstandspreis]												-- Einstandspreis
      ,[Line Amount]					AS [Zeilenbetrag]												-- Zeilenbetrag
      ,[Quantity (Base)]				AS [Menge (Basis)]												-- Menge (Basis)
      ,[Location Code]				    AS [Lagerort Code]												-- Lagerort Code
      ,[Description]				    AS [Beschreibung]												-- Beschreibung
      ,[Unit of Measure Code]		    AS [Einheitencode]												-- Einheitencode
      ,[Dimension Set ID]				AS [Dimension Set ID]	-- Dimension Set ID Link zur Tabelle [Dimension Set Entry]
	  ,[SG_Bundesland]						AS [Bundesland]													-- Bundesland
	  ,[Responsibility Center]			AS [Zuständigkeitseinheiten Code]								-- Zuständigkeitseinheiten Code
	  ,[VAT Bus_ Posting Group]			AS [MwSt.-Geschäftsbuchungsgruppe Code]							-- MwSt.-Geschäftsbuchungsgruppe Code
	  ,[Direct Unit Cost]				AS [EK-Preis ohne MwSt.]											-- [Direct Unit Cost]
  FROM [ein].[BC_t0000125_Purch_Cr_Memo_Line]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling95_2_Gutschrift]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fEinkaufscontrolling95_2_Gutschrift























 



CREATE view [ein].[fEinkaufscontrolling95_2_Gutschrift] AS 

SELECT [vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Mandant Code]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Belegnummer]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Buchungsdatum]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Währung Code]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Währungsfaktor]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Einkäufer Code]
	  ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Belegdatum]
	  ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Storno]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Fälligkeitsdatum]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Kauf von Kontakt]
	  ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Kauf von Kontaktnummer]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Buchungsbeschreibung]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Lagerort Code]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Skonto]
      ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Skontodatum]
	  ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Zuständigkeitseinheiten Code]
	  ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Lieferbedingungscode]
	  ,[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Bundesland]
	  ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[EK-Preis ohne MwSt.]		
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Zeilennummer]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Einkauf bei Kreditor Code]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Kostenstellencode]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Kostenträgercode]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Produktart]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Produktnummer]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Zeilenrabattbetrag] * -1	 AS  [Zeilenrabattbetrag]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Zahlung an Kreditornummer]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Rechnungsrabattbetrag] * -1	 AS  [Rechnungsrabattbetrag]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Zeilenbetrag] * -1			 AS  [Zeilenbetrag]
	  ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Menge] * -1				 AS  [Menge]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Menge (Basis)] * -1		 AS  [Menge (Basis)]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Einstandspreis] * -1				 AS  [Einstandspreis]
	  ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Betrag]
	  ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Verkaufspreis (MW)]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Beschreibung]
      ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Einheitencode]
	  ,[vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Dimension Set ID]
  FROM [vv].[vBC_t0000124_Einkaufsgutschriftkopf]

LEFT JOIN [vv].[vBC_t0000125_Einkaufsgutschriftzeile]
ON	[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Mandant Code]					= [vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Mandant Code]
AND	[vv].[vBC_t0000124_Einkaufsgutschriftkopf].[Belegnummer]	= [vv].[vBC_t0000125_Einkaufsgutschriftzeile].[Belegnummer]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenstelle90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenstelle90_2





















CREATE VIEW [dim].[dKostenstelle90_2] AS 
SELECT [Kostenstellenbezeichnung]
      ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Kostenstelle Code]
	  ,[Zuständige Person]
	  ,[Sortierreihenfolge]
      ,[Mandant Code]
	  ,[Kostenunterart Code]
	  ,[Kostenunterartbezeichnung DE]
	  ,[Kostenunterartbezeichnung EN]
  FROM [dim].[dKostenstelle95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKunde90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKunde90_2
-- Alter View dDebitor90_2
















CREATE VIEW [dim].[dKunde90_2] AS
SELECT [Kundenname]
      ,[Kundenname 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,IIF([Länder Code] = '''' AND [Länderbezeichnung] IS NULL, ''DE'', [Länder Code])			AS [Länder Code]
      ,IIF([Länder Code] = '''' AND [Länderbezeichnung] IS NULL, ''Deutschland'', [Länderbezeichnung])	AS [Länderbezeichnung]
      ,[Kundennummer]
      ,[Suchbezeichnung]
      ,[Budgetierter Betrag]
      ,[Kreditlimit (MW)]
      ,[Debitorenbuchungsgruppe Code]
      ,[Debitorenbuchungsgruppenbezeichnung]
      ,[Währung Code]
      ,[Währungsbezeichnung]
      ,[Sprache Code]
      ,[Sprachenbezeichnung]
      ,[Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Debitorenrabattgruppe Code]
      ,[Debitorenrabattsgruppenbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Verkäufer Code]
      ,[Verkäuferbezeichnung]
      ,[Mandant Code]
      ,[Kontaktbezeichnung]
      ,[Kontaktnummer]
      ,[Gebiet Code]
      ,[Gebietsbezeichnung]
      ,[Postleitzahl]
      ,[Vorauszahlung %]
      ,[Lagerort Code]
	  ,[Lagerortbezeichnung]
      ,[Lieferbedingung Code]
      ,[Lieferbedingungsbezeichnung]
      ,[Preise inkl. MwST]
      ,[Cashflow-Zlg.-Bedingung Code]
      ,[Zahlungstoleranz]
  FROM [dim].[dKunde95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKunde85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKunde85_2_CONCAT
-- Alter View dDebitor85_2_CONCAT
















CREATE VIEW [dim].[dKunde85_2_CONCAT] AS

SELECT [Kundenname]
      ,[Kundenname 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,[Länder Code]
      ,[Länderbezeichnung]
      ,[Kundennummer]
      ,[Suchbezeichnung]
      ,[Budgetierter Betrag]
      ,[Kreditlimit (MW)]
      ,[Debitorenbuchungsgruppe Code]
      ,[Debitorenbuchungsgruppenbezeichnung]
      ,[Währung Code]
      ,[Währungsbezeichnung]
      ,[Sprache Code]
      ,[Sprachenbezeichnung]
      ,[Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Debitorenrabattgruppe Code]
      ,[Debitorenrabattsgruppenbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Verkäufer Code]
      ,[Verkäuferbezeichnung]
      ,[Mandant Code]
      ,[Kontaktbezeichnung]
      ,[Kontaktnummer]
      ,[Gebiet Code]
      ,[Gebietsbezeichnung]
      ,[Postleitzahl]
      ,[Vorauszahlung %]
      ,[Lagerort Code]
	  ,[Lagerortbezeichnung]
      ,[Lieferbedingung Code]
      ,[Lieferbedingungsbezeichnung]
      ,[Preise inkl. MwST]
      ,[Cashflow-Zlg.-Bedingung Code]
      ,[Zahlungstoleranz]
	  ,CAST(ISNULL([Kundenname],'''') AS NVARCHAR(100)) + '' ('' + CAST([Kundennummer] AS NVARCHAR(20)) + '')'' AS [Kundenname (Nummer)]
      ,CAST(ISNULL([Kundennummer],'''') AS NVARCHAR(20)) + '' '' + CAST([Kundenname] AS NVARCHAR(100)) AS [Kundennummer Bezeichnung]
	  ,[Mandant Code] +''_''+ [Kundennummer] AS [PK dKunde]
  FROM [dim].[dKunde90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling75_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling75_2


































CREATE view [ein].[fEinkaufscontrolling75_2] AS 

SELECT [Mandant Code]
      ,[Belegnummer]			AS [Belegnummer]
      ,CAST(-1 AS INT)							AS [Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[Zeilennummer]		AS [Zeilennummer]
      ,[Kauf von Kreditornummer]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Produktart]
      ,[Produktnummer]
      ,[Zeilenrabattbetrag]
      ,[Zahlung an Kreditornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge]      
      ,[Menge (Basis)]
      ,[Einstandspreis]
      ,[Menge] * [Einstandspreis]					AS [Einheit Betrag]
	  ,[Betrag]
	  ,[Verkaufspreis (MW)]
	  ,CAST(NULL AS DATETIME)					AS [Anlieferungsdatum Zugesagt]    
	  ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsbetrag]
      ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsmenge]
	  ,[Storno Flag]
	  ,CAST(NULL AS INT)						AS [Status]		  		
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,CAST(NULL AS DATETIME)					AS [Gewünschtes Warenausgangsdatum]    				
	  ,[Kauf von Kontakt]    		    					
	  ,[Beschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,CAST(NULL AS DATETIME)					AS [Geplantes Anlieferungsdatum]   	 	  			
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,[Zahlungsbedingung Code]   
	  ,[Dimension Set ID]
	  ,[Kreditor Rechnungsnummer]
	  ,[Kreditor Bestellnummer]
	  ,CAST(NULL AS NVARCHAR(35))				AS [Kreditor Liefernummer]
	  ,[Zuständigkeitseinheiten Code]
	  ,[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[Lieferbedingung Code]
	  ,[Lagerplatz Code]
	  ,[Kauf von Kontaktnummer]
	  ,CAST(0 AS NUMERIC(38,20))				AS [Rabattwert]	
	  ,CAST(0 AS INT)							AS [Berechnungsart Rabatt]
	  ,[EK-Preis ohne MwSt.]		
	  ,CAST(0 AS NUMERIC(38,20))				AS [Menge akt. Rechnung]		
	  ,CAST(0 AS NUMERIC(38,20))				AS [Menge akt. Lieferung]		
	  ,CAST(0 AS NUMERIC(38,20))				AS [Bereits gelieferte Menge]		
	  ,CAST(0 AS NUMERIC(38,20))				AS [Bereits berechnete Menge] 
	  ,CAST(0 AS INT)							AS [Ist Archivbeleg]
	  ,[Bundesland]
  FROM [ein].[fEinkaufscontrolling95_2_Rechnung]

UNION ALL


SELECT [Mandant Code]
      ,[Belegnummer]			AS [Belegnummer]
      ,CAST(-2 AS INT)							AS [Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]      
      ,[Zeilennummer]	AS [Zeilennummer]
      ,[Einkauf bei Kreditor Code]
      ,[Kostenstellencode]
      ,[Kostenträgercode]      
      ,[Produktart]
      ,[Produktnummer]
      ,[Zeilenrabattbetrag]
      ,[Zahlung an Kreditornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge]            
      ,[Menge (Basis)]
      ,[Einstandspreis]
      ,[Menge] * [Einstandspreis] *-1				AS [Einheit Betrag]
	  ,[Betrag]
	  ,[Verkaufspreis (MW)]
      ,CAST(NULL AS DATETIME)					AS [Anlieferungsdatum Zugesagt]    
	  ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsbetrag]
      ,CAST(0 AS NUMERIC(38,20))				AS [Restauftragsmenge]
	  ,[Storno]
	  ,CAST(NULL AS INT)						AS [Status]	      		
	  ,CAST(NULL AS DATETIME)					AS [Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,CAST(NULL AS DATETIME)					AS [Gewünschtes Warenausgangsdatum]   
	  ,[Kauf von Kontakt]    		    					
	  ,[Buchungsbeschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,CAST(NULL AS DATETIME)					AS [Geplantes Anlieferungsdatum]   	 	 			
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,CAST(NULL AS NVARCHAR(10))				AS [Zahlungsbedingung Code]    	
	  ,[Dimension Set ID]
	  ,CAST(NULL AS NVARCHAR(35))				AS [Kreditor Rechnungsnummer]
	  ,CAST(NULL AS NVARCHAR(35))				AS [Kreditor Bestellnummer]
	  ,CAST(NULL AS NVARCHAR(35))				AS [Kreditor Liefernummer]
	  ,[Zuständigkeitseinheiten Code]
	  ,[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[Lieferbedingungscode]
	  ,CAST(NULL AS NVARCHAR(20))				AS [Lagerplatz Code]
	  ,[Kauf von Kontaktnummer]
	  ,CAST(0 AS NUMERIC(38,20))				AS [Rabattwert]	
	  ,CAST(0 AS INT)							AS [Berechnungsart Rabatt]
	  ,[EK-Preis ohne MwSt.]		
	  ,CAST(0 AS NUMERIC(38,20))				AS [Menge akt. Rechnung]		
	  ,CAST(0 AS NUMERIC(38,20))				AS [Menge akt. Lieferung]		
	  ,CAST(0 AS NUMERIC(38,20))				AS [Bereits gelieferte Menge]	
	  ,CAST(0 AS NUMERIC(38,20))				AS [Bereits berechnete Menge]
	  ,CAST(0 AS INT)							AS [Ist Archivbeleg]
	  ,[Bundesland]
  FROM [ein].[fEinkaufscontrolling95_2_Gutschrift]

  UNION ALL

SELECT [Mandant Code]
      ,[Belegnummer]					AS [Belegnummer]
	  ,[Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[Zeilennummer]				AS [Zeilennummer]
	  ,[Kauf von Kreditornummer]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Produktart]
      ,[Produktnummer]
      ,[Zeilenrabattbetrag]
      ,[Zahlung an Kreditornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge]
      ,[Menge (Basis)]
      ,[Einstandspreis]
	  ,[Menge] * [Einstandspreis] *-1				AS [Einheit Betrag]
	  ,[Betrag]
	  ,[Einkaufspreis (MW)]
      ,[Anlieferungsdatum Zugesagt]    
	  ,[Restauftragsbetrag]
      ,[Restauftragsmenge]
	  ,[Storno]
	  ,[Status]   		   		
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,[Gewünschtes Anlieferungsdatum]   
	  ,[Kauf von Kontakt]    		    					
	  ,[Beschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,[Geplantes Anlieferungsdatum]   	  			
	  ,[Zahlungsrabatt %]    	
	  ,[Skontodatum]    	
	  ,[Zlg.-Bedingungscode]   
	  ,[Dimension Set ID]
	  ,[Kreditor Rechnungsnummer]
	  ,[Kreditor Bestellnummer]
	  ,[Kreditor Liefernummer]
	  ,[Zuständigkeitseinheiten Code]
	  ,[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[Lieferbedingungscode]
	  ,[Lagerplatz Code]
	  ,[Kauf von Kontaktnummer]
	  ,[Rechnungsrabattbetrag]	
	  ,[Berechnungsart Rabatt]
	  ,[EK-Preis ohne MwSt.]		
	  ,[Menge akt. Rechnung]		
	  ,[Menge akt. Lieferung]		
	  ,[Bereits gelieferte Menge]		
	  ,[Bereits berechnete Menge] 
	  ,CAST(0 AS INT)							AS [Ist Archivbeleg]
	  ,[Bundesland]
  FROM [ein].[fEinkaufscontrolling95_2_Auftrag]

 UNION ALL

 SELECT [Mandant Code]
      ,[Belegnummer]					AS [Belegnummer]
	  ,[Belegart]
      ,[Buchungsdatum]
	  ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[Zeilennummer]				AS [Zeilennummer]
	  ,[Einkauf bei Kreditor Code]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Produktart]
      ,[Produktnummer]
      ,[Zeilenrabattbetrag]
      ,[Zahlung an Kreditornummer]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge]
      ,[Menge (Basis)]
      ,[Einstandspreis]
	  ,[Menge] * [Einstandspreis] *-1				AS [Einheit Betrag]
	  ,[Betrag]
	  ,[Einkaufsspreis]
      ,[Anlieferungsdatum Zugesagt]    
	  ,[Restauftragsbetrag]
      ,[Restauftragsmenge]
	  ,[Storno]
	  ,[Status]   		   		
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,[Gewünschtes Anlieferungsdatum]   
	  ,[Kauf von Kontakt]    		    					
	  ,[Beschreibung]    	
	  ,[Lagerort Code]    		
	  ,[Einheitencode]    	
	  ,[Geplantes Anlieferungsdatum]   	  			
	  ,[Skonto]    	
	  ,[Skontodatum]    	
	  ,[Zahlungsbedingungscode]   
	  ,[Dimension Set ID]
	  ,[Kreditor Rechnungsnummer]
	  ,[Kreditor Bestellnummer]
	  ,[Kreditor Liefernummer]
	  ,[Zuständigkeitseinheiten Code]
	  ,[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[Lieferbedingungscode]
	  ,[Lagerplatz Code]
	  ,[Kauf von Kontaktnummer]
	  ,[Rechnungsrabattbetrag]	
	  ,[Berechnungsart Rabatt]
	  ,[EK-Preis ohne MwSt.]		
	  ,[Menge akt. Rechnung]		
	  ,[Menge akt. Lieferung]		
	  ,[Bereits gelieferte Menge]		
	  ,[Bereits berechnete Menge] 
	  ,CAST(1 AS INT)							AS [Ist Archivbeleg]
	  ,[Bundesland]
  FROM [ein].[fEinkaufscontrolling80_2_ArchivMaxVersion]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKunde]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View dLagerplatz















-- Alter View dKunde
-- Alter View dDebitor
















CREATE VIEW [dim].[dKunde]AS
SELECT [Kundenname]			
      ,[Kundenname 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,[Länder Code]
      ,[Länderbezeichnung]
      ,[Kundennummer]
      ,[Suchbezeichnung]
      ,[Budgetierter Betrag]
      ,[Kreditlimit (MW)]
      ,[Debitorenbuchungsgruppe Code]
      ,[Debitorenbuchungsgruppenbezeichnung]
      ,[Währung Code]
      ,[Währungsbezeichnung]
      ,[Sprache Code]
      ,[Sprachenbezeichnung]
      ,[Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Debitorenrabattgruppe Code]
      ,[Debitorenrabattsgruppenbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Verkäufer Code]
      ,[Verkäuferbezeichnung]
      ,[Mandant Code]
      ,[Kontaktbezeichnung]
      ,[Kontaktnummer]
      ,[Gebiet Code]
      ,[Gebietsbezeichnung]
      ,[Postleitzahl]
      ,[Vorauszahlung %]
      ,[Lagerort Code]
	  ,[Lagerortbezeichnung]
      ,[Lieferbedingung Code]
      ,[Lieferbedingungsbezeichnung]
      ,[Preise inkl. MwST]
      ,[Cashflow-Zlg.-Bedingung Code]
      ,[Zahlungstoleranz]
      ,[Kundenname (Nummer)]
      ,[Kundennummer Bezeichnung]
	  ,[PK dKunde]
  FROM [dim].[dKunde85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dLieferant85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLieferant85_2_CONCAT
-- Alter View dKreditor85_2_CONCAT
















CREATE VIEW [dim].[dLieferant85_2_CONCAT] AS

SELECT [Lieferantname]
      ,[Lieferantname 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,[Länder Code]
      ,[Länderbezeichnung]
      ,[Lieferantnummer]
      ,[Suchbezeichnung]
      ,[Budgetierter Betrag]
      ,[Lieferantenbuchungsgruppe Code]
      ,[Lieferantenbuchungsgruppenbezeichnung]
      ,[Währung Code]
      ,[Währungsbezeichnung]
      ,[Sprache Code]
      ,[Sprachenbezeichnung]
      ,[Zlg.-Bedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Einkäufer Code]
      ,[Einkäufername]
      ,[Mandant Code]
      ,[Kontaktbezeichnung]
      ,[Kontakt Code]
      ,[Gebiet Code]
      ,[Gebietsbezeichnung]
      ,[Postleitzahl]
      ,[Vorauszahlung %]
      ,[Lagerort Code]
      ,[Lagerortbezeichnung]
      ,[Lieferbedingung Code]
      ,[Lieferbedingungsbezeichnung]
      ,[Preise inkl. MwST]
      ,[Cashflow-Zlg.-Bedingung Code]
      ,[Zahlungstoleranz]
	  ,CAST(ISNULL([Lieferantname],'''') AS NVARCHAR(100)) + '' ('' + CAST([Lieferantnummer] AS NVARCHAR(20)) + '')'' AS [Lieferantname (Nummer)]
      ,CAST(ISNULL([Lieferantnummer],'''') AS NVARCHAR(20)) + '' '' + CAST([Lieferantname] AS NVARCHAR(100)) AS [Lieferantnummer Bezeichnung]
	  ,[Mandant Code] +''_''+ [Lieferantnummer] AS [PK dLieferant]
  FROM [dim].[dLieferant90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenart]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenart


















CREATE VIEW [dim].[dKostenart] AS
SELECT [Kostenartbezeichnung]
      ,[Kostenartnummer]
      ,[Kostenstelle Code]
	  ,[Kostenstellenbezeichnung]
      ,[Kostenträger Code]
	  ,[Kostenträgerbezeichnung]
      ,[Gesperrt Code]
	  ,[Gesperrtbezeichnung DE]
	  ,[Gesperrtbezeichnung EN]
      ,[Mandant Code]
	  ,[Kostenartbezeichnung (Nummer)]
      ,[Kostenartnummer Bezeichnung]
	  ,[PK dKostenart]
  FROM [dim].[dKostenart85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZahlungsbedingungen95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dZahlungsbedingungen95_2









/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dim].[dZahlungsbedingungen95_2] AS
SELECT [Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Mandant Code]
  FROM [vv].[vBC_t0000003_Zahlungsbedingungen]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling70_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling70_2


































CREATE VIEW [ein].[fEinkaufscontrolling70_2] AS 

SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Belegart]
      ,[Buchungsdatum]
      ,[Belegdatum]
      ,[Währung Code]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,ISNULL([Zeilennummer],0)							AS [Zeilennummer]
      ,ISNULL([Kauf von Kreditornummer],'''')				AS [Kauf von Kreditornummer]
      ,ISNULL([Kostenstellencode],'''')		AS [Kostenstellencode]
      ,ISNULL([Kostenträgercode],'''')		AS [Kostenträgercode]
      ,ISNULL([Produktart],0)					AS [Produktart]
      ,ISNULL([Produktnummer],'''')						AS [Produktnummer]
      ,ISNULL([Zeilenrabattbetrag],0)				AS [Zeilenrabattbetrag]
      ,ISNULL([Zahlung an Kreditornummer],'''')				AS [Zahlung an Kreditornummer]
      ,ISNULL([Rechnungsrabattbetrag],0)				AS [Rechnungsrabattbetrag]
      ,ISNULL([Zeilenbetrag],0)						AS [Zeilenbetrag]
      ,ISNULL([Menge],0)							AS [Menge]
      ,ISNULL([Menge (Basis)],0)					AS [Menge (Basis)]
      ,ISNULL([Einstandspreis],0)						AS [Einstandspreis]
      ,ISNULL([Einheit Betrag],0)						AS [Einheit Betrag]
      ,ISNULL([Betrag],0)							AS [Betrag]
      ,ISNULL([Verkaufspreis (MW)],0)					AS [Verkaufspreis (MW)]
      ,ISNULL([Anlieferungsdatum Zugesagt],'''')			AS [Anlieferungsdatum Zugesagt]
      ,ISNULL([Restauftragsbetrag],0)				AS [Restauftragsbetrag]
      ,ISNULL([Restauftragsmenge],0)				AS [Restauftragsmenge]
      ,[Storno Flag]				
	  ,[Auftragsdatum]    			
	  ,[Fälligkeitsdatum]    				
	  ,[Gewünschtes Warenausgangsdatum]   
	  ,[Kauf von Kontakt]    		    					
	  ,[Beschreibung]
      ,[Lagerort Code]
      ,[Einheitencode] 	
	   ,[Geplantes Anlieferungsdatum]
      ,[Skonto]
      ,[Skontodatum]
      ,[Zahlungsbedingung Code]
	  ,[Dimension Set ID]
	  ,[Kreditor Rechnungsnummer]
      ,[Kreditor Bestellnummer]
      ,[Kreditor Liefernummer]
	  ,[Zuständigkeitseinheiten Code]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[Lieferbedingung Code]
      ,[Lagerplatz Code]
      ,[Kauf von Kontaktnummer]
      ,[Rabattwert]
	  ,[Berechnungsart Rabatt]
      ,[EK-Preis ohne MwSt.]	
	  ,[Menge akt. Rechnung]
      ,[Menge akt. Lieferung]
      ,[Bereits gelieferte Menge]
      ,[Bereits berechnete Menge]
	  ,[Ist Archivbeleg]
	  ,[Status]
	  ,CAST(CASE WHEN [Belegart] = 1 AND [Status] = 1 THEN 1 
																ELSE 0 
		END AS TINYINT) AS [Auftrag veröffentlicht]
	  ,[Bundesland]
  FROM [ein].[fEinkaufscontrolling75_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenstelle85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenstelle85_2_CONCAT














CREATE VIEW [dim].[dKostenstelle85_2_CONCAT] AS 
SELECT [Kostenstellenbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Kostenstelle Code]
      ,[Zuständige Person]
      ,[Sortierreihenfolge]
      ,[Mandant Code]
	  ,[Kostenunterart Code]
	  ,[Kostenunterartbezeichnung DE]
	  ,[Kostenunterartbezeichnung EN]
	  ,CAST(ISNULL([Kostenstellenbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Kostenstelle Code] AS NVARCHAR(20)) + '')'' AS [Kostenstellenbezeichnung (Code)]
      ,CAST(ISNULL([Kostenstelle Code],'''') AS NVARCHAR(20)) + '' '' + CAST([Kostenstellenbezeichnung] AS NVARCHAR(100)) AS [Kostenstelle Code Bezeichnung]
	  ,[Mandant Code] +''_''+ [Kostenstelle Code] AS [PK dKostenstelle]
  FROM [dim].[dKostenstelle90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000025_Kreditorenposten95_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000025_Kreditorenposten95_2
























CREATE   VIEW [vv].[vBC_t0000025_Kreditorenposten95_2] AS					  
SELECT [Entry No_]					   AS [Kreditorenposten Lfd.]												-- Kreditorenposten Lfd. 
	  ,[Description]				   AS [Beschreibung]														-- Beschreibung
      ,[Vendor No_]					   AS [Kreditornummer]														-- Kreditornummer
      ,[Posting Date]				   AS [Buchungsdatum]														-- Buchungsdatum 
      ,[Document Type]				   AS [Belegartcode]														-- Belegartcode
      ,[Document No_]				   AS [Belegnummer]															-- Belehnummer
      ,[Currency Code]				   AS [Währung Code]														-- Währungscode
      ,[Inv_ Discount (LCY)]		   AS [Rechnungsrabatt (MW)]												-- Rechnungsrabatt (MW)
      ,[Buy-from Vendor No_]		   AS [Einkauf von Kreditornummer]											-- Einkauf von Kreditornummer
      ,[Vendor Posting Group]		   AS [Lieferantenbuchungsgruppe Code]										-- Lieferantenbuchungsgruppe Code
      ,[Purchaser Code]				   AS [Einkäufer Code]														-- Einkäufer Code
      ,[On Hold]					   AS [Abwarten]															-- Abwarten
      ,[Applies-to Doc_ Type]		   AS [Ausgeglichen mit Belegart]											-- Ausgeglichen mit Belegart
      ,[Applies-to Doc_ No_]		   AS [Ausgeglichen mit Belegnummer]										-- Ausgeglichen mit Belegnummer
      ,[Open]						   AS [Offen]															-- Offen Flag
      ,[Due Date]					   AS [Fälligkeitsdatum]													-- Fälligkeitsdatum
      ,[Pmt_ Discount Date]			   AS [Skontodatum]															-- Skontodatum
      ,[Pmt_ Disc_ Rcd_(LCY)]		   AS [Zahlungsrabatt erhalten (MW)]										-- Skonto erhalten (MW) 
      ,[Closed by Amount (LCY)]		   AS [Geschlossen mit Betrag (MW)]											-- Geschlossen mit Betrag (MW)
      ,[Document Date]				   AS [Belegdatum]															-- Belegdatum
      ,[External Document No_]		   AS [Externe Belegnummer]													-- externe Belegnummer
      ,[Applying Entry]				   AS [Ausgleichposten]														-- Ausgleichposten
      ,[Reversed]					   AS [storniert]															-- storniert
      ,[Prepayment]					   AS [im vorraus bezahlt]													-- im vorraus bezahlt
      ,[Global Dimension 1 Code]	   AS [Kostenstellencode]	-- Global Dimension Code 1 (entweder Kostenstelle o. Kostenträger)
      ,[Global Dimension 2 Code]	   AS [Kostenträgercode]	-- Global Dimension Code 2 (entweder Kostenstelle o. Kostenträger)
	  ,[Closed by Entry No_]		   AS [Geschlossen von Lfd. Nr.]		  									-- Geschlossen von Lfd. Nr.
      ,[Closed at Date]				   AS [Geschlossen am]														-- Geschlossen am
	  ,[Bal_ Account Type]			   AS [Bilanzkontotyp]													-- 
	  ,[Reason Code]				   AS [Ursache Code]				  											-- Ursachecode
	  ,[Applies-to ID]				   AS [Gehört zu ID]														-- Gehört zu ID
	  ,[Pmt_ Disc_ Tolerance Date]	   AS [Skontotoleranzdatum]													-- Skontotoleranzdatum
	  ,[Payment Method Code]		   AS [Zahlungsbedingung Code]												-- Zahlungsbedinungscode
      ,[SG_MandantCode]				   AS [Mandant Code]														-- Mandant ID
      ,[SG_Bundesland]					   AS [Bundesland]															-- Bundesland
  FROM [fin].[BC_t0000025_Vendor_Ledger_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000025_Kreditorenposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000025_Kreditorenposten







CREATE VIEW [vv].[vBC_t0000025_Kreditorenposten]
AS
SELECT [Kreditorenposten Lfd.]
      ,[Beschreibung]
      ,[Kreditornummer]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Buchungsdatum])					AS [Buchungsdatum]
      ,[Belegartcode]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Rechnungsrabatt (MW)]
      ,[Einkauf von Kreditornummer]
      ,[Lieferantenbuchungsgruppe Code]
      ,[Einkäufer Code]
      ,[Abwarten]
      ,[Ausgeglichen mit Belegart]
      ,[Ausgeglichen mit Belegnummer]
      ,[Offen]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Fälligkeitsdatum])				AS [Fälligkeitsdatum]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontodatum])						AS [Skontodatum]
      ,[Zahlungsrabatt erhalten (MW)]
      ,[Geschlossen mit Betrag (MW)]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Belegdatum])						AS [Belegdatum]
      ,[Externe Belegnummer]
      ,[Ausgleichposten]
      ,[storniert]
      ,[im vorraus bezahlt]
      ,[Kostenstellencode]
      ,[Kostenträgercode]
      ,[Geschlossen von Lfd. Nr.]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Geschlossen am])					AS [Geschlossen am]
      ,[Bilanzkontotyp]
      ,[Ursache Code]
      ,[Gehört zu ID]
      ,[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]([Skontotoleranzdatum])				AS [Skontotoleranzdatum]
      ,[Zahlungsbedingung Code]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [vv].[vBC_t0000025_Kreditorenposten95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZahlungsbedingungen90_2]'))
EXEC dbo.sp_executesql @statement = N'/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dim].[dZahlungsbedingungen90_2] AS
SELECT [Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Mandant Code]
  FROM [dim].[dZahlungsbedingungen95_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZahlungsbedingungen85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'


CREATE VIEW [dim].[dZahlungsbedingungen85_2_CONCAT] AS 
SELECT [Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
	  ,CAST(ISNULL([Zahlungsbedingungsbezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Zahlungsbedingung Code] AS NVARCHAR(10)) + '')'' AS [Zahlungsbedingungsbezeichnung (Code)]
      ,CAST(ISNULL([Zahlungsbedingung Code],'''') AS NVARCHAR(10)) + '' '' + CAST([Zahlungsbedingungsbezeichnung] AS NVARCHAR(100)) AS [Zahlungsbedingung Code Bezeichnung]
      ,[Mandant Code]
	  ,[Mandant Code] +''_''+ [Zahlungsbedingung Code] AS [PK dZahlungsbedingungen]
  FROM [dim].[dZahlungsbedingungen90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005805_Artikel_Zu_Abschl_Zuw_EK]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005805_Artikel_Zu_Abschl_Zuw_EK







CREATE VIEW [vv].[vBC_t0005805_Artikel_Zu_Abschl_Zuw_EK] AS
SELECT [Document Type]			AS [Belegart]				-- Belegart	
      ,[Document No_]			AS [Belegnummer]			-- Belegnummer
      ,[Line No_]				AS [Zeilennummer]			-- Zeilennummer
      ,[Document Line No_]		AS [Belegzeilenummer]		-- Belegzeilenummer
      ,[Qty_ to Assign]			AS [Menge fuer Zuweisung]	-- Menge fuer Zuweisung
      ,[Qty_ Assigned]			AS [Zugewiesene Menge]		-- Zugewiesene Menge
      ,[SG_MandantCode]			AS [Mandant Code]			-- Mandant
      ,[SG_Bundesland]				AS [Bundesland]				-- Bundesland
  FROM [ein].[BC_t0005805_Item_Charge_Assignment_Purch]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling68_2_ZugewieseneMenge]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling68_2_ZugewieseneMenge









CREATE VIEW [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge] AS
SELECT [Belegart]
      ,[Belegnummer]
      ,[Belegzeilenummer]
      ,SUM([Menge fuer Zuweisung])	AS [Menge fuer Zuweisung]
      ,SUM([Zugewiesene Menge])		AS [Zugewiesene Menge]
      ,[Mandant Code]
      ,[Bundesland]
  FROM [vv].[vBC_t0005805_Artikel_Zu_Abschl_Zuw_EK]
  GROUP BY 
	   [Belegart]
      ,[Belegnummer]
      ,[Belegzeilenummer]
	  ,[Mandant Code]
      ,[Bundesland]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dLieferant]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dLieferant
-- Alter View dKreditor
















CREATE VIEW [dim].[dLieferant]AS
SELECT [Lieferantname]
      ,[Lieferantname 2]
      ,[Adresse]
      ,[Adresse 2]
      ,[Ort]
      ,[Länder Code]
      ,[Länderbezeichnung]
      ,[Lieferantnummer]
      ,[Suchbezeichnung]
      ,[Budgetierter Betrag]
      ,[Lieferantenbuchungsgruppe Code]
      ,[Lieferantenbuchungsgruppenbezeichnung]
      ,[Währung Code]
      ,[Währungsbezeichnung]
      ,[Sprache Code]
      ,[Sprachenbezeichnung]
      ,[Zlg.-Bedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Einkäufer Code]
      ,[Einkäufername]
      ,[Mandant Code]
      ,[Kontaktbezeichnung]
      ,[Kontakt Code]
      ,[Gebiet Code]
      ,[Gebietsbezeichnung]
      ,[Postleitzahl]
      ,[Vorauszahlung %]
      ,[Lagerort Code]
      ,[Lagerortbezeichnung]
      ,[Lieferbedingung Code]
      ,[Lieferbedingungsbezeichnung]
      ,[Preise inkl. MwST]
      ,[Cashflow-Zlg.-Bedingung Code]
      ,[Zahlungstoleranz]
      ,[Lieferantname (Nummer)]
      ,[Lieferantnummer Bezeichnung]
      ,[PK dLieferant]
  FROM [dim].[dLieferant85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000292_Mahnmethode]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000292_Mahnmethode










CREATE VIEW [vv].[vBC_t0000292_Mahnmethode] AS
SELECT [Code]			 AS [Mahnmethode Code]			-- Mahnmethodencode
      ,[Description]	 AS [Mahnmethodenbezeichnung]	-- Mahnmethodenbezeichnung
      ,[SG_MandantCode]	 AS [Mandant Code]					-- Mandant ID
  FROM [fin].[BC_t0000292_Reminder_Terms]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMahnstufe95_2_DEFAULT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dMahnstufe95_2_DEFAULT










CREATE VIEW [dim].[dMahnstufe95_2_DEFAULT] AS
--in BC gibt es für eine nicht gesetzte Mahnstufe keine Stammdaten, diese werden in dieser Sicht generiert und zwar pro Mahnmethode
SELECT CAST(0 AS INT) AS [Mahnstufe]
	  ,[Mahnmethode Code]
      ,[Mahnmethodenbezeichnung]
      ,[Mandant Code]
  FROM [vv].[vBC_t0000292_Mahnmethode]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling65_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling65_2















































CREATE VIEW [ein].[fEinkaufscontrolling65_2] AS 

SELECT [ein].[fEinkaufscontrolling70_2].[Mandant Code]
      ,[ein].[fEinkaufscontrolling70_2].[Belegnummer]
	  ,[ein].[fEinkaufscontrolling70_2].[Belegart]
      ,[ein].[fEinkaufscontrolling70_2].[Buchungsdatum]
	  ,[ein].[fEinkaufscontrolling70_2].[Belegdatum]
      ,[ein].[fEinkaufscontrolling70_2].[Währung Code]
      ,[ein].[fEinkaufscontrolling70_2].[Währungsfaktor]
	  ,[ein].[fEinkaufscontrolling70_2].[Storno Flag]	
      ,[ein].[fEinkaufscontrolling70_2].[Einkäufer Code]      
      ,[ein].[fEinkaufscontrolling70_2].[Kauf von Kreditornummer]      
      ,[ein].[fEinkaufscontrolling70_2].[Kostenstellencode]
      ,[ein].[fEinkaufscontrolling70_2].[Kostenträgercode]
      ,[ein].[fEinkaufscontrolling70_2].[Produktart]
      ,[ein].[fEinkaufscontrolling70_2].[Zeilennummer]
      ,[ein].[fEinkaufscontrolling70_2].[Produktnummer]
	  --wenn die Produktart = 2 ist, dann handelt es sich um einen Artikel, andernfalss Ressource oder Sachkonto
	  ,CASE WHEN [ein].[fEinkaufscontrolling70_2].[Produktart] = 2 THEN [ein].[fEinkaufscontrolling70_2].[Produktnummer]
																			ELSE ''''
	   END AS [Artikelnummer]
      ,[Zahlung an Kreditornummer]
	  --2020-02-21 Anpassungswunsch NSchuette - JW
	  --Ansonsten ist die Marge höher als der Betrag
      ,[ein].[fEinkaufscontrolling70_2].[Einheit Betrag] * -1	AS [Einheit Betrag]
      ,[ein].[fEinkaufscontrolling70_2].[Einstandspreis] * -1		AS [Einstandspreis]		
	  ,[ein].[fEinkaufscontrolling70_2].[Auftragsdatum]    			
	  ,[ein].[fEinkaufscontrolling70_2].[Fälligkeitsdatum]    				
	  ,[ein].[fEinkaufscontrolling70_2].[Gewünschtes Warenausgangsdatum]   
	  ,[ein].[fEinkaufscontrolling70_2].[Kauf von Kontakt]    		    					
	  ,[ein].[fEinkaufscontrolling70_2].[Beschreibung]    	
	  ,[ein].[fEinkaufscontrolling70_2].[Lagerort Code]    		
	  ,[ein].[fEinkaufscontrolling70_2].[Einheitencode]    	
	  ,[ein].[fEinkaufscontrolling70_2].[Geplantes Anlieferungsdatum]   					
	  ,[ein].[fEinkaufscontrolling70_2].[Skonto]    	
	  ,[ein].[fEinkaufscontrolling70_2].[Skontodatum]    	
	  ,[ein].[fEinkaufscontrolling70_2].[Zahlungsbedingung Code]
	  ,[ein].[fEinkaufscontrolling70_2].[Dimension Set ID]
	  ,[ein].[fEinkaufscontrolling70_2].[Kreditor Rechnungsnummer]
	  ,[ein].[fEinkaufscontrolling70_2].[Kreditor Bestellnummer]
	  ,[ein].[fEinkaufscontrolling70_2].[Kreditor Liefernummer]
	  ,[ein].[fEinkaufscontrolling70_2].[Zuständigkeitseinheiten Code]
	  ,[ein].[fEinkaufscontrolling70_2].[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[ein].[fEinkaufscontrolling70_2].[Lieferbedingung Code]
	  ,[ein].[fEinkaufscontrolling70_2].[Lagerplatz Code]
	  ,[ein].[fEinkaufscontrolling70_2].[Kauf von Kontaktnummer]
	  ,[ein].[fEinkaufscontrolling70_2].[Bundesland]
	  ,[ein].[fEinkaufscontrolling70_2].[Status]
	  ,[ein].[fEinkaufscontrolling70_2].[Anlieferungsdatum Zugesagt]
	  ,[ein].[fEinkaufscontrolling70_2].[Ist Archivbeleg]
--Kennzahlen  
	  ,[ein].[fEinkaufscontrolling70_2].[Betrag] 
      ,[ein].[fEinkaufscontrolling70_2].[Rechnungsrabattbetrag]
      ,[ein].[fEinkaufscontrolling70_2].[Zeilenbetrag]
      ,[ein].[fEinkaufscontrolling70_2].[Menge (Basis)]
	  ,[ein].[fEinkaufscontrolling70_2].[Menge]
      ,[ein].[fEinkaufscontrolling70_2].[Zeilenrabattbetrag]
	  ,IIF([ein].[fEinkaufscontrolling70_2].[Berechnungsart Rabatt] = 2, [ein].[fEinkaufscontrolling70_2].[Rabattwert] * 100, 0) AS [Rechnungsrabatt in %]	
	  ,[ein].[fEinkaufscontrolling70_2].[Berechnungsart Rabatt]
	  --EK-Preis ohne MwSt.
	  ,[ein].[fEinkaufscontrolling70_2].[EK-Preis ohne MwSt.]		
	  --Einkaufsmenge
	  ,CASE WHEN [ein].[fEinkaufscontrolling70_2].[Belegart] IN (0, 1)
			THEN [ein].[fEinkaufscontrolling70_2].[Menge]																				
			ELSE 0
			END AS [Einkaufsmenge]
	  --Reservierte Menge
	  ,CASE WHEN [ein].[fEinkaufscontrolling70_2].[Belegart] IN (1)
			THEN 0																				
			ELSE 0
			END AS [Reservierte Menge]
	  --Einkaufsbetrag ohne MwSt.
	  ,CASE WHEN [ein].[fEinkaufscontrolling70_2].[Belegart] IN (1)
			THEN [ein].[fEinkaufscontrolling70_2].[Zeilenbetrag]																				
			ELSE 0
			END AS [Einkaufsbetrag ohne MwSt.]
	  --Menge aktuelle Lieferung
	  ,CASE WHEN [ein].[fEinkaufscontrolling70_2].[Belegart] IN (1)
			THEN [ein].[fEinkaufscontrolling70_2].[Menge akt. Lieferung]																				
			ELSE 0
			END AS [Menge akt. Lieferung]
	  --Bereits gelieferte Menge
	  ,CASE WHEN [ein].[fEinkaufscontrolling70_2].[Belegart] IN (1)
			THEN [ein].[fEinkaufscontrolling70_2].[Bereits gelieferte Menge]																				
			ELSE 0
			END AS [Bereits gelieferte Menge]
	  --Menge aktuelle Rechnung
	  ,CASE WHEN [ein].[fEinkaufscontrolling70_2].[Belegart] IN (1)
			THEN [ein].[fEinkaufscontrolling70_2].[Menge akt. Rechnung]																				
			ELSE 0
			END AS [Menge akt. Rechnung]
	  --Bereits berechnete Menge
	  ,CASE WHEN [ein].[fEinkaufscontrolling70_2].[Belegart] IN (1)
			THEN [ein].[fEinkaufscontrolling70_2].[Bereits berechnete Menge]																				
			ELSE 0
			END AS [Bereits berechnete Menge]
	   --Menge für Zuweisung
	  ,CASE WHEN [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Belegart] IN (1)
			THEN [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Menge fuer Zuweisung]																				
			ELSE 0
			END AS [Menge fuer Zuweisung]
	   -- Zugewiesene Menge
	  ,CASE WHEN [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Belegart] IN (1)
			THEN [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Zugewiesene Menge]																				
			ELSE 0
			END AS [Zugewiesene Menge]
  FROM [ein].[fEinkaufscontrolling70_2]

  LEFT JOIN [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge]	   
  ON [ein].[fEinkaufscontrolling70_2].[Mandant Code] 		   =  [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Mandant Code] 		 
  AND [ein].[fEinkaufscontrolling70_2].[Belegnummer]		   =  [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Belegnummer]		 
  ANd [ein].[fEinkaufscontrolling70_2].[Belegart]    =  [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Belegart]
  AND [ein].[fEinkaufscontrolling70_2].[Zeilennummer]			   =  [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Belegzeilenummer]			 
  AND [ein].[fEinkaufscontrolling70_2].[Bundesland]				   =  [ein].[fEinkaufscontrolling68_2_ZugewieseneMenge].[Bundesland]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dZahlungsbedingungen]'))
EXEC dbo.sp_executesql @statement = N'
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dim].[dZahlungsbedingungen] AS
SELECT [Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Zahlungsbedingungsbezeichnung (Code)]
      ,[Zahlungsbedingung Code Bezeichnung]
      ,[Mandant Code]
      ,[PK dZahlungsbedingungen]
  FROM [dim].[dZahlungsbedingungen85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild95_2]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View dBilanzParentChild95_2






































CREATE VIEW [dim].[dBilanzParentChild95_2]

AS 

SELECT [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Mandant Code]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Strukturbezeichnung] AS [Strukturbezeichnung]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Child Code] AS [Child Code]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Childbezeichnung] AS [Childbezeichnung]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Child Zeilennummer] AS [Child Zeilennummer]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Parent Code] AS [Parent Code]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Sachkontonummer] AS [Sachkontonummer]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Sachkontobezeichnung] AS [Sachkontobezeichnung]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Parentbezeichnung] AS [Parentbezeichnung]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Parent Zeilennummer] AS [Parent Zeilennummer]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Ist Sachkonto]
	  --Lösung für das Reporting. Dann kann der Betrag direkt mit der Vorzeichenumkehr multipiziert werden (26.01.2021 - JH)
	  ,IIF([fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Umkehr Code] = 1, -1, 1) AS [Umkehr Code]
  FROM [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung]

  --filter on balance sheet data
  INNER JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Mandant Code]	   = [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]
  AND [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Strukturbezeichnung] = [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Name des Bilanz-Reports]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMahnstufe95_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dMahnstufe95_2












CREATE VIEW [dim].[dMahnstufe95_2] AS
SELECT [vv].[vBC_t0000293_Mahnstufe].[Mahnstufe]
      ,[vv].[vBC_t0000293_Mahnstufe].[Mahnmethode Code]
	  ,[vv].[vBC_t0000292_Mahnmethode].[Mahnmethodenbezeichnung]
      ,[vv].[vBC_t0000293_Mahnstufe].[Mandant Code]
  FROM [vv].[vBC_t0000293_Mahnstufe]

  LEFT JOIN [vv].[vBC_t0000292_Mahnmethode]
  ON [vv].[vBC_t0000293_Mahnstufe].[Mandant Code] = [vv].[vBC_t0000292_Mahnmethode].[Mandant Code]
  AND [vv].[vBC_t0000293_Mahnstufe].[Mahnmethode Code] = [vv].[vBC_t0000292_Mahnmethode].[Mahnmethode Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBilanzParentChild90_2






























CREATE VIEW [dim].[dBilanzParentChild90_2]

AS

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
	  ,[Childbezeichnung]
	  ,[Sachkontonummer]
	  ,[Sachkontobezeichnung]
      ,[Child Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
	  ,[Ist Sachkonto]
	  ,[Umkehr Code]
  FROM [dim].[dBilanzParentChild95_2]

UNION

SELECT DISTINCT
       [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Parent Code]
      ,[Parentbezeichnung] AS [Childbezeichnung]
	  ,CAST(0 AS NVARCHAR(20)) AS [Sachkontonummer]
	  ,CAST('''' AS NVARCHAR(80)) AS [Sachkontobezeichnung]
      ,[Parent Zeilennummer] AS [Positionsnummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
	  ,CAST(''False'' AS BIT) AS [Ist Sachkonto]
	  ,[Umkehr Code]
  FROM [dim].[dBilanzParentChild95_2]
  WHERE [Parent Code] NOT IN (SELECT [Child Code] FROM [dim].[dBilanzParentChild95_2])
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMahnstufe90_2_UNION]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dMahnstufe90_2_UNION












CREATE VIEW [dim].[dMahnstufe90_2_UNION] AS
SELECT [Mahnstufe]
      ,[Mahnmethode Code]
      ,[Mahnmethodenbezeichnung]
      ,[Mandant Code]
  FROM [dim].[dMahnstufe95_2]

  UNION ALL

SELECT [Mahnstufe]
      ,[Mahnmethode Code]
      ,[Mahnmethodenbezeichnung]
      ,[Mandant Code]
  FROM [dim].[dMahnstufe95_2_DEFAULT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild85_2_Sachkonto]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBilanzParentChild85_2_Sachkonto


































CREATE VIEW [dim].[dBilanzParentChild85_2_Sachkonto]

AS

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
      ,[Childbezeichnung]
	  ,[Child Zeilennummer]
	  ,[Parent Code]
	  ,[Sachkontonummer]
	  ,[Sachkontobezeichnung]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
	  ,[Ist Sachkonto]
	  ,[Umkehr Code]
  FROM [dim].[dBilanzParentChild90_2]
  -- Bedinung wurde umgedreht. Wenn = True kommt es zu einem Konvertierungsfehler, nicht behebar (JW - 15.12.2020)
  WHERE [Ist Sachkonto] != ''False''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMahnstufe85_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dMahnstufe85_2_CONCAT















CREATE VIEW [dim].[dMahnstufe85_2_CONCAT] AS
SELECT [Mahnstufe]
      ,[Mahnmethode Code]
      ,[Mahnmethodenbezeichnung]
	  ,CAST(ISNULL([Mahnmethodenbezeichnung],'''') AS NVARCHAR(50)) + '' ('' + CAST([Mahnmethode Code] AS NVARCHAR(20)) + '')'' AS [Mahnmethodenbezeichnung (Code)]
      ,CAST(ISNULL([Mahnmethode Code],'''') AS NVARCHAR(20)) + '' '' + CAST([Mahnmethodenbezeichnung] AS NVARCHAR(50)) AS [Mahnmethode Code Bezeichnung]
	  ,[Mandant Code] +''_''+ [Mahnmethode Code] +''_''+ CONVERT(NVARCHAR(2),[Mahnstufe]) AS [PK dMahnstufe]
      ,[Mandant Code]
  FROM [dim].[dMahnstufe90_2_UNION]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005714_Zuständigkeitseinheit]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005714_Zuständigkeitseinheit







CREATE VIEW [vv].[vBC_t0005714_Zuständigkeitseinheit] AS
SELECT [Name]			  AS [Zuständigkeiteinheiten Name]	  -- Zuständigkeiteinheiten Name
      ,[Code]			  AS [Zuständigkeiteinheiten Code]	  -- Zuständigkeiteinheiten Code
      ,[SG_MandantCode]	  AS [Mandant Code]					  -- Mandant ID
  FROM [com].[BC_t0005714_Responsibility_Center]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling55_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling55_2














































CREATE VIEW [ein].[fEinkaufscontrolling55_2]

 AS  

SELECT [ein].[fEinkaufscontrolling65_2].[Mandant Code]
      ,[ein].[fEinkaufscontrolling65_2].[Belegnummer]
      ,[ein].[fEinkaufscontrolling65_2].[Artikelnummer]
	  ,[ein].[fEinkaufscontrolling65_2].[Produktnummer]
	  ,[ein].[fEinkaufscontrolling65_2].[Belegart]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')					AS [Belegartbezeichnung DE]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')						AS [Belegartbezeichnung EN]
      ,[ein].[fEinkaufscontrolling65_2].[Buchungsdatum]
      ,[ein].[fEinkaufscontrolling65_2].[Belegdatum]
	  ,[ein].[fEinkaufscontrolling65_2].[Storno Flag] AS [Storno Code]
	  ,ISNULL([Stornobezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')					AS [Stornobezeichnung DE]
	  ,ISNULL([Stornobezeichnung].[Optionsfeldbezeichnung EN],''not defined'')						AS [Stornobezeichnung EN]
      ,[ein].[fEinkaufscontrolling65_2].[Währung Code]
	  ,[vv].[vBC_t0000004_Währung].[Währungsbezeichnung]
      ,[ein].[fEinkaufscontrolling65_2].[Währungsfaktor]
      ,[ein].[fEinkaufscontrolling65_2].[Einkäufer Code]
      ,[ein].[fEinkaufscontrolling65_2].[Zeilennummer]
      ,[ein].[fEinkaufscontrolling65_2].[Kauf von Kreditornummer]
	  ,[Kauf von Kreditor].[Lieferantname] AS [Kauf von Kreditorbezeichnung]
	  --in der General Ledger Setup Tabelle ist defineirt on welchem Shortcut Dim Code welcher Dimensionswert steht
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenstellencode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenstelle Code]
																					,[ein].[fEinkaufscontrolling65_2].[Kostenstellencode]
																					,[ein].[fEinkaufscontrolling65_2].[Kostenträgercode]) 
		AS [Kostenstelle Code]
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenträgercode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenträger Code]
																					,[ein].[fEinkaufscontrolling65_2].[Kostenträgercode]
																					,[ein].[fEinkaufscontrolling65_2].[Kostenstellencode]) 
		AS [Kostenträger Code]
      ,[ein].[fEinkaufscontrolling65_2].[Produktart]
      ,[ein].[fEinkaufscontrolling65_2].[Zahlung an Kreditornummer]
	  ,[ein].[fEinkaufscontrolling65_2].[Bundesland]  	
	  ,[ein].[fEinkaufscontrolling65_2].[Status]
	  ,ISNULL([Statusbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')							AS [Statusbezeichnung DE]
	  ,ISNULL([Statusbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')								AS [Statusbezeichnung EN]
	  ,[ein].[fEinkaufscontrolling65_2].[Kreditor Rechnungsnummer]
	  ,[ein].[fEinkaufscontrolling65_2].[Kreditor Bestellnummer]
	  ,[ein].[fEinkaufscontrolling65_2].[Kreditor Liefernummer]
	  ,[ein].[fEinkaufscontrolling65_2].[Zuständigkeitseinheiten Code]
	  ,[vv].[vBC_t0005714_Zuständigkeitseinheit].[Zuständigkeiteinheiten Name]
	  ,[ein].[fEinkaufscontrolling65_2].[MwSt.-Geschäftsbuchungsgruppe Code]
	  ,[ein].[fEinkaufscontrolling65_2].[Lieferbedingung Code]
	  ,[vv].[vBC_t0000010_Lieferbedingung].[Lieferbedingungsbezeichnung]
	  ,[ein].[fEinkaufscontrolling65_2].[Lagerplatz Code]
	  ,[ein].[fEinkaufscontrolling65_2].[Kauf von Kontaktnummer]
	  ,[ein].[fEinkaufscontrolling65_2].[Auftragsdatum]    			
	  ,[ein].[fEinkaufscontrolling65_2].[Fälligkeitsdatum]    				
	  ,[ein].[fEinkaufscontrolling65_2].[Gewünschtes Warenausgangsdatum]   
	  ,[ein].[fEinkaufscontrolling65_2].[Kauf von Kontakt]    		    					
	  ,[ein].[fEinkaufscontrolling65_2].[Beschreibung]    	
	  ,[ein].[fEinkaufscontrolling65_2].[Lagerort Code]    	
	  ,[vv].[vBC_t0000014_Lagerort].[Lagerortbezeichnung]
	  ,[ein].[fEinkaufscontrolling65_2].[Einheitencode]    	
	  ,[ein].[fEinkaufscontrolling65_2].[Geplantes Anlieferungsdatum]   	
	  ,[ein].[fEinkaufscontrolling65_2].[Skonto]    	
	  ,[ein].[fEinkaufscontrolling65_2].[Skontodatum]    	
	  ,[ein].[fEinkaufscontrolling65_2].[Zahlungsbedingung Code]
	  ,[vv].[vBC_t0000003_Zahlungsbedingungen].[Zahlungsbedingungsbezeichnung]
	  ,[ein].[fEinkaufscontrolling65_2].[Anlieferungsdatum Zugesagt]
	  ,[ein].[fEinkaufscontrolling65_2].[Ist Archivbeleg]
	  --Kennzahlen
      ,[ein].[fEinkaufscontrolling65_2].[Einheit Betrag]
      ,[ein].[fEinkaufscontrolling65_2].[Einstandspreis]
      ,[ein].[fEinkaufscontrolling65_2].[Betrag]
      ,[ein].[fEinkaufscontrolling65_2].[Rechnungsrabattbetrag]
      ,[ein].[fEinkaufscontrolling65_2].[Zeilenbetrag]
      ,[ein].[fEinkaufscontrolling65_2].[Menge (Basis)]
      ,[ein].[fEinkaufscontrolling65_2].[Menge]
      ,[ein].[fEinkaufscontrolling65_2].[Zeilenrabattbetrag]
      ,[ein].[fEinkaufscontrolling65_2].[Rechnungsrabatt in %]
      ,[ein].[fEinkaufscontrolling65_2].[EK-Preis ohne MwSt.]
      ,[ein].[fEinkaufscontrolling65_2].[Einkaufsmenge]
      ,[ein].[fEinkaufscontrolling65_2].[Reservierte Menge]
      ,[ein].[fEinkaufscontrolling65_2].[Einkaufsbetrag ohne MwSt.]
      ,[ein].[fEinkaufscontrolling65_2].[Menge akt. Lieferung]
      ,[ein].[fEinkaufscontrolling65_2].[Bereits gelieferte Menge]
      ,[ein].[fEinkaufscontrolling65_2].[Menge akt. Rechnung]
      ,[ein].[fEinkaufscontrolling65_2].[Bereits berechnete Menge]
      ,[ein].[fEinkaufscontrolling65_2].[Menge fuer Zuweisung]
      ,[ein].[fEinkaufscontrolling65_2].[Zugewiesene Menge]
  FROM [ein].[fEinkaufscontrolling65_2]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [ein].[fEinkaufscontrolling65_2].[Mandant Code] = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]

  LEFT JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON [ein].[fEinkaufscontrolling65_2].[Mandant Code] = [vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]

  LEFT JOIN [vv].[vBC_t0000004_Währung]
  ON [ein].[fEinkaufscontrolling65_2].[Mandant Code] = [vv].[vBC_t0000004_Währung].[Mandant Code]
  AND [ein].[fEinkaufscontrolling65_2].[Währung Code] = [vv].[vBC_t0000004_Währung].[Währung Code]

  LEFT JOIN [vv].[vBC_t0000010_Lieferbedingung]
  ON [ein].[fEinkaufscontrolling65_2].[Mandant Code]			= [vv].[vBC_t0000010_Lieferbedingung].[Mandant Code]
  AND [ein].[fEinkaufscontrolling65_2].[Lieferbedingung Code]	= [vv].[vBC_t0000010_Lieferbedingung].[Lieferbedingung Code]

  LEFT JOIN [vv].[vBC_t0000014_Lagerort]
  ON [ein].[fEinkaufscontrolling65_2].[Mandant Code]	= [vv].[vBC_t0000014_Lagerort].[Mandant Code]
  AND [ein].[fEinkaufscontrolling65_2].[Lagerort Code]	= [vv].[vBC_t0000014_Lagerort].[Lagerort Code]
  
  LEFT JOIN [vv].[vBC_t0000003_Zahlungsbedingungen]
  ON [ein].[fEinkaufscontrolling65_2].[Mandant Code]		= [vv].[vBC_t0000003_Zahlungsbedingungen].[Mandant Code]
  AND [ein].[fEinkaufscontrolling65_2].[Zahlungsbedingung Code]	= [vv].[vBC_t0000003_Zahlungsbedingungen].[Zahlungsbedingung Code]

  LEFT JOIN [vv].[vBC_t0005714_Zuständigkeitseinheit]
  ON [ein].[fEinkaufscontrolling65_2].[Mandant Code]				 = [vv].[vBC_t0005714_Zuständigkeitseinheit].[Mandant Code]
  AND [ein].[fEinkaufscontrolling65_2].[Zuständigkeitseinheiten Code]  = [vv].[vBC_t0005714_Zuständigkeitseinheit].[Zuständigkeiteinheiten Code]

  LEFT JOIN [vv].[vBC_t0000023_Lieferant] AS [Kauf von Kreditor]
  ON [ein].[fEinkaufscontrolling65_2].[Mandant Code]		 = [Kauf von Kreditor].[Mandant Code]
  AND [ein].[fEinkaufscontrolling65_2].[Kauf von Kreditornummer] = [Kauf von Kreditor].[Lieferantnummer]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Belegartbezeichnung]
  ON [ein].[fEinkaufscontrolling65_2].[Belegart]	= [Belegartbezeichnung].[Optionsfeld Code]
  AND [Belegartbezeichnung].[Tabellenname]		= ''Einkauf''
  AND [Belegartbezeichnung].[Spaltenbezeichnung]			= ''Belegartbezeichnung''
  
  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Statusbezeichnung]
  ON [ein].[fEinkaufscontrolling65_2].[Status]				= [Statusbezeichnung].[Optionsfeld Code]
  AND [Statusbezeichnung].[Tabellenname]						= ''Einkauf''
  AND [Statusbezeichnung].[Spaltenbezeichnung]							= ''Statusbezeichnung''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Stornobezeichnung]
  ON [ein].[fEinkaufscontrolling65_2].[Storno Flag]	= [Stornobezeichnung].[Optionsfeld Code]
  AND [Stornobezeichnung].[Tabellenname]			= ''Global''
  AND [Stornobezeichnung].[Spaltenbezeichnung]				= ''Ja/Nein''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild85_2_Struktur]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBilanzParentChild85_2_Struktur
-- Alter View dBilanzParentChild85_2_Structure
























CREATE VIEW [dim].[dBilanzParentChild85_2_Struktur]

AS

SELECT [dim].[dBilanzParentChild90_2].[Mandant Code]
      ,[dim].[dBilanzParentChild90_2].[Strukturbezeichnung]
      ,[dim].[dBilanzParentChild90_2].[Child Code]
      ,[dim].[dBilanzParentChild90_2].[Childbezeichnung]
      ,[dim].[dBilanzParentChild90_2].[Sachkontonummer]
      ,[dim].[dBilanzParentChild90_2].[Sachkontobezeichnung]
      ,[dim].[dBilanzParentChild90_2].[Child Zeilennummer]
	  ,[dim].[dBilanzParentChild90_2].[Parent Code]
      ,[dim].[dBilanzParentChild90_2].[Parentbezeichnung]
      ,[dim].[dBilanzParentChild90_2].[Parent Zeilennummer]
      ,[dim].[dBilanzParentChild90_2].[Ist Sachkonto]
	  ,[dim].[dBilanzParentChild90_2].[Umkehr Code]
	  --die jeweiligen AKTIVA und PASSIVA Knoten bekommen ein Kennzeichen
	  ,CAST(IIF([dim].[dBilanzParentChild90_2].[Parent Code] = [vv].[vSNCt_Aktiver_Mandant].[Aktiva Code], 1,0) AS BIT)		AS [Aktiva Code]
	  ,CAST(IIF([dim].[dBilanzParentChild90_2].[Parent Code] = [vv].[vSNCt_Aktiver_Mandant].[Passiva Code], 1,0) AS BIT)	AS [Passiva Code]
  FROM [dim].[dBilanzParentChild90_2]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [dim].[dBilanzParentChild90_2].[Mandant Code] = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]

  WHERE [Ist Sachkonto] = ''False''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dKostenstelle]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dKostenstelle























CREATE VIEW [dim].[dKostenstelle] AS 

SELECT [Kostenstellenbezeichnung]
      ,[Gesperrt Code]
      ,[Gesperrtbezeichnung DE]
      ,[Gesperrtbezeichnung EN]
      ,[Kostenstelle Code]
      ,[Zuständige Person]
      ,[Sortierreihenfolge]
      ,[Mandant Code]
      ,[Kostenstellenbezeichnung (Code)]
      ,[Kostenstelle Code Bezeichnung]
	  ,[Kostenunterart Code]
	  ,[Kostenunterartbezeichnung DE]
	  ,[Kostenunterartbezeichnung EN]
	  ,[PK dKostenstelle]
  FROM [dim].[dKostenstelle85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dMahnstufe]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dMahnstufe















CREATE VIEW [dim].[dMahnstufe] AS
SELECT [Mahnstufe]
      ,[Mahnmethode Code]
      ,[Mahnmethodenbezeichnung]
	  ,[Mahnmethode Code Bezeichnung]
	  ,[Mahnmethodenbezeichnung (Code)]
      ,[Mandant Code]
	  ,[PK dMahnstufe]
  FROM [dim].[dMahnstufe85_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling45_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fEinkaufscontrolling45_2_CONCAT

CREATE VIEW [ein].[fEinkaufscontrolling45_2_CONCAT] AS
SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Artikelnummer]
      ,[Produktnummer]
      ,[Belegart]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Buchungsdatum]
      ,[Belegdatum]
      ,[Storno Code]
      ,[Stornobezeichnung DE]
      ,[Stornobezeichnung EN]
      ,[Währung Code]
      ,[Währungsbezeichnung]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[Zeilennummer]
      ,[Kauf von Kreditornummer]
      ,[Kauf von Kreditorbezeichnung]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Produktart]
      ,[Zahlung an Kreditornummer]
      ,[Bundesland]
      ,[Status]
      ,[Statusbezeichnung DE]
      ,[Statusbezeichnung EN]
      ,[Kreditor Rechnungsnummer]
      ,[Kreditor Bestellnummer]
      ,[Kreditor Liefernummer]
      ,[Zuständigkeitseinheiten Code]
      ,[Zuständigkeiteinheiten Name]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
      ,[Lieferbedingung Code]
      ,[Lieferbedingungsbezeichnung]
      ,[Lagerplatz Code]
      ,[Kauf von Kontaktnummer]
      ,[Auftragsdatum]
      ,[Fälligkeitsdatum]
      ,[Gewünschtes Warenausgangsdatum]
      ,[Kauf von Kontakt]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[Lagerortbezeichnung]
      ,[Einheitencode]
      ,[Geplantes Anlieferungsdatum]
      ,[Skonto]
      ,[Skontodatum]
      ,[Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Anlieferungsdatum Zugesagt]
      ,[Ist Archivbeleg]
      ,[Einheit Betrag]
      ,[Einstandspreis]
      ,[Betrag]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[Menge]
      ,[Zeilenrabattbetrag]
      ,[Rechnungsrabatt in %]
      ,[EK-Preis ohne MwSt.]
      ,[Einkaufsmenge]
      ,[Reservierte Menge]
      ,[Einkaufsbetrag ohne MwSt.]
      ,[Menge akt. Lieferung]
      ,[Bereits gelieferte Menge]
      ,[Menge akt. Rechnung]
      ,[Bereits berechnete Menge]
      ,[Menge fuer Zuweisung]
      ,[Zugewiesene Menge]

	  
	  --PK for PowerBI
	  ,[Mandant Code]																									AS [PK dMandant]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenstelle Code],''NULL'')															AS [PK dKostenstelle]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenträger Code],''NULL'')															AS [PK dKostenträger]
	  ,[Mandant Code] +''_''+ ISNULL([Kauf von Kreditornummer],''NULL'')														AS [PK dKreditor (Einkauf)]
	  ,[Mandant Code] +''_''+ ISNULL([Zahlung an Kreditornummer],''NULL'')															AS [PK dKreditor (Rechnung)]
	  ,[Mandant Code] +''_''+ ISNULL([Artikelnummer],''NULL'')																	AS [PK dArtikel]
	  ,[Mandant Code] +''_''+ ISNULL(CONVERT(NVARCHAR(2),[Produktart]),''NULL'') +''_''+ ISNULL([Produktnummer],''NULL'')	AS [PK dProdukt]
	  ,[Mandant Code] +''_''+ ISNULL([Einkäufer Code],''NULL'')																AS [PK dVerkäuferEinkäufer]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Belegdatum],21),''NULL'')											AS [PK dZeit (Belegdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Buchungsdatum],21),''NULL'')												AS [PK dZeit (Buchungsdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Anlieferungsdatum Zugesagt],21),''NULL'')									AS [PK dZeit (Anlieferungsdatum Zugesagt)]
  FROM [ein].[fEinkaufscontrolling55_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild85_2_Kein_Sachkonto]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBilanzParentChild85_2_Kein_Sachkonto
-- Alter View ddBilanzParentChild85_2_Kein_Sachkonto




CREATE VIEW [dim].[dBilanzParentChild85_2_Kein_Sachkonto]

AS
--es müssen die Sachkonten identifiziert werden, die keine Zuordnung in der Struktur haben (JH - 2020-02-03 - #8006)
SELECT [vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Strukturbezeichnung]
      ,[dSachkonto].[Mandant Code]
	  ,[dSachkonto].[Sachkontonummer]
	  ,[dSachkonto].[Sachkontobezeichnung]
	  --der Child Knoten muss zum Vater gemachten werden für die Sachkonten
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Child Zeilennummer]	AS [Parent Zeilennummer]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Child Code]			AS [Parent Code]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Childbezeichnung]	AS [Parentbezeichnung]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Child Zeilennummer]
      ,[dSachkonto].[Sachkontonummer]													AS [Child Code]
      ,[dSachkonto].[Sachkontonummer Bezeichnung]										AS [Childbezeichnung]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Ist Blattknoten]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Zusammenzählung Start]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Zusammenzählung Ende]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Zusammenzählungstyp]
      ,[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt].[Umkehr Code]
  FROM [dim].[dBilanzParentChild90_2]

  RIGHT JOIN [dim].[dSachkonto]
  ON  [dBilanzParentChild90_2].[Mandant Code]		= [dSachkonto].[Mandant Code]
  AND [dBilanzParentChild90_2].[Sachkontonummer]	= [dSachkonto].[Sachkontonummer]
  AND [dBilanzParentChild90_2].[Ist Sachkonto] = 1

  LEFT JOIN [vv].[vBC_t0000085_Kontenplanzeilenaufteilung75_2_Unzugewiesenes_Blatt]
  ON 1=1

  WHERE [dBilanzParentChild90_2].[Mandant Code] IS NULL
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[ein].[fEinkaufscontrolling]'))
EXEC dbo.sp_executesql @statement = N'






-- Alter View fEinkaufscontrolling














CREATE VIEW [ein].[fEinkaufscontrolling] AS 


SELECT [Mandant Code]
      ,[Belegnummer]
      ,[Artikelnummer]
      ,[Produktnummer]
      ,[Belegart]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Buchungsdatum]
      ,[Belegdatum]
      ,[Storno Code]
      ,[Stornobezeichnung DE]
      ,[Stornobezeichnung EN]
      ,[Währung Code]
      ,[Währungsbezeichnung]
      ,[Währungsfaktor]
      ,[Einkäufer Code]
      ,[Zeilennummer]
      ,[Kauf von Kreditornummer]
      ,[Kauf von Kreditorbezeichnung]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Produktart]
      ,[Zahlung an Kreditornummer]
      ,[Bundesland]
      ,[Status]
      ,[Statusbezeichnung DE]
      ,[Statusbezeichnung EN]
      ,[Kreditor Rechnungsnummer]
      ,[Kreditor Bestellnummer]
      ,[Kreditor Liefernummer]
      ,[Zuständigkeitseinheiten Code]
      ,[Zuständigkeiteinheiten Name]
      ,[MwSt.-Geschäftsbuchungsgruppe Code]
      ,[Lieferbedingung Code]
      ,[Lieferbedingungsbezeichnung]
      ,[Lagerplatz Code]
      ,[Kauf von Kontaktnummer]
      ,[Auftragsdatum]
      ,[Fälligkeitsdatum]
      ,[Gewünschtes Warenausgangsdatum]
      ,[Kauf von Kontakt]
      ,[Beschreibung]
      ,[Lagerort Code]
      ,[Lagerortbezeichnung]
      ,[Einheitencode]
      ,[Geplantes Anlieferungsdatum]
      ,[Skonto]
      ,[Skontodatum]
      ,[Zahlungsbedingung Code]
      ,[Zahlungsbedingungsbezeichnung]
      ,[Anlieferungsdatum Zugesagt]
      ,[Ist Archivbeleg]
      ,[Einheit Betrag]
      ,[Einstandspreis]
      ,[Betrag]
      ,[Rechnungsrabattbetrag]
      ,[Zeilenbetrag]
      ,[Menge (Basis)]
      ,[Menge]
      ,[Zeilenrabattbetrag]
      ,[Rechnungsrabatt in %]
      ,[EK-Preis ohne MwSt.]
      ,[Einkaufsmenge]
      ,[Reservierte Menge]
      ,[Einkaufsbetrag ohne MwSt.]
      ,[Menge akt. Lieferung]
      ,[Bereits gelieferte Menge]
      ,[Menge akt. Rechnung]
      ,[Bereits berechnete Menge]
      ,[Menge fuer Zuweisung]
      ,[Zugewiesene Menge]
      ,[PK dMandant]
      ,[PK dKostenstelle]
      ,[PK dKostenträger]
      ,[PK dKreditor (Einkauf)]
      ,[PK dKreditor (Rechnung)]
      ,[PK dArtikel]
      ,[PK dProdukt]
      ,[PK dVerkäuferEinkäufer]
      ,[PK dZeit (Belegdatum)]
      ,[PK dZeit (Buchungsdatum)]
      ,[PK dZeit (Anlieferungsdatum Zugesagt)]
  FROM [ein].[fEinkaufscontrolling45_2_CONCAT]

' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild80_2_UNION]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBilanzParentChild80_2_UNION






































CREATE VIEW [dim].[dBilanzParentChild80_2_UNION]

AS

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Child Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
      ,[Ist Sachkonto]
	  ,[Aktiva Code]
	  ,[Passiva Code]
	  ,[Umkehr Code]
  FROM [dim].[dBilanzParentChild85_2_Struktur]

  UNION ALL

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Child Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
      ,[Ist Sachkonto]
	  ,CAST(0 AS BIT)		AS [Aktiva Code]
	  ,CAST(0 AS BIT)		AS [Passiva Code]
	  ,[Umkehr Code]
  FROM [dim].[dBilanzParentChild85_2_Sachkonto]

    UNION ALL

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Child Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
      ,''True'' AS [Ist Sachkonto]
	  ,CAST(0 AS BIT)		AS [Aktiva Code]
	  ,CAST(0 AS BIT)		AS [Passiva Code]
	  ,[Umkehr Code]
  FROM [dim].[dBilanzParentChild85_2_Kein_Sachkonto]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild75_2_UI]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBilanzParentChild75_2_UI
-- Alter View dBilanzParentChild75_2_UI






















CREATE VIEW [dim].[dBilanzParentChild75_2_UI]AS
SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
	  ,[Parent Code] AS [Parent Code Original]
      --,CAST([Company Code] +''_O_''+ ISNULL(CAST([Parent Line No.] AS NVARCHAR(10)),''0'') +''_L_''+ ISNULL([Parent Code],''ROOT'') AS NVARCHAR(40)) AS [Parent Code]
	  ,CAST(''O_''+ ISNULL(CAST([Parent Zeilennummer] AS NVARCHAR(10)),''0'') +''_L_''+ ISNULL([Parent Code],''ROOT'') AS NVARCHAR(40)) AS [Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
	  ,[Child Code] AS [Child Code Original]
      --,IIF([Is G/L Account] = ''True'', CAST([Company Code] +''_GL_''+ [Child Code] +''_L_''+ ISNULL([Parent Code],'''') AS NVARCHAR(40)),CAST([Company Code] +''_O_''+ ISNULL(CAST([Child Line No.] AS NVARCHAR(10)),''0'') +''_L_''+ ISNULL([Child Code],'''') AS NVARCHAR(40))) AS [Child Code]
      ,IIF([Ist Sachkonto] = ''True'', CAST(''GL_''+ [Child Code] +''_L_''+ ISNULL([Parent Code],'''') AS NVARCHAR(40)),CAST(''O_''+ ISNULL(CAST([Child Zeilennummer] AS NVARCHAR(10)),''0'') +''_L_''+ ISNULL([Child Code],'''') AS NVARCHAR(40))) AS [Child Code]
	  ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
	  ,[Aktiva Code]
	  ,[Passiva Code]
	  ,[Umkehr Code]
	  --Bezeichnungsfeld für Knotenelemente und Sachkonten (2021-02-18 - JH - #8131)
	  ,COALESCE([Sachkontobezeichnung],[Childbezeichnung]) AS [Elementbezeichnung]
  FROM [dim].[dBilanzParentChild80_2_UNION]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor95_2_OffenerBetrag]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPKreditor95_2_OffenerBetrag








CREATE VIEW [fin].[fOPKreditor95_2_OffenerBetrag] AS 
--Alle Posten summiert bis zum Stichtag ergeben den Restbetrag
SELECT
   [Mandant Code]
  ,[Kreditorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Offener Betrag (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Offener Betrag]
FROM [vv].[vBC_t0000380_Detaillierte_Kreditorenposten]

GROUP BY [Mandant Code]
        ,[Kreditorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild70_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBilanzParentChild70_2_CONCAT





















CREATE VIEW [dim].[dBilanzParentChild70_2_CONCAT] AS
SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code Original]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code Original]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
	  ,[Aktiva Code]
	  ,[Passiva Code]
	  ,[Umkehr Code]
	  ,[Elementbezeichnung]
	  ,CAST(ISNULL([Sachkontobezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Sachkontonummer] AS NVARCHAR(20)) + '')'' AS [Sachkontobezeichnung (Nummer)]
      ,CAST(ISNULL([Sachkontonummer],'''') AS NVARCHAR(20)) + '' '' + CAST([Sachkontobezeichnung] AS NVARCHAR(100)) AS [Sachkontonummer Bezeichnung]
	  ,[Mandant Code] +''_''+[Child Code] AS [PK dBilanzParentChild]
  FROM [dim].[dBilanzParentChild75_2_UI]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor95_2_Betrag]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPKreditor95_2_Betrag














CREATE VIEW [fin].[fOPKreditor95_2_Betrag] AS 
SELECT
   [Mandant Code]
  ,[Kreditorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Betrag (MW)]
  ,CAST(SUM([Sollbetrag (MW)]) AS NUMERIC(18,5)) AS [Sollbetrag (MW)]
  ,CAST(SUM([Habenbetrag (MW)]) AS NUMERIC(18,5)) AS [Habenbetrag (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Betrag]
  ,CAST(SUM([Sollbetrag]) AS NUMERIC(18,5)) AS [Sollbetrag]
  ,CAST(SUM([Habenbetrag]) AS NUMERIC(18,5)) AS [Habenbetrag]

FROM
  [vv].[vBC_t0000380_Detaillierte_Kreditorenposten]
--Ermittlung BetragMW zu einem Posten
  WHERE [Detaillierte Kreditorposten Art] IN (1,3,4,5,6,7,8,9,12,13,14,15,16,17) 
--Urspr. Posten / Unrealisierter Verlust / Unrealisierter Gewinn / Realisierter Verlust / Realisierter Gewinn / Skonto / Skonto (ohne MwSt.) / Skonto (MwSt.-Regulierung) / Zahlungstoleranz / Skontotoleranz / Zahlungstoleranz (ohne MwSt.) / Zahlungstoleranz (MwSt.-Regulierung) / Skontotoleranz (ohne MwSt.) / Skontotoleranz (MwSt.-Regulierung)
  GROUP BY [Mandant Code], [Kreditorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBWAParentChild95_2]'))
EXEC dbo.sp_executesql @statement = N'







-- Alter View dBWAParentChild95_2









































CREATE VIEW [dim].[dBWAParentChild95_2]

AS 

SELECT [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Mandant Code]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Strukturbezeichnung] AS [Strukturbezeichnung]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Child Code] AS [Child Code]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Childbezeichnung] AS [Childbezeichnung]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Child Zeilennummer] AS [Child Zeilennummer]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Parent Code] AS [Parent Code]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Sachkontonummer] AS [Sachkontonummer]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Sachkontobezeichnung] AS [Sachkontobezeichnung]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Parentbezeichnung] AS [Parentbezeichnung]
      ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Parent Zeilennummer] AS [Parent Zeilennummer]
	  ,[fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Ist Sachkonto]
	  --Lösung für das Reporting. Dann kann der Betrag direkt mit der Vorzeichenumkehr multipiziert werden (26.01.2021 - JH)
	  ,IIF([fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Umkehr Code] = 1, -1, 1) AS [Umkehr Code]
  FROM [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung]

  --filter on economical evaluations data
  INNER JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Mandant Code]	   = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]
  AND [fin].[TMP_vBC_t0000085_Kontenplanzeilenaufteilung].[Strukturbezeichnung] = [vv].[vSNCt_Aktiver_Mandant].[Schemabezeichnung BWA]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor95_2_BetragInklMwSt]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPKreditor95_2_BetragInklMwSt

















CREATE VIEW [fin].[fOPKreditor95_2_BetragInklMwSt] AS 
--Umsatz inkl. MWST
SELECT
   [Mandant Code]
  ,[Kreditorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Betrag inkl. MwSt. (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Betrag inkl. MwSt.]
FROM [vv].[vBC_t0000380_Detaillierte_Kreditorenposten]
--Beträge die durch unberechtigte Skonto gewährt wurden
WHERE [Detaillierte Kreditorposten Art] IN (1)
--Urspr. Posten
GROUP BY [Mandant Code]
        ,[Kreditorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBWAParentChild90_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBWAParentChild90_2






























CREATE VIEW [dim].[dBWAParentChild90_2]

AS

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
	  ,[Childbezeichnung]
	  ,[Sachkontonummer]
	  ,[Sachkontobezeichnung]
      ,[Child Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
	  ,[Ist Sachkonto]
	  ,[Umkehr Code]
  FROM [dim].[dBWAParentChild95_2]

UNION

SELECT DISTINCT
       [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Parent Code]
      ,[Parentbezeichnung] AS [Childbezeichnung]
	  ,CAST(0 AS NVARCHAR(20)) AS [Sachkontonummer]
	  ,CAST('''' AS NVARCHAR(80)) AS [Sachkontobezeichnung]
      ,[Parent Zeilennummer] AS [Child Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
	  ,CAST(''False'' AS BIT) AS [Ist Sachkonto]
	  ,[Umkehr Code]
  FROM [dim].[dBWAParentChild95_2]
  WHERE [Parent Code] NOT IN (SELECT [Child Code] FROM [dim].[dBWAParentChild95_2])
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor95_2_LetzteZahlung]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPKreditor95_2_LetzteZahlung















CREATE VIEW [fin].[fOPKreditor95_2_LetzteZahlung] AS 
SELECT
   [Mandant Code]
  ,[Kreditorenposten Lfd. Nr.]
  ,MAX([Buchungsdatum]) AS [Letztes Zahlungsdatum]
FROM [vv].[vBC_t0000380_Detaillierte_Kreditorenposten]
-- Ein Posten kann durch mehrere Zahlungen ausgeglichen werden. Hier wird die letzte Zahlung ermitellt
 WHERE [Detaillierte Kreditorposten Art] IN (2) 
  -- Zahlung
GROUP BY [Mandant Code]
        ,[Kreditorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBWAParentChild85_2_Sachkonto]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBWAParentChild85_2_Sachkonto



































CREATE VIEW [dim].[dBWAParentChild85_2_Sachkonto]

AS

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
      ,[Childbezeichnung]
	  ,[Child Zeilennummer]
	  ,[Parent Code]
	  ,[Sachkontonummer]
	  ,[Sachkontobezeichnung]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
	  ,[Ist Sachkonto]
	  ,[Umkehr Code]
  FROM [dim].[dBWAParentChild90_2]
  -- Bedinung wurde umgedreht. Wenn = True kommt es zu einem Konvertierungsfehler, nicht behebar (JW - 15.12.2020)
  WHERE [Ist Sachkonto] != ''False''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor95_2_ZlgRabatt]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPKreditor95_2_ZlgRabatt















CREATE VIEW [fin].[fOPKreditor95_2_ZlgRabatt] AS 
SELECT
   [Mandant Code]
  ,[Kreditorenposten Lfd. Nr.]
  ,CAST(SUM([Betrag (MW)]) AS NUMERIC(18,5)) AS [Betrag Zahlungsrabatt (MW)]
  ,CAST(SUM([Betrag]) AS NUMERIC(18,5)) AS [Betrag Zahlungsrabatt]
FROM [vv].[vBC_t0000380_Detaillierte_Kreditorenposten]
--BetrÃ¤ge durch berechtigte Skonto 
 WHERE [Detaillierte Kreditorposten Art] IN (8,9) -- Skonto (ohne MwSt.) / Skonto (MwSt.-Regulierung)
  -- Ausgleich / Restbetrag Korrektur
GROUP BY [Mandant Code]
        ,[Kreditorenposten Lfd. Nr.]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBWAParentChild85_2_Struktur]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBWAParentChild85_2_Struktur
-- Alter View dBWAParentChild85_2_Structure
























CREATE VIEW [dim].[dBWAParentChild85_2_Struktur]

AS

SELECT [dim].[dBWAParentChild90_2].[Mandant Code]
      ,[dim].[dBWAParentChild90_2].[Strukturbezeichnung]
      ,[dim].[dBWAParentChild90_2].[Child Code]
      ,[dim].[dBWAParentChild90_2].[Childbezeichnung]
      ,[dim].[dBWAParentChild90_2].[Sachkontonummer]
      ,[dim].[dBWAParentChild90_2].[Sachkontobezeichnung]
      ,[dim].[dBWAParentChild90_2].[Child Zeilennummer]
	  ,[dim].[dBWAParentChild90_2].[Parent Code]
      ,[dim].[dBWAParentChild90_2].[Parentbezeichnung]
      ,[dim].[dBWAParentChild90_2].[Parent Zeilennummer]
      ,[dim].[dBWAParentChild90_2].[Ist Sachkonto]
	  ,[dim].[dBWAParentChild90_2].[Umkehr Code]
  FROM [dim].[dBWAParentChild90_2]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [dim].[dBWAParentChild90_2].[Mandant Code] = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]

  WHERE [Ist Sachkonto] = ''False''
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung65_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung65_2













CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung65_2] AS
SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
	  ,CAST(IIF([Sachkontonummer] IS NOT NULL,''True'',''False'') AS BIT) AS [Ist Sachkonto]
      ,[Zusammenzählung Start]
      ,[Zusammenzählung Ende]
      ,[Zusammenzählungstyp]
      ,[Umkehr Code]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung70_2_UNION]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBWAParentChild80_2_UNION]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBWAParentChild80_2_UNION








CREATE VIEW [dim].[dBWAParentChild80_2_UNION]

AS

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Child Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
      ,[Ist Sachkonto]
	  ,[Umkehr Code]
  FROM [dim].[dBWAParentChild85_2_Struktur]

  UNION ALL

SELECT [Mandant Code]
      ,[Strukturbezeichnung]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Child Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Parent Zeilennummer]
      ,[Ist Sachkonto]
	  ,[Umkehr Code]
  FROM [dim].[dBWAParentChild85_2_Sachkonto]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000085_Kontenplanzeilenaufteilung]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000085_Kontenplanzeilenaufteilung




















CREATE VIEW [vv].[vBC_t0000085_Kontenplanzeilenaufteilung] AS 
SELECT DISTINCT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
      ,[Zusammenzählung Start]
      ,[Zusammenzählung Ende]
      ,[Zusammenzählungstyp]
      ,[Umkehr Code]
  FROM [vv].[vBC_t0000085_Kontenplanzeilenaufteilung65_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor90_2]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fOPKreditor90_2



























CREATE VIEW [fin].[fOPKreditor90_2] AS
SELECT [vv].[vBC_t0000025_Kreditorenposten].[Kreditorenposten Lfd.]
	  --in der General Ledger Setup Tabelle ist definiert on welchem Global Dim Code welcher Dimensionswert steht
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenstellencode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenstelle Code]
																				,[vv].[vBC_t0000025_Kreditorenposten].[Kostenstellencode]
																				,[vv].[vBC_t0000025_Kreditorenposten].[Kostenträgercode]) 
		AS [Kostenstelle Code]
	  ,IIF([vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Kostenträgercode] = [vv].[vSNCt_Aktiver_Mandant].[Kostenträger Code]
																				,[vv].[vBC_t0000025_Kreditorenposten].[Kostenträgercode]
																				,[vv].[vBC_t0000025_Kreditorenposten].[Kostenstellencode]) 
		AS [Kostenträger Code]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Kreditornummer]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Buchungsdatum]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Belegartcode]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Belegartbezeichnung DE]
	  ,ISNULL([Belegartbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Belegartbezeichnung EN]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Belegnummer]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Währung Code]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Rechnungsrabatt (MW)]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Einkauf von Kreditornummer]
	  ,[Einkauf von Kreditor].[Lieferantname]												AS [Einkauf von Kreditorbezeichnung]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Lieferantenbuchungsgruppe Code]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Einkäufer Code]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Abwarten]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Ausgeglichen mit Belegart]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Ausgeglichen mit Belegnummer]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Offen]
	  ,ISNULL([Offenbezeichnung].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Offenbezeichnung DE]
	  ,ISNULL([Offenbezeichnung].[Optionsfeldbezeichnung EN],''not defined'')		AS [Offenbezeichnung EN]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Fälligkeitsdatum]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Skontodatum]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Zahlungsrabatt erhalten (MW)]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Geschlossen mit Betrag (MW)]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Belegdatum]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Externe Belegnummer]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Ausgleichposten]
      ,[vv].[vBC_t0000025_Kreditorenposten].[storniert]
      ,[vv].[vBC_t0000025_Kreditorenposten].[im vorraus bezahlt]
	  ,[vv].[vBC_t0000025_Kreditorenposten].[Geschlossen von Lfd. Nr.]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Geschlossen am]
	  ,[vv].[vBC_t0000025_Kreditorenposten].[Bilanzkontotyp]
	  ,ISNULL([Bilanzkontotypbezeichnung ].[Optionsfeldbezeichnung DE],''nicht definiert'')	AS [Bilanzkontotypbezeichnung  DE]
	  ,ISNULL([Bilanzkontotypbezeichnung ].[Optionsfeldbezeichnung EN],''not defined'')		AS [Bilanzkontotypbezeichnung  EN]
	  ,[vv].[vBC_t0000025_Kreditorenposten].[Ursache Code]
	  ,[vv].[vBC_t0000231_Ursache_Code].[Ursachenbezeichnung]
	  ,[vv].[vBC_t0000025_Kreditorenposten].[Gehört zu ID]
	  ,[vv].[vBC_t0000025_Kreditorenposten].[Skontotoleranzdatum]
	  ,[vv].[vBC_t0000025_Kreditorenposten].[Zahlungsbedingung Code]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Mandant Code]
      ,[vv].[vBC_t0000025_Kreditorenposten].[Bundesland]
	  --Datum dient der Überfälligkeitsberechnung, wenn es keine Zahlung gibt muss vom ReportDatum ausgegangen werden
	  ,[fin].[fOPKreditor95_2_LetzteZahlung].[Letztes Zahlungsdatum] AS [Letztes Zahlungsdatum]
	  ,[vv].[vBC_t0000122_Einkaufsrechnungkopf].[Zahlungsbedingung Code] AS [Zahlungsbedingung Code (Rechnung)]
	  --die spätere Berechnung von überfälligkeiten darf nur für Posten erfolgen die noch offen sind
	  ,IIF([vv].[vBC_t0000025_Kreditorenposten].[Offen] = 0, [fin].[fOPKreditor95_2_LetzteZahlung].[Letztes Zahlungsdatum], [dbo].[SG_REPORT_DATE_TODAY]()) AS [Berechnungsdatum]
	  --detailierte Debitorenposten 
	  ,ISNULL([fin].[fOPKreditor95_2_Betrag].[Betrag (MW)], 0)										AS [Betrag (MW)]
	  ,ISNULL([fin].[fOPKreditor95_2_Betrag].[Sollbetrag (MW)], 0)									AS [Sollbetrag (MW)]
	  ,ISNULL([fin].[fOPKreditor95_2_Betrag].[Habenbetrag (MW)], 0)								AS [Habenbetrag (MW)]
	  ,ISNULL([fin].[fOPKreditor95_2_OffenerBetrag].[Offener Betrag (MW)], 0)				AS [Offener Betrag (MW)]
	  ,ISNULL([fin].[fOPKreditor95_2_ZlgRabatt].[Betrag Zahlungsrabatt (MW)],0)							AS [Betrag Zahlungsrabatt (MW)]
	  ,ISNULL([fin].[fOPKreditor95_2_ZlgRabattUngerechtfertigt].[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)], 0)	AS [Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
	  ,ISNULL([fin].[fOPKreditor95_2_BetragInklMwSt].[Betrag inkl. MwSt. (MW)], 0)						AS [Betrag inkl. MwSt. (MW)]
	  --Mandantenwährung
	  ,ISNULL([fin].[fOPKreditor95_2_Betrag].[Betrag], 0)												AS [Betrag]
	  ,ISNULL([fin].[fOPKreditor95_2_Betrag].[Sollbetrag], 0)										AS [Sollbetrag]
	  ,ISNULL([fin].[fOPKreditor95_2_Betrag].[Habenbetrag], 0)										AS [Habenbetrag]
	  ,ISNULL([fin].[fOPKreditor95_2_OffenerBetrag].[Offener Betrag], 0)							AS [Offener Betrag]
	  ,ISNULL([fin].[fOPKreditor95_2_ZlgRabatt].[Betrag Zahlungsrabatt],0)									AS [Betrag Zahlungsrabatt]
	  ,ISNULL([fin].[fOPKreditor95_2_ZlgRabattUngerechtfertigt].[Betrag Zahlungsrabatt (ungerechtfertigt)], 0)			AS [Betrag Zahlungsrabatt (ungerechtfertigt)]
	  ,ISNULL([fin].[fOPKreditor95_2_BetragInklMwSt].[Betrag inkl. MwSt.], 0)							AS [Betrag inkl. MwSt.]
  FROM [vv].[vBC_t0000025_Kreditorenposten]

  LEFT JOIN [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung]
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code] = [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code]

  LEFT JOIN [vv].[vSNCt_Aktiver_Mandant]
  ON [vv].[vBC_t0000098_Finanzbuchhaltung_Einrichtung].[Mandant Code] = [vv].[vSNCt_Aktiver_Mandant].[Mandant Code]

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Belegartbezeichnung]
  ON [vv].[vBC_t0000025_Kreditorenposten].[Belegartcode]  = [Belegartbezeichnung].[Optionsfeld Code]
  AND [Belegartbezeichnung].[Tabellenname]	= ''Finanzen''
  AND [Belegartbezeichnung].[Spaltenbezeichnung]		= ''Belegartbezeichnung''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Offenbezeichnung]
  ON [vv].[vBC_t0000025_Kreditorenposten].[Offen]  = [Offenbezeichnung].[Optionsfeld Code]
  AND [Offenbezeichnung].[Tabellenname]				= ''Global''
  AND [Offenbezeichnung].[Spaltenbezeichnung]					= ''Ja/Nein''

  LEFT JOIN [vv].[vSNCt_Beschreibung] AS [Bilanzkontotypbezeichnung ]
  ON [vv].[vBC_t0000025_Kreditorenposten].[Bilanzkontotyp]	= [Bilanzkontotypbezeichnung ].[Optionsfeld Code]
  AND [Bilanzkontotypbezeichnung ].[Tabellenname]					= ''Finanzen''
  AND [Bilanzkontotypbezeichnung ].[Spaltenbezeichnung]						= ''Bilanzkontotypbezeichnung ''

  LEFT JOIN [vv].[vBC_t0000023_Lieferant] AS [Einkauf von Kreditor]
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code]			= [Einkauf von Kreditor].[Mandant Code]
  AND [vv].[vBC_t0000025_Kreditorenposten].[Einkauf von Kreditornummer]	= [Einkauf von Kreditor].[Lieferantnummer]

  LEFT JOIN [fin].[fOPKreditor95_2_Betrag] 
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code] = [fin].[fOPKreditor95_2_Betrag].[Mandant Code]
  AND[vv].[vBC_t0000025_Kreditorenposten].[Kreditorenposten Lfd.] = [fin].[fOPKreditor95_2_Betrag].[Kreditorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPKreditor95_2_LetzteZahlung]
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code] = [fin].[fOPKreditor95_2_LetzteZahlung].[Mandant Code]
  AND [vv].[vBC_t0000025_Kreditorenposten].[Kreditorenposten Lfd.] = [fin].[fOPKreditor95_2_LetzteZahlung].[Kreditorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPKreditor95_2_OffenerBetrag] 
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code] = [fin].[fOPKreditor95_2_OffenerBetrag].[Mandant Code]
  AND [vv].[vBC_t0000025_Kreditorenposten].[Kreditorenposten Lfd.] = [fin].[fOPKreditor95_2_OffenerBetrag].[Kreditorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPKreditor95_2_ZlgRabatt]
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code] = [fin].[fOPKreditor95_2_ZlgRabatt].[Mandant Code]
  AND [vv].[vBC_t0000025_Kreditorenposten].[Kreditorenposten Lfd.] = [fin].[fOPKreditor95_2_ZlgRabatt].[Kreditorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPKreditor95_2_ZlgRabattUngerechtfertigt] 
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code] = [fin].[fOPKreditor95_2_ZlgRabattUngerechtfertigt].[Mandant Code]
  AND [vv].[vBC_t0000025_Kreditorenposten].[Kreditorenposten Lfd.] = [fin].[fOPKreditor95_2_ZlgRabattUngerechtfertigt].[Kreditorenposten Lfd. Nr.]
  
  LEFT JOIN [fin].[fOPKreditor95_2_BetragInklMwSt] 
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code] = [fin].[fOPKreditor95_2_BetragInklMwSt].[Mandant Code]
  AND[vv].[vBC_t0000025_Kreditorenposten].[Kreditorenposten Lfd.] = [fin].[fOPKreditor95_2_BetragInklMwSt].[Kreditorenposten Lfd. Nr.]
    
  LEFT JOIN [vv].[vBC_t0000122_Einkaufsrechnungkopf]
  ON  [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code] = [vv].[vBC_t0000122_Einkaufsrechnungkopf].[Mandant Code]
  AND [vv].[vBC_t0000025_Kreditorenposten].[Belegnummer] = [vv].[vBC_t0000122_Einkaufsrechnungkopf].[Belegnummer]
  --Rechnung
  AND [vv].[vBC_t0000025_Kreditorenposten].[Belegartcode] = 2

  LEFT JOIN [vv].[vBC_t0000231_Ursache_Code]
  ON [vv].[vBC_t0000025_Kreditorenposten].[Mandant Code]  = [vv].[vBC_t0000231_Ursache_Code].[Mandant Code]
  AND [vv].[vBC_t0000025_Kreditorenposten].[Ursache Code]	 = [vv].[vBC_t0000231_Ursache_Code].[Ursache Code]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBWAParentChild75_2_UI]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBWAParentChild75_2_UI






















CREATE VIEW [dim].[dBWAParentChild75_2_UI]AS
SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
	  ,[Parent Code] AS [Parent Code Original]
	  ,CAST(''O_''+ ISNULL(CAST([Parent Zeilennummer] AS NVARCHAR(10)),''0'') +''_L_''+ ISNULL([Parent Code],''ROOT'') AS NVARCHAR(40)) AS [Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
	  ,[Child Code] AS [Child Code Original]
      ,IIF([Ist Sachkonto] = ''True'', CAST(''GL_''+ [Child Code] +''_L_''+ ISNULL([Parent Code],'''') AS NVARCHAR(40)),CAST(''O_''+ ISNULL(CAST([Child Zeilennummer] AS NVARCHAR(10)),''0'') +''_L_''+ ISNULL([Child Code],'''') AS NVARCHAR(40))) AS [Child Code]
	  ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
	  ,[Umkehr Code]
	  --Bezeichnungsfeld für Knotenelemente und Sachkonten (2021-02-18 - JH - #8131)
	  ,COALESCE([Sachkontobezeichnung],[Childbezeichnung]) AS [Elementbezeichnung]
  FROM [dim].[dBWAParentChild80_2_UNION]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor85_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPKreditor85_2






























CREATE VIEW [fin].[fOPKreditor85_2] AS
SELECT [Kreditorenposten Lfd.]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Kreditornummer]
      ,[Buchungsdatum]
      ,[Belegartcode]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Rechnungsrabatt (MW)]
      ,[Einkauf von Kreditornummer]
      ,[Einkauf von Kreditorbezeichnung]
      ,[Lieferantenbuchungsgruppe Code]
      ,[Einkäufer Code]
      ,[Abwarten]
      ,[Ausgeglichen mit Belegart]
      ,[Ausgeglichen mit Belegnummer]
      ,[Offen]
      ,[Offenbezeichnung DE]
      ,[Offenbezeichnung EN]
      ,[Fälligkeitsdatum]
      ,[Skontodatum]
      ,[Zahlungsrabatt erhalten (MW)]
      ,[Geschlossen mit Betrag (MW)]
      ,[Belegdatum]
      ,[Externe Belegnummer]
      ,[Ausgleichposten]
      ,[storniert]
      ,[im vorraus bezahlt]
      ,[Geschlossen von Lfd. Nr.]
      ,[Geschlossen am]
      ,[Bilanzkontotyp]
      ,[Bilanzkontotypbezeichnung  DE]
      ,[Bilanzkontotypbezeichnung  EN]
      ,[Ursache Code]
      ,[Ursachenbezeichnung]
      ,[Gehört zu ID]
      ,[Skontotoleranzdatum]
      ,[Zahlungsbedingung Code]
      ,[Mandant Code]
      ,[Bundesland]
      ,[Zahlungsbedingung Code (Rechnung)]
	  --Tagesberechnungen
	  ,CAST(DATEDIFF(DAY,[dbo].[SG_REPORT_DATE_TODAY](), [Belegdatum]) AS INT)									AS [Alter offener Posten]
	  ,CAST(DATEDIFF(DAY,[Berechnungsdatum],[Fälligkeitsdatum]) AS INT)													AS [Anzahl Tage fällig] -- JH - 2021-02-05 - #8029 #8161
	  ,CAST(DATEDIFF(DAY,[Letztes Zahlungsdatum], [Berechnungsdatum]) AS INT)										AS [Anzahl Tage letzten Zahlung]
	  ,CAST(DATEDIFF(DAY,[Buchungsdatum], [Berechnungsdatum]) AS INT)											AS [Anzahl Tage Zahlungsdauer]
	  ,CAST(DATEDIFF(DAY,[Buchungsdatum], [Fälligkeitsdatum]) AS INT)														AS [Anzahl Tage Zahlungsfrist]
	  ,CAST(DATEDIFF(DAY,[Buchungsdatum], [Skontodatum]) AS INT)												AS [Anzahl Tage Rabattperiode]
	  ,CAST(IIF([Offen] = 1, 1, 0) AS TINYINT)																		AS [Anzahl offene Posten] 
	  ,CAST(IIF([Offen] = 0, 1, 0) AS TINYINT)																		AS [Anzahl geschlossener Posten] 
	  ,CAST(1 AS TINYINT)																							AS [Anzahl Posten] 
	  --detailierte Debitorenposten
      ,[Betrag (MW)]
      ,[Sollbetrag (MW)]
      ,[Habenbetrag (MW)]
	  ,[Letztes Zahlungsdatum]
	  ,[Offener Betrag (MW)]
      ,[Betrag Zahlungsrabatt (MW)]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
      ,[Betrag inkl. MwSt. (MW)]
      ,[Betrag]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Offener Betrag]
      ,[Betrag Zahlungsrabatt]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt)]
      ,[Betrag inkl. MwSt.]
  FROM [fin].[fOPKreditor90_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBilanzParentChild]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBilanzParentChild
































CREATE VIEW [dim].[dBilanzParentChild] AS

SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code Original]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code Original]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
      ,[Aktiva Code]
      ,[Passiva Code]
      ,[Umkehr Code]
      ,[Elementbezeichnung]
      ,[Sachkontobezeichnung (Nummer)]
      ,[Sachkontonummer Bezeichnung]
	  ,[PK dBilanzParentChild]
  FROM [dim].[dBilanzParentChild70_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBWAParentChild70_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBWAParentChild70_2_CONCAT





















CREATE VIEW [dim].[dBWAParentChild70_2_CONCAT] AS
SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code Original]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code Original]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
	  ,[Umkehr Code]
	  ,[Elementbezeichnung]
	  ,CAST(ISNULL([Sachkontobezeichnung],'''') AS NVARCHAR(100)) + '' ('' + CAST([Sachkontonummer] AS NVARCHAR(20)) + '')'' AS [Sachkontobezeichnung (Nummer)]
      ,CAST(ISNULL([Sachkontonummer],'''') AS NVARCHAR(20)) + '' '' + CAST([Sachkontobezeichnung] AS NVARCHAR(100)) AS [Sachkontonummer Bezeichnung]
	  ,[Mandant Code] +''_''+ [Child Code] AS [PK dBWAParentChild]
  FROM [dim].[dBWAParentChild75_2_UI]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dim].[dBWAParentChild]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View dBWAParentChild































CREATE VIEW [dim].[dBWAParentChild] AS

SELECT [Strukturbezeichnung]
      ,[Mandant Code]
      ,[Parent Zeilennummer]
      ,[Parent Code Original]
      ,[Parent Code]
      ,[Parentbezeichnung]
      ,[Child Zeilennummer]
      ,[Child Code Original]
      ,[Child Code]
      ,[Childbezeichnung]
      ,[Sachkontonummer]
      ,[Sachkontobezeichnung]
      ,[Ist Sachkonto]
	  ,[Sachkontobezeichnung (Nummer)]
      ,[Sachkontonummer Bezeichnung]
	  ,[Umkehr Code]
	  ,[Elementbezeichnung]
	  ,[PK dBWAParentChild]
  FROM [dim].[dBWAParentChild70_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor80_2]'))
EXEC dbo.sp_executesql @statement = N'




-- Alter View fOPKreditor80_2






























CREATE VIEW [fin].[fOPKreditor80_2] AS
SELECT [fin].[fOPKreditor85_2].[Kreditorenposten Lfd.]
      ,[fin].[fOPKreditor85_2].[Kostenstelle Code]
      ,[fin].[fOPKreditor85_2].[Kostenträger Code]
      ,[fin].[fOPKreditor85_2].[Kreditornummer]
      ,[fin].[fOPKreditor85_2].[Buchungsdatum]
      ,[fin].[fOPKreditor85_2].[Belegartcode]
      ,[fin].[fOPKreditor85_2].[Belegartbezeichnung DE]
      ,[fin].[fOPKreditor85_2].[Belegartbezeichnung EN]
      ,[fin].[fOPKreditor85_2].[Belegnummer]
      ,[fin].[fOPKreditor85_2].[Währung Code]
      ,[fin].[fOPKreditor85_2].[Rechnungsrabatt (MW)]
      ,[fin].[fOPKreditor85_2].[Einkauf von Kreditornummer]
	  ,[fin].[fOPKreditor85_2].[Einkauf von Kreditorbezeichnung]
      ,[fin].[fOPKreditor85_2].[Lieferantenbuchungsgruppe Code]
      ,[fin].[fOPKreditor85_2].[Einkäufer Code]
      ,[fin].[fOPKreditor85_2].[Abwarten]
      ,[fin].[fOPKreditor85_2].[Ausgeglichen mit Belegart]
      ,[fin].[fOPKreditor85_2].[Ausgeglichen mit Belegnummer]
      ,[fin].[fOPKreditor85_2].[Offen]
      ,[fin].[fOPKreditor85_2].[Offenbezeichnung DE]
      ,[fin].[fOPKreditor85_2].[Offenbezeichnung EN]
      ,[fin].[fOPKreditor85_2].[Fälligkeitsdatum]
      ,[fin].[fOPKreditor85_2].[Skontodatum]
      ,[fin].[fOPKreditor85_2].[Zahlungsrabatt erhalten (MW)]
      ,[fin].[fOPKreditor85_2].[Geschlossen mit Betrag (MW)]
      ,[fin].[fOPKreditor85_2].[Belegdatum]
      ,[fin].[fOPKreditor85_2].[Externe Belegnummer]
      ,[fin].[fOPKreditor85_2].[Ausgleichposten]
      ,[fin].[fOPKreditor85_2].[storniert]
      ,[fin].[fOPKreditor85_2].[im vorraus bezahlt]
	  ,[fin].[fOPKreditor85_2].[Geschlossen von Lfd. Nr.]
      ,[fin].[fOPKreditor85_2].[Geschlossen am]
	  ,[fin].[fOPKreditor85_2].[Bilanzkontotyp]
	  ,[fin].[fOPKreditor85_2].[Bilanzkontotypbezeichnung  DE]
	  ,[fin].[fOPKreditor85_2].[Bilanzkontotypbezeichnung  EN]
	  ,[fin].[fOPKreditor85_2].[Ursache Code]
	  ,[fin].[fOPKreditor85_2].[Ursachenbezeichnung]
	  ,[fin].[fOPKreditor85_2].[Gehört zu ID]
	  ,[fin].[fOPKreditor85_2].[Skontotoleranzdatum]
	  ,[fin].[fOPKreditor85_2].[Zahlungsbedingung Code]
      ,[fin].[fOPKreditor85_2].[Mandant Code]
      ,[fin].[fOPKreditor85_2].[Bundesland]
	  ,[fin].[fOPKreditor85_2].[Zahlungsbedingung Code (Rechnung)]
	  ,[fin].[fOPKreditor85_2].[Alter offener Posten]
	  ,[dim].[dAltersstruktur].[Altersstruktur Code]
	  ,[dim].[dFälligkeitsklasse].[Fälligkeitsklasse Code]
	  ,[fin].[fOPKreditor85_2].[Anzahl Tage fällig]
      ,[fin].[fOPKreditor85_2].[Anzahl Tage letzten Zahlung]
      ,[fin].[fOPKreditor85_2].[Anzahl Tage Zahlungsdauer]
      ,[fin].[fOPKreditor85_2].[Anzahl Tage Zahlungsfrist]
      ,[fin].[fOPKreditor85_2].[Anzahl Tage Rabattperiode]
      ,[fin].[fOPKreditor85_2].[Anzahl offene Posten]
      ,[fin].[fOPKreditor85_2].[Anzahl geschlossener Posten]
      ,[fin].[fOPKreditor85_2].[Anzahl Posten]
      ,[fin].[fOPKreditor85_2].[Betrag (MW)]
	  ,[fin].[fOPKreditor85_2].[Sollbetrag (MW)]
	  ,[fin].[fOPKreditor85_2].[Habenbetrag (MW)]
      ,[fin].[fOPKreditor85_2].[Letztes Zahlungsdatum]
      ,[fin].[fOPKreditor85_2].[Offener Betrag (MW)]
      ,[fin].[fOPKreditor85_2].[Betrag Zahlungsrabatt (MW)]
      ,[fin].[fOPKreditor85_2].[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
      ,[fin].[fOPKreditor85_2].[Betrag inkl. MwSt. (MW)]
	  ,[fin].[fOPKreditor85_2].[Betrag]
	  ,[fin].[fOPKreditor85_2].[Sollbetrag]
	  ,[fin].[fOPKreditor85_2].[Habenbetrag]
	  ,[fin].[fOPKreditor85_2].[Offener Betrag]
	  ,[fin].[fOPKreditor85_2].[Betrag Zahlungsrabatt]
	  ,[fin].[fOPKreditor85_2].[Betrag Zahlungsrabatt (ungerechtfertigt)]
	  ,[fin].[fOPKreditor85_2].[Betrag inkl. MwSt.]
  FROM [fin].[fOPKreditor85_2]

  --Strukturanbindung
  --in der Altersttruktur haben wir negative Grenzen, daher muss auch Start und Ende vertauscht werden
  LEFT JOIN [dim].[dAltersstruktur]
  ON [fin].[fOPKreditor85_2].[Alter offener Posten] BETWEEN [dim].[dAltersstruktur].[Altersstruktur Ende] AND [dim].[dAltersstruktur].[Altersstruktur Start]

  LEFT JOIN [dim].[dFälligkeitsklasse]
  ON [fin].[fOPKreditor85_2].[Anzahl Tage fällig] BETWEEN [dim].[dFälligkeitsklasse].[Fälligkeitsklasse Start] AND [dim].[dFälligkeitsklasse].[Fälligkeitsklasse Ende]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor75_2_CONCAT]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fOPKreditor75_2_CONCAT

CREATE VIEW [fin].[fOPKreditor75_2_CONCAT] AS
SELECT [Kreditorenposten Lfd.]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Kreditornummer]
      ,[Buchungsdatum]
      ,[Belegartcode]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Rechnungsrabatt (MW)]
      ,[Einkauf von Kreditornummer]
      ,[Einkauf von Kreditorbezeichnung]
      ,[Lieferantenbuchungsgruppe Code]
      ,[Einkäufer Code]
      ,[Abwarten]
      ,[Ausgeglichen mit Belegart]
      ,[Ausgeglichen mit Belegnummer]
      ,[Offen]
      ,[Offenbezeichnung DE]
      ,[Offenbezeichnung EN]
      ,[Fälligkeitsdatum]
      ,[Skontodatum]
      ,[Zahlungsrabatt erhalten (MW)]
      ,[Geschlossen mit Betrag (MW)]
      ,[Belegdatum]
      ,[Externe Belegnummer]
      ,[Ausgleichposten]
      ,[storniert]
      ,[im vorraus bezahlt]
      ,[Geschlossen von Lfd. Nr.]
      ,[Geschlossen am]
      ,[Bilanzkontotyp]
      ,[Bilanzkontotypbezeichnung  DE]
      ,[Bilanzkontotypbezeichnung  EN]
      ,[Ursache Code]
      ,[Ursachenbezeichnung]
      ,[Gehört zu ID]
      ,[Skontotoleranzdatum]
      ,[Zahlungsbedingung Code]
      ,[Mandant Code]
      ,[Bundesland]
      ,[Zahlungsbedingung Code (Rechnung)]
      ,[Alter offener Posten]
      ,[Altersstruktur Code]
      ,[Fälligkeitsklasse Code]
      ,[Anzahl Tage fällig]
      ,[Anzahl Tage letzten Zahlung]
      ,[Anzahl Tage Zahlungsdauer]
      ,[Anzahl Tage Zahlungsfrist]
      ,[Anzahl Tage Rabattperiode]
      ,[Anzahl offene Posten]
      ,[Anzahl geschlossener Posten]
      ,[Anzahl Posten]
      ,[Betrag (MW)]
      ,[Sollbetrag (MW)]
      ,[Habenbetrag (MW)]
      ,[Letztes Zahlungsdatum]
      ,[Offener Betrag (MW)]
      ,[Betrag Zahlungsrabatt (MW)]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
      ,[Betrag inkl. MwSt. (MW)]
      ,[Betrag]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Offener Betrag]
      ,[Betrag Zahlungsrabatt]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt)]
      ,[Betrag inkl. MwSt.]
	  --PK for PowerBI
	  ,[Mandant Code]																									AS [PK dMandant]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenstelle Code],''NULL'')															AS [PK dKostenstelleDimension]
	  ,[Mandant Code] +''_''+ ISNULL([Kostenträger Code],''NULL'')															AS [PK dKostenträgerDimension]
	  ,[Mandant Code] +''_''+ ISNULL([Kreditornummer],''NULL'')																	AS [PK dKreditor]
	  ,[Mandant Code] +''_''+ ISNULL([Zahlungsbedingung Code (Rechnung)],''NULL'')												AS [PK dZahlungsbedingungen]
	  ,[Mandant Code] +''_''+ ISNULL([Einkäufer Code],''NULL'')																AS [PK dEinkäufer]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Buchungsdatum],21),''NULL'')												AS [PK dZeit (Buchungsdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Belegdatum],21),''NULL'')											AS [PK dZeit (Belegdatum)]
	  ,[Bundesland] +''_''+ ISNULL(CONVERT(NVARCHAR(25),[Fälligkeitsdatum],21),''NULL'')													AS [PK dZeit (Fälligkeitsdatum)]
	  ,ISNULL([Altersstruktur Code],''NULL'')																				AS [PK dAltersstruktur]
	  ,ISNULL([Fälligkeitsklasse Code],''NULL'')																				AS [PK dFälligkeitsklasse]
  FROM [fin].[fOPKreditor80_2]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[fin].[fOPKreditor]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View fOPKreditor




























CREATE VIEW [fin].[fOPKreditor] AS

SELECT [Kreditorenposten Lfd.]
      ,[Kostenstelle Code]
      ,[Kostenträger Code]
      ,[Kreditornummer]
      ,[Buchungsdatum]
      ,[Belegartcode]
      ,[Belegartbezeichnung DE]
      ,[Belegartbezeichnung EN]
      ,[Belegnummer]
      ,[Währung Code]
      ,[Rechnungsrabatt (MW)]
      ,[Einkauf von Kreditornummer]
      ,[Einkauf von Kreditorbezeichnung]
      ,[Lieferantenbuchungsgruppe Code]
      ,[Einkäufer Code]
      ,[Abwarten]
      ,[Ausgeglichen mit Belegart]
      ,[Ausgeglichen mit Belegnummer]
      ,[Offen]
      ,[Offenbezeichnung DE]
      ,[Offenbezeichnung EN]
      ,[Fälligkeitsdatum]
      ,[Skontodatum]
      ,[Zahlungsrabatt erhalten (MW)]
      ,[Geschlossen mit Betrag (MW)]
      ,[Belegdatum]
      ,[Externe Belegnummer]
      ,[Ausgleichposten]
      ,[storniert]
      ,[im vorraus bezahlt]
      ,[Geschlossen von Lfd. Nr.]
      ,[Geschlossen am]
      ,[Bilanzkontotyp]
      ,[Bilanzkontotypbezeichnung  DE]
      ,[Bilanzkontotypbezeichnung  EN]
      ,[Ursache Code]
      ,[Ursachenbezeichnung]
      ,[Gehört zu ID]
      ,[Skontotoleranzdatum]
      ,[Zahlungsbedingung Code]
      ,[Mandant Code]
      ,[Bundesland]
      ,[Zahlungsbedingung Code (Rechnung)]
      ,[Alter offener Posten]
      ,[Altersstruktur Code]
      ,[Fälligkeitsklasse Code]
      ,[Anzahl Tage fällig]
      ,[Anzahl Tage letzten Zahlung]
      ,[Anzahl Tage Zahlungsdauer]
      ,[Anzahl Tage Zahlungsfrist]
      ,[Anzahl Tage Rabattperiode]
      ,[Anzahl offene Posten]
      ,[Anzahl geschlossener Posten]
      ,[Anzahl Posten]
      ,[Betrag (MW)]
      ,[Sollbetrag (MW)]
      ,[Habenbetrag (MW)]
      ,[Letztes Zahlungsdatum]
      ,[Offener Betrag (MW)]
      ,[Betrag Zahlungsrabatt (MW)]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt) (MW)]
      ,[Betrag inkl. MwSt. (MW)]
      ,[Betrag]
      ,[Sollbetrag]
      ,[Habenbetrag]
      ,[Offener Betrag]
      ,[Betrag Zahlungsrabatt]
      ,[Betrag Zahlungsrabatt (ungerechtfertigt)]
      ,[Betrag inkl. MwSt.]
      ,[PK dMandant]
      ,[PK dKostenstelleDimension]
      ,[PK dKostenträgerDimension]
      ,[PK dKreditor]
      ,[PK dZahlungsbedingungen]
      ,[PK dEinkäufer]
      ,[PK dZeit (Buchungsdatum)]
      ,[PK dZeit (Belegdatum)]
      ,[PK dZeit (Fälligkeitsdatum)]
      ,[PK dAltersstruktur]
      ,[PK dFälligkeitsklasse]
  FROM [fin].[fOPKreditor75_2_CONCAT]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0000480_Dimensionssatzposten]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0000480_Dimensionssatzposten








CREATE VIEW [vv].[vBC_t0000480_Dimensionssatzposten] AS
SELECT [Dimension Set ID]		AS [Dimensionsatz ID]		-- Dimensionsatz ID
      ,[Dimension Code]			AS [Dimensionscode]			-- Dimensionscode
      ,[Dimension Value Code]	AS [Dimensionswert]			-- Dimensionswert
      ,[Dimension Value ID]		AS [Dimensionswert ID]		-- Dimensionswert ID
      ,[SG_MandantCode]			AS [Mandant Code]			-- Mandant ID
  FROM [com].[BC_t0000480_Dimension_Set_Entry]
' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vv].[vBC_t0005401_Artikelvariante]'))
EXEC dbo.sp_executesql @statement = N'





-- Alter View vBC_t0005401_Artikelvariante


CREATE VIEW [vv].[vBC_t0005401_Artikelvariante] AS
SELECT [Code]				AS [Artikelvarianten Code]			   -- Artikelvariante Code
      ,[Item No_]			AS [Artikelnummer]					   -- Artikelnummer
      ,[Description]		AS [Artikelvariantenbezeichnung]	   -- Artikelvariante Bezeichnung
      ,[Description 2]		AS [Artikelvariantenbezeichnung 2]	   -- Artikelvariante Bezeichnung 2
      ,[SG_MandantCode]		AS [Mandant Code]				   -- Mandant ID
  FROM [com].[BC_t0005401_Item_Variant]
' 
GO
