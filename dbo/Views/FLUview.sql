CREATE VIEW dbo.FLUview
AS
SELECT        b.SAMPLE_NUMBER, b.Patient_First_Name, b.Patient_Last_Name, b.Patient_Address, b.City, b.State, b.County, b.ZIP, b.Date_of_Birth, b.GENDER, b.Race, 
                         b.Ethnicity, b.Submitter_Name, b.Submitter_City, b.Submitter_Type, b.Specimen_Source, b.SAMPLED_DATE, b.Sample_Record_Date, b.Date_Test_Started, 
                         b.TEST_LIST, b.Report_Date_Created, b.Report_Type, b.Report_Link, b.Sample_Approved, b.Sample_Reviewed_Date, b.Outbreak, t1.[PCR Influenza A], 
                         t1.[Influenza A PCR Date], t3.Subtype, t3.[Subtype Date], t2.[PCR Influenza B], t2.[Influenza B PCR Date]
FROM            dbo.BaseView AS b INNER JOIN
                             (SELECT        SAMPLE_NUMBER, FORMATTED_ENTRY AS [PCR Influenza A], DATE_REVIEWED AS [Influenza A PCR Date]
                               FROM            dbo.TestResult AS tr1
                               WHERE        (NAME = 'Interpretation') AND (REPORTED_NAME = 'Influenza A PCR')) AS t1 ON b.SAMPLE_NUMBER = t1.SAMPLE_NUMBER INNER JOIN
                             (SELECT        SAMPLE_NUMBER, FORMATTED_ENTRY AS [PCR Influenza B], DATE_REVIEWED AS [Influenza B PCR Date]
                               FROM            dbo.TestResult AS tr2
                               WHERE        (NAME = 'Interpretation') AND (REPORTED_NAME = 'Influenza B PCR')) AS t2 ON b.SAMPLE_NUMBER = t2.SAMPLE_NUMBER LEFT OUTER JOIN
                             (SELECT        SAMPLE_NUMBER, FORMATTED_ENTRY AS Subtype, DATE_REVIEWED AS [Subtype Date]
                               FROM            dbo.TestResult AS tr3
                               WHERE        (NAME = 'Subtype') AND (REPORTED_NAME = 'Influenza A PCR')) AS t3 ON t1.SAMPLE_NUMBER = t3.SAMPLE_NUMBER

GO
GRANT SELECT
    ON OBJECT::[dbo].[FLUview] TO [OSDH\LITS-FLU-SQL]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[20] 4[5] 2[27] 3) )"
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
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t1"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 250
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t2"
            Begin Extent = 
               Top = 138
               Left = 276
               Bottom = 250
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t3"
            Begin Extent = 
               Top = 6
               Left = 288
               Bottom = 118
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'FLUview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'FLUview';

