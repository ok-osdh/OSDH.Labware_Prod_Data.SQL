﻿--***************************************************************************
--    Procedure Name : [usp_LabWare_LabDataCreatTables]
--
--    Description    : Load relational data from [LabWare_Dev]
--    Author         : LilyL
--    Date Written   : 06/12/2015
--    Current Version: 
--	Vers. # Date:       Author:		Description:
--	------- ----------  ----------	-------------------------------------------
--
---***************************************************************************

Create PROCEDURE  [dbo].[usp_LabWare_LabDataCreatTables]

AS

/****** Object:  Table [dbo].[ANALYSIS]    Script Date: 06/12/2015 14:56:39 ******/

CREATE TABLE [dbo].[ANALYSIS](
	[NAME] [varchar](15) NOT NULL,
	[VERSION] [int] NOT NULL,
	[ACTIVE] [varchar](1) NULL,
	[REPORTED_NAME] [varchar](20) NULL,
	[COMMON_NAME] [varchar](20) NULL,
	[ANALYSIS_TYPE] [varchar](10) NULL,
	[DESCRIPTION] [varchar](254) NULL,
	[CHANGED_ON] [datetime] NULL,
 CONSTRAINT [PK_ANALYSIS] PRIMARY KEY NONCLUSTERED 
(
	[NAME] ASC,
	[VERSION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


/****** Object:  Table [dbo].[COMPONENT]    Script Date: 06/12/2015 16:29:25 ******/
CREATE TABLE [dbo].[COMPONENT](
	[NAME] [varchar](40) NOT NULL,
	[ANALYSIS] [varchar](15) NOT NULL,
	[VERSION] [int] NOT NULL,
	[ORDER_NUMBER] [int] NULL,
	[RESULT_TYPE] [varchar](1) NULL,
	[REPORTABLE] [varchar](1) NULL,
	[OPTIONAL] [varchar](1) NULL,
 CONSTRAINT [PK_COMPONENT] PRIMARY KEY CLUSTERED 
(
	[ANALYSIS] ASC,
	[NAME] ASC,
	[VERSION] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[COMPONENT]  WITH CHECK ADD  CONSTRAINT [FK_COMPONENT_ANALYSIS] FOREIGN KEY([ANALYSIS], [VERSION])
REFERENCES [dbo].[ANALYSIS] ([NAME], [VERSION])

ALTER TABLE [dbo].[COMPONENT] CHECK CONSTRAINT [FK_COMPONENT_ANALYSIS]

/****** Object:  Table [dbo].[SAMPLE_Temp]    Script Date: 06/16/2015 13:26:08 ******/

CREATE TABLE [dbo].[SAMPLE_Temp](
	[SAMPLE_NUMBER] [int] NOT NULL,
	[TEXT_ID] [varchar](30) NULL,
	[STATUS] [varchar](1) NULL,
	[LOGIN_DATE] [datetime] NULL,
	[SAMPLED_DATE] [datetime] NULL,
	[RECD_DATE] [datetime] NULL,
	[DATE_STARTED] [datetime] NULL,
	[STARTED] [varchar](1) NULL,
	[DATE_COMPLETED] [datetime] NULL,
	[DATE_REVIEWED] [datetime] NULL,
	[SAMPLE_TYPE] [varchar](10) NULL,
	[SAMPLE_NAME] [varchar](30) NULL,
	[CUSTOMER] [varchar](30) NULL,
	[TEST_LIST] [varchar](20) NULL,
	[SPEC_TYPE] [varchar](20) NULL,
	[RELEASED] [varchar](1) NULL,
	[RELEASED_ON] [datetime] NULL,
	[APPROVED] [varchar](1) NULL,
	[REPORT_NUMBER] [int] NULL,
	[PATIENT] [varchar](20) NULL,
	[PATIENT_REV_NO] [int] NULL,
	[LAB] [varchar](20) NULL,
	[LABEL_ID] [varchar](20) NULL,
	[X_REPORTED] [varchar](1) NULL,
	[X_LAST_REPORT_DATE] [datetime] NULL,
	[X_LAST_REPORT_TYPE] [varchar](10) NULL,
	[GROUP_NAME] [varchar](10) NULL,
	[X_PRACTITIONER] [varchar](30) NULL,
	[X_SPECIMEN_SOURCE] [varchar](10) NULL,
	[CHANGED_ON] [datetime] NULL
) ON [PRIMARY]

/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 06/12/2015 16:29:45 ******/

CREATE TABLE [dbo].[CUSTOMER](
	[NAME] [varchar](30) NOT NULL,
	[REMOVED] [varchar](1) NULL,
	[COMPANY_NAME] [varchar](78) NULL,
	[X_CUSTOMER_TYPE] [varchar](20) NULL,
	[ADDRESS1] [varchar](78) NULL,
	[ADDRESS2] [varchar](78) NULL,
	[X_CITY] [varchar](30) NULL,
	[X_STATE] [varchar](20) NULL,
	[X_ZIPCODE] [varchar](10) NULL,
	[X_COUNTY] [varchar](20) NULL,
	[PHONE_NUM] [varchar](78) NULL,
	[FAX_NUM] [varchar](78) NULL,
	[ACTIVE] [varchar](1) NULL,
	[X_NPI] [varchar](10) NULL,
	[Z_PHOCIS_ID] [varchar](20) NULL,
	[Z_PHIDDO_ID] [varchar](20) NULL,
	[CHANGED_ON] [datetime] NULL,
 CONSTRAINT [PK_CUSTOMER] PRIMARY KEY NONCLUSTERED 
(
	[NAME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[PATIENT]    Script Date: 06/12/2015 16:29:59 ******/

CREATE TABLE [dbo].[PATIENT](
	[NAME] [varchar](20) NOT NULL,
	[REVISION_NO] [int] NOT NULL,
	[ACTIVE_FLAG] [varchar](1) NULL,
	[FIRST_NAME] [varchar](80) NULL,
	[LAST_NAME] [varchar](80) NULL,
	[MIDDLE_NAME] [varchar](14) NULL,
	[BIRTH_DATE] [datetime] NULL,
	[GENDER] [varchar](20) NULL,
	[ADDRESS1_LINE_1] [varchar](50) NULL,
	[ADDRESS1_LINE_2] [varchar](50) NULL,
	[ADDRESS1_CITY] [varchar](30) NULL,
	[ADDRESS1_STATE] [varchar](20) NULL,
	[ADDRESS1_ZIP] [varchar](10) NULL,
	[ADDRESS1_COUNTRY] [varchar](20) NULL,
	[ADDRESS1_COUNTY] [varchar](20) NULL,
	[ADDRESS1_TYPE] [varchar](20) NULL,
	[X_RACE] [varchar](254) NULL,
	[X_ETHNICITY] [varchar](254) NULL,
	[Z_PHOCIS_ID] [varchar](20) NULL,
	[Z_PHIDDO_ID] [varchar](20) NULL,
	[CHANGED_ON] [datetime] NULL,
 CONSTRAINT [PK_PATIENT] PRIMARY KEY CLUSTERED 
(
	[NAME] ASC,
	[REVISION_NO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[PRACTITIONER]    Script Date: 06/12/2015 16:30:15 ******/
CREATE TABLE [dbo].[PRACTITIONER](
	[NAME] [varchar](30) NOT NULL,
	[REMOVED] [varchar](1) NULL,
	[DESCRIPTION] [varchar](254) NULL,
	[X_PRACT_TYPE] [varchar](20) NULL,
	[CHANGED_ON] [datetime] NULL,
 CONSTRAINT [PK_PRACTITIONER] PRIMARY KEY NONCLUSTERED 
(
	[NAME] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[SAMPLE]    Script Date: 06/12/2015 16:30:36 ******/

CREATE TABLE [dbo].[SAMPLE](
	[SAMPLE_NUMBER] [int] NOT NULL,
	[TEXT_ID] [varchar](30) NULL,
	[STATUS] [varchar](1) NULL,
	[LOGIN_DATE] [datetime] NULL,
	[SAMPLED_DATE] [datetime] NULL,
	[RECD_DATE] [datetime] NULL,
	[DATE_STARTED] [datetime] NULL,
	[STARTED] [varchar](1) NULL,
	[DATE_COMPLETED] [datetime] NULL,
	[DATE_REVIEWED] [datetime] NULL,
	[SAMPLE_TYPE] [varchar](10) NULL,
	[SAMPLE_NAME] [varchar](30) NULL,
	[CUSTOMER] [varchar](30) NULL,
	[TEST_LIST] [varchar](20) NULL,
	[SPEC_TYPE] [varchar](20) NULL,
	[RELEASED] [varchar](1) NULL,
	[RELEASED_ON] [datetime] NULL,
	[APPROVED] [varchar](1) NULL,
	[REPORT_NUMBER] [int] NULL,
	[PATIENT] [varchar](20) NULL,
	[PATIENT_REV_NO] [int] NULL,
	[LAB] [varchar](20) NULL,
	[LABEL_ID] [varchar](20) NULL,
	[X_REPORTED] [varchar](1) NULL,
	[X_LAST_REPORT_DATE] [datetime] NULL,
	[X_LAST_REPORT_TYPE] [varchar](10) NULL,
	[GROUP_NAME] [varchar](10) NULL,
	[X_PRACTITIONER] [varchar](30) NULL,
	[X_SPECIMEN_SOURCE] [varchar](10) NULL,
	[CHANGED_ON] [datetime] NULL,
 CONSTRAINT [PK_SAMPLE] PRIMARY KEY NONCLUSTERED 
(
	[SAMPLE_NUMBER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[SAMPLE]  WITH CHECK ADD  CONSTRAINT [FK_SAMPLE_CUSTOMER] FOREIGN KEY([CUSTOMER])
REFERENCES [dbo].[CUSTOMER] ([NAME])

ALTER TABLE [dbo].[SAMPLE] CHECK CONSTRAINT [FK_SAMPLE_CUSTOMER]

ALTER TABLE [dbo].[SAMPLE]  WITH CHECK ADD  CONSTRAINT [FK_SAMPLE_PATIENT] FOREIGN KEY([PATIENT], [PATIENT_REV_NO])
REFERENCES [dbo].[PATIENT] ([NAME], [REVISION_NO])

ALTER TABLE [dbo].[SAMPLE] CHECK CONSTRAINT [FK_SAMPLE_PATIENT]

ALTER TABLE [dbo].[SAMPLE]  WITH CHECK ADD  CONSTRAINT [FK_SAMPLE_PRACTITIONER] FOREIGN KEY([X_PRACTITIONER])
REFERENCES [dbo].[PRACTITIONER] ([NAME])

ALTER TABLE [dbo].[SAMPLE] CHECK CONSTRAINT [FK_SAMPLE_PRACTITIONER]

/****** Object:  Table [dbo].[TEST]    Script Date: 06/12/2015 16:30:49 ******/

CREATE TABLE [dbo].[TEST](
	[TEST_NUMBER] [int] NOT NULL,
	[ANALYSIS] [varchar](15) NULL,
	[VERSION] [int] NULL,
	[SAMPLE_NUMBER] [int] NULL,
	[STATUS] [varchar](1) NULL,
	[DATE_RECEIVED] [datetime] NULL,
	[DATE_STARTED] [datetime] NULL,
	[DATE_COMPLETED] [datetime] NULL,
	[DATE_REVIEWED] [datetime] NULL,
	[TEST_COMMENT] [varchar](254) NULL,
	[LAB] [varchar](20) NULL,
	[REPORTED_NAME] [varchar](20) NULL,
	[VARIATION] [varchar](15) NULL,
	[RELEASED] [varchar](1) NULL,
	[X_REPORTED] [varchar](1) NULL,
	[X_FIRST_REPORT_DATE] [datetime] NULL,
	[X_LAST_REPORT_DATE] [datetime] NULL,
	[CHANGED_ON] [datetime] NULL,
 CONSTRAINT [PK_TEST] PRIMARY KEY NONCLUSTERED 
(
	[TEST_NUMBER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[TEST]  WITH CHECK ADD  CONSTRAINT [FK_TEST_ANALYSIS] FOREIGN KEY([ANALYSIS], [VERSION])
REFERENCES [dbo].[ANALYSIS] ([NAME], [VERSION])

ALTER TABLE [dbo].[TEST] CHECK CONSTRAINT [FK_TEST_ANALYSIS]

ALTER TABLE [dbo].[TEST]  WITH CHECK ADD  CONSTRAINT [FK_TEST_SAMPLE] FOREIGN KEY([SAMPLE_NUMBER])
REFERENCES [dbo].[SAMPLE] ([SAMPLE_NUMBER])

ALTER TABLE [dbo].[TEST] CHECK CONSTRAINT [FK_TEST_SAMPLE]

/****** Object:  Table [dbo].[RESULT]    Script Date: 06/12/2015 16:31:03 ******/

CREATE TABLE [dbo].[RESULT](
	[RESULT_NUMBER] [int] NOT NULL,
	[TEST_NUMBER] [int] NULL,
	[NAME] [varchar](40) NULL,
	[FORMATTED_ENTRY] [varchar](254) NULL,
	[ENTERED_ON] [datetime] NULL,
	[DATE_REVIEWED] [datetime] NULL,
	[ANALYSIS] [varchar](15) NULL,
	[SAMPLE_NUMBER] [int] NULL,
	[REPORTED_NAME] [varchar](40) NULL,
	[LOINC] [varchar](7) NULL,
	[SNOMED_CODE] [varchar](18) NULL,
	[X_ORGANISM] [varchar](20) NULL,
	[X_ORGANISM_REF] [varchar](20) NULL,
	[CHANGED_ON] [datetime] NULL,
 CONSTRAINT [PK_RESULT] PRIMARY KEY NONCLUSTERED 
(
	[RESULT_NUMBER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


ALTER TABLE [dbo].[RESULT]  WITH CHECK ADD  CONSTRAINT [FK_RESULT_TEST] FOREIGN KEY([TEST_NUMBER])
REFERENCES [dbo].[TEST] ([TEST_NUMBER])

ALTER TABLE [dbo].[RESULT] CHECK CONSTRAINT [FK_RESULT_TEST]

/****** Object:  Table [dbo].[REPORTS]    Script Date: 06/12/2015 16:31:35 ******/

CREATE TABLE [dbo].[REPORTS](
	[REPORT_NUMBER] [int] NOT NULL,
	[REPORT_TYPE] [varchar](40) NULL,
	[PURPOSE] [varchar](20) NULL,
	[OBJECT_CLASS] [varchar](10) NULL,
	[DATE_CREATED] [datetime] NULL,
	[CREATED_BY] [varchar](10) NULL,
	[PRINT_COUNT] [int] NULL,
	[DATA_CHANGED] [varchar](1) NULL,
	[RESULTS_CHANGED] [varchar](1) NULL,
	[REPORT_FILE_NAME] [varchar](254) NULL,
	[SUPERSEDED] [varchar](1) NULL,
	[ALLOW_EDIT] [varchar](1) NULL,
	[ALLOW_PRINT] [varchar](1) NULL,
	[REPORT_STATUS] [varchar](1) NULL,
	[AUDIT] [varchar](1) NULL,
 CONSTRAINT [PK_REPORTS] PRIMARY KEY NONCLUSTERED 
(
	[REPORT_NUMBER] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


/****** Object:  Table [dbo].[REPORT_OBJECTS]    Script Date: 06/12/2015 16:32:51 ******/

CREATE TABLE [dbo].[REPORT_OBJECTS](
	[REPORT_NUMBER] [int] NOT NULL,
	[OBJECT_ID] [int] NULL,
	[OBJECT_NAME] [varchar](25) NULL
) ON [PRIMARY]


ALTER TABLE [dbo].[REPORT_OBJECTS]  WITH CHECK ADD  CONSTRAINT [FK_REPORT_OBJECTS_REPORTS] FOREIGN KEY([REPORT_NUMBER])
REFERENCES [dbo].[REPORTS] ([REPORT_NUMBER])

ALTER TABLE [dbo].[REPORT_OBJECTS] CHECK CONSTRAINT [FK_REPORT_OBJECTS_REPORTS]

ALTER TABLE [dbo].[REPORT_OBJECTS]  WITH CHECK ADD  CONSTRAINT [FK_REPORT_OBJECTS_SAMPLE] FOREIGN KEY([OBJECT_ID])
REFERENCES [dbo].[SAMPLE] ([SAMPLE_NUMBER])

ALTER TABLE [dbo].[REPORT_OBJECTS] CHECK CONSTRAINT [FK_REPORT_OBJECTS_SAMPLE]
