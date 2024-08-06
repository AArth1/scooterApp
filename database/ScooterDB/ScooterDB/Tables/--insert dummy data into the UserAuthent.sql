--insert dummy data into the UserAuthentication table
INSERT INTO [ScooterDB].[dbo].[UserAuthentication] (Username, Password, UserID, Email, CreatedAt, UpdatedAt)
VALUES 
('john_doe', 'password123', 1, 'john.doe@example.com', GETDATE(), GETDATE()),
('jane_smith', 'password456', 2, 'jane.smith@example.com', GETDATE(), GETDATE()),
('alice_jones', 'password789', 3, 'alice.jones@example.com', GETDATE(), GETDATE()),
('bob_brown', 'password101', 4, 'bob.brown@example.com', GETDATE(), GETDATE()),
('charlie_black', 'password202', 5, 'charlie.black@example.com', GETDATE(), GETDATE());

select * from ScooterDB.dbo.UserAuthentication;

select * from ScooterDB.dbo.Scooters;

USE ScooterDB;
GO


-- Insert dummy data into Scooters table
INSERT INTO [ScooterDB].[dbo].[Scooters] (ScooterCode, Model, CurrentLocation, Battery, IsAvailable, BasePrice, PricePerMinute, Range, MaxSpeed, Distance, LastMaintenanceDate, CreatedAt, UpdatedAt)
VALUES 
('SC001', 'Model X', geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), 100, 1, 1.00, 0.15, 20.0, 25.0, 0.5, GETDATE(), GETDATE(), GETDATE()),
('SC002', 'Model Y', geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), 80, 1, 1.00, 0.15, 18.0, 22.0, 1.2, GETDATE(), GETDATE(), GETDATE()),
('SC003', 'Model Z', geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), 90, 1, 1.00, 0.15, 22.0, 24.0, 2.1, GETDATE(), GETDATE(), GETDATE()),
('SC004', 'Model A', geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), 85, 1, 1.00, 0.15, 25.0, 26.0, 3.0, GETDATE(), GETDATE(), GETDATE()),
('SC005', 'Model B', geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), 95, 1, 1.00, 0.15, 30.0, 28.0, 4.2, GETDATE(), GETDATE(), GETDATE());

select * from ScooterDB.dbo.ScooterTracking;

-- Enable CLR integration
-- CLR integration is enabled by default in SQL Server, so this command is not necessary.
-- Check if CLR integration is enabled
EXEC sp_configure 'clr enabled';
USE master;
GO

-- Enable CLR integration
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

USE ScooterDB;
GO

-- Insert dummy data into ScooterTracking table
INSERT INTO [ScooterDB].[dbo].[ScooterTracking] (ScooterID, Timestamp, CurrentLocation, CreatedAt, UpdatedAt)
VALUES 
(1, GETDATE(), geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), GETDATE(), GETDATE()),
(2, GETDATE(), geography::STGeomFromText('POINT(-122.34910 47.62060)', 4326), GETDATE(), GETDATE()),
(3, GETDATE(), geography::STGeomFromText('POINT(-122.34920 47.62070)', 4326), GETDATE(), GETDATE()),
(4, GETDATE(), geography::STGeomFromText('POINT(-122.34930 47.62080)', 4326), GETDATE(), GETDATE()),
(5, GETDATE(), geography::STGeomFromText('POINT(-122.34940 47.62090)', 4326), GETDATE(), GETDATE());

INSERT INTO [ScooterDB].[dbo].[Scooters] (
    [ScooterCode], 
    [Model], 
    [CurrentLocation], 
    [Battery], 
    [IsAvailable], 
    [BasePrice], 
    [PricePerMinute], 
    [Range], 
    [MaxSpeed], 
    [Distance], 
    [LastMaintenanceDate], 
    [CreatedAt], 
    [UpdatedAt]
) VALUES (
    'SC12345', 
    'ModelX', 
    geography::STGeomFromText('POINT(-122.34900 47.65100)', 4326), 
    100, 
    1, 
    1.00, 
    0.15, 
    25.00, 
    15.00, 
    100.00, 
    '2023-01-01 10:00:00', 
    GETDATE(), 
    GETDATE()
);

ALTER TABLE [ScooterDB].[dbo].[Scooters]
ADD [Latitude] FLOAT, [Longitude] FLOAT;

select * from ScooterDB.dbo.Scooters;

ALTER TABLE [ScooterDB].[dbo].[Scooters]
drop Column [CurrentLocation];

Select * from ScooterDB.dbo.Scooters;
--insert dummy data into ScooterDB.dbo.Scooters
INSERT INTO [ScooterDB].[dbo].[Scooters] (ScooterCode, Model, Latitude, Longitude, Battery, IsAvailable, BasePrice, PricePerMinute, Range, MaxSpeed, Distance, LastMaintenanceDate, CreatedAt, UpdatedAt)
-- Verify the columns are added
SELECT * FROM ScooterDB.dbo.Scooters;

