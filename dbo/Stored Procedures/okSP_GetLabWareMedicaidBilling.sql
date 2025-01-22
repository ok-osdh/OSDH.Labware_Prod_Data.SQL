CREATE  Procedure [dbo].[okSP_GetLabWareMedicaidBilling]	@StartDate  datetime ,
															@EndDate  datetime
AS
/******************************************************************************
**		File: 
**		Name: okSP_GetLabWareMedicaidBilling
**		Desc: Procedure to populate the SUBMISSIONS table with Medicaid billable Lab tests performed between the
**			  start date and end date.
**              
**		Return values: None
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**		----------						-----------
**		@StartDate
**		@EndDate
**
**		Auth: Peter M. Lemmon
**		Date: 09/20/2005
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/07/05	PML					Added code to truncate Zip code to 5 characters.
**		12/21/05	PML					Added code to remove records without billable codes.
**		01/20/05	PML					Changed code to multiply CH columns by UNITS per Pankaj.
**		11/01/07	PML					Changed outputed StartDate to LITS Date_of_Collection
**		11/01/07	PML					Changed output EndDate to LITS date_test_completed.
**		01/03/08	PML					Changed output StartDate to LITS date_test_completed.
**		08/18/10	PML					Changed output EndDate to LITS Date_of_Collection.
**		08/18/10	PML					Changed output StartDate to LITS Date_of_Collection
**		08/18/10	PML					Changed Changed procedure to use new linked server (\\SALERIO) rather then \\NTFS5.
**		02/17/11	PML					Correct error with StartDate and EndDate
**		04/17/12	PML					Changed linked PHOCIS database to point to \\HIPPOLYTA rather than \\SALERIO
**		01/08/15	PML					Begin reworking procedure to bill Medicaid from LabWare system beginning with the
**										original okSP_GetLabMedicaidBilling procedure.
**		01/15/15	PML					Development completed -- not tested.
**		02/01/16	PML					Development resumed.  Remap source tables to Production environment.
**		02/29/16	PML					Rework procedure to pull billing rates from LabWare table(s).
**		03/01/16	PML					Development continued with procedure debugging.
**		03/03/16	PML					Development continued with filtering encounter diagnosis codes to those appropriate to laboratory testing CPTs.
**		03/04/16	PML					Diagnosis code lookup will revert to table-based lookup (same as LITS Plus...) per Mike Ewald.
**		03/07/16	PML					Development resumed with replacement of diagnosis code source.
**		04/19/16	PML					Troubleshooting last problems with procedure.
**		11/18/19	PML					Changed linked server from \\HIPPOLYTA to \\DAT-MSQ99-340
*******************************************************************************/

SET NOCOUNT ON
/**DECLARE @Counter tinyint ,
		@SQL varchar(2000),
		@MaxDCs tinyint **/
/** Build temporary table to hold reported specimens with linkable PATIENT_IDs, key information, and billing data structure. **/	
CREATE TABLE #pmlTemp (LabWareKey int NOT NULL ,
					DemographicsID int ,
					EncounterID int , 
					LabNumber varchar(20) ,
					StartDate smalldatetime ,
					EndDate smalldatetime ,
					SubmitterProgramID varchar(2) ,
					TotalCharges smallmoney ,
					DiagnosisCode1 varchar(7),
					PC1 varchar(6) ,
					DC1REF1 varchar(1) ,
					CH1 smallmoney , 
					CH1UNITS tinyint ,
					PC2 varchar(6) ,
					DC2REF1 varchar(1) ,
					CH2 smallmoney ,  
					CH2UNITS tinyint,
					PC3 varchar(6),
					DC3REF1 varchar(1) ,
					CH3 smallmoney, 
					CH3UNITS tinyint,
					PC4 varchar(6) ,
					DC4REF1 varchar(1) ,
					CH4 smallmoney , 
					CH4UNITS tinyint ,
					PC5 varchar(6) ,
					DC5REF1 varchar(1) ,
					CH5 smallmoney , 
					CH5UNITS tinyint ,
					PC6 varchar(6) ,
					DC6REF1 varchar(1) ,
					CH6 smallmoney , 
					CH6UNITS tinyint ,
					PC7 varchar(6) ,
					DC7REF1 varchar(1) ,
					CH7 smallmoney , 
					CH7UNITS tinyint ,
					PC8 varchar(6) ,
					DC8REF1 varchar(1) ,
					CH8 smallmoney , 
					CH8UNITS tinyint ,
					PC9 varchar(6) ,
					DC9REF1 varchar(1) ,
					CH9 smallmoney , 
					CH9UNITS tinyint ,
					PC10 varchar(6) ,
					DC10REF1 varchar(1) ,
					CH10 smallmoney , 
					CH10UNITS tinyint)
