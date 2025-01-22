--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER OFF
--GO

--***************************************************************************
--    Procedure Name : usp_LabWare_SaveResultsLog
--
--    Description    : logging when loginUser retrive a pdf lab result				  
--    Author         : LilyL
--    Date Written   : 10/08/2015
--    Current Version: 
--	Vers. # Date:       Author:		Description:
--		
--	------- ----------  ----------	-------------------------------------------
--
---***************************************************************************

CREATE PROCEDURE  [dbo].[usp_LabWare_SaveResultsLog]

@loginUser varchar(50), 
@logDateTime datetime,
@clinic  varchar(50),
@dateViewed datetime,
@reportNum int

AS

Begin

Insert into [dbo].[RESULTSLOG]
values (@loginUser, @logDateTime, @clinic, @dateViewed, @reportNum);

End



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_SaveResultsLog] TO [OSDH\LilyL]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_SaveResultsLog] TO [OSDH\OSDHDataService]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_SaveResultsLog] TO [AGENCY\278235]
    AS [dbo];

