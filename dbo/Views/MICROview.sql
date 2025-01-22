CREATE VIEW dbo.MICROview
AS
SELECT DISTINCT 
                         b.SAMPLE_NUMBER, b.LABEL_ID, t.TEST_NUMBER, r.RESULT_NUMBER, b.Patient_First_Name, b.Patient_Last_Name, b.Patient_Address, b.City, b.State, b.County, 
                         b.ZIP, b.Date_of_Birth, b.GENDER, b.Race, b.Ethnicity, b.Submitter_Name, b.Submitter_City, b.Submitter_Type, b.Specimen_Source, b.SAMPLED_DATE, 
                         b.Sample_Record_Date, b.Date_Test_Started, b.TEST_LIST, b.Report_Date_Created, b.Report_Type, b.Report_Link, b.Sample_Approved, b.Sample_Reviewed_Date, 
                         b.Outbreak, t.ANALYSIS, t.VERSION AS Analysis_Version, CASE WHEN r.ANALYSIS = 'cult_strep_b' AND 
                         r.NAME = 'gbs' THEN r.FORMATTED_ENTRY END AS CULT_STREP_B, CASE WHEN r.ANALYSIS = 'cult_bact' AND 
                         r.NAME = 'Bacterial Culture (Aerobic)' THEN r.FORMATTED_ENTRY END AS CULT_BACT, CASE WHEN r.ANALYSIS = 'cult_environ' AND (r.NAME IN ('overall', 
                         'Environmental Culture ID', 'other organism identified')) THEN r.FORMATTED_ENTRY END AS CULT_ENVIRON, CASE WHEN r.ANALYSIS = 'iso_aerobic' AND 
                         (r.NAME IN ('overall', 'Aerobic isolate ID', 'other organism identification')) THEN r.FORMATTED_ENTRY END AS ISO_AEROBIC, 
                         CASE WHEN r.ANALYSIS = 'iso_anaerobic' AND (r.NAME IN ('overall', 'Anaerobic isolate ID', 'other organism identification')) 
                         THEN r.FORMATTED_ENTRY END AS ANAEROBIC, CASE WHEN r.ANALYSIS = 'iso_h_influ' AND (r.NAME IN ('overall', 'H.influenzae isolate ID', 
                         'other organism identified')) THEN r.FORMATTED_ENTRY END AS ISO_H_INFLU, CASE WHEN r.ANALYSIS = 'iso_n_men' AND (r.NAME IN ('overall', 
                         'N.menigitidis isolate ID', 'other organism identified')) THEN r.FORMATTED_ENTRY END AS ISO_N_MEN, CASE WHEN r.ANALYSIS = 'cult_stool' AND 
                         (r.NAME IN ('overall', 'aeromonas species', 'campylobacter species', 'Escherichia coli toxigenic', 'salmonella species', 'staphylococcus aureas', 'vibrio species', 
                         'Yersinia species')) THEN r.FORMATTED_ENTRY END AS Cult_Stool, CASE WHEN r.ANALYSIS = 'iso_aer_vib' AND (r.NAME IN ('overall', 
                         'aeromonas/vibrio isolate Id', 'other organism identified')) THEN r.FORMATTED_ENTRY END AS Iso_Aer_Vib, CASE WHEN r.ANALYSIS = 'iso_campy' AND 
                         (r.NAME IN ('overall', 'campy isolate Id', 'other organism identified')) THEN r.FORMATTED_ENTRY END AS Iso_Campy, CASE WHEN r.ANALYSIS = 'iso_e_coli' AND 
                         (r.NAME IN ('overall', 'E.coli isolate Id', 'other organism identified')) THEN r.FORMATTED_ENTRY END AS Iso_E_Coli, CASE WHEN r.ANALYSIS = 'iso_samomella' AND
                          (r.NAME IN ('overall', 'salmonella isolate Id', 'other organism identified')) THEN r.FORMATTED_ENTRY END AS Iso_Samomella, 
                         CASE WHEN r.ANALYSIS = 'iso_shigella' AND (r.NAME IN ('overall', 'shigella isolate Id', 'other organism identified')) 
                         THEN r.FORMATTED_ENTRY END AS Iso_Shigella, CASE WHEN r.ANALYSIS = 'iso_y_enterocol' AND (r.NAME IN ('overall', 'yersinia isolate Id', 
                         'other organism identified')) THEN r.FORMATTED_ENTRY END AS Iso_Y_Enterocol, CASE WHEN r.ANALYSIS = 'ehec' AND 
                         r.NAME = 'Shiga-like toxin' THEN r.FORMATTED_ENTRY END AS [Shiga Like Toxin], CASE WHEN r.ANALYSIS = 'pfge' AND 
                         r.NAME = 'Primary Pattern' THEN r.FORMATTED_ENTRY END AS [Primary PFGE Pattern], CASE WHEN r.ANALYSIS = 'pfge' AND 
                         r.NAME = 'Primary Pattern' THEN r.[DATE_REVIEWED] END AS [Primary PFGE Date], CASE WHEN r.ANALYSIS = 'pfge' AND 
                         r.NAME = 'Secondary Pattern' THEN r.FORMATTED_ENTRY END AS [Secondary PFGE Pattern], CASE WHEN r.ANALYSIS = 'pfge' AND 
                         r.NAME = 'Secondary Pattern' THEN r.[DATE_REVIEWED] END AS [Secondary PFGE Date], CASE WHEN r.ANALYSIS = 'PCR_ECOLI' AND (r.NAME = 'interpretation' OR
                         r.NAME = 'toxin/factor') THEN r.FORMATTED_ENTRY END AS [STX 1], CASE WHEN r.ANALYSIS = 'PCR_ECOLI' AND (r.NAME = 'interpretation' OR
                         r.NAME = 'toxin/factor') THEN r.[DATE_REVIEWED] END AS [STX 1 Date], CASE WHEN r.ANALYSIS = 'PCR_ECOLI' AND (r.NAME = 'interpretation' OR
                         r.NAME = 'toxin/factor') THEN r.FORMATTED_ENTRY END AS [STX 2], CASE WHEN r.ANALYSIS = 'PCR_ECOLI' AND (r.NAME = 'interpretation' OR
                         r.NAME = 'toxin/factor') THEN r.[DATE_REVIEWED] END AS [STX 2 Date], CASE WHEN r.ANALYSIS = 'pcr_noro' AND (r.NAME = 'interpretation' OR
                         r.NAME = 'group') THEN r.FORMATTED_ENTRY END AS [Norovirus PCR], CASE WHEN r.ANALYSIS = 'pcr_noro' AND (r.NAME = 'interpretation' OR
                         r.NAME = 'group') THEN r.[DATE_REVIEWED] END AS [Norovirus PCR Date], CASE WHEN r.ANALYSIS = 'PCR_ECOLI' AND (r.NAME = 'interpretation' OR
                         r.NAME = 'toxin/factor') THEN r.FORMATTED_ENTRY END AS [eaeA FAM], CASE WHEN r.ANALYSIS = 'PCR_ECOLI' AND (r.NAME = 'interpretation' OR
                         r.NAME = 'toxin/factor') THEN r.FORMATTED_ENTRY END AS [hlyA Tx RED], 
                         CASE WHEN t .[X_REPORTED] = 'T' THEN r.[REPORTED_NAME] END AS [Final Results]
FROM            dbo.BaseView AS b INNER JOIN
                         dbo.TEST AS t ON b.SAMPLE_NUMBER = t.SAMPLE_NUMBER LEFT OUTER JOIN
                         dbo.RESULT AS r ON t.TEST_NUMBER = r.TEST_NUMBER
WHERE        (b.Report_Link IS NOT NULL)

GO
GRANT SELECT
    ON OBJECT::[dbo].[MICROview] TO [OSDH\LITS-EPI-SQL]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[MICROview] TO [OSDH\LITS-BAC-SQL]
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
         Begin Table = "t"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "r"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'MICROview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'MICROview';

