/*
GROUP MEMBERS

Jawad Ali      : 68626
Goveend Kumar  : 69504

Digit Extraction

68626 = 6+8+6+2+6 = 28
69504 = 6+9+5+0+4 = 24

Total = 28 + 24 = 52

Seed Number = 52 MOD 7 = 3

Database Name: Retail_3

Embedding Map

Reg ID     Embedded In        Column            Sample Value
68626      Products           ProductCode       PRD-68626
69504      Shipments          TrackingNumber    TRK-69504


SN=3 Anomaly: Negative Stock Values in WarehouseInventory

Additional Entities: Discounts, Claims

*/

CREATE DATABASE Retail_3;
GO
USE Retail_3;
GO

CREATE TABLE Regions
(
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(100) NOT NULL,
    Country VARCHAR(100) NOT NULL,
    Currency VARCHAR(20) NOT NULL
);
INSERT INTO Regions (RegionID, RegionName, Country, Currency) VALUES 
(1, 'Sindh', 'Pakistan', 'PKR'),
(2, 'Punjab', 'Pakistan', 'PKR'),
(3, 'Dubai', 'UAE', 'AED'),
(4, 'Riyadh', 'Saudi Arabia', 'SAR'),
(5, 'London', 'UK', 'GBP');
GO
SELECT 'Regions Table' AS TableName, COUNT(*) AS RecordCount FROM Regions;
SELECT * FROM Regions;
GO

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    DateOfBirth DATE,
    RegistrationDate DATE DEFAULT GETDATE(),
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);
INSERT INTO Customers (CustomerID, FullName, Email, Phone, DateOfBirth, RegistrationDate, RegionID) VALUES 
(1, 'Ahmed Ali', 'ahmed@gmail.com', '0300000001', '1985-01-15', '2026-06-01', 1),
(2, 'Sara Khan', 'sara@gmail.com', '0300000002', '1990-02-20', '2026-06-02', 2),
(3, 'Usman Shah', 'usman@gmail.com', '0300000003', '1988-03-25', '2026-06-03', 3),
(4, 'Ayesha Noor', 'ayesha@gmail.com', '0300000004', '1992-04-10', '2026-06-04', 4),
(5, 'Bilal Ahmed', 'bilal@gmail.com', '0300000005', '1987-05-05', '2026-06-05', 5),
(6, 'Hassan Raza', 'hassan@gmail.com', '0300000006', '1995-06-15', '2026-06-06', 1),
(7, 'Zain Ali', 'zain@gmail.com', '0300000007', '1991-07-20', '2026-06-07', 2),
(8, 'Fatima Noor', 'fatima@gmail.com', '0300000008', '1989-08-25', '2026-06-08', 3),
(9, 'Omar Sheikh', 'omar@gmail.com', '0300000009', '1993-09-10', '2026-06-09', 4),
(10, 'Nida Khan', 'nida@gmail.com', '0300000010', '1986-10-05', '2026-06-10', 5),
(11, 'Khalid Mehmood', 'khalid@gmail.com', '0300000011', '1994-11-15', '2026-06-11', 1),
(12, 'Sana Tariq', 'sana@gmail.com', '0300000012', '1988-12-20', '2026-06-12', 2),
(13, 'Faisal Qureshi', 'faisal@gmail.com', '0300000013', '1990-01-25', '2026-06-13', 3),
(14, 'Mehwish Ali', 'mehwish@gmail.com', '0300000014', '1996-02-10', '2026-06-14', 4),
(15, 'Asif Rana', 'asif@gmail.com', '0300000015', '1985-03-05', '2026-06-15', 5),
(16, 'Rabia Malik', 'rabia@gmail.com', '0300000016', '1992-04-15', '2026-06-16', 1),
(17, 'Imran Akhtar', 'imran@gmail.com', '0300000017', '1989-05-20', '2026-06-17', 2),
(18, 'Hina Aslam', 'hina@gmail.com', '0300000018', '1993-06-25', '2026-06-18', 3),
(19, 'Salman Mir', 'salman@gmail.com', '0300000019', '1987-07-10', '2026-06-19', 4),
(20, 'Nadia Hashmi', 'nadia@gmail.com', '0300000020', '1995-08-05', '2026-06-20', 5),
(21, 'Tariq Aziz', 'tariq@gmail.com', '0300000021', '1991-09-15', '2026-06-21', 1),
(22, 'Samina Parvez', 'samina@gmail.com', '0300000022', '1986-10-20', '2026-06-22', 2),
(23, 'Rizwan Anwar', 'rizwan@gmail.com', '0300000023', '1994-11-25', '2026-06-23', 3),
(24, 'Kiran Arif', 'kiran@gmail.com', '0300000024', '1988-12-10', '2026-06-24', 4),
(25, 'Danish Iqbal', 'danish@gmail.com', '0300000025', '1990-01-05', '2026-06-25', 5),
(26, 'Maryam Bukhari', 'maryam@gmail.com', '0300000026', '1992-02-15', '2026-06-26', 1),
(27, 'Naveed Ahmed', 'naveed@gmail.com', '0300000027', '1987-03-20', '2026-06-27', 2),
(28, 'Saima Masood', 'saima@gmail.com', '0300000028', '1993-04-25', '2026-06-28', 3),
(29, 'Fahad Ali', 'fahad@gmail.com', '0300000029', '1989-05-10', '2026-06-29', 4),
(30, 'Iqra Qasim', 'iqra@gmail.com', '0300000030', '1996-06-05', '2026-06-30', 5);
GO
SELECT 'Customers Table' AS TableName, COUNT(*) AS RecordCount FROM Customers;
SELECT TOP 5 * FROM Customers;
GO

CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    JobTitle VARCHAR(100),
    ManagerID INT NULL,
    HireDate DATE,
    RegionID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);
INSERT INTO Employees (EmployeeID, FullName, JobTitle, ManagerID, HireDate, RegionID) VALUES 
(1, 'Ali Raza', 'Manager', NULL, '2020-01-10', 1),
(2, 'Sara Khan', 'Supervisor', 1, '2021-03-15', 1),
(3, 'Usman Tariq', 'Staff', 2, '2022-06-01', 2),
(4, 'Ayesha Noor', 'Staff', 2, '2022-07-11', 2),
(5, 'Hamza Ali', 'Staff', 2, '2023-01-05', 3),
(6, 'Fatima Noor', 'Staff', 2, '2023-02-10', 3),
(7, 'Bilal Ahmed', 'Staff', 2, '2023-03-12', 4),
(8, 'Hassan Raza', 'Staff', 2, '2023-04-14', 4),
(9, 'Zainab Ali', 'Staff', 2, '2023-05-18', 5),
(10, 'Omar Sheikh', 'Staff', 2, '2023-06-20', 5),
(11, 'Nida Khan', 'Staff', 1, '2022-08-11', 1),
(12, 'Kashif Ali', 'Staff', 1, '2022-09-13', 2),
(13, 'Imran Shah', 'Staff', 1, '2022-10-17', 3),
(14, 'Laiba Fatima', 'Staff', 1, '2022-11-19', 4),
(15, 'Danish Raza', 'Staff', 1, '2023-01-21', 5),
(16, 'Sana Ahmed', 'Staff', 2, '2023-02-22', 1),
(17, 'Mujtaba Ali', 'Staff', 2, '2023-03-23', 2),
(18, 'Rida Noor', 'Staff', 2, '2023-04-24', 3),
(19, 'Saad Khan', 'Staff', 2, '2023-05-25', 4),
(20, 'Hina Ali', 'Staff', 2, '2023-06-26', 5);
GO
SELECT 'Employees Table' AS TableName, COUNT(*) AS RecordCount FROM Employees;
SELECT TOP 5 * FROM Employees;
GO

CREATE TABLE Warehouses
(
    WarehouseID INT PRIMARY KEY,
    WarehouseName VARCHAR(100),
    RegionID INT,
    Capacity INT CHECK (Capacity > 0),
    ManagerEmployeeID INT,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID),
    FOREIGN KEY (ManagerEmployeeID) REFERENCES Employees(EmployeeID)
);
INSERT INTO Warehouses (WarehouseID, WarehouseName, RegionID, Capacity, ManagerEmployeeID) VALUES 
(1, 'Karachi Hub', 1, 500, 1),
(2, 'Lahore Hub', 2, 600, 2),
(3, 'Dubai Hub', 3, 700, 3),
(4, 'Riyadh Hub', 4, 550, 4),
(5, 'London Hub', 5, 800, 5),
(6, 'Hyderabad Hub', 1, 450, 1),
(7, 'Multan Hub', 2, 400, 2),
(8, 'Sharjah Hub', 3, 650, 3),
(9, 'Jeddah Hub', 4, 500, 4),
(10, 'Manchester Hub', 5, 750, 5);
GO
SELECT 'Warehouses Table' AS TableName, COUNT(*) AS RecordCount FROM Warehouses;
SELECT * FROM Warehouses;
GO

CREATE TABLE Suppliers
(
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactEmail VARCHAR(150),
    RegionID INT,
    ContractStartDate DATE,
    FOREIGN KEY (RegionID) REFERENCES Regions(RegionID)
);
INSERT INTO Suppliers (SupplierID, SupplierName, ContactEmail, RegionID, ContractStartDate) VALUES 
(1, 'Alpha Traders', 'alpha@gmail.com', 1, '2021-01-01'),
(2, 'Beta Supplies', 'beta@gmail.com', 2, '2021-02-01'),
(3, 'Gamma Corp', 'gamma@gmail.com', 3, '2021-03-01'),
(4, 'Delta Imports', 'delta@gmail.com', 4, '2021-04-01'),
(5, 'Omega Goods', 'omega@gmail.com', 5, '2021-05-01'),
(6, 'Prime Traders', 'prime@gmail.com', 1, '2021-06-01'),
(7, 'Royal Supplies', 'royal@gmail.com', 2, '2021-07-01'),
(8, 'City Exporters', 'city@gmail.com', 3, '2021-08-01'),
(9, 'Global Trade', 'global@gmail.com', 4, '2021-09-01'),
(10, 'NextGen Supply', 'nextgen@gmail.com', 5, '2021-10-01');
GO
SELECT 'Suppliers Table' AS TableName, COUNT(*) AS RecordCount FROM Suppliers;
SELECT * FROM Suppliers;
GO

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductCode VARCHAR(50) UNIQUE,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2) CHECK (UnitPrice > 0),
    SupplierID INT,
    StockQuantity INT DEFAULT 0,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
