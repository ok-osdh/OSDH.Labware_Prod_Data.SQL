﻿CREATE VIEW dbo.[TB-HIVview]
AS
SELECT DISTINCT 
                         b.SAMPLE_NUMBER, b.Patient_First_Name, b.Patient_Last_Name, b.Patient_Address, b.City, b.State, b.County, b.ZIP, b.Date_of_Birth, b.GENDER, b.Race, b.Ethnicity, b.Submitter_Name, b.Submitter_City, b.Submitter_Type, 
                         b.Specimen_Source, b.SAMPLED_DATE, b.Sample_Record_Date, b.Date_Test_Started, b.TEST_LIST, b.Report_Date_Created, b.Report_Type, b.Report_Link, b.Sample_Approved, b.Sample_Reviewed_Date, 
                         e1.FORMATTED_ENTRY AS [HIV1-EIA Screen], e2.FORMATTED_ENTRY AS [HIV 1/2 Differentiation], b.Outbreak
FROM            dbo.BaseView AS b LEFT OUTER JOIN
                         dbo.TEST AS t1 ON b.SAMPLE_NUMBER = t1.SAMPLE_NUMBER AND t1.ANALYSIS = 'HIV_OVRL' LEFT OUTER JOIN
                         dbo.RESULT AS e1 ON t1.TEST_NUMBER = e1.TEST_NUMBER LEFT OUTER JOIN
                         dbo.TEST AS t2 ON b.SAMPLE_NUMBER = t2.SAMPLE_NUMBER AND t2.ANALYSIS = 'HIV_RAPID_EIA' LEFT OUTER JOIN
                         dbo.RESULT AS e2 ON t2.TEST_NUMBER = e2.TEST_NUMBER
WHERE        (e1.FORMATTED_ENTRY IS NOT NULL) AND (b.Practioner_Name IN ('CLAFLIN_GENE', 'HARVEY_CHARLES', 'LINDSEY_PHILLIP')) OR
                         (e1.FORMATTED_ENTRY IS NOT NULL) AND (b.Sample_Program = '21') OR
                         (b.Practioner_Name IN ('CLAFLIN_GENE', 'HARVEY_CHARLES', 'LINDSEY_PHILLIP')) AND (e2.FORMATTED_ENTRY IS NOT NULL) OR
                         (e2.FORMATTED_ENTRY IS NOT NULL) AND (b.Sample_Program = '21')

GO
GRANT SELECT
    ON OBJECT::[dbo].[TB-HIVview] TO [OSDH\LITS-TB-SQL]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "t1"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e1"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t2"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 532
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e2"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 664
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 250
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
         Or = 1350
    ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TB-HIVview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TB-HIVview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TB-HIVview';

