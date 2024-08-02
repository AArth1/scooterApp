-- create scooter database
-- USE MASTER;
-- GO
 
-- CREATE Database ScooterDB;
-- GO
 
USE ScooterDB;
GO

DROP TABLE IF EXISTS UserAuthentication;
CREATE TABLE UserAuthentication (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL
);
DROP TABLE IF EXISTS UserManagement;
CREATE TABLE UserManagement (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    BillingAddress VARCHAR(255) NOT NULL,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID)
);
DROP TABLE IF EXISTS Scooters;
CREATE TABLE Scooters (
    ScooterID INT PRIMARY KEY IDENTITY(1,1),
    ScooterCode NVARCHAR(255) NOT NULL,
    Model NVARCHAR(255) NOT NULL,
    CurrentLocation GEOGRAPHY NOT NULL,
    Battery INT NOT NULL,
    IsAvailable BIT NOT NULL,
    BasePrice DECIMAL(10, 2) NOT NULL,
    PricePerMinute DECIMAL(10, 2) NOT NULL,
    Range DECIMAL(10, 2) NOT NULL,
    MaxSpeed DECIMAL(10, 2) NOT NULL,
    LastMaintenanceDate DATETIME NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
DROP TABLE IF EXISTS Rides;
CREATE TABLE Rides (
    RideID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ScooterID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME,
    StartLocation GEOGRAPHY NOT NULL,
    EndLocation GEOGRAPHY,
    CostOfRide DECIMAL(10, 2) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID),
    FOREIGN KEY (ScooterID) REFERENCES Scooters(ScooterID)
);
DROP TABLE IF EXISTS ScooterTracking;
CREATE TABLE ScooterTracking (
    TrackingID INT PRIMARY KEY IDENTITY(1,1),
    ScooterID INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    CurrentLocation GEOGRAPHY NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ScooterID) REFERENCES Scooters(ScooterID)
);
DROP TABLE IF EXISTS MaintenanceRecords;
CREATE TABLE MaintenanceRecords (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1),
    ScooterID INT NOT NULL,
    MaintenanceDate DATETIME NOT NULL,
    Description NVARCHAR(255) NOT NULL,
    PerformedBy NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ScooterID) REFERENCES Scooters(ScooterID)
);
DROP TABLE IF EXISTS ScooterIssues;
CREATE TABLE ScooterIssues (
    IssueID INT PRIMARY KEY IDENTITY(1,1),
    ScooterID INT NOT NULL,
    ReportedBy INT NOT NULL,
    IssueDate DATETIME NOT NULL,
    Description NVARCHAR(255) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ScooterID) REFERENCES Scooters(ScooterID),
    FOREIGN KEY (ReportedBy) REFERENCES UserAuthentication(UserID)
);
DROP TABLE IF EXISTS Notifications;
CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Message NVARCHAR(255) NOT NULL,
    NotificationType NVARCHAR(50) NOT NULL,
    SentAt DATETIME NOT NULL DEFAULT GETDATE(),
    IsRead BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID)
);
DROP TABLE IF EXISTS PaymentMethods;
CREATE TABLE PaymentMethods (
    PaymentMethodID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    MethodType NVARCHAR(50) NOT NULL,
    Provider NVARCHAR(50) NOT NULL,
    AccountNumber NVARCHAR(50) NOT NULL,
    ExpiryDate DATETIME NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID)
);
DROP TABLE IF EXISTS Payments;
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    RideID INT NOT NULL,
    PaymentMethodID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Status NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID),
    FOREIGN KEY (RideID) REFERENCES Rides(RideID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethods(PaymentMethodID)
);
DROP TABLE IF EXISTS Geofences;
CREATE TABLE Geofences (
    GeofenceID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Boundary GEOGRAPHY NOT NULL,
    Type NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
DROP TABLE IF EXISTS GeofenceViolations;
CREATE TABLE GeofenceViolations (
    ViolationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ScooterID INT NOT NULL,
    GeofenceID INT NOT NULL,
    ViolationTime DATETIME NOT NULL,
    ViolationType NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID),
    FOREIGN KEY (ScooterID) REFERENCES Scooters(ScooterID),
    FOREIGN KEY (GeofenceID) REFERENCES Geofences(GeofenceID)
);

-- Insert dummy data into UserAuthentication table
INSERT INTO UserAuthentication (UserID, Username, Password, FirstName, LastName, Email, CreatedAt, UpdatedAt)
VALUES 
(1,'john_doe', 'password123', 'John', 'Doe', 'john.doe@example.com', GETDATE(), GETDATE()),
(2,'jane_smith', 'password456', 'Jane', 'Smith', 'jane.smith@example.com', GETDATE(), GETDATE());

