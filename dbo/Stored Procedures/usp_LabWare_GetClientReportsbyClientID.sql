--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER OFF
--GO

--***************************************************************************
--    Procedure Name : usp_LabWare_GetClientReportsbyClientID
--
--    Description    : Get Client Reports By ClientID lives in [LabWare_Lab_Data]
--					   Retrive data from [LabWare_Prod].
--    Author         : LilyL
--    Date Written   : 08/06/2014
--    Current Version: 
--	Vers. # Date:       Author:		Description:
--		8/14/2015		lilyl		Move DB to Prod, update names
--      9/17/2015		lilyl		Change filter to status = 'C' (temp)
--		10/06/2015      lilyl       Add ReptNum for logging
--		11/13/2015		lilyl		update prod
--	    12/14/2015		lilyl		Add filter to not showing Emp health
--		1/3/2016		peterl		Reworked procedure to simplify and correct issue with null Z_PROGRAM values
--		1/26/2016		PeterL		Added REPORT_STATUS = 'T' condition to REPORTS insert.
--	------- ----------  ----------	-------------------------------------------
--
---***************************************************************************

CREATE PROCEDURE  [dbo].[usp_LabWare_GetClientReportsbyClientID]

@clientID varchar(20)
AS

 SELECT	sam.Sampled_Date as DateCollected,	
		rep.report_file_name as Pdfpath,	
		rep.REPORT_NUMBER as ReptNum,	
		sam.LABEL_ID as LabelId, 
		sam.CUSTOMER as Clinic, 
		sam.X_Practitioner as Doc, 
		sam.X_SAMPLE_CATEGORY as TestType, 
		sam.X_Specimen_Source as SpecimenSource,  
		Max(rep.DATE_CREATED) as DateCreated, 
		rep.PURPOSE as Purpose 
   FROM [LabWare_Prod].[dbo].[PATIENT] AS pat INNER JOIN
		[LabWare_Prod].[dbo].[SAMPLE] AS sam ON pat.NAME = sam.PATIENT INNER JOIN
		[LabWare_Prod].[dbo].[REPORT_OBJECTS] AS obj ON sam.SAMPLE_NUMBER = obj.[OBJECT_ID] INNER JOIN
		[LabWare_Prod].[dbo].[REPORTS] as rep on obj.REPORT_NUMBER = rep.REPORT_NUMBER 
  WHERE	pat.Z_PHOCIS_ID = @clientID
	AND rep.report_file_name IS NOT NULL
	AND rep.REPORT_STATUS = 'T'
	AND (sam.Z_PROGRAM IS NULL
	 OR sam.Z_PROGRAM != '30') --Z-Program not 30 means not from Occupation/Emp health
		--sam.STATUS = 'C'--C means completed 'A'means being reviewed. 9/24/15 Matt informed me to remove the condition on Status.
GROUP BY sam.LABEL_ID,rep.report_file_name,rep.REPORT_NUMBER, sam.CUSTOMER,sam.X_Practitioner, sam.X_SAMPLE_CATEGORY,sam.X_Specimen_Source,rep.PURPOSE,rep.DATE_CREATED, sam.[STATUS],sam.Sampled_Date 
ORDER BY rep.DATE_CREATED desc



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_GetClientReportsbyClientID] TO [OSDH\LilyL]
    AS [dbo];

