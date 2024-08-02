CREATE TABLE [dbo].[ScooterIssues] (
    [IssueID]     INT            IDENTITY (1, 1) NOT NULL,
    [ScooterID]   INT            NOT NULL,
    [ReportedBy]  INT            NOT NULL,
    [IssueDate]   DATETIME       NOT NULL,
    [Description] NVARCHAR (255) NOT NULL,
    [Status]      NVARCHAR (50)  NOT NULL,
    [CreatedAt]   DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]   DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([IssueID] ASC),
    FOREIGN KEY ([ReportedBy]) REFERENCES [dbo].[UserAuthentication] ([UserID]),
    FOREIGN KEY ([ScooterID]) REFERENCES [dbo].[Scooters] ([ScooterID])
);


GO

