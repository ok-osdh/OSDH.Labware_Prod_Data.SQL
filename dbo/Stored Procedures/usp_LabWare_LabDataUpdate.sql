--***************************************************************************
--    Procedure Name : [usp_LabWare_LabDataUpdate]
--
--    Description    : Update table data for LabWare_Lab_Data
--    Author         : LilyL
--    Date Written   : 03/19/2015
--    Current Version: 
--	Vers. # Date:					Author:		Description:
--		8/14/2015					lilyl		Move to test db, update name
--      10/22/2015 - 11/12/2015     lilyl		overall adjust
--	------- ----------  ----------	-------------------------------------------
--		11/30/2015					lilyl		copy from test and change to Prod name.
--		12/29/2015					PeterL		Reworked procedure to simplify and correct skipped records.
--		1/3/2016					PeterL		Added filter to SAMPLE insert for Employee Health specimens,
--												  added joins and filter to REPORTS insert limiting records to specimens in SAMPLE table,
--												  and removed STATUS filter from TEST insert.
--		1/7/2016					PeterL		Added OR condition to ANALYSIS insert to include PFGE and GASTRO_PANEL analyses
--												  and addes OR condition to TEST insert to include tests for PFGE and GASTRO_PANEL analyses.
--		1/8/2016					PeterL		Added OR condition to RESULT insert to include PFGE and GASTRO_PANEL results.
--		1/26/2016					PeterL		Added REPORT_STATUS = 'T' condition to REPORTS insert.
--		5/15/2020					PeterL		Added HOME_PHONE to PATIENT insert.
--
---***************************************************************************

CREATE PROCEDURE  [dbo].[usp_LabWare_LabDataUpdate]
AS
--ANALYSIS-----------------------------------------------------------------------
----UPDATE:
	UPDATE tar
	   SET tar.ACTIVE = src.ACTIVE , 
	       tar.REPORTED_NAME = src.REPORTED_NAME , 
		   tar.COMMON_NAME = src.COMMON_NAME , 
		   tar.ANALYSIS_TYPE = src.ANALYSIS_TYPE , 
		   tar.[DESCRIPTION] = src.[DESCRIPTION] ,
		   tar.CHANGED_ON = src.CHANGED_ON
	  FROM LabWare_Prod.dbo.ANALYSIS AS src INNER JOIN 
		   LabWare_Prod_Data.dbo.ANALYSIS tar ON src.NAME = tar.NAME AND src.[VERSION] = tar.[VERSION]
	 WHERE src.CHANGED_ON > tar.CHANGED_ON		
----INSERT:
	INSERT LabWare_Prod_Data.dbo.ANALYSIS (
	       NAME,
		   [VERSION],
		   ACTIVE,
		   REPORTED_NAME,
		   COMMON_NAME,
		   ANALYSIS_TYPE,
		   [DESCRIPTION], 
		   CHANGED_ON)
	SELECT src.NAME ,
		   src.[VERSION],
		   src.ACTIVE,
		   src.REPORTED_NAME,
		   src.COMMON_NAME,
		   src.ANALYSIS_TYPE,
		   src.[DESCRIPTION], 
		   src.CHANGED_ON	
	  FROM LabWare_Prod.dbo.ANALYSIS AS src LEFT OUTER JOIN 
		   LabWare_Prod_Data.dbo.ANALYSIS AS tar ON src.NAME = tar.NAME AND src.[VERSION] = tar.[VERSION]			
	 WHERE ((src.ACTIVE = 'T' 
	   AND (src.X_REPORTABLE = 'T' 
	    OR src.X_PRELIMINARY_OS = 'T'))
		OR (src.NAME IN ('PFGE','GASTRO_PANEL'))) 
	   AND tar.NAME IS NULL
