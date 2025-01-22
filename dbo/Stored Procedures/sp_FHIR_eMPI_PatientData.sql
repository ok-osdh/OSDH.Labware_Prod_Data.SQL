

/******************************************************************************
**                      Name: sp_FHIR_eMPI_PatientData
**                      Desc: Get any changed Patient table data since an inputted date
**
**                      Return values:
**						Dataset
**                      Called by:  HeO active update process
**              
**                      Parameters:
**                      Input                                             Output
**     					----------                                        -----------
**                      Date                                                                              
**
**                      Auth: Bill Holmberg 
**                      Date: 04/2016
*******************************************************************************
**                      Change History
*******************************************************************************
**                      Date:                Author:                                   Description:
**                      May 9 2016    	     Bill H                          no longer get phocis patients
**						Oct 25 2019			 PeterL							 added joins to CUSTOMER and SAMPLE tables to pull event location and date/time.
**						Dec 06 2019			 Randy KEEP						 Changeing param to an actual datetime
**						 			 					 
**
*******************************************************************************/

CREATE PROCEDURE [dbo].[sp_FHIR_eMPI_PatientData] 
@LastRunDateTime DATETIME
	AS
		 Select TOP 1000 
			pat.ACTIVE_FLAG,
		    pat.[NAME],
			pat.FIRST_NAME,
			pat.LAST_NAME,
			pat.MIDDLE_NAME,
			pat.BIRTH_DATE,
			pat.GENDER,
			pat.ADDRESS1_LINE_1,
			pat.ADDRESS1_LINE_2,
			pat.ADDRESS1_CITY,
			pat.ADDRESS1_STATE,
			pat.ADDRESS1_ZIP,
			pat.ADDRESS1_COUNTRY,
			pat.ADDRESS1_COUNTY,
			pat.ADDRESS1_TYPE,
			pat.X_RACE,
			pat.X_ETHNICITY,
			--pat.Z_PHOCIS_ID,  no longer get phocis patients
			pat.Z_PHIDDO_ID,
			pat.REVISION_NO,
			pat.CHANGED_ON,
			LEFT(cus.DESCRIPTION,80) AS [Event Facility Name],
			LEFT(cus.NAME,30) AS [Event Facility ID],
				CASE
					WHEN ISDATE(sam.SAMPLED_DATE) = 1 THEN CONVERT(varchar(8),CAST(sam.SAMPLED_DATE AS datetime),112)
				ELSE NULL
				END AS [Event Date]		
	   FROM LabWare_Prod.dbo.PATIENT AS pat INNER JOIN
	        LabWare_Prod.dbo.[SAMPLE] AS sam ON sam.PATIENT = pat.[NAME] INNER JOIN 
			LabWare_Prod.dbo.CUSTOMER AS cus ON cus.[NAME] = sam.CUSTOMER
	   WHERE pat.Z_PHOCIS_ID IS NULL
		AND pat.CHANGED_ON > @LastRunDateTime
		AND pat.ACTIVE_FLAG = 'T'
	   ORDER BY pat.CHANGED_ON



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[sp_FHIR_eMPI_PatientData] TO [AGENCY\MediatorApiProductio]
    AS [dbo];

