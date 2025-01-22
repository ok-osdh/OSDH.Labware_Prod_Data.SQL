
/******************************************************************************
**		File: dbo.GetLabManifestItems.sql
**		Name: dbo.GetLabManifestItems.prc
**		Desc: returns potential items to Lab Manifest selection screen in PHOCIS for Nurse to prune the list to send.  Should hit Labware prod db
**		Server: DAT-MSQ26-340 (Labware_Prod_Data)
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
*******************************************************************************/

 CREATE Procedure [dbo].[GetLabManifestItems] @nClinicID int
	 AS
 SELECT c.[COMPANY_NAME] AS SubmitterName ,
		c.[X_CITY] AS SubmitterCity ,
		c.[PHONE_NUM] AS SubmitterPhone ,
		s.LABEL_ID AS LabNumber ,
		s.X_PATIENT_FULLNAME AS PatientName ,
		s.X_SAMPLE_SUBCAT AS Test ,
		s.SAMPLED_DATE AS DOC,
		s.[STATUS] AS TESTSTATUS,
		s.[X_SPECIMEN_SOURCE] as Specimen
   FROM CUSTOMER AS c INNER JOIN
		[LabWare_Prod]..[SAMPLE] AS s ON c.[NAME] = s.[CUSTOMER]
  WHERE	s.[STATUS] = 'U'		
	AND	c.[Z_PHOCIS_ID] = RIGHT('0000000' + CONVERT(varchar(3),@nClinicID),8)
ORDER BY s.LABEL_ID ASC


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLabManifestItems] TO [phocisapp]
    AS [dbo];