/** Populate temporary table **/
 INSERT INTO #pmlTemp (LabWareKey ,
					  DemographicsID ,
					  EncounterID ,
					  LabNumber ,
					  StartDate ,
					  EndDate ,
					  SubmitterProgramID ,
					  DiagnosisCode1 ,
					  PC1 ,
					  DC1REF1 ,
					  CH1UNITS , 
					  CH1 ,
					  PC2 ,
					  DC2REF1 ,
					  CH2UNITS ,
					  CH2 ,
					  PC3 ,
					  DC3REF1 ,
					  CH3UNITS ,
					  CH3 ,
					  PC4 ,
					  DC4REF1 ,
					  CH4UNITS ,
					  CH4 ,
					  PC5 ,
					  DC5REF1 ,
					  CH5UNITS ,
					  CH5 ,
					  PC6 ,
					  DC6REF1 ,
					  CH6UNITS ,
					  CH6 ,
					  PC7 ,
					  DC7REF1 ,
					  CH7UNITS ,
					  CH7 ,
					  PC8 ,
					  DC8REF1 ,
					  CH8UNITS ,
					  CH8 ,
					  PC9 ,
					  DC9REF1 ,
					  CH9UNITS ,
					  CH9 ,
					  PC10 ,
					  DC10REF1 ,
					  CH10UNITS ,
					  CH10)
 SELECT	bs.SubmissionKey ,
		bs.DemographicsID ,
		bs.ENCOUNTERID ,
		bs.LABNUMBER ,
		CONVERT(varchar(10),bs.STARTDATE,101) ,
		CONVERT(varchar(10),bs.ENDDATE,101) ,
		bs.SUBMITTERPROGRAM ,
		odc.DiagnosisCode ,
		ISNULL(bs.PC1,'999999') AS PC1 ,
		CASE bs.PC1
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC1REF1 ,
	    ISNULL(bs.CH1UNITS ,0) AS CH1UNITS , 
	    CASE bs.PC1
			WHEN NULL THEN 0
			ELSE ISNULL((c1.X_COST * bs.CH1UNITS),0)
			END AS CH1 ,
	    ISNULL(bs.PC2,'999999') AS PC2 ,
	    CASE bs.PC2
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC2REF1 ,
	    ISNULL(bs.CH2UNITS, 0) AS CH2UNITS ,
	    CASE bs.PC2
			WHEN NULL THEN 0
			ELSE ISNULL((c2.X_COST * bs.CH2UNITS),0)
			END AS CH2 ,
	    ISNULL(bs.PC3,'999999') AS PC3 ,
	    CASE bs.PC3
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC3REF1 ,
	    ISNULL(bs.CH3UNITS,0) AS CH3UNITS ,
	    CASE bs.PC3
			WHEN NULL THEN 0
			ELSE ISNULL((c3.X_COST * bs.CH3UNITS),0)
			END AS CH3 ,
	    ISNULL(bs.PC4,'999999') AS PC4 ,
		CASE bs.PC4
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC3REF1 ,
	    ISNULL(bs.CH4UNITS,0) AS CH4UNITS ,
	    CASE bs.PC4
			WHEN NULL THEN 0
			ELSE ISNULL((c4.X_COST * bs.CH4UNITS),0)
			END AS CH4 ,
	    ISNULL(bs.PC5,'999999') AS PC5 ,
	    CASE bs.PC5
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC5REF1 ,
	    ISNULL(bs.CH5UNITS,0) AS CH5UNITS ,
	    CASE bs.PC5
			WHEN NULL THEN 0
			ELSE ISNULL((c5.X_COST * bs.CH5UNITS),0)
			END AS CH5 ,
	    ISNULL(bs.PC6,'999999') AS PC6 ,
	    CASE bs.PC6
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC6REF1 ,
	    ISNULL(bs.CH6UNITS,0) AS CH6UNITS ,
	    CASE bs.PC6
			WHEN NULL THEN 0
			ELSE ISNULL((c6.X_COST * bs.CH6UNITS),0)
			END AS CH6 ,
	    ISNULL(bs.PC7,'999999') AS PC7 ,
	    CASE bs.PC7
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC7REF1 ,
	    ISNULL(bs.CH7UNITS,0) AS CH7UNITS ,
	    CASE bs.PC7
			WHEN NULL THEN 0
			ELSE ISNULL((c7.X_COST * bs.CH7UNITS),0)
			END AS CH7 ,
	    ISNULL(bs.PC8,'999999') AS PC8 ,
	    CASE bs.PC8
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC8REF1 ,
	    ISNULL(bs.CH8UNITS,0) AS CH8UNITS ,
	    CASE bs.PC8
			WHEN NULL THEN 0
			ELSE ISNULL((c8.X_COST * bs.CH8UNITS),0)
			END AS CH8 ,
	    ISNULL(bs.PC9,'999999') AS PC9 ,
	    CASE bs.PC9
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC9REF1 ,
	    ISNULL(bs.CH9UNITS,0) AS CH9UNITS ,
	    CASE bs.PC9
			WHEN NULL THEN 0
			ELSE ISNULL((c9.X_COST * bs.CH9UNITS),0)
			END AS CH9 ,
	    ISNULL(bs.PC10,'999999') AS PC10 ,
	    CASE bs.PC10
			WHEN NULL THEN ''
			ELSE '1'
			END AS DC10REF1 ,
	    ISNULL(bs.CH10UNITS,0) AS CH1UNITS ,
	    CASE bs.PC10
			WHEN NULL THEN 0
			ELSE ISNULL((c10.X_COST * bs.CH10UNITS),0)
			END AS CH10
   FROM LabWare_Prod.dbo.Z_BILLING_STAGING AS bs INNER JOIN
		LabWare_Prod_Data.dbo.OK_DiagnosisCodes AS odc ON bs.SubmitterProgram = odc.ProgramID LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c1 ON bs.PC1 = c1.CPT4
										AND c1.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c2 ON bs.PC2 = c2.CPT4
										AND c2.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c3 ON bs.PC3 = c3.CPT4
										AND c3.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c4 ON bs.PC4 = c4.CPT4
										AND c4.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c5 ON bs.PC5 = c5.CPT4
										AND c5.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c6 ON bs.PC6 = c6.CPT4
										AND c6.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c7 ON bs.PC7 = c7.CPT4
										AND c7.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c8 ON bs.PC8 = c8.CPT4
										AND c8.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c9 ON bs.PC9 = c9.CPT4
										AND c9.X_BILLABLE = 'T' LEFT OUTER JOIN
        LabWare_Prod.dbo.CPT_CODES AS c10 ON bs.PC10 = c10.CPT4
										AND c10.X_BILLABLE = 'T'
  WHERE bs.STARTDATE BETWEEN @StartDate AND @EndDate
	AND ISNULL(bs.DEMOGRAPHICSID,0) <> 0
    AND ISNULL(bs.ENCOUNTERID,0) <> 0
    AND bs.RETRIEVED <> 'T'
