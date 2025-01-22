/******************************************************************************
**		File: dbo.okSp_GetCountyLabShippingManifestRpt.prc
**		Name: okSp_GetCountyLabShippingManifestRpt
**		Desc: returns specimen rows for data source for County daily Lab specimen Shipping manifest Crystal report CountyLabShippingManifest11.rpt 
**
**		This template can be customized:
**              
**		for single submitter location Clinic int key
**			Return values:  report header: sumitter name, city , county
**			multiple 1 row/patient - specimen accession #  for single submitter shipping location (could be county health department site)
**                  		paiteint name 
**                  		lits #
**                  		date of collection
**		    		test requested
**
**			sorted by patient name first, then lits number, 
**
**			this query is located on CERES LITS_QA, called by sp on sql link server PHOCIS 
**			this link server sp is called from PHOCIS in vb6, 
**			it returns ADO rows which are 
**			then set to datasource of Crystal Report v8.5 "CountyLabShippingManifest8.rpt"
**              
**          example call: exec dbo.okSp_GetCountyLabShippingManifestRpt '131'
**                        example of submitterid paramaeter '131' above
**                        table ok_subitters submitterid for sequoyah county, city sallisaw 
**                        
**                        submitterid = '0000013115' 10 digits 
**                        10 ditits = 5 0 '00000' + 3 numbers (location-city,etc) '131' + 2clinic
**                        parameter is 3 digits, location only, no clinic
**                        historical: phocus litsqa submitterid are not identical
**
**		Parameters:
**		Input							Output
**     ----------						-----------
**        @nClinicID                    db FLASH. TABLE CLINIC.Clinic     location only 3 digits
**		Auth: Robert Murphree
**		Date: 2/26/2007
*******************************************************************************
**		Change History
*******************************************************************************
**	   Date:		Author:				Description:
**	  --------		--------		-------------------------------------------
**     3/1/10      ROBERT Murphree  replace vss with sql server ceres lits_qa production version 
**     4/26/09     ROBERT Murphree  add submitter phone column to returned query
**				                    to help deploy, rename sp to 'okSp_GetCountyLabShippingManifestRpt'
**
**     2/26/07      ROBERT Murphree create sp cut paste dbo.okSP_GenerateIntLabNagListRpt.prc
**     2/28/06						add error trapping, message
**	   2/5/16		PML				Rework procedure extensively to pull data from LabWare instead of LITS Plus.		
*******************************************************************************/
/*-- visual source safe keyword expansion macro --*/
/*-- $Header:: /LITS Plus/SQL/LITS_QA/Stored Procedures/dbo.okSp_GetCountyLabShippingManifestRpt.PRC 8     3/02/10 8:54a Robertwm $ --*/
--   vss sp v6 3/1/10 11:43 :: rpt v6 3/1/10 3:02
--   \\VSS$\LITS Plus\InternalLabNagListReport\addCrystalReports\CountyLabShippingManifest11.rpt  VSS ver. 6 3/1/2010 3:02p
/*******************************************************************************/
 CREATE Procedure [dbo].[okSp_GetCountyLabShippingManifestRpt] @nClinicID int
	 AS
 SELECT c.[COMPANY_NAME] AS SubmitterName ,
		c.[X_CITY] AS SubmitterCity ,
		c.[PHONE_NUM] AS SubmitterPhone ,
		s.LABEL_ID AS LabNumber ,
		s.X_PATIENT_FULLNAME AS PatientName ,
		s.X_SAMPLE_SUBCAT AS Test ,
		s.SAMPLED_DATE AS DOC
   FROM CUSTOMER AS c INNER JOIN
		[LabWare_Prod]..[SAMPLE] AS s ON c.[NAME] = s.[CUSTOMER]
  WHERE	s.[STATUS] = 'U'		
	AND	c.[Z_PHOCIS_ID] = RIGHT('0000000' + CONVERT(varchar(3),@nClinicID),8)
ORDER BY s.X_SAMPLE_SUBCAT ,
		 s.LABEL_ID
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[okSp_GetCountyLabShippingManifestRpt] TO [phocisapp]
    AS [dbo];

