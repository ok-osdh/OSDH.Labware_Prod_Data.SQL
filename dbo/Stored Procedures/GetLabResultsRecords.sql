
/******************************************************************************
**		File: dbo.GetLabResultsRecords.sql
**		Name: dbo.GetLabResultsRecords.prc
**		Desc: returns lab results records to Lab Results selection screen in PHOCIS for Nurse to prune the list to print.  Should hit Labware prod db
**            If DemoID is 0 or not passed, report will get clinic by collection date instead. 1 Procedure for both options.
**		This template can be customized:
**              
**		
**		Parameters:
**		Input							Output
**     ----------						-----------
**      @DemographicsID					int 
**		@ClinicID                    db FLASH. TABLE CLINIC.Clinic     location only 3 digits
**		@CollectedDate					datetime
**		Auth: Tim Higdon
**		Date: 11/08/2022
*******************************************************************************
**		Change History
*******************************************************************************
**	   Date:		Author:				Description:
**	  --------		--------		-------------------------------------------
**    11/08/2022	Tim Higdon		Created		
**	  01/12/2023	Tim Higdon		Adding UseDateCreated to allow flexibility in using this
**    02/22/2023	Tim Higdon		Remove wildcard at the end of the client lab results query.  Was returning multiple clients instead of correct client.
**    05/19/2023	Tim Higdon		Fixing wildcard at the beginning to only include leading 0s to make sure we don't pull multiple clients.
*******************************************************************************/

 CREATE Procedure [dbo].[GetLabResultsRecords] @DemographicsID int = 0, @ClinicID int, @ReportDate datetime,  @UseDateCreated bit = 0
	 AS
 
