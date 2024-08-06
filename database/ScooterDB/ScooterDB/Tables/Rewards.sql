CREATE TABLE [dbo].[Rewards]
(
  [RewardID] INT IDENTITY(1,1) NOT NULL,
  [UserID] INT NOT NULL,
  [RewardPoints] INT NOT NULL,
  [CreatedAt] DATETIME NOT NULL,
  [UpdatedAt] DATETIME NOT NULL,
  PRIMARY KEY CLUSTERED ([RewardID] ASC),
  FOREIGN KEY ([UserID]) REFERENCES [dbo].[UserAuthentication] ([UserID])
)
