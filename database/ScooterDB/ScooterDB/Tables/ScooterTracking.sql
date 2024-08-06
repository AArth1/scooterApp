CREATE TABLE [dbo].[ScooterTracking] (
    [TrackingID]      INT               IDENTITY (1, 1) NOT NULL,
    [ScooterID]       INT               NOT NULL,
    [Timestamp]       DATETIME          NOT NULL,
    [Latitude]        FLOAT             NOT NULL,
    [Longitude]       FLOAT             NOT NULL,
    [CreatedAt]       DATETIME          DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]       DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([TrackingID] ASC),
    FOREIGN KEY ([ScooterID]) REFERENCES [dbo].[Scooters] ([ScooterID])
);


GO