DECLARE @chrDemographicsID varchar(20)
SET @chrDemographicsID = @DemographicsID

 IF @DemographicsID = 0  -- Get clinic lab results records for a single date
	 BEGIN
		IF @UseDateCreated = 1
			BEGIN
				SELECT sam.Sampled_Date as DateCollected, 
				rep.report_file_name as Pdfpath,  
				rep.REPORT_NUMBER as ReptNum,
				sam.LABEL_ID as LabelId, 
				sam.CUSTOMER as Clinic,
				sam.PATIENT as Patient,           
				sam.X_Practitioner as Doc, 
				sam.X_SAMPLE_CATEGORY as TestType, 
				sam.X_Specimen_Source as SpecimenSource,  
				rep.DATE_CREATED as DateCreated, 
				rep.PURPOSE as Purpose ,
				ISNULL(sam.X_PATIENT_FULLNAME,'') AS PatientName ,
				ISNULL(sam.X_SAMPLE_SUBCAT,'') AS Test 
				FROM [LabWare_Prod].[dbo].[SAMPLE] as sam INNER JOIN
				[LabWare_Prod].[dbo].[CUSTOMER] AS cus ON sam.CUSTOMER = cus.NAME INNER JOIN
				[LabWare_Prod].[dbo].[REPORT_OBJECTS] as obj on sam.SAMPLE_NUMBER = obj.[OBJECT_ID] INNER JOIN
				[LabWare_Prod].[dbo].[REPORTS] as rep on obj.REPORT_NUMBER = rep.REPORT_NUMBER 
				WHERE cus.Z_PHOCIS_ID = RIGHT('0000000' + CONVERT(varchar(3),@ClinicID),8)
				AND rep.DATE_CREATED BETWEEN @ReportDate and DATEADD(dd,1,@ReportDate)  --use this for created, use the other for collected date
				--AND sam.sampled_date BETWEEN @ReportDate and DATEADD(dd,1,@ReportDate) -- date dollected, plus 1 on the day.  Is this correct?
				AND (rep.report_file_name is not NULL ) 
				AND rep.REPORT_STATUS = 'T'
				AND (sam.Z_PROGRAM IS NULL
				OR sam.Z_PROGRAM != '30')
				ORDER BY sam.LABEL_ID, 
						rep.DATE_CREATED desc
			END
		ELSE
			BEGIN
				SELECT sam.Sampled_Date as DateCollected, 
				rep.report_file_name as Pdfpath,  
				rep.REPORT_NUMBER as ReptNum,
				sam.LABEL_ID as LabelId, 
				sam.CUSTOMER as Clinic,
				sam.PATIENT as Patient,           
				sam.X_Practitioner as Doc, 
				sam.X_SAMPLE_CATEGORY as TestType, 
				sam.X_Specimen_Source as SpecimenSource,  
				rep.DATE_CREATED as DateCreated, 
				rep.PURPOSE as Purpose ,
				ISNULL(sam.X_PATIENT_FULLNAME,'') AS PatientName ,
				ISNULL(sam.X_SAMPLE_SUBCAT,'') AS Test 
				FROM [LabWare_Prod].[dbo].[SAMPLE] as sam INNER JOIN
				[LabWare_Prod].[dbo].[CUSTOMER] AS cus ON sam.CUSTOMER = cus.NAME INNER JOIN
				[LabWare_Prod].[dbo].[REPORT_OBJECTS] as obj on sam.SAMPLE_NUMBER = obj.[OBJECT_ID] INNER JOIN
				[LabWare_Prod].[dbo].[REPORTS] as rep on obj.REPORT_NUMBER = rep.REPORT_NUMBER 
				WHERE cus.Z_PHOCIS_ID = RIGHT('0000000' + CONVERT(varchar(3),@ClinicID),8)
				-- AND rep.DATE_CREATED BETWEEN @repDate and DATEADD(dd,1,@repDate) use this for created, use the other for collected date
				AND sam.sampled_date BETWEEN @ReportDate and DATEADD(dd,1,@ReportDate) -- date dollected, plus 1 on the day.  Is this correct?
				AND (rep.report_file_name is not NULL ) 
				AND rep.REPORT_STATUS = 'T'
				AND (sam.Z_PROGRAM IS NULL
				OR sam.Z_PROGRAM != '30')
				ORDER BY sam.LABEL_ID, 
						rep.DATE_CREATED desc
			END
	END
 ELSE  -- Get client lab results records
	BEGIN
		 SELECT	sam.Sampled_Date as DateCollected,	
				rep.report_file_name as Pdfpath,	
				rep.REPORT_NUMBER as ReptNum,	
				sam.LABEL_ID as LabelId, 
				sam.CUSTOMER as Clinic, 
				sam.PATIENT as Patient, 
				sam.X_Practitioner as Doc, 
				sam.X_SAMPLE_CATEGORY as TestType, 
				sam.X_Specimen_Source as SpecimenSource,  
				Max(rep.DATE_CREATED) as DateCreated, 
				rep.PURPOSE as Purpose,
				ISNULL(sam.X_PATIENT_FULLNAME,'') AS PatientName ,
				ISNULL(sam.X_SAMPLE_SUBCAT,'') AS Test 
		   FROM [LabWare_Prod].[dbo].[PATIENT] AS pat INNER JOIN
				[LabWare_Prod].[dbo].[SAMPLE] AS sam ON pat.NAME = sam.PATIENT INNER JOIN
				[LabWare_Prod].[dbo].[REPORT_OBJECTS] AS obj ON sam.SAMPLE_NUMBER = obj.[OBJECT_ID] INNER JOIN
				[LabWare_Prod].[dbo].[REPORTS] as rep on obj.REPORT_NUMBER = rep.REPORT_NUMBER 
		  WHERE	(pat.Z_PHOCIS_ID like ('%' + @chrDemographicsID) -- 2-22-2023 Remove wildcard at the end, returning wrong clients = @chrDemographicsID
			AND pat.Z_PHOCIS_ID NOT LIKE '%[^0]%' + @chrDemographicsID)  -- 5-19-2023 Do not get other records that are not 0 leading.  Was returning other clients.
			AND rep.report_file_name IS NOT NULL
			AND rep.REPORT_STATUS = 'T'
			AND (sam.Z_PROGRAM IS NULL
			 OR sam.Z_PROGRAM != '30') --Z-Program not 30 means not from Occupation/Emp health
				--sam.STATUS = 'C'--C means completed 'A'means being reviewed. 9/24/15 Matt informed me to remove the condition on Status.
		GROUP BY sam.LABEL_ID,rep.report_file_name,rep.REPORT_NUMBER, sam.CUSTOMER,sam.PATIENT, sam.X_Practitioner, sam.X_SAMPLE_CATEGORY,
		sam.X_Specimen_Source,rep.PURPOSE,rep.DATE_CREATED, sam.[STATUS],sam.Sampled_Date,sam.X_PATIENT_FULLNAME,
				sam.X_SAMPLE_SUBCAT  
		ORDER BY rep.DATE_CREATED desc
			END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLabResultsRecords] TO [phocisapp]
    AS [dbo];

