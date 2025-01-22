CREATE VIEW dbo.[COVID-19view]
AS
SELECT        b.SAMPLE_NUMBER, b.Patient_First_Name, b.Patient_Last_Name, b.Patient_Address, b.City, b.State, b.County, b.ZIP, b.Date_of_Birth, b.GENDER, b.Race, b.Ethnicity, b.Submitter_Name, b.Submitter_City, b.Submitter_Type, 
                         b.Specimen_Source, b.SAMPLED_DATE, b.Sample_Record_Date, b.Date_Test_Started, b.TEST_LIST, b.Report_Date_Created, b.Report_Type, b.Report_Link, b.Sample_Approved, b.Sample_Reviewed_Date, b.Outbreak, 
                         r.FORMATTED_ENTRY AS RESULT, b.HOME_PHONE, b.EXT_LINK
FROM            dbo.BaseView AS b INNER JOIN
                         dbo.TEST AS t ON b.SAMPLE_NUMBER = t.SAMPLE_NUMBER INNER JOIN
                         dbo.RESULT AS r ON t.TEST_NUMBER = r.TEST_NUMBER
WHERE        (t.ANALYSIS IN ('SARS2_PANTHER', 'PCR_2019_NCOV', 'PCR_SARS_COV2')) AND (r.NAME IN ('SARS-COV-2', 'interpretation')) AND (t.STATUS IN ('A', 'X')) AND (b.Submitter_Name NOT IN ('CDC', 'CAP_NORTHFIELD', 
                         'PUBLIC_HEALTH_LAB_OKC', 'WISCONSIN_PHL_MADISON')) AND (b.Patient_Last_Name NOT IN ('Proficiency')) OR
                         (t.ANALYSIS = 'sendout_molec') AND (r.NAME = 'referral lab') AND (t.STATUS IN ('A', 'X')) AND (b.Submitter_Name NOT IN ('CDC', 'CAP_NORTHFIELD', 'PUBLIC_HEALTH_LAB_OKC', 'WISCONSIN_PHL_MADISON')) AND 
                         (b.Patient_Last_Name NOT IN ('Proficiency')) AND (t.VARIATION IN ('dlo', 'oumc', 'cpl', 'rml', 'immy'))

GO
GRANT SELECT
    ON OBJECT::[dbo].[COVID-19view] TO [OSDH\EvarenP]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[COVID-19view] TO [OSDH\HimaniR]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[COVID-19view] TO [OSDH\WilliamBH]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[COVID-19view] TO [OSDH\DerekP]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[COVID-19view] TO [OSDH\Buffy]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[32] 3) )"
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
               Bottom = 136
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 400
               Right = 237
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
      Begin ColumnWidths = 11
         Column = 2145
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 5265
         Or = 3630
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'COVID-19view';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'COVID-19view';

