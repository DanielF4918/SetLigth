CREATE DATABASE SetLight;
GO

USE SetLight;
GO

-- Table Roles
CREATE TABLE Roles (
    RoleId INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(100) NOT NULL
);

-- Table Users
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Password NVARCHAR(100) NOT NULL,
    RoleId INT FOREIGN KEY REFERENCES Roles(RoleId)
);

-- Table Clients
CREATE TABLE Clients (
    ClientId INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20),
    Email NVARCHAR(100)
);

-- Table RentalOrderStatus
CREATE TABLE RentalOrderStatus (
    StatusId INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(100) NOT NULL
);

-- Table RentalOrders
CREATE TABLE RentalOrders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    StatusId INT FOREIGN KEY REFERENCES RentalOrderStatus(StatusId),
    ClientId INT FOREIGN KEY REFERENCES Clients(ClientId)
);

-- Table OrderDetails
CREATE TABLE OrderDetails (
    DetailId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT FOREIGN KEY REFERENCES RentalOrders(OrderId),
    EquipmentId INT,
    Quantity INT NOT NULL
);

-- Table EquipmentCategories
CREATE TABLE EquipmentCategories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL
);

-- Table EquipmentStatus
CREATE TABLE EquipmentStatus (
    StatusId INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(100) NOT NULL
);

-- Table Equipment
CREATE TABLE Equipment (
    EquipmentId INT PRIMARY KEY IDENTITY(1,1),
    EquipmentName NVARCHAR(100) NOT NULL,
    Brand NVARCHAR(100),
    Model NVARCHAR(100),
    SerialNumber NVARCHAR(100),
    Description NVARCHAR(MAX),
    CategoryId INT FOREIGN KEY REFERENCES EquipmentCategories(CategoryId),
    StatusId INT FOREIGN KEY REFERENCES EquipmentStatus(StatusId)
);

-- Add FK to OrderDetails for EquipmentId
ALTER TABLE OrderDetails ADD CONSTRAINT FK_OrderDetails_Equipment FOREIGN KEY (EquipmentId) REFERENCES Equipment(EquipmentId);

-- Table EquipmentHistory
CREATE TABLE EquipmentHistory (
    HistoryId INT PRIMARY KEY IDENTITY(1,1),
    EquipmentId INT FOREIGN KEY REFERENCES Equipment(EquipmentId),
    ChangeDate DATE NOT NULL,
    Notes NVARCHAR(MAX)
);

-- Table MaintenanceTypes
CREATE TABLE MaintenanceTypes (
    MaintenanceTypeId INT PRIMARY KEY IDENTITY(1,1),
    TypeName NVARCHAR(100) NOT NULL
);

-- Table MaintenanceStatus
CREATE TABLE MaintenanceStatus (
    MaintenanceStatusId INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(100) NOT NULL
);

-- Table Maintenance
CREATE TABLE Maintenance (
    MaintenanceId INT PRIMARY KEY IDENTITY(1,1),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    MaintenanceTypeId INT FOREIGN KEY REFERENCES MaintenanceTypes(MaintenanceTypeId),
    MaintenanceStatusId INT FOREIGN KEY REFERENCES MaintenanceStatus(MaintenanceStatusId),
    EquipmentId INT FOREIGN KEY REFERENCES Equipment(EquipmentId)
);