/** Create index on LabNumber **/
CREATE NONCLUSTERED INDEX t1_LabWareKey ON #pmlTemp(LabWareKey)
/** Calculate and update TotalCharges in #pmlTemp. **/
UPDATE #pmlTemp
   SET TotalCharges = CH1 + CH2 + CH3 + CH4 + CH5 + CH6 + CH7 + CH8 + CH9 + CH10
/** Delete Specimens with linkable PATIENT_ID but no billable tests. **/
DELETE 
  FROM #pmlTemp 
 WHERE TotalCharges = 0
/** Comment out code to retrieve PHOCIS DCs
--  Create pmlTemp2 table for holding diagnosis codes. 
CREATE TABLE pmlTemp2 ([ID] int IDENTITY(1,1) NOT NULL ,
				 LabWareKey int ,
				 DiagnosisCode varchar(7))
CREATE NONCLUSTERED INDEX t2_LabWareKey ON pmlTemp2(LabWareKey)
-- Collect Diagnosis codes from PHOCIS Encounters into temp table pmlTemp2.  
INSERT pmlTemp2 (LabWareKey ,
			DiagnosisCode)
SELECT DISTINCT #pmlTemp.LabWareKey ,
				d.DiagnosisCode
  FROM #pmlTemp INNER JOIN
	   HIPPOLYTA.PHOCIS_QUERY.dbo.EncounterServices AS es ON #pmlTemp.EncounterID = es.encounter_id INNER JOIN
	   HIPPOLYTA.PHOCIS_QUERY.dbo.ServiceCode AS sc ON es.ServiceCodeID = sc.ServiceCodeID INNER JOIN
	   LabWare_Prod.dbo.CPT_CODES AS c ON sc.CODE = c.CPT4 INNER JOIN 
	   HIPPOLYTA.PHOCIS_QUERY.dbo.EncounterServicesDiagnosisCodes AS esdc on es.EncounterServiceID = esdc.EncounterServiceID INNER JOIN
	   HIPPOLYTA.PHOCIS_QUERY.dbo.Diagnosis AS d ON esdc.DiagnosisID = d.DiagnosisID
 ORDER BY #pmlTemp.LabWareKey
 -- Create pmlTemp3 table for use transposing pmlTemp2 diagnosis code data into #pmlTemp diagnosis codes. 
CREATE TABLE pmlTemp3 (LabWareKey int ,
				 DiagnosisCode varchar(7) ,
				 DCCount tinyint,
				 MinID smallint ,
				 MaxID smallint )
CREATE NONCLUSTERED INDEX t3_LabWareKey ON pmlTemp3(LabWareKey)
-- Gather count of encounter diagnosis codes. 
INSERT pmlTemp3 (LabWareKey ,
			DCCount ,
			MinID ,
			MaxID)
SELECT LabWareKey ,
	   COUNT(LabWareKey) AS DCCount ,
	   MIN(ID) AS MinID ,
	   MAX(ID) AS MaxID
  FROM pmlTemp2
GROUP BY LabWareKey
-- Update #pmlTemp DCCount field with count of encounter diagnosis codes, minimum ID for each LabWareKey diagnosis code, 
   and maximum ID  for each LabWareKey diagnosis code. 
UPDATE #pmlTemp
   SET DCCount = pmlTemp3.DCCount ,
	   MinID = pmlTemp3.MinID ,
	   MaxID = pmlTemp3.MaxID
  FROM #pmlTemp INNER JOIN
       pmlTemp3 ON #pmlTemp.LabWareKey = pmlTemp3.LabWareKey
-- Get maximum number of diagnosis codes 
 SELECT @MaxDCs = MAX(DCCount)
   FROM #pmlTemp
SELECT @MaxDCs AS MaxDC
-- Truncate table pmlTemp3  
 DELETE FROM pmlTemp3   
 -- Update #pmlTemp with diagnosis codes from pmlTemp2. 
 SELECT @Counter = 0
-- Loop to populate table #pmlTemp with diagnosis codes. 
WHILE @Counter < @MaxDCs - 1
SELECT @Counter
	BEGIN
-- Collect next set of Diagnosis Codes in pmlTemp3 
		INSERT pmlTemp3 (LabWareKey ,
			       DiagnosisCode)
		SELECT pmlTemp2.LabWareKey ,
			   pmlTemp2.DiagnosisCode
		  FROM pmlTemp2 INNER JOIN
		       #pmlTemp ON pmlTemp2.LabWareKey = #pmlTemp.LabWareKey
		           AND pmlTemp2.ID = #pmlTemp.MinID + @Counter 
-- Update appropriate #pmlTemp diagnosis code fields based on MinID and @Counter. 	
		SELECT	@SQL = 'UPDATE #pmlTemp ' + CHAR(13)
		SELECT	@SQL = @SQL + 'SET DiagnosisCode' + LTRIM(STR(1 + @Counter)) + ' = pmlTemp3.DiagnosisCode ' + CHAR(13)
		SELECT	@SQL = @SQL + 'FROM #pmlTemp INNER JOIN ' + CHAR(13)
		SELECT	@SQL = @SQL + '     pmlTemp3 ON #pmlTemp.LabWareKey = pmlTemp3.LabWareKey ' 
		EXEC(@SQL)
		SELECT @Counter = 1 + @Counter
-- Delete pmlTemp3 rows that held diagnosis codes just updated to #pmlTemp. 
	    DELETE FROM pmlTemp3  
	END
-- Drop unneeded temp tables. 
-- DROP TABLE pmlTemp3 
-- DROP TABLE pmlTemp2 **/
/** Update LabWare Z_BILLING_STAGING table RETRIEVED field. **/ 
UPDATE LabWare_Prod.dbo.Z_BILLING_STAGING
   SET RETRIEVED = 'T'
  FROM LabWare_Prod.dbo.Z_BILLING_STAGING AS bs INNER JOIN
	   #pmlTemp ON #pmlTemp.LabWareKey = bs.SUBMISSIONKEY 
