
 --***************************************************************************
--    Procedure Name : [GetLabReportsByDateAndCustomer]
--
--    Description    : Get Reports By Date and Customer
--    Author         : Coz
--    Date Written   : 2020-04-015
--    Current Version: 
--    Vers. #	Date:			Author:        Description:
--    -------	----------		----------    -------------------------------------------
---***************************************************************************
CREATE PROCEDURE  [dbo].[GetLabReportsByDateAndCustomer]
@CustomerName varchar(30),  --Submitter ID for reports
@ReportDate datetime	--One day's reports for a particular submitter for report created date.
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
 WHERE cus.[NAME] = @CustomerName
   AND rep.DATE_CREATED BETWEEN @ReportDate and DATEADD(dd,1,@ReportDate) 
   AND (rep.report_file_name is not NULL ) 
   AND rep.REPORT_STATUS = 'T'
   AND (sam.Z_PROGRAM IS NULL
    OR sam.Z_PROGRAM != '30')
   ORDER BY sam.LABEL_ID, 
			rep.DATE_CREATED desc

