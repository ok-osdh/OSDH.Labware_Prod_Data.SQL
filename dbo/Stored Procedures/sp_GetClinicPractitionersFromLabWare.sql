/******************************************************************************
**                      Name: sp_GetClinicPractitionersFromLabWare
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
**                      Date: 04/2014
*******************************************************************************
**                      Change History
*******************************************************************************
**                      Date:                Author:                                   Description:
**                      --------    	     --------                          -------------------------------------------
**						Nov 03 2015			Bill Holmberg						replaced all LabWare_Test with LabWare_Prod
**
*******************************************************************************/
/******NOTES****************************
** use the last three digits of the clinic number "Z_PHOCIS_ID", to match to a 3 digit phocis submitter clinicID
**   PHIDDO companies (clinics) start with the digit 4  example: 400000011   " CIMARRON_HOSP_BOISECITY"   
**   PHOCIS companies (clinics) start with 0   example: 00000011    "CANADIAN_CHD_YUKON"
*******************************************************************************************/        
CREATE PROCEDURE [dbo].[sp_GetClinicPractitionersFromLabWare] 
@SubmitterClinicID varchar(20)  
	AS
SELECT DISTINCT
   X_CUST_PRACTITIONER.DESCRIPTION_PRACT,
   PRACTITIONER.X_NPI, PRACTITIONER.FIRST_NAME,PRACTITIONER.LAST_NAME  
   FROM [LabWare_Prod].[dbo].[CUSTOMER]
      Inner  JOIN [LabWare_Prod].[dbo].[X_CUST_PRACTITIONER]
       ON  CUSTOMER.NAME = X_CUST_PRACTITIONER.CUSTOMER
      Inner  JOIN [LabWare_Prod].[dbo].[PRACTITIONER] 
       ON PRACTITIONER.NAME = X_CUST_PRACTITIONER.PRACTITIONER
      Where RIGHT(RTRIM(CUSTOMER.Z_PHOCIS_ID), 3)  = @SubmitterClinicID
      
      
----      ALTER PROCEDURE [dbo].[sp_GetClinicPractitionersFromLabWare] 
----@SubmitterClinicID varchar(20)  
----	AS
----SELECT DISTINCT
----    X_CUST_PRACTITIONER.DESCRIPTION_PRACT  
----   FROM [LabWare_Dev].[dbo].[CUSTOMER]
----      Inner  JOIN LabWare_Dev..X_CUST_PRACTITIONER
----       ON CUSTOMER.NAME= LabWare_Dev..X_CUST_PRACTITIONER.CUSTOMER
----      Inner  JOIN PRACTITIONER 
----       ON PRACTITIONER.NAME = LabWare_Dev..X_CUST_PRACTITIONER.PRACTITIONER
----      Where RIGHT(RTRIM(CUSTOMER.Z_PHOCIS_ID), 3)  = @SubmitterClinicID

GO
GRANT ALTER
    ON OBJECT::[dbo].[sp_GetClinicPractitionersFromLabWare] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[sp_GetClinicPractitionersFromLabWare] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetClinicPractitionersFromLabWare] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT TAKE OWNERSHIP
    ON OBJECT::[dbo].[sp_GetClinicPractitionersFromLabWare] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[sp_GetClinicPractitionersFromLabWare] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[sp_GetClinicPractitionersFromLabWare] TO [phocisapp]
    AS [dbo];

