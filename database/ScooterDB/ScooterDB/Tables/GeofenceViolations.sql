CREATE TABLE [dbo].[GeofenceViolations] (
    [ViolationID]   INT           IDENTITY (1, 1) NOT NULL,
    [UserID]        INT           NOT NULL,
    [ScooterID]     INT           NOT NULL,
    [GeofenceID]    INT           NOT NULL,
    [ViolationTime] DATETIME      NOT NULL,
    [ViolationType] NVARCHAR (50) NOT NULL,
    [CreatedAt]     DATETIME      DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]     DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ViolationID] ASC),
    FOREIGN KEY ([GeofenceID]) REFERENCES [dbo].[Geofences] ([GeofenceID]),
    FOREIGN KEY ([ScooterID]) REFERENCES [dbo].[Scooters] ([ScooterID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserAuthentication] ([UserID])
);


GO

