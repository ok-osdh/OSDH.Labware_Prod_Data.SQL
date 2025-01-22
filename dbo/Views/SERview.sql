
CREATE VIEW [dbo].[SERview]
AS
 SELECT b.SAMPLE_NUMBER ,
		b.Patient_First_Name ,
		b.Patient_Last_Name ,
		b.Patient_Address ,
		b.City, b.State ,
		b.County ,
		b.ZIP ,
		b.Date_of_Birth ,
		b.GENDER ,
		b.Race , 
        b.Ethnicity ,
		b.Submitter_Name ,
		b.Submitter_City ,
		b.Submitter_Type ,
		b.Specimen_Source ,
		b.SAMPLED_DATE ,
		b.Sample_Record_Date ,
		b.Date_Test_Started ,
		b.TEST_LIST ,
		b.Report_Date_Created ,
		b.Report_Type ,
		b.Report_Link ,
		b.Sample_Approved ,
		b.Sample_Reviewed_Date ,
		e1.FORMATTED_ENTRY AS OVRL_RPR , 
        e2.FORMATTED_ENTRY AS OVRL_RPR_Titer ,
		e3.FORMATTED_ENTRY AS OVRL_TP_PA ,
		e4.FORMATTED_ENTRY AS RPR ,
		e5.FORMATTED_ENTRY AS Titer_Result ,
		e6.FORMATTED_ENTRY AS  TPPA ,
		b.Outbreak
   FROM dbo.BaseView AS b LEFT OUTER JOIN
        dbo.TEST AS t1 ON b.SAMPLE_NUMBER = t1.SAMPLE_NUMBER AND t1.ANALYSIS = 'SYPH_RPR_OVRL' 
															 AND t1.STATUS = 'A' 
															 AND t1.LAB = 'IMMUNOLOGY' LEFT OUTER JOIN
        dbo.RESULT AS e1 ON t1.TEST_NUMBER = e1.TEST_NUMBER AND e1.NAME = 'RPR QUAL' LEFT OUTER JOIN
        dbo.RESULT AS e2 ON t1.TEST_NUMBER = e2.TEST_NUMBER AND e2.NAME = 'RPR QUANT' LEFT OUTER JOIN
        dbo.TEST AS t3 ON b.SAMPLE_NUMBER = t3.SAMPLE_NUMBER AND t3.ANALYSIS = 'SYPH_TPPA_OVRL' and t3.STATUS = 'A'  LEFT OUTER JOIN
        dbo.RESULT AS e3 ON t3.TEST_NUMBER = e3.TEST_NUMBER AND e3.NAME = 'TPPA' LEFT OUTER JOIN 
		dbo.TEST AS t4 ON b.SAMPLE_NUMBER = t4.SAMPLE_NUMBER AND t4.ANALYSIS = 'SYPH_RPR_L' 
											 				 AND t4.STATUS = 'A'  
															 AND t4.LAB = 'IMMUNOLOGY' LEFT OUTER JOIN 
        dbo.RESULT AS e4 ON t4.TEST_NUMBER = e4.TEST_NUMBER AND e4.NAME = 'RPR' LEFT OUTER JOIN 
		dbo.TEST AS t5 ON b.SAMPLE_NUMBER = t5.SAMPLE_NUMBER AND t5.ANALYSIS = 'SYPH_RPR_T' and t5.STATUS = 'A'  LEFT OUTER JOIN
        dbo.RESULT AS e5 ON t5.TEST_NUMBER = e5.TEST_NUMBER AND e5.NAME = 'TITER RESULT' LEFT OUTER JOIN 
		dbo.TEST AS t6 ON b.SAMPLE_NUMBER = t6.SAMPLE_NUMBER AND t6.ANALYSIS = 'SYPH_TPPA' and t6.STATUS = 'A'  LEFT OUTER JOIN
        dbo.RESULT AS e6 ON t6.TEST_NUMBER = e6.TEST_NUMBER AND e6.NAME = 'TPPA' 
  WHERE ((e1.FORMATTED_ENTRY IS NOT NULL)
	 OR (e2.FORMATTED_ENTRY IS NOT NULL)
	 OR (e3.FORMATTED_ENTRY IS NOT NULL)
	 OR (e4.FORMATTED_ENTRY IS NOT NULL)
	 OR (e5.FORMATTED_ENTRY IS NOT NULL)
	 OR (e6.FORMATTED_ENTRY IS NOT NULL))


GO
GRANT SELECT
    ON OBJECT::[dbo].[SERview] TO [OSDH\LITS-SER-SQL]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[5] 2[35] 3) )"
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
               Right = 300
            End
            DisplayFlags = 280
            TopColumn = 30
         End
         Begin Table = "t1"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 267
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e1"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 399
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t2"
            Begin Extent = 
               Top = 402
               Left = 38
               Bottom = 531
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e2"
            Begin Extent = 
               Top = 270
               Left = 275
               Bottom = 399
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t3"
            Begin Extent = 
               Top = 534
               Left = 38
               Bottom = 663
               Right = 250
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e3"
            Begin Extent = 
               Top = 666
               Left = 38
               Bottom = 795
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'SERview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'End
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'SERview';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'SERview';

