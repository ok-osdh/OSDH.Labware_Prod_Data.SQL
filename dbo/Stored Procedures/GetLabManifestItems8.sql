
/******************************************************************************
**		File: dbo.GetLabManifestItems8.sql
**		Name: dbo.GetLabManifestItems8.prc
**		Desc: returns potential items from labware 8 to Lab Manifest selection screen in PHOCIS for Nurse to prune the list to send.  Should hit Labware8 prod db
**		Server: Dev: sqlmi-doh-lab-d.9841065d907c.database.windows.net,  *** Verify Test and Prod *** Test: sqlmi-doh-lab-t.9841065d907c.database.windows.net, Prod: sqlmi-doh-lab-p.9841065d907c.database.windows.net
** 	    Database: Dev: LW8_DEV Test: LW8_TEST Prod: LW8_PROD
**		This template can be customized:
**              
**		
**		Parameters:
**		Input							Output
**     ----------						-----------
**        @nClinicID                    db FLASH. TABLE CLINIC.Clinic     location only 3 digits
**		Auth: Tim Higdon
**		Date: 07/08/2022
*******************************************************************************
**		Change History
*******************************************************************************
**	   Date:		Author:				Description:
**	  --------		--------		-------------------------------------------
**    07/08/2022	Tim Higdon		Created		
**    12/2/2022		Tim Higdon		Adding X_SPECIMEN_SOURCE to show this in the grid and on report per request
**    01/22/2025	Tim Higdon		Changed to hit Labware8 and changed field names from x to t where required
*******************************************************************************/

  CREATE OR ALTER Procedure [phocis].[GetLabManifestItems8] @nClinicID int
	 AS
 SELECT c.[COMPANY_NAME] AS SubmitterName ,
		c.[T_CITY] AS SubmitterCity ,
		c.[PHONE_NUM] AS SubmitterPhone ,
		s.LABEL_ID AS LabNumber ,
		s.T_PATIENT_FULLNAME AS PatientName ,
		s.T_SAMPLE_SUBCAT AS Test ,
		s.SAMPLED_DATE AS DOC,
		s.[STATUS] AS TESTSTATUS,
		s.[T_SPECIMEN_SOURCE] as Specimen
   FROM CUSTOMER AS c 
   INNER JOIN
		[SAMPLE] AS s ON c.[NAME] = s.[CUSTOMER]   -- Labware_Prod might be another database name depending on what it's called in each environment
  WHERE	s.[STATUS] = 'U'		
	AND	c.[Z_PHOCIS_ID] = RIGHT('0000000' + CONVERT(varchar(3),@nClinicID),8)
ORDER BY s.LABEL_ID ASC


GO
GRANT EXECUTE
    ON OBJECT::[phocis].[GetLabManifestItems8] TO [phocisapp]
    AS [phocisapp];