INSERT INTO [ScooterDB].[dbo].[Scooters] 
(ScooterCode, Model, Latitude, Longitude, Battery, IsAvailable, BasePrice, PricePerMinute, Range, MaxSpeed, Distance, LastMaintenanceDate, CreatedAt, UpdatedAt)
VALUES 
('SC001', 'ModelX', 40.7128, -74.0060, 85, 1, 1.00, 0.15, 25, 15, 100, '2023-01-01', '2023-01-01', '2023-01-01'),
('SC002', 'ModelY', 34.0522, -118.2437, 90, 1, 1.20, 0.20, 30, 18, 150, '2023-02-01', '2023-02-01', '2023-02-01');
--insert 3 more rows of dummy data into the Scooters table
INSERT INTO [ScooterDB].[dbo].[Scooters]
(ScooterCode, Model, Latitude, Longitude, Battery, IsAvailable, BasePrice, PricePerMinute, Range, MaxSpeed, Distance, LastMaintenanceDate, CreatedAt, UpdatedAt)
VALUES 
('SC003', 'ModelZ', 37.7749, -122.4194, 95, 1, 1.50, 0.25, 35, 20, 200, '2023-03-01', '2023-03-01', '2023-03-01'),
('SC004', 'ModelA', 41.8781, -87.6298, 80, 1, 1.00, 0.15, 20, 15, 100, '2023-04-01', '2023-04-01', '2023-04-01'),
('SC005', 'ModelB', 33.4484, -112.0740, 75, 1, 1.20, 0.20, 25, 18, 150, '2023-05-01', '2023-05-01', '2023-05-01');

--insert 5 rows of dummy data into the ScooterTracking table
INSERT INTO [ScooterDB].[dbo].[ScooterTracking] (ScooterID, Timestamp, Latitude, Longitude, CreatedAt, UpdatedAt)
VALUES 
(1, GETDATE(), 40.7128, -74.0060, GETDATE(), GETDATE()),
(2, GETDATE(), 34.0522, -118.2437, GETDATE(), GETDATE()),
(3, GETDATE(), 37.7749, -122.4194, GETDATE(), GETDATE()),
(4, GETDATE(), 41.8781, -87.6298, GETDATE(), GETDATE()),
(5, GETDATE(), 33.4484, -112.0740, GETDATE(), GETDATE());
--check on ScooterTracking table
select * from ScooterDB.dbo.ScooterTracking;

--insert dummy data into the Rides table
INSERT INTO [ScooterDB].[dbo].[Rides] (UserID, ScooterID, StartTime, StartLatitude, StartLongitude, CostOfRide, CreatedAt, UpdatedAt)
VALUES 
(1, 1, GETDATE(), 40.7128, -74.0060, 5.00, GETDATE(), GETDATE()),
(2, 2, GETDATE(), 34.0522, -118.2437, 7.50, GETDATE(), GETDATE()),
(3, 3, GETDATE(), 37.7749, -122.4194, 10.00, GETDATE(), GETDATE()),
(4, 4, GETDATE(), 41.8781, -87.6298, 8.00, GETDATE(), GETDATE()),
(5, 5, GETDATE(), 33.4484, -112.0740, 6.00, GETDATE(), GETDATE());
--check on Rides table
select * from ScooterDB.dbo.Rides;

--insert dummy data into the ScooterIssues table
INSERT INTO [ScooterDB].[dbo].[ScooterIssues] (ScooterID, ReportedBy, IssueDate, Description, Status, CreatedAt, UpdatedAt)
VALUES 
(1, 1, GETDATE(), 'Battery issue', 'Open', GETDATE(), GETDATE()),
(2, 2, GETDATE(), 'Brake issue', 'Open', GETDATE(), GETDATE()),
(3, 3, GETDATE(), 'Tire issue', 'Open', GETDATE(), GETDATE()),
(4, 4, GETDATE(), 'Motor issue', 'Open', GETDATE(), GETDATE()),
(5, 5, GETDATE(), 'Light issue', 'Open', GETDATE(), GETDATE());
--check on ScooterIssues table
select * from ScooterDB.dbo.ScooterIssues;

--insert dummy data into the Geofences table
INSERT INTO [ScooterDB].[dbo].[Geofences] (Name, BoundaryLatitude, BoundaryLongitude, Type, CreatedAt, UpdatedAt)
VALUES 
('Geofence1', 40.7128, -74.0060, 'Circular', GETDATE(), GETDATE()),
('Geofence2', 34.0522, -118.2437, 'Circular', GETDATE(), GETDATE()),
('Geofence3', 37.7749, -122.4194, 'Circular', GETDATE(), GETDATE()),
('Geofence4', 41.8781, -87.6298, 'Circular', GETDATE(), GETDATE()),
('Geofence5', 33.4484, -112.0740, 'Circular', GETDATE(), GETDATE());
--check on Geofences table
select * from ScooterDB.dbo.Geofences;

