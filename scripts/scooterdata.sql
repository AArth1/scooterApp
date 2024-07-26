-- create scooter database
USE MASTER;
GO
 
CREATE Database ScooterDB;
GO
 
USE ScooterDB;
GO

CREATE TABLE UserAuthentication (
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    UserID INT NOT NULL,
    Email VARCHAR(255) NOT NULL,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE UserManagement (
    UserID INT NOT NULL,
    BillingAddress VARCHAR(255) NOT NULL,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME NOT NULL,
    PRIMARY KEY (UserID),
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID)
);

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

CREATE TABLE ScooterTracking (
    TrackingID INT PRIMARY KEY IDENTITY(1,1),
    ScooterID INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    CurrentLocation GEOGRAPHY NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ScooterID) REFERENCES Scooters(ScooterID)
);

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

CREATE TABLE Geofences (
    GeofenceID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Boundary GEOGRAPHY NOT NULL,
    Type NVARCHAR(50) NOT NULL, -- e.g., 'No Parking', 'Slow Zone', 'No Ride Zone'
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE GeofenceViolations (
    ViolationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ScooterID INT NOT NULL,
    GeofenceID INT NOT NULL,
    ViolationTime DATETIME NOT NULL,
    ViolationType NVARCHAR(50) NOT NULL, -- e.g., 'Entered No Ride Zone', 'Exited Slow Zone'
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID),
    FOREIGN KEY (ScooterID) REFERENCES Scooters(ScooterID),
    FOREIGN KEY (GeofenceID) REFERENCES Geofences(GeofenceID)
);

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

CREATE TABLE ScooterIssues (
    IssueID INT PRIMARY KEY IDENTITY(1,1),
    ScooterID INT NOT NULL,
    ReportedBy INT NOT NULL, -- UserID or EmployeeID
    IssueDate DATETIME NOT NULL,
    Description NVARCHAR(255) NOT NULL,
    Status NVARCHAR(50) NOT NULL, -- e.g., 'Reported', 'In Progress', 'Resolved'
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (ScooterID) REFERENCES Scooters(ScooterID),
    FOREIGN KEY (ReportedBy) REFERENCES UserAuthentication(UserID) -- Assuming UserAuthentication table for users
);

CREATE TABLE Notifications (
    NotificationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    Message NVARCHAR(255) NOT NULL,
    NotificationType NVARCHAR(50) NOT NULL, -- e.g., 'Ride Update', 'Payment Reminder', 'Promotion'
    SentAt DATETIME NOT NULL DEFAULT GETDATE(),
    IsRead BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES UserAuthentication(UserID)
);

