CREATE TABLE [dbo].[UserAuthentication] (
    [Username]  VARCHAR (255) NOT NULL,
    [Password]  VARCHAR (255) NOT NULL,
    [UserID]    INT           NOT NULL,
    [Email]     VARCHAR (255) NOT NULL,
    [CreatedAt] DATETIME      NOT NULL,
    [UpdatedAt] DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([UserID] ASC)
);


GO

