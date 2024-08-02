CREATE TABLE [dbo].[MaintenanceRecords] (
    [MaintenanceID]   INT            IDENTITY (1, 1) NOT NULL,
    [ScooterID]       INT            NOT NULL,
    [MaintenanceDate] DATETIME       NOT NULL,
    [Description]     NVARCHAR (255) NOT NULL,
    [PerformedBy]     NVARCHAR (255) NOT NULL,
    [CreatedAt]       DATETIME       DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]       DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([MaintenanceID] ASC),
    FOREIGN KEY ([ScooterID]) REFERENCES [dbo].[Scooters] ([ScooterID])
);


GO

