CREATE VIEW dbo.BaseView
AS
SELECT        s.SAMPLE_NUMBER, s.LABEL_ID, p.NAME AS Patient_ID, p.REVISION_NO AS Patient_Revision_No, p.FIRST_NAME AS Patient_First_Name, p.LAST_NAME AS Patient_Last_Name, p.MIDDLE_NAME AS Patient_Middle_Name, 
                         ISNULL(p.ADDRESS1_LINE_1, '') + ' ' + ISNULL(p.ADDRESS1_LINE_2, '') AS Patient_Address, p.ADDRESS1_CITY AS City, p.ADDRESS1_STATE AS State, p.ADDRESS1_COUNTY AS County, p.ADDRESS1_ZIP AS ZIP, 
                         p.BIRTH_DATE AS Date_of_Birth, p.GENDER, p.X_RACE AS Race, p.X_ETHNICITY AS Ethnicity, c.NAME AS Submitter_ID, c.COMPANY_NAME AS Submitter_Name, ISNULL(c.ADDRESS1, '') + ' ' + ISNULL(c.ADDRESS2, '') 
                         AS Submitter_Address, c.X_CITY AS Submitter_City, c.X_STATE AS Submitter_State, c.X_COUNTY AS Submitter_County, c.X_ZIPCODE AS Submitter_ZIP, c.X_CUSTOMER_TYPE AS Submitter_Type, t.NAME AS Practioner_Name, 
                         s.Z_PROGRAM AS Sample_Program, s.X_SPECIMEN_SOURCE AS Specimen_Source, s.SAMPLED_DATE, s.RECD_DATE AS Sample_Record_Date, s.DATE_STARTED AS Date_Test_Started, s.APPROVED AS Sample_Approved, 
                         s.DATE_REVIEWED AS Sample_Reviewed_Date, s.TEST_LIST, r.DATE_CREATED AS Report_Date_Created, r.PURPOSE AS Report_Type, r.REPORT_FILE_NAME AS Report_Link, s.Z_OK_OUTBREAK AS Outbreak, s.EXT_LINK, 
                         p.HOME_PHONE
FROM            dbo.SAMPLE AS s INNER JOIN
                         dbo.CUSTOMER AS c ON s.CUSTOMER = c.NAME INNER JOIN
                         dbo.PATIENT AS p ON s.PATIENT = p.NAME AND s.PATIENT_REV_NO = p.REVISION_NO LEFT OUTER JOIN
                         dbo.PRACTITIONER AS t ON s.X_PRACTITIONER = t.NAME LEFT OUTER JOIN
                         dbo.LatestReportObject AS o ON s.SAMPLE_NUMBER = o.OBJECT_ID LEFT OUTER JOIN
                         dbo.REPORTS AS r ON o.REPORT_NUMBER = r.REPORT_NUMBER

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[24] 4[6] 2[41] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "s"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 248
            End
            DisplayFlags = 280
            TopColumn = 27
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "p"
            Begin Extent = 
               Top = 138
               Left = 271
               Bottom = 267
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 6
               Left = 509
               Bottom = 135
               Right = 679
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "o"
            Begin Extent = 
               Top = 6
               Left = 286
               Bottom = 84
               Right = 453
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 169
               Left = 69
               Bottom = 298
               Right = 266
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 38
         Width = 284
         Width = 2190
         Width = 3345
         Width = 2340
         Width = 1500', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'BaseView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 4275
         Width = 1500
         Width = 1500
         Width = 2040
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2190
         Width = 1680
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1785
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'BaseView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'BaseView';

