/*the name was too long */
CREATE VIEW dbo.TBview
AS
SELECT DISTINCT 
                         b.SAMPLE_NUMBER, b.Patient_First_Name, b.Patient_Last_Name, b.Patient_Address, b.City, b.State, b.County, b.ZIP, b.Date_of_Birth, b.GENDER, b.Race, 
                         b.Ethnicity, b.Submitter_Name, b.Submitter_City, b.Submitter_Type, b.Specimen_Source, b.SAMPLED_DATE, b.Sample_Record_Date, b.Date_Test_Started, 
                         b.TEST_LIST, b.Report_Date_Created, b.Report_Type, b.Report_Link, b.Sample_Approved, b.Sample_Reviewed_Date, b.Outbreak, 
                         e1.FORMATTED_ENTRY AS [Clinical Smear Result], e1.DATE_REVIEWED AS [Smear Date], e2.FORMATTED_ENTRY AS [TB Final Results], 
                         e3.FORMATTED_ENTRY AS [Streptomycin 1], e3.DATE_REVIEWED AS [Streptomycin1 Date], e4.FORMATTED_ENTRY AS [Isoniazid 01], 
                         e4.DATE_REVIEWED AS [Isoniazid 01 Date], e5.FORMATTED_ENTRY AS [Isoniazid 04], e5.DATE_REVIEWED AS [Isoniazid 04 Date], 
                         e6.FORMATTED_ENTRY AS [Rifampin 1], e6.DATE_REVIEWED AS [Rifampin 1 Date], e7.FORMATTED_ENTRY AS [Ethambutol 5], 
                         e7.DATE_REVIEWED AS [Ethambutol 5 Date], e8.FORMATTED_ENTRY AS [PZA 100], e8.DATE_REVIEWED AS [PZA10 0Date], e9.FORMATTED_ENTRY AS [TB PCR], 
                         e9.DATE_REVIEWED AS [TB PCR Date], b.Outbreak AS Expr1
FROM            dbo.BaseView AS b LEFT OUTER JOIN
                         dbo.TEST AS t1 ON b.SAMPLE_NUMBER = t1.SAMPLE_NUMBER AND t1.ANALYSIS = 'AFB_CLIN_SMEAR' LEFT OUTER JOIN
                         dbo.RESULT AS e1 ON t1.TEST_NUMBER = e1.TEST_NUMBER AND e1.NAME = 'Clinical Smear' LEFT OUTER JOIN
                         dbo.TEST AS t2 ON b.SAMPLE_NUMBER = t2.SAMPLE_NUMBER AND (t2.ANALYSIS = 'AFB_CULTURE' OR
                         t2.ANALYSIS = 'AFB_CULTURE_CFI') LEFT OUTER JOIN
                         dbo.RESULT AS e2 ON t2.TEST_NUMBER = e2.TEST_NUMBER AND (e2.NAME = 'AFB' OR
                         e2.NAME = 'Overall') LEFT OUTER JOIN
                         dbo.TEST AS t3 ON b.SAMPLE_NUMBER = t3.SAMPLE_NUMBER AND t3.ANALYSIS = 'AFB_SIRE' LEFT OUTER JOIN
                         dbo.RESULT AS e3 ON t3.TEST_NUMBER = e3.TEST_NUMBER AND e3.NAME = 'Streptomycin 1.0 mcg/ml' LEFT OUTER JOIN
                         dbo.TEST AS t4 ON b.SAMPLE_NUMBER = t4.SAMPLE_NUMBER AND t4.ANALYSIS = 'AFB_SIRE' LEFT OUTER JOIN
                         dbo.RESULT AS e4 ON t4.TEST_NUMBER = e4.TEST_NUMBER AND e4.NAME = 'Isoniazid 0.1 mcg/ml' LEFT OUTER JOIN
                         dbo.TEST AS t5 ON b.SAMPLE_NUMBER = t5.SAMPLE_NUMBER AND t5.ANALYSIS = 'AFB_SIRE' LEFT OUTER JOIN
                         dbo.RESULT AS e5 ON t5.TEST_NUMBER = e5.TEST_NUMBER AND e5.NAME = 'Isoniazid 0.4 mcg/ml' LEFT OUTER JOIN
                         dbo.TEST AS t6 ON b.SAMPLE_NUMBER = t6.SAMPLE_NUMBER AND t6.ANALYSIS = 'AFB_SIRE' LEFT OUTER JOIN
                         dbo.RESULT AS e6 ON t6.TEST_NUMBER = e6.TEST_NUMBER AND e6.NAME = 'Rifampin 1.0 mcg/ml' LEFT OUTER JOIN
                         dbo.TEST AS t7 ON b.SAMPLE_NUMBER = t7.SAMPLE_NUMBER AND t7.ANALYSIS = 'AFB_SIRE' LEFT OUTER JOIN
                         dbo.RESULT AS e7 ON t7.TEST_NUMBER = e7.TEST_NUMBER AND e7.NAME = 'Ethambutol 5.0 mcg/ml' LEFT OUTER JOIN
                         dbo.TEST AS t8 ON b.SAMPLE_NUMBER = t8.SAMPLE_NUMBER AND t8.ANALYSIS = 'AFB_PZA' LEFT OUTER JOIN
                         dbo.RESULT AS e8 ON t8.TEST_NUMBER = e8.TEST_NUMBER AND e8.NAME = 'Pyrazinamide 100 mcg/ml' LEFT OUTER JOIN
                         dbo.TEST AS t9 ON b.SAMPLE_NUMBER = t9.SAMPLE_NUMBER AND t9.ANALYSIS = 'AFB_TB_PCR' LEFT OUTER JOIN
                         dbo.RESULT AS e9 ON t9.TEST_NUMBER = e9.TEST_NUMBER AND e9.NAME = 'MTB PCR'
