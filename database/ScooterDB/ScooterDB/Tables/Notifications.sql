CREATE TABLE [dbo].[Notifications] (
    [NotificationID]   INT            IDENTITY (1, 1) NOT NULL,
    [UserID]           INT            NOT NULL,
    [Message]          NVARCHAR (255) NOT NULL,
    [NotificationType] NVARCHAR (50)  NOT NULL,
    [SentAt]           DATETIME       DEFAULT (getdate()) NOT NULL,
    [IsRead]           BIT            DEFAULT ((0)) NOT NULL,
    [CreatedAt]        DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]        DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([NotificationID] ASC),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserAuthentication] ([UserID])
);


GO