/** Insert billable Lab tests in OK_SUBMISSIONS table **/
INSERT INTO LabWare_Prod_Data.dbo.SUBMISSIONS(SubmissionKey ,
											StatusID ,
											LabNumber ,
											DemographicsID ,
											Clinic_No ,
											StartDate  ,
											EndDate ,
											SUBMITTERID ,
											LOCATION ,
											SUBMITTERPROGRAM ,
											LASTNAME ,
											FIRSTNAME ,
											MIDDLENAME ,
											STREETADDRESS,
											CITY ,
											[STATE]  ,
											ZIPCODE ,
											DOB ,
											MEDICAID#  ,
											SSN  ,
											GENDER  ,
											SUBMITTERNAME ,
											DIAGNOSISCODE1 ,
											TOTALCHARGES ,
											PC1,
											DC1REF1 ,
											CH1 ,
											CH1UNITS ,
											PC2,
											DC2REF1 ,
											CH2 ,
											CH2UNITS ,
											PC3,
											DC3REF1 ,
											CH3 ,
											CH3UNITS ,
											PC4,
											DC4REF1 ,
											CH4 ,
											CH4UNITS ,
											PC5,
											DC5REF1 ,
											CH5 ,
											CH5UNITS ,
											PC6,
											DC6REF1 ,
											CH6 ,
											CH6UNITS ,
											PC7,
											DC7REF1 ,
											CH7 ,
											CH7UNITS ,
											PC8,
											DC8REF1 ,
											CH8 ,
											CH8UNITS ,
											PC9,
											DC9REF1 ,
											CH9 ,
											CH9UNITS ,
											PC10,
											DC10REF1 ,
											CH10 ,
											CH10UNITS ,
											ChangeDateTime ,
											ChangeUser)  
 SELECT #pmlTemp.LabWareKey + 2000000 AS SubmissionKey ,
		1 AS StatusID ,
		#pmlTemp.LabNumber ,
		#pmlTemp.DemographicsID ,
		'99299' AS Clinic_No ,
		#pmlTemp.StartDate  ,
		#pmlTemp.EndDate ,
		'100758760' AS SUBMITTERID ,
		'B' AS LOCATION ,
		#pmlTemp.SubmitterProgramID ,
		CASE LEN(RTRIM(ISNULL(ins.MedicaidLastName,'')))
			WHEN 0 THEN LEFT(dem.last_name,35)
			ELSE LEFT(ins.MedicaidLastName,35)
		END AS LASTNAME ,
		CASE LEN(RTRIM(ISNULL(ins.MedicaidFirstName,'')))
			WHEN 0 THEN dem.first_name
			ELSE ins.MedicaidFirstName
		END AS FIRSTNAME ,
		CASE dem.middle_initial 
			WHEN 'NMI' THEN ''
			WHEN '-' THEN ''
			WHEN 'UNK' THEN ''
			WHEN 'N.M.I.' THEN ''
			ELSE ISNULL(dem.middle_initial,'')
		END AS MIDDLENAME ,
		LEFT(RTRIM(dem.mailing_address_1 + ' ' + ISNULL(dem.mailing_address_2,'')),55) AS STREETADDRESS ,
		dem.city AS CITY ,
		dem.state AS STATE  ,
		LEFT(LTRIM(STR(dem.zip)),5) AS ZIPCODE ,
		dem.dob AS DOB ,
		CASE 
			WHEN LEN(RTRIM(ins.MedicaidNumber)) = 9 THEN RTRIM(ins.MedicaidNumber)
			WHEN LEN(RTRIM(dem.medicaid_no)) = 9 THEN RTRIM(dem.medicaid_no)
			ELSE ''
		END AS MEDICAID#  ,
		dem.ssn AS SSN  ,
		dem.gender AS GENDER  ,
		'OSDH Public Health Lab' AS SUBMITTERNAME ,
		#pmlTemp.DiagnosisCode1 ,
		#pmlTemp.TotalCharges  ,
		#pmlTemp.PC1 ,
		#pmlTemp.DC1REF1 ,
		#pmlTemp.CH1  ,
		#pmlTemp.CH1Units ,
		#pmlTemp.PC2 ,
		#pmlTemp.DC2REF1 ,
		#pmlTemp.CH2  ,
		#pmlTemp.CH2UNITS ,
		#pmlTemp.PC3 ,
		#pmlTemp.DC3REF1 ,
		#pmlTemp.CH3  ,
		#pmlTemp.CH3UNITS ,
		#pmlTemp.PC4 ,
		#pmlTemp.DC4REF1 ,
		#pmlTemp.CH4 ,
		#pmlTemp.CH4UNITS ,
		#pmlTemp.PC5 ,
		#pmlTemp.DC5REF1 ,
		#pmlTemp.CH5 ,
		#pmlTemp.CH5UNITS ,
		#pmlTemp.PC6 ,
		#pmlTemp.DC6REF1 ,
		#pmlTemp.CH6 ,
		#pmlTemp.CH6UNITS ,
		#pmlTemp.PC7 ,
		#pmlTemp.DC7REF1 ,
		#pmlTemp.CH7 ,
		#pmlTemp.CH7UNITS ,
		#pmlTemp.PC8 ,
		#pmlTemp.DC8REF1 ,
		#pmlTemp.CH8  ,
		#pmlTemp.CH8UNITS ,
		#pmlTemp.PC9 ,
		#pmlTemp.DC9REF1 ,
		#pmlTemp.CH9 ,
		#pmlTemp.CH9UNITS ,
		#pmlTemp.PC10 ,
		#pmlTemp.DC10REF1 ,
		#pmlTemp.CH10  ,
		#pmlTemp.CH10UNITS ,
		GETDATE() AS ChangeDateTime ,
		'LAB%EXP' AS ChangeUser
   FROM #pmlTemp INNER JOIN
		[DAT-MSQ99-340].PHOCIS_QUERY.dbo.DEMOGRAPHICS AS dem ON #pmlTemp.DemographicsID = dem.DemographicsID LEFT OUTER JOIN
		[DAT-MSQ99-340].PHOCIS_QUERY.dbo.INSURANCE AS ins ON #pmlTemp.DemographicsID = ins.DemographicsID  
/** Drop last temp table.  **/	
DROP TABLE #pmlTemp



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[okSP_GetLabWareMedicaidBilling] TO [AGENCY\143452]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[okSP_GetLabWareMedicaidBilling] TO [AGENCY\143452]
    AS [dbo];