--insert dummy data into the GeofenceViolations table
INSERT INTO [ScooterDB].[dbo].[GeofenceViolations] (UserID, ScooterID, GeofenceID, ViolationTime, ViolationType, CreatedAt, UpdatedAt)
VALUES 
(1, 1, 1, GETDATE(), 'Speeding', GETDATE(), GETDATE()),
(2, 2, 2, GETDATE(), 'Entering restricted area', GETDATE(), GETDATE()),
(3, 3, 3, GETDATE(), 'Leaving designated area', GETDATE(), GETDATE()),
(4, 4, 4, GETDATE(), 'Speeding', GETDATE(), GETDATE()),
(5, 5, 5, GETDATE(), 'Entering restricted area', GETDATE(), GETDATE());
--check on GeofenceViolations table
select * from ScooterDB.dbo.GeofenceViolations;

--insert dummy data into the MaintenanceRecords table
INSERT INTO [ScooterDB].[dbo].[MaintenanceRecords] (ScooterID, MaintenanceDate, Description, PerformedBy, CreatedAt, UpdatedAt)
VALUES 
(1, GETDATE(), 'Battery replacement', 'John Doe', GETDATE(), GETDATE()),
(2, GETDATE(), 'Brake repair', 'Jane Smith', GETDATE(), GETDATE()),
(3, GETDATE(), 'Tire replacement', 'Alice Jones', GETDATE(), GETDATE()),
(4, GETDATE(), 'Motor repair', 'Bob Brown', GETDATE(), GETDATE()),
(5, GETDATE(), 'Light replacement', 'Charlie Black', GETDATE(), GETDATE());
--check on MaintenanceRecords table
select * from ScooterDB.dbo.MaintenanceRecords;

--insert dummy data into the Rewards table
INSERT INTO [ScooterDB].[dbo].[Rewards] (UserID, RewardPoints, CreatedAt, UpdatedAt)
VALUES 
(1, 100, GETDATE(), GETDATE()),
(2, 150, GETDATE(), GETDATE()),
(3, 200, GETDATE(), GETDATE()),
(4, 250, GETDATE(), GETDATE()),
(5, 300, GETDATE(), GETDATE());

--check on Rewards table
select * from ScooterDB.dbo.Rewards;

--insert dummy data into the PaymentMethods table
INSERT INTO [ScooterDB].[dbo].[PaymentMethods] (UserID, MethodType, Provider, AccountNumber, ExpiryDate, CreatedAt, UpdatedAt)
VALUES 
(1, 'Credit Card', 'Visa', '1234567890', '2025-01-01', GETDATE(), GETDATE()),
(2, 'Debit Card', 'Mastercard', '0987654321', '2024-01-01', GETDATE(), GETDATE()),
(3, 'PayPal', 'PayPal', 'abcdef1234', '2023-01-01', GETDATE(), GETDATE()),
(4, 'Venmo', 'Venmo', '567890abcd', '2022-01-01', GETDATE(), GETDATE()),
(5, 'Apple Pay', 'Apple', '901234bcde', '2021-01-01', GETDATE(), GETDATE());
--check on PaymentMethods table
select * from ScooterDB.dbo.PaymentMethods;

--insert dummy data into the Payments table
INSERT INTO [ScooterDB].[dbo].[Payments] (UserID, RideID, PaymentMethodID, Amount, Status, CreatedAt, UpdatedAt)
VALUES 
(1, 1, 1, 5.00, 'Paid', GETDATE(), GETDATE()),
(2, 2, 2, 7.50, 'Paid', GETDATE(), GETDATE()),
(3, 3, 3, 10.00, 'Paid', GETDATE(), GETDATE()),
(4, 4, 4, 8.00, 'Paid', GETDATE(), GETDATE()),
(5, 5, 5, 6.00, 'Paid', GETDATE(), GETDATE());
--check on Payments table
select * from ScooterDB.dbo.Payments;

--insert dummy data into the Notifications table
INSERT INTO [ScooterDB].[dbo].[Notifications] (UserID, Message, NotificationType, IsRead, CreatedAt, UpdatedAt)
VALUES 
(1, 'New ride available', 'Ride', 0, GETDATE(), GETDATE()),
(2, 'Scooter issue reported', 'Issue', 0, GETDATE(), GETDATE()),
(3, 'Reward points earned', 'Reward', 0, GETDATE(), GETDATE()),
(4, 'Payment received', 'Payment', 0, GETDATE(), GETDATE()),
(5, 'Geofence violation detected', 'Violation', 0, GETDATE(), GETDATE());
--check on Notifications table
select * from ScooterDB.dbo.Notifications;

--check on dummy data from all tables
select * from ScooterDB.dbo.UserAuthentication;
select * from ScooterDB.dbo.UserManagement;
select * from ScooterDB.dbo.Scooters;
select * from ScooterDB.dbo.ScooterTracking;
select * from ScooterDB.dbo.Rides;
select * from ScooterDB.dbo.ScooterIssues;
select * from ScooterDB.dbo.Geofences;
select * from ScooterDB.dbo.GeofenceViolations;
select * from ScooterDB.dbo.MaintenanceRecords;
select * from ScooterDB.dbo.Rewards;
select * from ScooterDB.dbo.PaymentMethods;
select * from ScooterDB.dbo.Payments;
select * from ScooterDB.dbo.Notifications;
