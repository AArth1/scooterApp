CREATE TABLE [dbo].[PaymentMethods] (
    [PaymentMethodID] INT           IDENTITY (1, 1) NOT NULL,
    [UserID]          INT           NOT NULL,
    [MethodType]      NVARCHAR (50) NOT NULL,
    [Provider]        NVARCHAR (50) NOT NULL,
    [AccountNumber]   NVARCHAR (50) NOT NULL,
    [ExpiryDate]      DATETIME      NOT NULL,
    [CreatedAt]       DATETIME      DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]       DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([PaymentMethodID] ASC),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserAuthentication] ([UserID])
);


GO

