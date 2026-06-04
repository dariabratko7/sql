CREATE DATABASE DZ2205CarPark

USE DZ2205CarPark

CREATE TABLE Owners 
(
	OwnerID INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Phone VARCHAR(20)
);

CREATE TABLE Cars 
(
	CarID INT PRIMARY KEY,
	OwnerID INT,
	Brand VARCHAR(50),
	Model VARCHAR(50),

	FOREIGN KEY (OwnerID)
	REFERENCES Owners(OwnerID)
);

CREATE TABLE CarTechnicalDetails
(
    CarID INT PRIMARY KEY,
    ProductionYear INT,
    Mileage INT,

    FOREIGN KEY (CarID)
    REFERENCES Cars(CarID)

);

CREATE TABLE OwnershipHistory
(
    HistoryID INT PRIMARY KEY,
    OwnerID INT,
    CarID INT,
    StartDate DATE,
    EndDate DATE,

    FOREIGN KEY (OwnerID)
    REFERENCES Owners(OwnerID),

    FOREIGN KEY (CarID)
    REFERENCES Cars(CarID)
);

INSERT INTO Owners VALUES
(1,'Ivan','Petrenko','0971111111'),
(2,'Olena','Koval','0502222222'),
(3,'Andrii','Bondarenko','0633333333'),
(4,'Maria','Romanenko','0674444444');

INSERT INTO Cars VALUES
(1,1,'Toyota','Corolla'),
(2,1,'BMW','X5'),
(3,2,'Audi','A4'),
(4,3,'Ford','Focus'),
(5,4,'Mercedes','C200');

INSERT INTO CarTechnicalDetails VALUES
(1,2018,95000),
(2,2020,60000),
(3,2019,75000),
(4,2017,120000),
(5,2021,30000);

INSERT INTO OwnershipHistory VALUES
(1,1,1,'2022-01-10',NULL),
(2,1,2,'2023-03-15',NULL),
(3,2,3,'2021-05-20',NULL),
(4,3,4,'2020-07-01',NULL),
(5,4,5,'2024-02-01',NULL),
(6,2,1,'2020-01-01','2021-12-31');

SELECT
    Owners.FirstName,
    Owners.LastName,
    Cars.Brand,
    Cars.Model
FROM Owners
JOIN Cars
ON Owners.OwnerID = Cars.OwnerID;

SELECT
    Cars.Brand,
    Cars.Model,
    CarTechnicalDetails.ProductionYear,
    CarTechnicalDetails.Mileage
FROM Cars
JOIN CarTechnicalDetails
ON Cars.CarID = CarTechnicalDetails.CarID;

SELECT
    Owners.FirstName,
    Owners.LastName,
    Cars.Brand,
    Cars.Model,
    CarTechnicalDetails.ProductionYear,
    CarTechnicalDetails.Mileage
FROM Owners
JOIN Cars
    ON Owners.OwnerID = Cars.OwnerID
JOIN CarTechnicalDetails
    ON Cars.CarID = CarTechnicalDetails.CarID;