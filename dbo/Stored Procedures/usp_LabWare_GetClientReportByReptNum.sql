--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER OFF
--GO

--***************************************************************************
--    Procedure Name : usp_LabWare_GetLabReportsByReportNumber
--
--    Description    : Retrive file path with give report number in [LabWare_Lab_Data]				  
--    Author         : LilyL
--    Date Written   : 10/06/2015
--    Current Version: 
--	Vers. # Date:       Author:		Description:
--		11/13/15		lily		update Prod
--	------- ----------  ----------	-------------------------------------------
--
---***************************************************************************

CREATE PROCEDURE  [dbo].[usp_LabWare_GetClientReportByReptNum]

@reptNum int
AS

Select	report_file_name as Pdfpath		
From    [LabWare_Prod].[dbo].[REPORTS] 
Where	REPORT_NUMBER = @reptNum



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_GetClientReportByReptNum] TO [OSDH\LilyL]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_GetClientReportByReptNum] TO [AGENCY\278235]
    AS [dbo];

