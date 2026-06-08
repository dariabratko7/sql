CREATE DATABASE DZ2905

USE DZ2905

-- НА ОСНОВІ ПОПЕРЕДНЬОГО ДЗ

CREATE TABLE Passengers
(
    PassengerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PassportNumber VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Flights
(
    FlightID INT PRIMARY KEY IDENTITY(1,1),
    FlightNumber VARCHAR(10) NOT NULL,
    DepartureCity VARCHAR(50) NOT NULL,
    ArrivalCity VARCHAR(50) NOT NULL,
    DepartureDateTime DATETIME NOT NULL,
    ArrivalDateTime DATETIME NOT NULL,
    BusinessSeats INT NOT NULL,
    EconomySeats INT NOT NULL
);

CREATE TABLE Tickets
(
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    FlightID INT NOT NULL,
    PassengerID INT NOT NULL,
    TicketClass VARCHAR(20) NOT NULL, 
    Price DECIMAL(10,2) NOT NULL,
    PurchaseDate DATE NOT NULL,

    FOREIGN KEY (FlightID) REFERENCES Flights(FlightID),
    FOREIGN KEY (PassengerID) REFERENCES Passengers(PassengerID)
);

INSERT INTO Passengers
VALUES
('Іван','Петренко','AA111111'),
('Марія','Коваль','BB222222'),
('Олег','Шевченко','CC333333');

INSERT INTO Flights
VALUES
('PS101','Одеса','Київ','2025-06-10 08:00','2025-06-10 09:30',20,100),
('PS102','Одеса','Львів','2025-06-10 10:00','2025-06-10 12:30',15,80),
('PS103','Одеса','Варшава','2025-06-11 07:00','2025-06-11 11:00',25,120),
('PS104','Одеса','Київ','2025-06-11 14:00','2025-06-11 15:20',20,100);

INSERT INTO Tickets
VALUES
(1,1,'Business',3000,'2025-06-01'),
(1,2,'Economy',1500,'2025-06-01'),
(2,3,'Economy',1800,'2025-06-02'),
(3,1,'Business',5000,'2025-06-03'),
(3,2,'Economy',3500,'2025-06-03');


SELECT YEAR(DepartureDateTime) AS FlightYear
FROM Flights;

SELECT *
FROM Passengers
WHERE FirstName LIKE '%SQL%'
   OR LastName LIKE '%SQL%';

SELECT REPLACE(FirstName, 'кішка', 'собака') AS NewText
FROM Passengers;

SELECT LEFT(FlightNumber, CHARINDEX('-', FlightNumber) - 1) AS BeforeDash
FROM Flights
WHERE FlightNumber LIKE '%-%';

SELECT RIGHT(PassportNumber,
             CHARINDEX('/', REVERSE(PassportNumber)) - 1) AS AfterSlash
FROM Passengers
WHERE PassportNumber LIKE '%/%';

SELECT PassportNumber
FROM Passengers;

SELECT DATENAME(WEEKDAY, DepartureDateTime) AS WeekDay
FROM Flights;

SELECT *
FROM Tickets
WHERE Price < 10;

SELECT AVG(Price) AS AveragePrice
FROM Tickets;

SELECT SUM(Price) AS TotalPrice
FROM Tickets
WHERE PurchaseDate > '2021-01-01';

SELECT FORMAT(DepartureDateTime, 'MM-yyyy') AS MonthYear
FROM Flights;

SELECT TRIM(FirstName) AS TrimmedName
FROM Passengers;

SELECT DATEDIFF(DAY, PurchaseDate, DepartureDateTime) AS DaysDifference
FROM Tickets T
JOIN Flights F
ON T.FlightID = F.FlightID;

SELECT TicketClass,
SUM(Price) AS TotalPrice
FROM Tickets
GROUP BY TicketClass;

SELECT UPPER(FirstName) AS UpperName
FROM Passengers;