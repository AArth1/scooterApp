CREATE TABLE [dbo].[Geofences] (
    [GeofenceID] INT               IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (255)    NOT NULL,
    [Boundary]   [sys].[geography] NOT NULL,
    [Type]       NVARCHAR (50)     NOT NULL,
    [CreatedAt]  DATETIME          DEFAULT (getdate()) NOT NULL,
    [UpdatedAt]  DATETIME          DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([GeofenceID] ASC)
);


GO