--COMPONENT-----------------------------------------------------------------------
----INSERT:		
	 INSERT COMPONENT (
			ANALYSIS ,
			NAME ,
			[VERSION] ,
			ORDER_NUMBER ,
			RESULT_TYPE , 
			REPORTABLE ,
			OPTIONAL )
	 SELECT src.ANALYSIS ,
		    src.NAME ,
			src.[VERSION] ,
			src.ORDER_NUMBER ,
			src.RESULT_TYPE ,
			src.REPORTABLE ,
			src.OPTIONAL
	   FROM [LabWare_Prod].[dbo].COMPONENT AS src INNER JOIN
	        [LabWare_Prod_Data].dbo.ANALYSIS AS a ON src.ANALYSIS = a.NAME 
												 AND src.VERSION = a.VERSION LEFT OUTER JOIN
		    [LabWare_Prod_Data].[dbo].COMPONENT  AS tar ON src.NAME = tar.NAME
													   AND src.ANALYSIS = tar.ANALYSIS
													   AND src.[VERSION] = tar.[VERSION] 
	  WHERE src.REPORTABLE = 'T' 
	    AND tar.ANALYSIS IS NULL

--CUSTOMER-----------------------------------------------------------------------
----UPDATE:
	 UPDATE CUSTOMER
		SET REMOVED= src.REMOVED, 
			COMPANY_NAME = src.COMPANY_NAME,
			X_CUSTOMER_TYPE = src.X_CUSTOMER_TYPE , 
			ADDRESS1 = src.ADDRESS1, 
			ADDRESS2 = src.ADDRESS2,
			X_CITY = src.X_CITY, 
			X_STATE = src.X_STATE,
			X_ZIPCODE = src.X_ZIPCODE, 
			X_COUNTY = src.X_COUNTY,
			PHONE_NUM = src.PHONE_NUM, 
			FAX_NUM = src.FAX_NUM, 
			ACTIVE = src.ACTIVE,
			X_NPI = src.X_NPI,
			Z_PHOCIS_ID = src.Z_PHOCIS_ID, 
			Z_PHIDDO_ID = src.Z_PHIDDO_ID, 
			CHANGED_ON = src.CHANGED_ON
	  FROM [LabWare_Prod].dbo.CUSTOMER AS src INNER JOIN
		   [LabWare_Prod_Data].dbo.CUSTOMER AS tar on src.NAME = tar.NAME
	 WHERE src.CHANGED_ON > tar.CHANGED_ON
----INSERT:
	INSERT CUSTOMER (
			NAME,
			REMOVED,
			COMPANY_NAME,
			X_CUSTOMER_TYPE,
			ADDRESS1,
			ADDRESS2,
			X_CITY,
			X_STATE,
			X_ZIPCODE,
			X_COUNTY,
			PHONE_NUM,
			FAX_NUM,
			ACTIVE,
			X_NPI,
			Z_PHOCIS_ID,
			Z_PHIDDO_ID, 
			CHANGED_ON)
	SELECT src.NAME,
	       src.REMOVED,
	       src.COMPANY_NAME,
	       src.X_CUSTOMER_TYPE,
	       src.ADDRESS1,
	       src.ADDRESS2,
	       src.X_CITY,
	       src.X_STATE,
	       src.X_ZIPCODE,
	       src.X_COUNTY,
	       src.PHONE_NUM,
	       src.FAX_NUM,
	       src.ACTIVE,
	       src.X_NPI,
	       src.Z_PHOCIS_ID,
	       src.Z_PHIDDO_ID, 
	       src.CHANGED_ON
	  FROM [LabWare_Prod].dbo.CUSTOMER AS src LEFT OUTER JOIN
		   [LabWare_Prod_Data].dbo.CUSTOMER AS tar on src.NAME = tar.NAME
	 WHERE tar.NAME IS NULL
