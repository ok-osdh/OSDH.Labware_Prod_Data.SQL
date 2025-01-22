CREATE TABLE [dbo].[OK_DiagnosisCodes] (
    [ProgramID]     TINYINT      NOT NULL,
    [DiagnosisCode] VARCHAR (10) NOT NULL,
    [ProgramName]   VARCHAR (40) NULL,
    CONSTRAINT [PK_OK_DiagnosisCodes] PRIMARY KEY CLUSTERED ([ProgramID] ASC) WITH (FILLFACTOR = 90)
);

