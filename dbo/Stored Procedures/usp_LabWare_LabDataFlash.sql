--***************************************************************************
--    Procedure Name : [usp_LabWare_LabDataFlash]
--
--    Description    : delete all data from all tables in the LabWare_Lab_Data
--    Author         : LilyL
--    Date Written   : 02/12/2015
--    Current Version: 
--	Vers. # Date:       Author:		Description:
--  8/14/15				lilyl		move db to test server modify for names
--  8/27/15				lilyl		After test, re-arraged the deletion sequence
--	------- ----------  ----------	-------------------------------------------
--
---***************************************************************************

CREATE PROCEDURE  [dbo].[usp_LabWare_LabDataFlash]

AS

--delete existing unchanged data

delete from dbo.REPORT_OBJECTS

delete from dbo.REPORTS

delete from dbo.RESULT

delete from dbo.RESULTSLOG 

delete from dbo.TEST

delete from [dbo].[SAMPLE_Temp]

delete from dbo.[SAMPLE]

delete from dbo.CUSTOMER

delete from dbo.PATIENT

delete from dbo.PRACTITIONER

delete from dbo.COMPONENT

delete from dbo.ANALYSIS

--load new data in
--exec ( 'dbo.usp_LabWare_ImportLabData')