--PATIENT-----------------------------------------------------------------------
----UPDATE:
	 UPDATE PATIENT
		SET ACTIVE_FLAG = src.ACTIVE_FLAG,
			FIRST_NAME = src.FIRST_NAME,
			LAST_NAME = src.LAST_NAME,
			MIDDLE_NAME = src.MIDDLE_NAME,
			BIRTH_DATE = src.BIRTH_DATE,
			GENDER = src.GENDER,
			ADDRESS1_LINE_1 = src.ADDRESS1_LINE_1,
			ADDRESS1_LINE_2 = src.ADDRESS1_LINE_2,
			ADDRESS1_CITY = src.ADDRESS1_CITY,
			ADDRESS1_STATE = src.ADDRESS1_STATE,
			ADDRESS1_ZIP = src.ADDRESS1_ZIP,
			ADDRESS1_COUNTRY = src.ADDRESS1_COUNTRY,
			ADDRESS1_COUNTY = src.ADDRESS1_COUNTY,
			ADDRESS1_TYPE = src.ADDRESS1_TYPE,
			X_RACE = src.X_RACE,
			X_ETHNICITY = src.X_ETHNICITY,
			Z_PHOCIS_ID = src.Z_PHOCIS_ID,
			Z_PHIDDO_ID = src.Z_PHIDDO_ID,
			CHANGED_ON = src.CHANGED_ON,
			HOME_PHONE = src.HOME_PHONE		
	   FROM [LabWare_Prod].dbo.PATIENT AS src INNER JOIN
			[LabWare_Prod_Data].dbo.PATIENT AS tar ON src.NAME = tar.NAME
												  AND src.REVISION_NO = tar.REVISION_NO
	  WHERE src.CHANGED_ON > tar.CHANGED_ON
----INSERT:
	 INSERT PATIENT (
			NAME,
			REVISION_NO,
			ACTIVE_FLAG,
			FIRST_NAME,
			LAST_NAME,
			MIDDLE_NAME,
			BIRTH_DATE,
			GENDER,
			ADDRESS1_LINE_1,
			ADDRESS1_LINE_2,
			ADDRESS1_CITY,
			ADDRESS1_STATE,
			ADDRESS1_ZIP,
			ADDRESS1_COUNTRY,
			ADDRESS1_COUNTY,
			ADDRESS1_TYPE,
			X_RACE,
			X_ETHNICITY,
			Z_PHOCIS_ID,
			Z_PHIDDO_ID,
			CHANGED_ON,
			HOME_PHONE)
	 SELECT src.NAME,
			src.REVISION_NO,
			src.ACTIVE_FLAG,
			src.FIRST_NAME,
			src.LAST_NAME,
			src.MIDDLE_NAME,
			src.BIRTH_DATE,
			src.GENDER,
			src.ADDRESS1_LINE_1,
			src.ADDRESS1_LINE_2,
			src.ADDRESS1_CITY,
			src.ADDRESS1_STATE,
			src.ADDRESS1_ZIP,
			src.ADDRESS1_COUNTRY,
			src.ADDRESS1_COUNTY,
			src.ADDRESS1_TYPE,
			src.X_RACE,
			src.X_ETHNICITY,
			src.Z_PHOCIS_ID,
			src.Z_PHIDDO_ID,
			src.CHANGED_ON,
			src.HOME_PHONE
	   FROM [LabWare_Prod].dbo.PATIENT AS src LEFT OUTER JOIN
			[LabWare_Prod_Data].[dbo].PATIENT AS tar ON src.NAME = tar.NAME
													AND src.REVISION_NO = tar.REVISION_NO
	  WHERE tar.NAME IS NULL
--PRACTITIONER-----------------------------------------------------------------------
----UPDATE:
	 UPDATE PRACTITIONER 
		SET [REMOVED] = src.[REMOVED], 
			[DESCRIPTION] = src.[DESCRIPTION], 
			[X_PRACT_TYPE] = src.[X_PRACT_TYPE], 
			[CHANGED_ON] = src.[CHANGED_ON]
	   FROM LabWare_Prod.dbo.PRACTITIONER AS src INNER JOIN 
		    [LabWare_Prod_Data].dbo.PRACTITIONER tar on src.NAME = tar.NAME
	  WHERE src.CHANGED_ON > tar.CHANGED_ON 
----INSERT:
	 INSERT PRACTITIONER (
	        [NAME],
			[REMOVED],
			[DESCRIPTION],
			[X_PRACT_TYPE], 
			[CHANGED_ON]) 
	 SELECT src.[NAME],
			src.[REMOVED], 
			src.[DESCRIPTION], 
			src.[X_PRACT_TYPE], 
			src.[CHANGED_ON] 
	   FROM [LabWare_Prod].dbo.PRACTITIONER AS src LEFT OUTER JOIN 
			LabWare_Prod_Data.dbo.PRACTITIONER AS tar ON src.NAME = tar.NAME
	  WHERE tar.NAME IS NULL
