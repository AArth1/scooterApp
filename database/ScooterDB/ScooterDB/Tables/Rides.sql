CREATE TABLE [dbo].[Rides] (
    [RideID]        INT               IDENTITY (1, 1) NOT NULL,
    [UserID]        INT               NOT NULL,
    [ScooterID]     INT               NOT NULL,
    [StartTime]     DATETIME          NOT NULL,
    [EndTime]       DATETIME          NULL,
    [StartLatitude] FLOAT             NOT NULL,
    [StartLongitude] FLOAT            NOT NULL,
    [EndLatitude]   FLOAT             NULL,
    [EndLongitude]  FLOAT             NULL,
    [CostOfRide]    DECIMAL (10, 2)   NOT NULL,
    [CreatedAt]     DATETIME          DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]     DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([RideID] ASC),
    FOREIGN KEY ([ScooterID]) REFERENCES [dbo].[Scooters] ([ScooterID]),
    FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserAuthentication] ([UserID])
);


GO

