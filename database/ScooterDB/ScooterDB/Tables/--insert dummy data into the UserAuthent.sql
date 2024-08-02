--insert dummy data into the UserAuthentication table
INSERT INTO [ScooterDB].[dbo].[UserAuthentication] (Username, Password, UserID, Email, CreatedAt, UpdatedAt)
VALUES 
('john_doe', 'password123', 1, 'john.doe@example.com', GETDATE(), GETDATE()),
('jane_smith', 'password456', 2, 'jane.smith@example.com', GETDATE(), GETDATE()),
('alice_jones', 'password789', 3, 'alice.jones@example.com', GETDATE(), GETDATE()),
('bob_brown', 'password101', 4, 'bob.brown@example.com', GETDATE(), GETDATE()),
('charlie_black', 'password202', 5, 'charlie.black@example.com', GETDATE(), GETDATE());

select * from ScooterDB.dbo.UserAuthentication;

--insert dummy data into the UserManagement table
INSERT INTO [ScooterDB].[dbo].[UserManagement] (UserID, BillingAddress, CreatedAt, UpdatedAt)
VALUES 
(1, '123 Main St, Springfield, IL', GETDATE(), GETDATE()),
(2, '456 Elm St, Springfield, IL', GETDATE(), GETDATE()),
(3, '789 Oak St, Springfield, IL', GETDATE(), GETDATE()),
(4, '101 Maple St, Springfield, IL', GETDATE(), GETDATE()),
(5, '202 Pine St, Springfield, IL', GETDATE(), GETDATE());

select * from ScooterDB.dbo.UserManagement;

--insert dummy data into the Scooters table
INSERT INTO [ScooterDB].[dbo].[Scooters] (ScooterCode, Model, CurrentLocation, Battery, IsAvailable, BasePrice, PricePerMinute, Range, MaxSpeed, LastMaintenanceDate, CreatedAt, UpdatedAt) VALUES 
('SC001', 'Model A', geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), 100, 1, 1.00, 0.15, 20.00, 15.00, GETDATE(), GETDATE(), GETDATE()),
('SC002', 'Model B', geography::STGeomFromText('POINT(-122.34910 47.62060)', 4326), 90, 1, 1.20, 0.20, 25.00, 18.00, GETDATE(), GETDATE(), GETDATE()),
('SC003', 'Model C', geography::STGeomFromText('POINT(-122.34920 47.62070)', 4326), 80, 1, 1.50, 0.25, 30.00, 20.00, GETDATE(), GETDATE(), GETDATE()),
('SC004', 'Model D', geography::STGeomFromText('POINT(-122.34930 47.62080)', 4326), 70, 1, 1.80, 0.30, 35.00, 22.00, GETDATE(), GETDATE(), GETDATE()),
('SC005', 'Model E', geography::STGeomFromText('POINT(-122.34940 47.62090)', 4326), 60, 1, 2.00, 0.35, 40.00, 25.00, GETDATE(), GETDATE(), GETDATE());

-- Enable CLR
sp_configure 'clr enabled', 1;
RECONFIGURE;

select * from ScooterDB.dbo.Scooters;