--SAMPLE-----------------------------------------------------------------------
----UPDATE:
	UPDATE SAMPLE
	   SET [TEXT_ID] = src.[TEXT_ID],
	       [STATUS] = src.[STATUS],
		   [LOGIN_DATE] = src.[LOGIN_DATE],
		   [SAMPLED_DATE] = src.[SAMPLED_DATE],
		   [RECD_DATE] = src.[RECD_DATE],
		   [DATE_STARTED] = src.[DATE_STARTED],
		   [STARTED] = src.[STARTED],
		   [DATE_COMPLETED] = src.[DATE_COMPLETED],
		   [DATE_REVIEWED] = src.[DATE_REVIEWED],
		   [SAMPLE_TYPE] = src.[SAMPLE_TYPE],
		   [SAMPLE_NAME] = src.[SAMPLE_NAME],
		   [CUSTOMER] = src.[CUSTOMER],
		   [TEST_LIST] = src.[TEST_LIST],
		   [SPEC_TYPE] = src.[SPEC_TYPE],
		   [RELEASED] = src.[RELEASED],
		   [RELEASED_ON] = src.[RELEASED_ON],
		   [APPROVED] = src.[APPROVED],
		   [REPORT_NUMBER] = src.[REPORT_NUMBER],
		   [PATIENT] = src.[PATIENT],
		   [PATIENT_REV_NO] = src.[PATIENT_REV_NO],
		   [LAB] = src.[LAB],
		   [LABEL_ID] = src.[LABEL_ID],
		   [X_REPORTED] = src.[X_REPORTED],
		   [X_LAST_REPORT_DATE] = src.[X_LAST_REPORT_DATE],
		   [X_LAST_REPORT_TYPE] = src.[X_LAST_REPORT_TYPE],
		   [GROUP_NAME] = src.[GROUP_NAME],
		   [X_PRACTITIONER] = src.[X_PRACTITIONER],
		   [X_SPECIMEN_SOURCE] = src.[X_SPECIMEN_SOURCE],
		   [CHANGED_ON] = src.[CHANGED_ON],
		   [Z_PROGRAM] = src.[Z_PROGRAM],
		   [Z_OK_OUTBREAK] = src.[Z_OK_OUTBREAK],
		   [EXT_LINK] = src.[EXT_LINK]
	  FROM [LabWare_Prod].dbo.[SAMPLE] AS src INNER JOIN 
		   [LabWare_Prod_Data].dbo.[SAMPLE] AS tar on src.[SAMPLE_NUMBER] = tar.[SAMPLE_NUMBER]
	 WHERE src.CHANGED_ON > tar.CHANGED_ON