WHERE        (e1.FORMATTED_ENTRY IS NOT NULL) OR
                         (e2.FORMATTED_ENTRY IS NOT NULL) OR
                         (e3.FORMATTED_ENTRY IS NOT NULL) OR
                         (e4.FORMATTED_ENTRY IS NOT NULL) OR
                         (e5.FORMATTED_ENTRY IS NOT NULL) OR
                         (e6.FORMATTED_ENTRY IS NOT NULL) OR
                         (e7.FORMATTED_ENTRY IS NOT NULL) OR
                         (e8.FORMATTED_ENTRY IS NOT NULL) OR
                         (e9.FORMATTED_ENTRY IS NOT NULL)

GO
GRANT SELECT
    ON OBJECT::[dbo].[TBview] TO [OSDH\LITS-TB-SQL]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[14] 3[22] 2) )"
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
               Top = 72
               Left = 711
               Bottom = 201
               Right = 973
            End
            DisplayFlags = 280
            TopColumn = 32
         End
         Begin Table = "t1"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 241
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e1"
            Begin Extent = 
               Top = 111
               Left = 303
               Bottom = 226
               Right = 483
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t2"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 361
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e2"
            Begin Extent = 
               Top = 246
               Left = 276
               Bottom = 361
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t3"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 481
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e3"
            Begin Extent = 
               Top = 366
               Left = 276
               Bottom = 481
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
    ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TBview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'     End
         Begin Table = "t4"
            Begin Extent = 
               Top = 486
               Left = 38
               Bottom = 601
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e4"
            Begin Extent = 
               Top = 486
               Left = 276
               Bottom = 601
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t5"
            Begin Extent = 
               Top = 606
               Left = 38
               Bottom = 721
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e5"
            Begin Extent = 
               Top = 606
               Left = 276
               Bottom = 721
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t6"
            Begin Extent = 
               Top = 726
               Left = 38
               Bottom = 841
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e6"
            Begin Extent = 
               Top = 726
               Left = 276
               Bottom = 841
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t7"
            Begin Extent = 
               Top = 846
               Left = 38
               Bottom = 961
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e7"
            Begin Extent = 
               Top = 846
               Left = 276
               Bottom = 961
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t8"
            Begin Extent = 
               Top = 966
               Left = 38
               Bottom = 1081
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e8"
            Begin Extent = 
               Top = 966
               Left = 276
               Bottom = 1081
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t9"
            Begin Extent = 
               Top = 1086
               Left = 38
               Bottom = 1201
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e9"
            Begin Extent = 
               Top = 1086
               Left = 276
               Bottom = 1201
               Right = 456
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
      Begin ColumnWidths = 45
         Width = 284
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Widt', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TBview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane3', @value = N'h = 1500
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 17
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
         Or = 1350
         Or = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TBview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 3, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'TBview';

