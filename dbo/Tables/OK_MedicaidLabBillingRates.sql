CREATE TABLE [dbo].[OK_MedicaidLabBillingRates] (
    [ID]        INT           NOT NULL,
    [CPTCode]   CHAR (5)      NOT NULL,
    [Active]    BIT           NOT NULL,
    [BeginDate] SMALLDATETIME NOT NULL,
    [EndDate]   SMALLDATETIME NULL,
    [Charge]    MONEY         NULL
);

