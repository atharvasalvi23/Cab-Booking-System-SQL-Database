-- 🚖 Cab Booking Relational Database & Analytics Project
-- Author: Atharva Salvi
--Description: Database schema, sample data insertion, and analytical SQL queries

CREATE DATABASE CabBookingSystem;
USE CabBookingSystem;

-- TABLE CREATION

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    RegistrationDate DATE NOT NULL DEFAULT (CURRENT_DATE));

CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    LicenseNumber VARCHAR(50) UNIQUE NOT NULL,
    VehicleType VARCHAR(20) NOT NULL,
    Rating DECIMAL(3,2));

CREATE TABLE Cabs (
    CabID INT PRIMARY KEY,
    DriverID INT,
    LicensePlate VARCHAR(20) UNIQUE NOT NULL,
    VehicleType VARCHAR(20) NOT NULL,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID) ON DELETE SET NULL);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    CabID INT NOT NULL,
    BookingDate DATE NOT NULL,
    PickupLocation VARCHAR(100) NOT NULL,
    DropoffLocation VARCHAR(100) NOT NULL,
    Fare DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (CabID) REFERENCES Cabs(CabID));

CREATE TABLE TripDetails (
    TripID INT PRIMARY KEY,
    BookingID INT NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    Distance DECIMAL(10,2) NOT NULL,
    TripFare DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID));

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    BookingID INT NOT NULL,
    CustomerID INT NOT NULL,
    DriverID INT NOT NULL,
    Rating DECIMAL(3,2),
    Comments TEXT,
    FeedbackDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID));

-- SAMPLE DATA INSERTION

INSERT INTO Customers 
(CustomerID, FirstName, LastName, Email, Phone, RegistrationDate) 
VALUES
(1, 'Aarav', 'Sharma', 'aarav.s@email.com', '9876543210', '2025-01-10'),
(2, 'Priya', 'Patel', 'priya.p@email.com', '9876543211', '2025-01-12'),
(3, 'John', 'Smith', 'john.smith@email.com', '9876543212', '2025-01-15'),
(4, 'Ananya', 'Iyer', 'ananya.i@email.com', '9876543213', '2025-01-20'),
(5, 'Rahul', 'Verma', 'rahul.v@email.com', '9876543214', '2025-01-22'),
(6, 'Sita', 'Smith', 'sita.s@email.com', '9876543215', '2025-01-25'),
(7, 'Vikram', 'Singh', 'vikram.s@email.com', '9876543216', '2025-02-01'),
(8, 'Sneha', 'Reddy', 'sneha.r@email.com', '9876543217', '2025-02-03'),
(9, 'Ishaan', 'Gupta', 'ishaan.g@email.com', '9876543218', '2025-02-05'),
(10, 'Rohan', 'Mehta', 'rohan.m@email.com', '9876543219', '2025-02-07');

INSERT INTO Drivers 
(DriverID, FirstName, LastName, Email, Phone, LicenseNumber, VehicleType, Rating) 
VALUES
(1, 'Amit', 'Kumar', 'amit.k@cabs.com', '9998887770', 'DL-12345', 'Sedan', 4.50),
(2, 'Sumit', 'Negi', 'sumit.n@cabs.com', '9998887771', 'DL-23456', 'SUV', 4.20),
(3, 'Rajesh', 'Yadav', 'rajesh.y@cabs.com', '9998887772', 'DL-34567', 'Sedan', 4.85),
(4, 'Vijay', 'Khanna', 'vijay.k@cabs.com', '9998887773', 'DL-45678', 'SUV', 3.90),
(5, 'Arjun', 'Puri', 'arjun.p@cabs.com', '9998887774', 'DL-56789', 'SUV', 4.10),
(6, 'Karan', 'Sethi', 'karan.s@cabs.com', '9998887775', 'DL-67890', 'Sedan', 4.95),
(7, 'Deepak', 'Joshi', 'deepak.j@cabs.com', '9998887776', 'DL-78901', 'Hatchback', 3.50),
(8, 'Manish', 'Goel', 'manish.g@cabs.com', '9998887777', 'DL-89012', 'Sedan', 4.40),
(9, 'Sanjay', 'Dutt', 'sanjay.d@cabs.com', '9998887778', 'DL-90123', 'SUV', 4.60),
(10, 'Sunil', 'Grover', 'sunil.g@cabs.com', '9998887779', 'DL-01234', 'Sedan', 4.30);

