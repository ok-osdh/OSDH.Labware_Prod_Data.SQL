CREATE TABLE [dbo].[RESULTSLOG] (
    [id]              INT          IDENTITY (1, 1) NOT NULL,
    [loginUser]       VARCHAR (50) NULL,
    [logDateTime]     DATETIME     NULL,
    [clinic]          VARCHAR (50) NULL,
    [dateViewed]      DATETIME     NULL,
    [clientReportNum] INT          NULL,
    CONSTRAINT [PK_RESULTSLOG] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[RESULTSLOG] TO [OSDH\OSDHDataService]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'user login name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RESULTSLOG', @level2type = N'COLUMN', @level2name = N'loginUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'date time did the view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RESULTSLOG', @level2type = N'COLUMN', @level2name = N'logDateTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'clinic interesed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RESULTSLOG', @level2type = N'COLUMN', @level2name = N'clinic';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'date of a clinic reports being viewed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RESULTSLOG', @level2type = N'COLUMN', @level2name = N'dateViewed';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'one client''s reporting being viewed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RESULTSLOG', @level2type = N'COLUMN', @level2name = N'clientReportNum';

