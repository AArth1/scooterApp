CREATE TABLE [dbo].[Payments] (
    [PaymentID]       INT             IDENTITY (1, 1) NOT NULL,
    [UserID]          INT             NOT NULL,
    [RideID]          INT             NOT NULL,
    [PaymentMethodID] INT             NOT NULL,
    [Amount]          DECIMAL (10, 2) NOT NULL,
    [Status]          NVARCHAR (50)   NOT NULL,
    [CreatedAt]       DATETIME        DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]       DATETIME        DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([PaymentID] ASC),
    FOREIGN KEY ([PaymentMethodID]) REFERENCES [dbo].[PaymentMethods] ([PaymentMethodID]),
    FOREIGN KEY ([RideID]) REFERENCES [dbo].[Rides] ([RideID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserAuthentication] ([UserID])
);


GO