INSERT INTO Cabs 
(CabID, DriverID, LicensePlate, VehicleType) 
VALUES
(101, 1, 'MH-01-AA-1111', 'Sedan'),
(102, 2, 'MH-01-BB-2222', 'SUV'),
(103, 3, 'MH-01-CC-3333', 'Sedan'),
(104, 4, 'MH-01-DD-4444', 'SUV'),
(105, 5, 'MH-01-EE-5555', 'SUV'),
(106, 6, 'MH-01-FF-6666', 'Sedan'),
(107, 7, 'MH-01-GG-7777', 'Hatchback'),
(108, 8, 'MH-01-HH-8888', 'Sedan'),
(109, 9, 'MH-01-II-9999', 'SUV'),
(110, 10, 'MH-01-JJ-0000', 'Sedan');

INSERT INTO Bookings 
(BookingID, CustomerID, CabID, BookingDate, PickupLocation, DropoffLocation, Fare, Status) 
VALUES
(501, 1, 101, '2026-02-01', 'Andheri', 'Bandra', 350.00, 'Completed'),
(502, 1, 103, '2026-02-02', 'Bandra', 'Airport', 600.00, 'Completed'),
(503, 1, 106, '2026-02-03', 'Airport', 'Dadar', 450.00, 'Completed'),
(504, 1, 108, '2026-02-04', 'Dadar', 'Andheri', 300.00, 'Completed'),
(505, 3, 102, '2026-02-05', 'Powai', 'Vashi', 80.00, 'Completed'),
(506, 5, 105, '2026-02-06', 'Colaba', 'Worli', 150.00, 'In Progress'),
(507, 7, 109, '2026-02-07', 'Mulund', 'Thane', 25.00, 'Completed'),
(508, 2, 110, '2026-02-07', 'Kurla', 'Sion', 120.00, 'In Progress'),
(509, 4, 104, '2026-02-08', 'Juhu', 'Versova', 90.00, 'Cancelled'),
(510, 6, 107, '2026-02-08', 'Borivali', 'Kandivali', 60.00, 'Completed');

INSERT INTO TripDetails 
(TripID, BookingID, StartTime, EndTime, Distance, TripFare) 
VALUES
(1, 501, '2026-02-01 10:00:00', '2026-02-01 10:45:00', 12.5, 350.00),
(2, 502, '2026-02-02 11:00:00', '2026-02-02 12:00:00', 25.0, 600.00),
(3, 503, '2026-02-03 09:00:00', '2026-02-03 09:30:00', 8.0, 450.00),
(4, 504, '2026-02-04 18:00:00', '2026-02-04 18:45:00', 10.0, 300.00),
(5, 505, '2026-02-05 14:00:00', '2026-02-05 15:30:00', 30.5, 80.00),
(6, 507, '2026-02-07 08:00:00', '2026-02-07 08:20:00', 5.0, 25.00),
(7, 510, '2026-02-08 12:00:00', '2026-02-08 12:15:00', 3.0, 60.00),
(8, 501, '2026-02-01 10:00:00', '2026-02-01 10:45:00', 12.5, 350.00),
(9, 502, '2026-02-02 11:00:00', '2026-02-02 12:00:00', 25.0, 600.00),
(10, 503, '2026-02-03 09:00:00', '2026-02-03 09:30:00', 8.0, 450.00);

