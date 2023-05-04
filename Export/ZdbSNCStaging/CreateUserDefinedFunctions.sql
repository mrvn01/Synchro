SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SG_DELETE_BC_DEFAULT_DATETIME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Wessel, Jörn
-- Create date: 27.11.2019
-- Description:	the default value for an datetime field in BC is 01.01.1753 (the entries can not be NULL)
--				therefore these entries have to be nulled
-- =============================================

CREATE FUNCTION [dbo].[SG_DELETE_BC_DEFAULT_DATETIME]  (
	
	@DATE DATETIME

)
RETURNS DATETIME
AS
BEGIN
   -- In NAV wird in der Datenbank für Leere Datumsfelder das Datum 01.01.1753 hinterlegt
   -- Diese Funktion überführt das Datum ''01.01.1753'' in einen NULLwert
   
   RETURN NULLIF(@DATE,CAST(''01.01.1753'' AS DATETIME))
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SG_REPORT_DATE_TODAY]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'





CREATE FUNCTION [dbo].[SG_REPORT_DATE_TODAY]  ()
RETURNS DATETIME
AS
BEGIN
   -- Diese Funktion liefert bis 20:00 das aktuelle Datum (Ohne Urzeit)
   -- Nach 20:00 wird das Datum vom Folgetag ermittelt. 
   -- Die Funktion ist notwendig, da der ETL Prozess ggf. am Abend oder Morgen des Folgetages ausgeführt wird
   -- jedoch das heutige Datum in Bezug auf die Reportausführungszeit ermittelt werden soll. 
   
   DECLARE @CurrentDate DATETIME
   DECLARE @GETDATE DATETIME
   DECLARE @GETDATEDate DATETIME
   DECLARE @GETDATETime VARCHAR(8)
   
   SET @GETDATE = GETDATE()
   
   SET @GETDATEDate =  CAST(CAST(@GETDATE AS DATE) AS DATETIME)

   SET @GETDATETime = CONVERT(VARCHAR(8),@GETDATE,108)
   
   SET @CurrentDate = CASE WHEN @GETDATETime >= ''20:00:00''
							  THEN DATEADD(DAY, 1, @GETDATEDate)
							  ELSE @GETDATEDate 
						 END

   --Sonderlösung: Testdaten (Datumsbestand 06-2020), soll nur auf der Azure-Maschine überschrieben werden (2021-01-06 - JW)
   SET @CurrentDate = IIF(@@SERVERNAME = ''sncbspdbadwh'', ''2021-03-15 00:00:00.000'', @CurrentDate)
   RETURN (@CurrentDate)							
  

   
END

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SG_SPLIT_TOTALING_STRINGS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		Jörn Wessel
-- Create date: 18.11.2019
-- Description:	split totaling string values of BC
-- =============================================
CREATE FUNCTION [dbo].[SG_SPLIT_TOTALING_STRINGS]
(
	@totaling_string NVARCHAR(30),
	@startend_flag NVARCHAR(5)
)
RETURNS NVARCHAR(15)
AS
BEGIN
	DECLARE @intPositionDot INT
	DECLARE @intPositionPlus INT
	--return variable
	DECLARE @returnString NVARCHAR(15)

	--find positions of seperators
	SET @intPositionDot = CHARINDEX(''.'',@totaling_string,0);
	SET @intPositionPlus = CHARINDEX(''+'',@totaling_string,0);

	SET @returnString =  
		CASE 
	    --range splitting
			WHEN @intPositionDot > 0 AND @intPositionPlus = 0 AND @startend_flag = ''start''
			THEN SUBSTRING(@totaling_string,0,@intPositionDot)
			
			WHEN @intPositionDot > 0 AND @intPositionPlus = 0 AND @startend_flag = ''end''
			THEN SUBSTRING(@totaling_string, @intPositionDot+2,@intPositionDot)

		--plus splitting
			WHEN @intPositionDot = 0 AND @intPositionPlus > 0 AND @startend_flag = ''start''
			THEN SUBSTRING(@totaling_string,0,@intPositionPlus)

			WHEN @intPositionDot = 0 AND @intPositionPlus > 0 AND @startend_flag = ''end''
			THEN SUBSTRING(@totaling_string, @intPositionPlus+1,@intPositionPlus)
		ELSE @totaling_string
		END
		
	RETURN @returnString

END
' 
END
GO