INSERT INTO Products (ProductID, ProductCode, ProductName, Category, UnitPrice, SupplierID, StockQuantity) VALUES 
(1, 'PRD-68626', 'Laptop Pro', 'Electronics', 1200, 1, 50),
(2, 'PRD-1002', 'Smartphone X', 'Electronics', 800, 2, 60),
(3, 'PRD-1003', 'Tablet Plus', 'Electronics', 500, 3, 40),
(4, 'PRD-1004', 'Wireless Mouse', 'Accessories', 20, 4, 200),
(5, 'PRD-1005', 'Mechanical Keyboard', 'Accessories', 30, 5, 150),
(6, 'PRD-1006', '4K Monitor', 'Electronics', 300, 6, 70),
(7, 'PRD-1007', 'Laser Printer', 'Electronics', 250, 7, 30),
(8, 'PRD-1008', 'Office Desk', 'Furniture', 150, 8, 20),
(9, 'PRD-1009', 'Ergonomic Chair', 'Furniture', 100, 9, 25),
(10, 'PRD-1010', 'USB-C Cable', 'Accessories', 10, 10, 500),
(11, 'PRD-1011', 'WiFi Router', 'Electronics', 90, 1, 80),
(12, 'PRD-1012', 'SSD 1TB', 'Electronics', 110, 2, 90),
(13, 'PRD-1013', 'HDD 2TB', 'Electronics', 70, 3, 120),
(14, 'PRD-1014', 'RAM 16GB', 'Electronics', 60, 4, 110),
(15, 'PRD-1015', 'Graphics Card', 'Electronics', 600, 5, 15),
(16, 'PRD-1016', 'CPU i7', 'Electronics', 400, 6, 25),
(17, 'PRD-1017', 'Cooling Fan', 'Accessories', 15, 7, 300),
(18, 'PRD-1018', 'PC Case', 'Accessories', 50, 8, 60),
(19, 'PRD-1019', 'Power Supply', 'Electronics', 85, 9, 40),
(20, 'PRD-1020', 'Studio Mic', 'Accessories', 25, 10, 90),
(21, 'PRD-1021', 'Digital Camera', 'Electronics', 550, 1, 35),
(22, 'PRD-1022', 'Camera Tripod', 'Accessories', 45, 2, 75),
(23, 'PRD-1023', 'Noise Cancelling Headphones', 'Accessories', 95, 3, 85),
(24, 'PRD-1024', 'Bluetooth Speaker', 'Electronics', 120, 4, 65),
(25, 'PRD-1025', 'Smartwatch Pro', 'Electronics', 200, 5, 55),
(26, 'PRD-1026', 'Mini Projector', 'Electronics', 700, 6, 20),
(27, 'PRD-1027', 'Document Scanner', 'Electronics', 180, 7, 30),
(28, 'PRD-1028', 'SSD Enclosure', 'Accessories', 35, 8, 100),
(29, 'PRD-1029', 'Cable Management Kit', 'Accessories', 12, 9, 400),
(30, 'PRD-1030', '4K Webcam', 'Accessories', 55, 10, 95),
(31, 'PRD-1031', 'Gaming Monitor', 'Electronics', 450, 1, 45),
(32, 'PRD-1032', 'Wireless Charger', 'Accessories', 40, 2, 120),
(33, 'PRD-1033', 'Smart Home Hub', 'Electronics', 150, 3, 35);
GO
SELECT 'Products Table' AS TableName, COUNT(*) AS RecordCount FROM Products;
SELECT TOP 5 * FROM Products;
GO

CREATE TABLE Orders
(
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(30) DEFAULT 'Pending',
    WarehouseID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID)
);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status, WarehouseID) VALUES 
(1, 1, '2026-06-01', 1200.00, 'Completed', 1),
(2, 2, '2026-06-02', 800.00, 'Completed', 2),
(3, 3, '2026-06-03', 500.00, 'Completed', 3),
(4, 4, '2026-06-04', 300.00, 'Completed', 4),
(5, 5, '2026-06-05', 150.00, 'Completed', 5),
(6, 6, '2026-06-06', 90.00, 'Completed', 1),
(7, 7, '2026-06-07', 110.00, 'Completed', 2),
(8, 8, '2026-06-08', 70.00, 'Completed', 3),
(9, 9, '2026-06-09', 60.00, 'Completed', 4),
(10, 10, '2026-06-10', 85.00, 'Completed', 5),
(11, 11, '2026-06-11', 400.00, 'Completed', 1),
(12, 12, '2026-06-12', 600.00, 'Completed', 2),
(13, 13, '2026-06-13', 700.00, 'Completed', 3),
(14, 14, '2026-06-14', 200.00, 'Completed', 4),
(15, 15, '2026-06-15', 900.00, 'Completed', 5),
(16, 16, '2026-06-16', 1000.00, 'Completed', 1),
(17, 17, '2026-06-17', 1100.00, 'Completed', 2),
(18, 18, '2026-06-18', 120.00, 'Completed', 3),
(19, 19, '2026-06-19', 220.00, 'Completed', 4),
(20, 20, '2026-06-20', 330.00, 'Completed', 5),
(21, 21, '2026-06-21', 440.00, 'Completed', 1),
(22, 22, '2026-06-22', 550.00, 'Completed', 2),
(23, 23, '2026-06-23', 660.00, 'Completed', 3),
(24, 24, '2026-06-24', 770.00, 'Completed', 4),
(25, 25, '2026-06-25', 880.00, 'Completed', 5),
(26, 26, '2026-06-26', 990.00, 'Completed', 1),
(27, 27, '2026-06-27', 1010.00, 'Completed', 2),
(28, 28, '2026-06-28', 1110.00, 'Completed', 3),
(29, 29, '2026-06-29', 1210.00, 'Completed', 4),
(30, 30, '2026-06-30', 1310.00, 'Completed', 5),
(31, 1, '2026-07-01', 1410.00, 'Pending', 1),
(32, 2, '2026-07-02', 1510.00, 'Pending', 2),
(33, 3, '2026-07-03', 1610.00, 'Pending', 3),
(34, 4, '2026-07-04', 1710.00, 'Pending', 4),
(35, 5, '2026-07-05', 1810.00, 'Pending', 5),
(36, 6, '2026-07-06', 1900.00, 'Pending', 1),
(37, 7, '2026-07-07', 2000.00, 'Pending', 2),
(38, 8, '2026-07-08', 2100.00, 'Pending', 3),
(39, 9, '2026-07-09', 2200.00, 'Pending', 4),
(40, 10, '2026-07-10', 2300.00, 'Pending', 5);
GO
SELECT 'Orders Table' AS TableName, COUNT(*) AS RecordCount FROM Orders;
SELECT TOP 5 * FROM Orders;
GO

