CREATE TABLE [dbo].[Scooters] (
    [ScooterID]           INT               IDENTITY (1, 1) NOT NULL,
    [ScooterCode]         NVARCHAR (255)    NOT NULL,
    [Model]               NVARCHAR (255)    NOT NULL,
    [Latitude]            FLOAT             NOT NULL,
    [Longitude]           FLOAT             NOT NULL,
    [Battery]             INT               NOT NULL,
    [IsAvailable]         BIT               NOT NULL,
    [BasePrice]           DECIMAL (10, 2)   NOT NULL,
    [PricePerMinute]      DECIMAL (10, 2)   NOT NULL,
    [Range]               DECIMAL (10, 2)   NOT NULL,
    [MaxSpeed]            DECIMAL (10, 2)   NOT NULL,
    [Distance]            DECIMAL (10, 2)   NOT NULL,
    [LastMaintenanceDate] DATETIME          NOT NULL,
    [CreatedAt]           DATETIME          DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]           DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ScooterID] ASC)
);


GO

