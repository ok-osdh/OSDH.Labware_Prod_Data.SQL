/******************************************************************************
**                      Name: sp_GetClinicPractitionersFromLabWare8
**                      Desc: Gets the clinic (clinics are called "customers" in Labware) info to populate Lab Request web page
**
**                      Return values:
** 
**                      Called by:  PHOCIS calls clsLabRequisition.vb which calls this stored proc to get list of practitioners at a clinic
**              
**                      Parameters:
**                      Input                                             Output
**     			----------                                        -----------
**                      ClinicID                                                                              
**
**                      Auth: Bill Holmberg 
**                      Date: 01/2025
*******************************************************************************
**                      Change History
*******************************************************************************
**                      Date:                Author:                                   Description:
**                      --------    	     --------                          -------------------------------------------
**						Nov 03 2015			Bill Holmberg						replaced all LabWare_Test with LabWare_Prod
**                      01/2025             Tim Higdon                          Changed to hit Labware8 and changed field names from x to t where required
*******************************************************************************/
/******NOTES****************************
** use the last three digits of the clinic number "Z_PHOCIS_ID", to match to a 3 digit phocis submitter clinicID
**   PHIDDO companies (clinics) start with the digit 4  example: 400000011   " CIMARRON_HOSP_BOISECITY"   
**   PHOCIS companies (clinics) start with 0   example: 00000011    "CANADIAN_CHD_YUKON"
*******************************************************************************************/        
CREATE OR ALTER PROCEDURE [phocis].[sp_GetClinicPractitionersFromLabWare8] 
@SubmitterClinicID varchar(20)  
	AS
SELECT DISTINCT
   T_CUST_PRACTITIONER.DESCRIPTION_PRACT,
   PRACTITIONER.T_NPI, PRACTITIONER.FIRST_NAME,PRACTITIONER.LAST_NAME  
   FROM [dbo].[CUSTOMER]
      Inner  JOIN [dbo].[T_CUST_PRACTITIONER]
       ON  CUSTOMER.NAME = T_CUST_PRACTITIONER.CUSTOMER
      Inner  JOIN [dbo].[PRACTITIONER] 
       ON PRACTITIONER.NAME = T_CUST_PRACTITIONER.PRACTITIONER
      Where RIGHT(RTRIM(CUSTOMER.Z_PHOCIS_ID), 3)  = @SubmitterClinicID
      


GO

GRANT EXECUTE
    ON OBJECT::[phocis].[sp_GetClinicPractitionersFromLabWare8] TO [phocisapp]
    AS [phocis];