CREATE TABLE OrderDetails
(
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice) VALUES 
(1, 1, 1, 1, 1200),
(2, 2, 2, 1, 800),
(3, 3, 3, 1, 500),
(4, 4, 4, 2, 150),
(5, 5, 5, 3, 50),
(6, 6, 6, 1, 90),
(7, 7, 7, 1, 110),
(8, 8, 8, 1, 70),
(9, 9, 9, 1, 60),
(10, 10, 10, 1, 85),
(11, 11, 11, 1, 400),
(12, 12, 12, 1, 600),
(13, 13, 13, 1, 700),
(14, 14, 14, 2, 100),
(15, 15, 15, 1, 900),
(16, 16, 16, 1, 1000),
(17, 17, 17, 1, 1100),
(18, 18, 18, 2, 60),
(19, 19, 19, 2, 110),
(20, 20, 20, 3, 110),
(21, 21, 21, 1, 440),
(22, 22, 22, 1, 550),
(23, 23, 23, 1, 660),
(24, 24, 24, 2, 385),
(25, 25, 25, 1, 880),
(26, 26, 26, 1, 990),
(27, 27, 27, 1, 1010),
(28, 28, 28, 1, 1110),
(29, 29, 29, 2, 605),
(30, 30, 30, 3, 430),
(31, 31, 1, 1, 1410),
(32, 32, 2, 1, 1510),
(33, 33, 3, 1, 1610),
(34, 34, 4, 2, 855),
(35, 35, 5, 3, 605),
(36, 36, 6, 1, 1900),
(37, 37, 7, 1, 2000),
(38, 38, 8, 1, 2100),
(39, 39, 9, 2, 1100),
(40, 40, 10, 3, 770);
GO
SELECT 'OrderDetails Table' AS TableName, COUNT(*) AS RecordCount FROM OrderDetails;
SELECT TOP 5 * FROM OrderDetails;
GO

CREATE TABLE Payments
(
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    Status VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount, PaymentMethod, Status) VALUES 
(1, 1, '2026-06-01', 1200, 'Card', 'Paid'),
(2, 2, '2026-06-02', 800, 'Card', 'Paid'),
(3, 3, '2026-06-03', 500, 'Cash', 'Paid'),
(4, 4, '2026-06-04', 300, 'Card', 'Paid'),
(5, 5, '2026-06-05', 150, 'Cash', 'Paid'),
(6, 6, '2026-06-06', 90, 'Card', 'Paid'),
(7, 7, '2026-06-07', 110, 'Card', 'Paid'),
(8, 8, '2026-06-08', 70, 'Cash', 'Paid'),
(9, 9, '2026-06-09', 60, 'Card', 'Paid'),
(10, 10, '2026-06-10', 85, 'Cash', 'Paid'),
(11, 11, '2026-06-11', 400, 'Card', 'Paid'),
(12, 12, '2026-06-12', 600, 'Card', 'Paid'),
(13, 13, '2026-06-13', 700, 'Card', 'Paid'),
(14, 14, '2026-06-14', 200, 'Cash', 'Paid'),
(15, 15, '2026-06-15', 900, 'Card', 'Paid'),
(16, 16, '2026-06-16', 1000, 'Card', 'Paid'),
(17, 17, '2026-06-17', 1100, 'Card', 'Paid'),
(18, 18, '2026-06-18', 120, 'Cash', 'Paid'),
(19, 19, '2026-06-19', 220, 'Card', 'Paid'),
(20, 20, '2026-06-20', 330, 'Cash', 'Paid'),
(21, 21, '2026-06-21', 440, 'Card', 'Paid'),
(22, 22, '2026-06-22', 550, 'Card', 'Paid'),
(23, 23, '2026-06-23', 660, 'Card', 'Paid'),
(24, 24, '2026-06-24', 770, 'Cash', 'Paid'),
(25, 25, '2026-06-25', 880, 'Card', 'Paid'),
(26, 26, '2026-06-26', 990, 'Card', 'Paid'),
(27, 27, '2026-06-27', 1010, 'Card', 'Paid'),
(28, 28, '2026-06-28', 1110, 'Cash', 'Paid'),
(29, 29, '2026-06-29', 1210, 'Card', 'Paid'),
(30, 30, '2026-06-30', 1310, 'Cash', 'Paid'),
(31, 31, '2026-07-01', 1410, 'Card', 'Paid'),
(32, 32, '2026-07-02', 1510, 'Card', 'Paid'),
(33, 33, '2026-07-03', 1610, 'Card', 'Paid'),
(34, 34, '2026-07-04', 1710, 'Cash', 'Paid'),
(35, 35, '2026-07-05', 1810, 'Card', 'Paid'),
(36, 36, '2026-07-06', 1900, 'Card', 'Paid'),
(37, 37, '2026-07-07', 2000, 'Card', 'Paid'),
(38, 38, '2026-07-08', 2100, 'Card', 'Paid'),
(39, 39, '2026-07-09', 2200, 'Cash', 'Paid'),
(40, 40, '2026-07-10', 2300, 'Card', 'Paid');
GO
SELECT 'Payments Table' AS TableName, COUNT(*) AS RecordCount FROM Payments;
SELECT TOP 5 * FROM Payments;
GO

