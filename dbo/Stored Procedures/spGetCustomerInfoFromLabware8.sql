/******************************************************************************
**                      Name: sp_GetCustomerInfoFromLabware8
**                      Desc: Gets the clinic (clinics are called "customers" in Labware) info to populate Lab Request web page
**
**                      Return values:
** 
**                      Called by:  PHOCIS calls clsLabRequisition.vb which calls this stored proc
**              
**                      Parameters:
**                      Input                                             Output
**     			----------                                        -----------
**                      County Code                                                                               
**
**                      Auth: Tim Higdon 
**                      Date: 01/2025
*******************************************************************************
**                      Change History
*******************************************************************************
**                      Date:                Author:                                   Description:
**                      --------    	     --------                          -------------------------------------------
**						03 2015				Bill Holmberg						replaced all LabWare_Test with LabWare_Prod
**                      01 2025             Tim Higdon                          Changed to hit Labware8 and changed field names from x to t where required
*******************************************************************************/
/******NOTES****************************
** use the last three digits of the clinic number "Z_PHOCIS_ID", to match to a 3 digit phocis submitter clinicID 
**   PHOCIS companies (clinics) start with 0   example: 00000011    "CANADIAN_CHD_YUKON"
*******************************************************************************************/        


CREATE OR ALTER PROCEDURE [phocis].[spGetCustomerInfoFromLabware8] 
@SubmitterClinicID varchar(20)  
	AS
SELECT COMPANY_NAME, ADDRESS1, T_CITY, T_STATE, T_COUNTY,  T_ZIPCODE, PHONE_NUM, FAX_NUM, Z_PHOCIS_ID
   FROM [dbo].[CUSTOMER]
   Where RIGHT(RTRIM(Z_PHOCIS_ID), 3) = @SubmitterClinicID
  




GO
GRANT EXECUTE
    ON OBJECT::[phocis].[spGetCustomerInfoFromLabware8] TO [phocisapp]
    AS [phocis];

