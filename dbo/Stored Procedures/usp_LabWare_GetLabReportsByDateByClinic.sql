--***************************************************************************
--    Procedure Name : [usp_LabWare_GetLabReportsByDateByClinic]
--
--    Description    : Get All daily Reports By ClinicID lives in [LabWare_Lab_Data]
--					   Retrive data from [LabWare_Prod].
--    Author         : LilyL
--    Date Written   : 08/12/2014
--    Current Version: 
--	Vers. # Date:       Author:		Description:
--	------- ----------  ----------	-------------------------------------------
--		11/13/2015		lilyl		update prod
--		12/14/2015		lilyl		Add filter to hide Emp Health data
--		12/31/2015		PeterL		Reworked procedure to simplify and correct issue with null Z_PROGRAM values
--		1/26/2016		PeterL		Added REPORT_STATUS = 'T' condition to REPORTS insert.
---***************************************************************************
CREATE PROCEDURE  [dbo].[usp_LabWare_GetLabReportsByDateByClinic]
@clinicID varchar(20),  --Submitter ID for reports
@repDate datetime	--One day's reports for a particular submitter for report created date.
AS
SELECT sam.Sampled_Date as DateCollected, 
       rep.report_file_name as Pdfpath,         
       sam.LABEL_ID as LabelId, 
       sam.CUSTOMER as Clinic,
       sam.PATIENT as Patient,           
       sam.X_Practitioner as Doc, 
       sam.X_SAMPLE_CATEGORY as TestType, 
       sam.X_Specimen_Source as SpecimenSource,  
       rep.DATE_CREATED as DateCreated, 
       rep.PURPOSE as Purpose 
  FROM [LabWare_Prod].[dbo].[SAMPLE] as sam INNER JOIN
       [LabWare_Prod].[dbo].[CUSTOMER] AS cus ON sam.CUSTOMER = cus.NAME INNER JOIN
	   [LabWare_Prod].[dbo].[REPORT_OBJECTS] as obj on sam.SAMPLE_NUMBER = obj.[OBJECT_ID] INNER JOIN
	   [LabWare_Prod].[dbo].[REPORTS] as rep on obj.REPORT_NUMBER = rep.REPORT_NUMBER 
 WHERE cus.Z_PHOCIS_ID = @clinicID 
   AND rep.DATE_CREATED BETWEEN @repDate and DATEADD(dd,1,@repDate) 
   AND (rep.report_file_name is not NULL ) 
   AND rep.REPORT_STATUS = 'T'
   AND (sam.Z_PROGRAM IS NULL
    OR sam.Z_PROGRAM != '30')
   ORDER BY sam.LABEL_ID, 
			rep.DATE_CREATED desc



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_GetLabReportsByDateByClinic] TO [OSDH\LilyL]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_GetLabReportsByDateByClinic] TO [AGENCY\278235]
    AS [dbo];

