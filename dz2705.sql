CREATE DATABASE DZ2705

USE DZ2705

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

SELECT *
FROM Flights
WHERE ArrivalCity = 'Київ'
AND CAST(DepartureDateTime AS DATE) = '2025-06-11'
ORDER BY DepartureDateTime;

SELECT TOP 1 *,
DATEDIFF(MINUTE, DepartureDateTime, ArrivalDateTime) AS DurationMinutes
FROM Flights
ORDER BY DurationMinutes DESC;

SELECT *
FROM Flights
WHERE DATEDIFF(MINUTE, DepartureDateTime, ArrivalDateTime) > 120;

SELECT ArrivalCity,
COUNT(*) AS FlightsCount
FROM Flights
GROUP BY ArrivalCity;

SELECT TOP 1 ArrivalCity,
COUNT(*) AS FlightsCount
FROM Flights
GROUP BY ArrivalCity
ORDER BY FlightsCount DESC;

SELECT ArrivalCity,
COUNT(*) AS FlightsToCity
FROM Flights
WHERE MONTH(DepartureDateTime)=6
AND YEAR(DepartureDateTime)=2025
GROUP BY ArrivalCity;

SELECT COUNT(*) AS TotalFlights
FROM Flights
WHERE MONTH(DepartureDateTime)=6
AND YEAR(DepartureDateTime)=2025;

SELECT F.*
FROM Flights F
WHERE CAST(F.DepartureDateTime AS DATE) = CAST(GETDATE() AS DATE)
AND
(
    F.BusinessSeats >
    (
        SELECT COUNT(*)
        FROM Tickets T
        WHERE T.FlightID = F.FlightID
        AND T.TicketClass = 'Business'
    )
);

SELECT
COUNT(*) AS TicketsSold,
SUM(Price) AS TotalAmount
FROM Tickets
WHERE PurchaseDate = '2025-06-03';

SELECT
F.FlightNumber,
COUNT(T.TicketID) AS SoldTickets
FROM Flights F
LEFT JOIN Tickets T
ON F.FlightID = T.FlightID
WHERE CAST(F.DepartureDateTime AS DATE) = '2025-06-11'
GROUP BY F.FlightNumber;

SELECT FlightNumber,
ArrivalCity
FROM Flights;