CREATE TABLE Shipments
(
    ShipmentID INT PRIMARY KEY,
    TrackingNumber VARCHAR(50),
    OrderID INT,
    ShipDate DATE,
    DeliveryDate DATE,
    TransportCost DECIMAL(10,2),
    CarrierName VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Shipments (ShipmentID, TrackingNumber, OrderID, ShipDate, DeliveryDate, TransportCost, CarrierName) VALUES 
(1, 'TRK-69504', 1, '2026-06-02', '2026-06-05', 50, 'DHL'),
(2, 'TRK-1002', 2, '2026-06-03', '2026-06-06', 60, 'FedEx'),
(3, 'TRK-1003', 3, '2026-06-04', '2026-06-07', 70, 'DHL'),
(4, 'TRK-1004', 4, '2026-06-05', '2026-06-08', 80, 'UPS'),
(5, 'TRK-1005', 5, '2026-06-06', '2026-06-09', 90, 'DHL'),
(6, 'TRK-1006', 6, '2026-06-07', '2026-06-10', 50, 'UPS'),
(7, 'TRK-1007', 7, '2026-06-08', '2026-06-11', 60, 'DHL'),
(8, 'TRK-1008', 8, '2026-06-09', '2026-06-12', 70, 'FedEx'),
(9, 'TRK-1009', 9, '2026-06-10', '2026-06-13', 80, 'UPS'),
(10, 'TRK-1010', 10, '2026-06-11', '2026-06-14', 90, 'DHL'),
(11, 'TRK-1011', 11, '2026-06-12', '2026-06-15', 45, 'FedEx'),
(12, 'TRK-1012', 12, '2026-06-13', '2026-06-16', 55, 'DHL'),
(13, 'TRK-1013', 13, '2026-06-14', '2026-06-17', 65, 'UPS'),
(14, 'TRK-1014', 14, '2026-06-15', '2026-06-18', 75, 'DHL'),
(15, 'TRK-1015', 15, '2026-06-16', '2026-06-19', 85, 'FedEx'),
(16, 'TRK-1016', 16, '2026-06-17', '2026-06-20', 50, 'UPS'),
(17, 'TRK-1017', 17, '2026-06-18', '2026-06-21', 60, 'DHL'),
(18, 'TRK-1018', 18, '2026-06-19', '2026-06-22', 70, 'FedEx'),
(19, 'TRK-1019', 19, '2026-06-20', '2026-06-23', 80, 'DHL'),
(20, 'TRK-1020', 20, '2026-06-21', '2026-06-24', 90, 'UPS'),
(21, 'TRK-1021', 21, '2026-06-22', '2026-06-25', 45, 'DHL'),
(22, 'TRK-1022', 22, '2026-06-23', '2026-06-26', 55, 'FedEx'),
(23, 'TRK-1023', 23, '2026-06-24', '2026-06-27', 65, 'UPS'),
(24, 'TRK-1024', 24, '2026-06-25', '2026-06-28', 75, 'DHL'),
(25, 'TRK-1025', 25, '2026-06-26', '2026-06-29', 85, 'FedEx'),
(26, 'TRK-1026', 26, '2026-06-27', '2026-06-30', 50, 'UPS'),
(27, 'TRK-1027', 27, '2026-06-28', '2026-07-01', 60, 'DHL'),
(28, 'TRK-1028', 28, '2026-06-29', '2026-07-02', 70, 'FedEx'),
(29, 'TRK-1029', 29, '2026-06-30', '2026-07-03', 80, 'DHL'),
(30, 'TRK-1030', 30, '2026-07-01', '2026-07-04', 90, 'UPS');
GO
SELECT 'Shipments Table' AS TableName, COUNT(*) AS RecordCount FROM Shipments;
SELECT TOP 5 * FROM Shipments;
GO

CREATE TABLE Discounts
(
    DiscountID INT PRIMARY KEY,
    ProductID INT,
    DiscountPercent DECIMAL(5,2),
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Discounts (DiscountID, ProductID, DiscountPercent, StartDate, EndDate) VALUES 
(1, 1, 10.00, '2026-06-01', '2026-06-30'),
(2, 2, 15.00, '2026-06-01', '2026-06-30'),
(3, 3, 5.00, '2026-06-15', '2026-07-15'),
(4, 4, 20.00, '2026-06-01', '2026-06-30'),
(5, 5, 10.00, '2026-06-01', '2026-06-30'),
(6, 6, 8.00, '2026-06-01', '2026-07-31'),
(7, 7, 12.00, '2026-06-15', '2026-07-15'),
(8, 8, 25.00, '2026-06-01', '2026-06-30'),
(9, 9, 5.00, '2026-06-01', '2026-06-30'),
(10, 10, 15.00, '2026-06-15', '2026-07-15'),
(11, 11, 10.00, '2026-06-01', '2026-07-31'),
(12, 12, 20.00, '2026-06-01', '2026-06-30'),
(13, 13, 8.00, '2026-06-01', '2026-06-30'),
(14, 14, 12.00, '2026-06-15', '2026-07-15'),
(15, 15, 15.00, '2026-06-01', '2026-06-30');
GO
SELECT 'Discounts Table' AS TableName, COUNT(*) AS RecordCount FROM Discounts;
SELECT * FROM Discounts;
GO

CREATE TABLE Claims
(
    ClaimID INT PRIMARY KEY,
    OrderID INT,
    ClaimDate DATE,
    ClaimReason VARCHAR(255),
    Status VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Claims (ClaimID, OrderID, ClaimDate, ClaimReason, Status) VALUES 
(1, 1, '2026-06-06', 'Product damaged during shipping', 'Open'),
(2, 2, '2026-06-07', 'Wrong item delivered', 'Open'),
(3, 3, '2026-06-08', 'Product defective', 'Pending'),
(4, 4, '2026-06-09', 'Late delivery', 'Resolved'),
(5, 5, '2026-06-10', 'Missing parts in package', 'Open'),
(6, 6, '2026-06-11', 'Product not as described', 'Pending'),
(7, 7, '2026-06-12', 'Damaged packaging', 'Resolved'),
(8, 8, '2026-06-13', 'Wrong quantity delivered', 'Open'),
(9, 9, '2026-06-14', 'Product expired', 'Pending'),
(10, 10, '2026-06-15', 'Shipping delay', 'Resolved'),
(11, 11, '2026-06-16', 'Quality issues', 'Open'),
(12, 12, '2026-06-17', 'Missing invoice', 'Pending'),
(13, 13, '2026-06-18', 'Wrong color delivered', 'Resolved'),
(14, 14, '2026-06-19', 'Product size mismatch', 'Open'),
(15, 15, '2026-06-20', 'Defective battery', 'Pending');
GO
SELECT 'Claims Table' AS TableName, COUNT(*) AS RecordCount FROM Claims;
SELECT * FROM Claims;
GO

CREATE TABLE WarehouseInventory
(
    InventoryID INT PRIMARY KEY,
    WarehouseID INT,
    ProductID INT,
    StockLevel INT,
    FOREIGN KEY (WarehouseID) REFERENCES Warehouses(WarehouseID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO WarehouseInventory (InventoryID, WarehouseID, ProductID, StockLevel) VALUES 
(1, 1, 1, -10),
(2, 2, 2, -15),
(3, 3, 3, -5),
(4, 4, 4, -20),
(5, 5, 5, -8),
(6, 1, 6, -12),
(7, 2, 7, -30),
(8, 3, 8, -25),
(9, 4, 9, -18),
(10, 5, 10, -22),
(11, 1, 11, -7),
(12, 2, 12, -14),
(13, 3, 13, -9),
(14, 4, 14, -16),
(15, 5, 15, -11);
GO
SELECT 'WarehouseInventory Table (ANOMALY)' AS TableName, COUNT(*) AS RecordCount FROM WarehouseInventory;
SELECT * FROM WarehouseInventory;
GO

CREATE TABLE AuditLog
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    OldAmount DECIMAL(10,2),
    NewAmount DECIMAL(10,2),
    DBUser VARCHAR(100),
    ChangeTime DATETIME
);
GO
SELECT 'AuditLog Table Created' AS Status;
SELECT * FROM AuditLog;
GO

IF OBJECT_ID('trg_payment_update', 'TR') IS NOT NULL
    DROP TRIGGER trg_payment_update;
GO

CREATE TRIGGER trg_payment_update
ON Payments
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @IsFromProc INT;
    BEGIN TRY
        SET @IsFromProc = CAST(SESSION_CONTEXT(N'FromProc') AS INT);
    END TRY
    BEGIN CATCH
        SET @IsFromProc = 0;
    END CATCH
    IF @IsFromProc IS NULL OR @IsFromProc = 0
    BEGIN
        INSERT INTO AuditLog(OrderID, OldAmount, NewAmount, DBUser, ChangeTime)
        SELECT 
            DELETED.OrderID,
            DELETED.Amount,
            INSERTED.Amount,
            SYSTEM_USER,
            GETDATE()
        FROM INSERTED
        INNER JOIN DELETED ON INSERTED.OrderID = DELETED.OrderID;
    END
END;
GO
SELECT 'Trigger trg_payment_update Created Successfully' AS Status;
GO

IF OBJECT_ID('CreateOrder', 'P') IS NOT NULL
    DROP PROCEDURE CreateOrder;
GO

CREATE PROCEDURE CreateOrder
    @pCustomer INT,
    @pProduct INT,
    @pQty INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @vStock INT;
    DECLARE @vPrice DECIMAL(10,2);
    DECLARE @vOrder INT;
    DECLARE @vEmployeeID INT;

    SELECT @vStock = StockQuantity, @vPrice = UnitPrice
    FROM Products
    WHERE ProductID = @pProduct;

    IF @vStock IS NULL
    BEGIN
        RAISERROR('Product not found', 16, 1);
        RETURN;
    END

    IF @vStock < @pQty
    BEGIN
        RAISERROR('Insufficient Stock. Available: %d, Requested: %d', 16, 1, @vStock, @pQty);
        RETURN;
    END

    BEGIN TRANSACTION;

    UPDATE Products
    SET StockQuantity = StockQuantity - @pQty
    WHERE ProductID = @pProduct;

    SELECT @vOrder = ISNULL(MAX(OrderID), 0) + 1 FROM Orders;

    SELECT TOP 1 @vEmployeeID = EmployeeID
    FROM Employees
    ORDER BY NEWID();

    EXEC sp_set_session_context 'FromProc', 1;

    INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status, WarehouseID)
    VALUES (@vOrder, @pCustomer, GETDATE(), @vPrice * @pQty, 'Completed', 1);

    INSERT INTO Payments (PaymentID, OrderID, PaymentDate, Amount, PaymentMethod, Status)
    VALUES ((SELECT ISNULL(MAX(PaymentID), 0) + 1 FROM Payments), @vOrder, GETDATE(), 
            @vPrice * @pQty, 'Card', 'Paid');

    INSERT INTO Shipments (ShipmentID, TrackingNumber, OrderID, ShipDate, DeliveryDate, 
                           TransportCost, CarrierName)
    VALUES ((SELECT ISNULL(MAX(ShipmentID), 0) + 1 FROM Shipments), 
            'AUTO-' + CAST(@vOrder AS VARCHAR(10)), @vOrder, 
            GETDATE(), DATEADD(DAY, 3, GETDATE()), 50, 'DHL');

    EXEC sp_set_session_context 'FromProc', 0;

    COMMIT TRANSACTION;

    SELECT @vOrder AS OrderID, 'Order created successfully! Fulfilled by Employee ID: ' + CAST(@vEmployeeID AS VARCHAR) AS Message;
END;
GO

WITH ProductPriceRank AS (
    SELECT 
        ProductID,
        ProductName,
        Category,
        UnitPrice,
        PERCENT_RANK() OVER (ORDER BY UnitPrice DESC) AS PricePercentile
    FROM Products
),
CategoryAge AS (
    SELECT 
        p.Category,
        AVG(DATEDIFF(YEAR, c.DateOfBirth, GETDATE())) AS AvgCategoryAge
    FROM Products p
    JOIN OrderDetails od ON p.ProductID = od.ProductID
    JOIN Orders o ON od.OrderID = o.OrderID
    JOIN Customers c ON o.CustomerID = c.CustomerID
    WHERE o.Status = 'Completed'
    GROUP BY p.Category
),
CompanyAvgAge AS (
    SELECT AVG(DATEDIFF(YEAR, DateOfBirth, GETDATE())) AS AvgAge
    FROM Customers
)
SELECT DISTINCT 
    p.ProductID,
    p.ProductCode,
    p.ProductName,
    p.Category,
    p.UnitPrice,
    ppr.PricePercentile
FROM Products p
JOIN ProductPriceRank ppr ON p.ProductID = ppr.ProductID
JOIN CategoryAge ca ON p.Category = ca.Category
CROSS JOIN CompanyAvgAge caa
WHERE 
    p.ProductID NOT IN (
        SELECT DISTINCT od.ProductID
        FROM OrderDetails od
        JOIN Orders o ON od.OrderID = o.OrderID
        WHERE o.Status = 'Completed'
    )
    AND p.ProductID IN (
        SELECT wi.ProductID
        FROM WarehouseInventory wi
        WHERE wi.StockLevel < 0
    )
    AND ppr.PricePercentile <= 0.20
    AND ca.AvgCategoryAge > caa.AvgAge
ORDER BY p.UnitPrice DESC;
GO


SELECT TOP 10
    c.CustomerID,
    c.FullName,
    r.RegionName,
    SUM(o.TotalAmount) AS TotalSpent,
    AVG(o.TotalAmount) AS AvgOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Regions r ON c.RegionID = r.RegionID
GROUP BY c.CustomerID, c.FullName, r.RegionName, r.RegionID
HAVING AVG(o.TotalAmount) > (
    SELECT AVG(o2.TotalAmount)
    FROM Orders o2
    JOIN Customers c2 ON o2.CustomerID = c2.CustomerID
    WHERE c2.RegionID = r.RegionID
    GROUP BY c2.RegionID
)
ORDER BY TotalSpent DESC;
GO

SELECT 
    c.CustomerID,
    c.FullName,
    r.RegionName,
    (SELECT SUM(o.TotalAmount) FROM Orders o WHERE o.CustomerID = c.CustomerID) AS TotalSpent,
    (SELECT AVG(o.TotalAmount) FROM Orders o WHERE o.CustomerID = c.CustomerID) AS AvgOrderValue
FROM Customers c
JOIN Regions r ON c.RegionID = r.RegionID
WHERE (
    SELECT AVG(o.TotalAmount) 
    FROM Orders o 
    WHERE o.CustomerID = c.CustomerID
) > (
    SELECT AVG(o2.TotalAmount)
    FROM Orders o2
    WHERE o2.CustomerID IN (
        SELECT c2.CustomerID 
        FROM Customers c2 
        WHERE c2.RegionID = c.RegionID
    )
)
ORDER BY TotalSpent DESC;
GO


WITH CustomerOrders AS (
    SELECT 
        c.CustomerID,
        c.FullName,
        (SELECT r.RegionName FROM Regions r WHERE r.RegionID = c.RegionID) AS RegionName,
        (SELECT r.RegionID FROM Regions r WHERE r.RegionID = c.RegionID) AS RegionID,
        o.OrderID,
        o.TotalAmount
    FROM Customers c
    CROSS JOIN Orders o
    WHERE o.CustomerID = c.CustomerID
),
CustomerAggregates AS (
    SELECT 
        CustomerID,
        FullName,
        RegionName,
        RegionID,
        SUM(TotalAmount) AS TotalSpent,
        AVG(TotalAmount) AS AvgOrderValue,
        AVG(AVG(TotalAmount)) OVER (PARTITION BY RegionID) AS RegionAvgOrderValue
    FROM CustomerOrders
    GROUP BY CustomerID, FullName, RegionName, RegionID
)
SELECT 
    CustomerID,
    FullName,
    RegionName,
    TotalSpent,
    AvgOrderValue,
    RegionAvgOrderValue
FROM CustomerAggregates
WHERE AvgOrderValue > RegionAvgOrderValue
ORDER BY TotalSpent DESC;
GO

EXEC CreateOrder @pCustomer = 1, @pProduct = 1, @pQty = 2;
GO

EXEC CreateOrder @pCustomer = 1, @pProduct = 1, @pQty = 100;
GO

EXEC CreateOrder @pCustomer = 1, @pProduct = 999, @pQty = 2;
GO



SELECT * FROM AuditLog;
GO


UPDATE Payments 
SET Amount = 999.99 
WHERE PaymentID = 1;
GO

SELECT * FROM AuditLog;
GO

SELECT 'Database Retail_3 Setup Complete' AS Status;
SELECT COUNT(*) AS TotalRegions FROM Regions;
SELECT COUNT(*) AS TotalCustomers FROM Customers;
SELECT COUNT(*) AS TotalEmployees FROM Employees;
SELECT COUNT(*) AS TotalWarehouses FROM Warehouses;
SELECT COUNT(*) AS TotalSuppliers FROM Suppliers;
SELECT COUNT(*) AS TotalProducts FROM Products;
SELECT COUNT(*) AS TotalOrders FROM Orders;
SELECT COUNT(*) AS TotalPayments FROM Payments;
SELECT COUNT(*) AS TotalShipments FROM Shipments;
SELECT COUNT(*) AS TotalDiscounts FROM Discounts;
SELECT COUNT(*) AS TotalClaims FROM Claims;
SELECT COUNT(*) AS TotalOrderDetails FROM OrderDetails;
SELECT COUNT(*) AS TotalInventoryRecords FROM WarehouseInventory;
SELECT COUNT(*) AS TotalAuditLogs FROM AuditLog;
GO

SELECT 'SN=3 Anomaly: Negative Stock Values' AS Anomaly;
SELECT wi.InventoryID, w.WarehouseName, p.ProductName, wi.StockLevel
FROM WarehouseInventory wi
JOIN Warehouses w ON wi.WarehouseID = w.WarehouseID
JOIN Products p ON wi.ProductID = p.ProductID
WHERE wi.StockLevel < 0
ORDER BY wi.StockLevel;
GO

SELECT 'Registration ID 68626 Embedded in ProductCode' AS Embedding;
SELECT ProductID, ProductCode, ProductName FROM Products WHERE ProductCode = 'PRD-68626';
GO

SELECT 'Registration ID 69504 Embedded in TrackingNumber' AS Embedding;
SELECT ShipmentID, TrackingNumber, OrderID FROM Shipments WHERE TrackingNumber = 'TRK-69504';
GO


SELECT 
    'Regions' AS TableName, COUNT(*) AS Count FROM Regions
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL
SELECT 'Warehouses', COUNT(*) FROM Warehouses
UNION ALL
SELECT 'Suppliers', COUNT(*) FROM Suppliers
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM OrderDetails
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments
UNION ALL
SELECT 'Shipments', COUNT(*) FROM Shipments
UNION ALL
SELECT 'Discounts', COUNT(*) FROM Discounts
UNION ALL
SELECT 'Claims', COUNT(*) FROM Claims
UNION ALL
SELECT 'WarehouseInventory', COUNT(*) FROM WarehouseInventory
UNION ALL
SELECT 'AuditLog', COUNT(*) FROM AuditLog
ORDER BY TableName;
GO

