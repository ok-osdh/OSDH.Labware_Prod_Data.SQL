/******************************************************************************
**                      Name: sp_GetClinic_Info
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
**                      Auth: Bill Holmberg 
**                      Date: 04/2014
*******************************************************************************
**                      Change History
*******************************************************************************
**                      Date:                Author:                                   Description:
**                      --------    	     --------                          -------------------------------------------
**						03 2015				Bill Holmberg						replaced all LabWare_Test with LabWare_Prod
** 
*******************************************************************************/
/******NOTES****************************
** use the last three digits of the clinic number "Z_PHOCIS_ID", to match to a 3 digit phocis submitter clinicID 
**   PHOCIS companies (clinics) start with 0   example: 00000011    "CANADIAN_CHD_YUKON"
*******************************************************************************************/        


CREATE PROCEDURE [dbo].[spGetCustomerInfoFromLabware] 
@SubmitterClinicID varchar(20)  
	AS
SELECT COMPANY_NAME, ADDRESS1, X_CITY, X_STATE, X_COUNTY,  X_ZIPCODE, PHONE_NUM, FAX_NUM, Z_PHOCIS_ID
   FROM [LabWare_Prod].[dbo].[CUSTOMER]
   Where RIGHT(RTRIM(Z_PHOCIS_ID), 3) = @SubmitterClinicID
  



--Go
--GRANT SELECT ON [LabWare_Dev].[dbo].[CUSTOMER] TO "phocisapp"
--Go
-- The above doesnt work...."You can only grant or revoke permissions on objects in the current database."
GO
GRANT ALTER
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT TAKE OWNERSHIP
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\WilliamH]
    AS [dbo];


GO
GRANT ALTER
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\LilyL]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\LilyL]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\LilyL]
    AS [dbo];


GO
GRANT TAKE OWNERSHIP
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\LilyL]
    AS [dbo];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [OSDH\LilyL]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[spGetCustomerInfoFromLabware] TO [phocisapp]
    AS [dbo];