-- Insert dummy data into UserManagement table
INSERT INTO UserManagement (BillingAddress, CreatedAt, UpdatedAt, UserID)
VALUES 
('123 Main St', GETDATE(), GETDATE(), 1),
('456 Elm St', GETDATE(), GETDATE(), 2);

-- Insert dummy data into Scooters table
INSERT INTO Scooters (ScooterCode, Model, CurrentLocation, Battery, IsAvailable, BasePrice, PricePerMinute, Range, MaxSpeed, LastMaintenanceDate, CreatedAt, UpdatedAt)
VALUES 
('SC001', 'Model X', geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), 100, 1, 1.00, 0.15, 20.0, 25.0, GETDATE(), GETDATE(), GETDATE()),
('SC002', 'Model Y', geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), 80, 1, 1.00, 0.15, 18.0, 22.0, GETDATE(), GETDATE(), GETDATE());

-- Insert dummy data into Rides table
INSERT INTO Rides (UserID, ScooterID, StartTime, EndTime, StartLocation, EndLocation, CostOfRide, CreatedAt)
VALUES 
(1, 1, GETDATE(), NULL, geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), NULL, 0.00, GETDATE()),
(2, 2, GETDATE(), NULL, geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), NULL, 0.00, GETDATE());

-- Insert dummy data into ScooterTracking table
INSERT INTO ScooterTracking (ScooterID, Timestamp, CurrentLocation, CreatedAt, UpdatedAt)
VALUES 
(1, GETDATE(), geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), GETDATE(), GETDATE()),
(2, GETDATE(), geography::STGeomFromText('POINT(-122.34900 47.62050)', 4326), GETDATE(), GETDATE());

-- Insert dummy data into MaintenanceRecords table
INSERT INTO MaintenanceRecords (ScooterID, MaintenanceDate, Description, PerformedBy, CreatedAt, UpdatedAt)
VALUES 
(1, GETDATE(), 'Battery replacement', 'Technician A', GETDATE(), GETDATE()),
(2, GETDATE(), 'Tire replacement', 'Technician B', GETDATE(), GETDATE());

-- Insert dummy data into ScooterIssues table
INSERT INTO ScooterIssues (ScooterID, ReportedBy, IssueDate, Description, Status, CreatedAt, UpdatedAt)
VALUES 
(1, 1, GETDATE(), 'Battery not charging', 'Open', GETDATE(), GETDATE()),
(2, 2, GETDATE(), 'Flat tire', 'Open', GETDATE(), GETDATE());

-- Insert dummy data into Notifications table
INSERT INTO Notifications (UserID, Message, NotificationType, SentAt, IsRead)
VALUES 
(1, 'Your ride has started', 'Ride', GETDATE(), 0),
(2, 'Your scooter is ready for pickup', 'Maintenance', GETDATE(), 0);

-- Insert dummy data into PaymentMethods table
INSERT INTO PaymentMethods (UserID, MethodType, Provider, AccountNumber, ExpiryDate, CreatedAt, UpdatedAt)
VALUES 
(1, 'Credit Card', 'Visa', '1234567890', GETDATE(), GETDATE(), GETDATE()),
(2, 'PayPal', 'PayPal', '1234567898', GETDATE(), GETDATE(), GETDATE());

-- Insert dummy data into Payments table
INSERT INTO Payments (UserID, RideID, PaymentMethodID, Amount, Status, CreatedAt, UpdatedAt)
VALUES 
(1, 1, 1, 0.00, 'Pending', GETDATE(), GETDATE()),
(2, 2, 2, 0.00, 'Pending', GETDATE(), GETDATE());

-- Insert dummy data into Geofences table
INSERT INTO Geofences (Name, Boundary, Type, CreatedAt, UpdatedAt)
VALUES 
('Downtown Area', geography::STGeomFromText('POLYGON((-122.34900 47.62050, -122.34900 47.62060, -122.34910 47.62060, -122.34910 47.62050, -122.34900 47.62050))', 4326), 'Restricted', GETDATE(), GETDATE()),
('University Area', geography::STGeomFromText('POLYGON((-122.34900 47.62050, -122.34900 47.62060, -122.34910 47.62060, -122.34910 47.62050, -122.34900 47.62050))', 4326), 'Restricted', GETDATE(), GETDATE());

-- Insert dummy data into GeofenceViolations table
INSERT INTO GeofenceViolations (UserID, ScooterID, GeofenceID, ViolationTime, ViolationType, CreatedAt, UpdatedAt)
VALUES 
(1, 1, 1, GETDATE(), 'Entry', GETDATE(), GETDATE()),
(2, 2, 2, GETDATE(), 'Exit', GETDATE(), GETDATE());