----INSERT:
	INSERT SAMPLE (
		   [SAMPLE_NUMBER],
		   [TEXT_ID],
		   [STATUS] ,
		   [LOGIN_DATE],
		   [SAMPLED_DATE],
		   [RECD_DATE],
		   [DATE_STARTED],
		   [STARTED],
		   [DATE_COMPLETED],
		   [DATE_REVIEWED],
		   [SAMPLE_TYPE],
		   [SAMPLE_NAME],
		   [CUSTOMER],
		   [TEST_LIST],
		   [SPEC_TYPE],
		   [RELEASED],
		   [RELEASED_ON],
		   [APPROVED],
		   [REPORT_NUMBER] ,
		   [PATIENT],
		   [PATIENT_REV_NO],
		   [LAB],[LABEL_ID],
		   [X_REPORTED],
		   [X_LAST_REPORT_DATE],
		   [X_LAST_REPORT_TYPE],
		   [GROUP_NAME],
		   [X_PRACTITIONER],
		   [X_SPECIMEN_SOURCE],
		   [CHANGED_ON],
		   [Z_PROGRAM],
		   [Z_OK_OUTBREAK],
		   [EXT_LINK])	
	SELECT src.[SAMPLE_NUMBER],
		   src.[TEXT_ID],
		   src.[STATUS],
		   src.[LOGIN_DATE],
		   src.[SAMPLED_DATE],
		   src.[RECD_DATE],
		   src.[DATE_STARTED],
		   src.[STARTED],
		   src.[DATE_COMPLETED],
		   src.[DATE_REVIEWED],
		   src.[SAMPLE_TYPE],
		   src.[SAMPLE_NAME],
		   src.[CUSTOMER],
		   src.[TEST_LIST],
		   src.[SPEC_TYPE],
		   src.[RELEASED],
		   src.[RELEASED_ON],
		   src.[APPROVED],
		   src.[REPORT_NUMBER],
		   src.[PATIENT],
		   src.[PATIENT_REV_NO],
		   src.[LAB],
		   src.[LABEL_ID],
		   src.[X_REPORTED],
		   src.[X_LAST_REPORT_DATE],
		   src.[X_LAST_REPORT_TYPE],
		   src.[GROUP_NAME],
		   src.[X_PRACTITIONER],
		   src.[X_SPECIMEN_SOURCE],
		   src.[CHANGED_ON],
		   src.[Z_PROGRAM],
		   src.[Z_OK_OUTBREAK],
		   src.[EXT_LINK]
	  FROM [LabWare_Prod].dbo.[SAMPLE] AS src INNER JOIN
		   [LabWare_Prod_Data].dbo.[PATIENT] AS p ON src.Patient = p.NAME 
												 AND src.PATIENT_REV_NO = P.REVISION_NO INNER JOIN
		   [LabWare_Prod_Data].dbo.[PRACTITIONER] AS pr ON src.X_PRACTITIONER = pr.NAME INNER JOIN
		   [LabWare_Prod_Data].dbo.[CUSTOMER] AS c ON src.CUSTOMER = c.NAME	LEFT OUTER JOIN
		   [LabWare_Prod_Data].dbo.[SAMPLE] AS tar ON src.SAMPLE_NUMBER = tar.SAMPLE_NUMBER
	 WHERE (src.Z_PROGRAM IS NULL
		OR src.Z_PROGRAM != '30')
	   AND tar.[SAMPLE_NUMBER] IS NULL
--TEST-----------------------------------------------------------------------
----UPDATE:
	UPDATE TEST
	   SET [ANALYSIS] = src.[ANALYSIS],
		   [VERSION] = src.[VERSION],
		   [SAMPLE_NUMBER] = src.[SAMPLE_NUMBER],
		   [STATUS] = src.[STATUS],
		   [DATE_RECEIVED] = src.[DATE_RECEIVED],
		   [DATE_STARTED] = src.[DATE_STARTED],
		   [DATE_COMPLETED] = src.[DATE_COMPLETED],
		   [DATE_REVIEWED] = src.[DATE_REVIEWED],
		   [TEST_COMMENT] = src.[TEST_COMMENT],
		   [LAB] = src.[LAB],
		   [REPORTED_NAME] = src.[REPORTED_NAME],
		   [VARIATION] = src.[VARIATION],
		   [RELEASED] = src.[RELEASED],
		   [X_REPORTED] = src.[X_REPORTED],
		   [X_FIRST_REPORT_DATE] = src.[X_FIRST_REPORT_DATE],
		   [X_LAST_REPORT_DATE] = src.[X_LAST_REPORT_DATE],
		   [CHANGED_ON] = src.[CHANGED_ON]	
	  FROM [LabWare_Prod].dbo.TEST AS src INNER JOIN
		   [LabWare_Prod_Data].dbo.TEST as tar ON src.TEST_NUMBER = tar.TEST_NUMBER
	 WHERE src.CHANGED_ON > tar.CHANGED_ON
