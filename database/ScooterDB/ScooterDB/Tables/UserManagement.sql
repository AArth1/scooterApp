CREATE TABLE [dbo].[UserManagement] (
    [UserID]         INT           NOT NULL,
    [BillingAddress] VARCHAR (255) NOT NULL,
    [CreatedAt]      DATETIME      NOT NULL,
    [UpdatedAt]      DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserAuthentication] ([UserID])
);


GO