INSERT INTO Feedback 
(FeedbackID, BookingID, CustomerID, DriverID, Rating, Comments, FeedbackDate) 
VALUES
(1, 501, 1, 1, 4.50, 'Good drive.', '2026-02-01'),
(2, 502, 1, 3, 5.00, 'Excellent service!', '2026-02-02'),
(3, 503, 1, 6, 4.80, 'Driver was polite.', '2026-02-03'),
(4, 505, 3, 2, 3.20, 'Vehicle was a bit dirty.', '2026-02-05'),
(5, 507, 7, 9, 4.90, 'Very fast and safe.', '2026-02-07'),
(6, 510, 6, 7, 2.50, 'Delayed pickup.', '2026-02-08'),
(7, 504, 1, 8, 4.00, 'Satisfied.', '2026-02-04'),
(8, 501, 1, 1, 4.20, 'Consistent.', '2026-02-01'),
(9, 502, 1, 3, 4.70, 'Nice.', '2026-02-02'),
(10, 503, 1, 6, 5.00, 'Perfect.', '2026-02-03');

-- ANALYTICAL QUERIES

-- Query 1: Retrieve bookings currently in progress
SELECT * FROM Bookings 
WHERE Status = 'In Progress';

-- Query 2: Retrieve SUV cabs assigned to DriverID 5
SELECT * FROM Cabs 
WHERE VehicleType = 'SUV' AND DriverID = 5;

-- Query 3: Find customers with last name containing 'Smith'
SELECT * FROM Customers 
WHERE LastName LIKE '%Smith%';

-- Query 4: Categorize fares as High or Low
SELECT 
    Fare,
    CASE 
        WHEN Fare > 50 THEN 'High'
        ELSE 'Low'
    END AS FareStatus
FROM Bookings;

-- Query 5: Drivers with rating above average
SELECT * FROM Drivers 
WHERE Rating > (SELECT AVG(Rating) FROM Drivers);

-- Query 6: Total revenue generated per driver
SELECT 
    c.DriverID, 
    SUM(b.Fare) AS Total_Fare
FROM Bookings b
INNER JOIN Cabs c ON b.CabID = c.CabID
GROUP BY c.DriverID;

-- Query 7: Customers with more than 3 completed bookings
SELECT 
    CustomerID, 
    COUNT(BookingID) AS Completed_Bookings
FROM Bookings
WHERE Status = 'Completed'
GROUP BY CustomerID
HAVING COUNT(BookingID) > 3;

-- Query 8: Top 5 drivers based on rating
SELECT 
    FirstName, 
    LastName, 
    Rating
FROM Drivers
ORDER BY Rating DESC
LIMIT 5;

-- Query 9: Pickup & Dropoff locations with cab details
SELECT 
    b.PickupLocation, 
    b.DropoffLocation, 
    c.LicensePlate
FROM Bookings b
INNER JOIN Cabs c ON b.CabID = c.CabID;

-- Query 10: Driver and associated bookings (including drivers without bookings)
SELECT 
    d.FirstName, 
    d.LastName, 
    b.BookingID
FROM Drivers d
LEFT JOIN Cabs c ON d.DriverID = c.DriverID
LEFT JOIN Bookings b ON c.CabID = b.CabID;

-- Query 11: Total distance covered per cab
SELECT 
    c.CabID, 
    c.LicensePlate,
    SUM(td.Distance) AS Total_Distance_KM
FROM Cabs c
INNER JOIN Bookings b ON c.CabID = b.CabID
INNER JOIN TripDetails td ON b.BookingID = td.BookingID
GROUP BY c.CabID, c.LicensePlate;

-- Query 12: Bookings with fare above average completed fare
SELECT * FROM Bookings
WHERE Fare > (SELECT AVG(Fare) FROM Bookings WHERE Status = 'Completed');

-- Query 13: Complete trip mapping (Customer, Driver, Locations)
SELECT 
    CONCAT(cust.FirstName, ' ', cust.LastName) AS Customer_Name,
    CONCAT(d.FirstName, ' ', d.LastName) AS Driver_Name,
    b.PickupLocation,
    b.DropoffLocation
FROM Bookings b
INNER JOIN Customers cust ON b.CustomerID = cust.CustomerID
INNER JOIN Cabs c ON b.CabID = c.CabID
INNER JOIN Drivers d ON c.DriverID = d.DriverID;