----INSERT:
	INSERT TEST (
	       [TEST_NUMBER],
		   [ANALYSIS],
		   [VERSION],
		   [SAMPLE_NUMBER],
		   [STATUS],
		   [DATE_RECEIVED],
		   [DATE_STARTED],
		   [DATE_COMPLETED],
		   [DATE_REVIEWED],
		   [TEST_COMMENT],
		   [LAB],
		   [REPORTED_NAME],
		   [VARIATION],
		   [RELEASED],
		   [X_REPORTED],
		   [X_FIRST_REPORT_DATE],
		   [X_LAST_REPORT_DATE],
		   [CHANGED_ON])
	SELECT src.[TEST_NUMBER],
		   src.[ANALYSIS],
		   src.[VERSION],
		   src.[SAMPLE_NUMBER],
		   src.[STATUS],
		   src.[DATE_RECEIVED],
		   src.[DATE_STARTED],
		   src.[DATE_COMPLETED],
		   src.[DATE_REVIEWED],
		   src.[TEST_COMMENT],
		   src.[LAB],
		   src.[REPORTED_NAME],
		   src.[VARIATION],
		   src.[RELEASED],
		   src.[X_REPORTED],
		   src.[X_FIRST_REPORT_DATE],
		   src.[X_LAST_REPORT_DATE],
		   src.[CHANGED_ON]
	FROM   [LabWare_Prod].dbo.TEST AS src INNER JOIN
		   [LabWare_Prod_Data].[dbo].[SAMPLE] AS s ON src.SAMPLE_NUMBER = s.SAMPLE_NUMBER INNER JOIN
		   [LabWare_Prod_Data].[dbo].[ANALYSIS] AS a ON src.ANALYSIS = a.NAME
		                                            AND src.VERSION = a.VERSION LEFT OUTER JOIN
		   [LabWare_Prod_Data].dbo.TEST AS tar ON src.TEST_NUMBER = tar.TEST_NUMBER
	 WHERE (src.X_REPORTABLE = 'T'
		    OR a.NAME IN ('PFGE','GASTRO_PANEL'))
	   AND tar.[TEST_NUMBER] IS NULL
--RESULT-----------------------------------------------------------------------
----UPDATE:
	UPDATE RESULT
	   SET TEST_NUMBER = src.[TEST_NUMBER],
		   NAME = src.NAME,
		   FORMATTED_ENTRY = src.[FORMATTED_ENTRY],
		   ENTERED_ON = src.[ENTERED_ON],
		   DATE_REVIEWED = src.[DATE_REVIEWED],
		   ANALYSIS = src.[ANALYSIS],
		   X_REPORT_NAME = src.[X_REPORT_NAME],
		   SAMPLE_NUMBER = src.[SAMPLE_NUMBER],
		   REPORTED_NAME = src.[REPORTED_NAME],
		   LOINC = src.[LOINC],
		   SNOMED_CODE = src.[SNOMED_CODE],
		   [X_ORGANISM] = src.X_ORGANISM,
		   [X_ORGANISM_REF] = src.X_ORGANISM_REF,
		   CHANGED_ON = src.[CHANGED_ON]
	  FROM [LabWare_Prod].dbo.RESULT AS src INNER JOIN
		   [LabWare_Prod_Data].dbo.RESULT AS tar ON src.RESULT_NUMBER = tar.RESULT_NUMBER
     WHERE src.CHANGED_ON > tar.CHANGED_ON
----INSERT:
	INSERT RESULT (
	       [RESULT_NUMBER],
		   [TEST_NUMBER],
		   [NAME],
		   [FORMATTED_ENTRY],
		   [ENTERED_ON],
		   [DATE_REVIEWED],
		   [ANALYSIS],
		   [X_REPORT_NAME],
		   [SAMPLE_NUMBER],
		   [REPORTED_NAME],
		   [LOINC],
		   [SNOMED_CODE],
		   [X_ORGANISM],
		   [X_ORGANISM_REF],
		   [CHANGED_ON])
	SELECT src.[RESULT_NUMBER],
		   src.[TEST_NUMBER],
		   src.[NAME],
		   src.[FORMATTED_ENTRY],
		   src.[ENTERED_ON],
		   src.[DATE_REVIEWED],
		   src.[ANALYSIS],
		   src.[X_REPORT_NAME],
		   src.[SAMPLE_NUMBER],
		   src.[REPORTED_NAME],
		   src.[LOINC],
		   src.[SNOMED_CODE],
		   src.[X_ORGANISM],
		   src.[X_ORGANISM_REF],
		   src.[CHANGED_ON]
	  FROM [LabWare_Prod].dbo.RESULT src INNER JOIN
		   [LabWare_Prod_Data].[dbo].[TEST] AS t ON src.TEST_NUMBER = t.TEST_NUMBER LEFT OUTER JOIN
		   [LabWare_Prod_Data].[dbo].[RESULT] AS tar ON src.RESULT_NUMBER = tar.RESULT_NUMBER
	  WHERE src.[STATUS] = 'A'
	   AND ((src.REPORTABLE = 'T')
	    OR (src.ANALYSIS = 'GASTRO_PANEL'
	   AND src.NAME IN ('Campylobacter',
						'Yersinia enterocolitica',
						'ETEC LT',
						'ETEC ST',
						'STEC stx1',
						'STEC stx2',
						'Salmonella',
						'Shigella',
						'Adenovirus 40/41',
						'Norovirus GI',
						'Norovirus GII',
						'Giardia',
						'Cryptosporidium',
						'Rotavirus A'))
		OR (src.ANALYSIS = 'PFGE'
	   AND src.NAME IN ('Primary Pattern',
						'Secondary Pattern'))) 
	   AND tar.RESULT_NUMBER IS NULL
--REPORTS-----------------------------------------------------------------------
----INSERT:
	INSERT REPORTS (
		   [REPORT_NUMBER],
		   [REPORT_TYPE],
		   [PURPOSE],
		   [OBJECT_CLASS],
		   [DATE_CREATED],
		   [CREATED_BY],
		   [PRINT_COUNT],
		   [DATA_CHANGED],
		   [RESULTS_CHANGED],
		   [REPORT_FILE_NAME],
		   [SUPERSEDED],
		   [ALLOW_EDIT],
		   [ALLOW_PRINT],
		   [REPORT_STATUS],
		   [AUDIT])
	SELECT src.[REPORT_NUMBER],
		   src.[REPORT_TYPE],
		   src.[PURPOSE],
		   src.[OBJECT_CLASS],
		   src.[DATE_CREATED],
		   src.[CREATED_BY],
		   src.[PRINT_COUNT],
		   src.[DATA_CHANGED],
		   src.[RESULTS_CHANGED],
		   src.[REPORT_FILE_NAME],
		   src.[SUPERSEDED],
		   src.[ALLOW_EDIT],
		   src.[ALLOW_PRINT],
		   src.[REPORT_STATUS],
		   src.[AUDIT]
	  FROM [LabWare_Prod_Data].dbo.[SAMPLE] AS sam INNER JOIN
		   [LabWare_Prod].dbo.[REPORT_OBJECTS] AS ro ON sam.SAMPLE_NUMBER = ro.[OBJECT_ID] INNER JOIN
		   [LabWare_Prod].dbo.REPORTS AS src ON ro.REPORT_NUMBER = src.REPORT_NUMBER LEFT OUTER JOIN
		   [LabWare_Prod_Data].dbo.REPORTS AS tar ON src.REPORT_NUMBER = tar.REPORT_NUMBER
	 WHERE tar.REPORT_NUMBER IS NULL
	   AND src.REPORT_STATUS = 'T'
--REPORT OBJECTS-----------------------------------------------------------------------
----INSERT:
	INSERT REPORT_OBJECTS (
		   [REPORT_NUMBER],
		   [OBJECT_ID])
	SELECT src.[REPORT_NUMBER],
		   src.[OBJECT_ID]
	  FROM [LabWare_Prod].dbo.REPORT_OBJECTS AS src INNER JOIN
		   [LabWare_Prod_Data].[dbo].[SAMPLE] AS s ON src.[OBJECT_ID] = s.SAMPLE_NUMBER INNER JOIN
		   [LabWare_Prod_Data].[dbo].[REPORTS] AS r ON src.REPORT_NUMBER = r.REPORT_NUMBER LEFT OUTER JOIN
		   [LabWare_Prod_Data].dbo.REPORT_OBJECTS AS tar ON src.REPORT_NUMBER = tar.REPORT_NUMBER
		   where tar.REPORT_NUMBER IS NULL
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[usp_LabWare_LabDataUpdate] TO [OSDH\LilyL]
    AS [dbo];

