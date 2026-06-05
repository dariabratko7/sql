CREATE DATABASE EXAM0506

USE EXAM0506

CREATE TABLE Categories
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Products
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Brand VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) CHECK (Price BETWEEN 1 AND 100000),
    Description VARCHAR(255),
    CategoryId INT NOT NULL,

    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

CREATE TABLE Customers
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Employees
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL
);

CREATE TABLE Orders
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    EmployeeID INT NOT NULL,
    Date DATE DEFAULT GETDATE(),
    Status VARCHAR(20) DEFAULT 'Pending',
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount >= 0),

    FOREIGN KEY (CustomerID) REFERENCES Customers(Id),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(Id)
);

CREATE TABLE Reviews
(
    Id INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment VARCHAR(255),

    FOREIGN KEY (ProductID) REFERENCES Products(Id),
    FOREIGN KEY (CustomerID) REFERENCES Customers(Id)
);

CREATE TABLE OrderDetails
(
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT DEFAULT 1 CHECK (Quantity > 0),

    PRIMARY KEY (OrderId, ProductId),

    FOREIGN KEY (OrderId) REFERENCES Orders(Id),
    FOREIGN KEY (ProductId) REFERENCES Products(Id)
);

INSERT INTO Categories(Name)
VALUES
('Smartphones'),
('Laptops'),
('Accessories');

INSERT INTO Products(Name, Brand, Price, Description, CategoryId)
VALUES
('iPhone 15', 'Apple', 45000, 'Smartphone', 1),
('Galaxy S24', 'Samsung', 38000, 'Smartphone', 1),
('MacBook Air M3', 'Apple', 60000, 'Laptop', 2),
('ThinkPad X1', 'Lenovo', 55000, 'Laptop', 2),
('Wireless Mouse', 'Logitech', 1200, 'Accessory', 3);

INSERT INTO Customers(FirstName, LastName, Address, Email)
VALUES
('Ivan', 'Petrenko', 'Kyiv', 'ivan@gmail.com'),
('Olena', 'Shevchenko', 'Lviv', 'olena@gmail.com'),
('Andriy', 'Koval', 'Odesa', 'andriy@gmail.com');

INSERT INTO Employees(FirstName, LastName, Position)
VALUES
('Maria', 'Bondar', 'Manager'),
('Petro', 'Ivanov', 'Sales Manager');

INSERT INTO Orders(CustomerID, EmployeeID, Date, Status, TotalAmount)
VALUES
(1,1,'2025-05-10','Completed',45000),
(2,2,'2025-05-11','Completed',61200),
(1,1,'2025-05-15','Pending',1200);

INSERT INTO OrderDetails(OrderId, ProductId, Quantity)
VALUES
(1,1,1),
(2,3,1),
(2,5,1),
(3,5,1);

INSERT INTO Reviews(ProductID, CustomerID, Rating, Comment)
VALUES
(1,1,5,'Excellent'),
(1,2,4,'Good'),
(3,2,5,'Perfect'),
(5,1,4,'Nice');

SELECT P.Name, P.Brand, P.Price
FROM Products P
JOIN Categories C
ON P.CategoryId = C.Id
WHERE C.Name = 'Smartphones';

SELECT C.Name AS Category,
       AVG(P.Price) AS AveragePrice
FROM Categories C
JOIN Products P
ON C.Id = P.CategoryId
GROUP BY C.Name;

SELECT O.*
FROM Orders O
JOIN Customers C
ON O.CustomerID = C.Id
WHERE C.FirstName = 'Ivan';

SELECT DISTINCT C.FirstName,
                C.LastName,
                O.TotalAmount
FROM Customers C
JOIN Orders O
ON C.Id = O.CustomerID
WHERE O.TotalAmount > 50000;

SELECT DISTINCT C.Name
FROM Categories C
JOIN Products P
ON C.Id = P.CategoryId
WHERE P.Price < 2000;

SELECT C.Name,
       COUNT(P.Id) AS ProductCount
FROM Categories C
LEFT JOIN Products P
ON C.Id = P.CategoryId
GROUP BY C.Name;

SELECT TOP 1
       C.FirstName,
       C.LastName,
       COUNT(R.Id) AS ReviewCount
FROM Customers C
JOIN Reviews R
ON C.Id = R.CustomerID
GROUP BY C.FirstName, C.LastName
ORDER BY ReviewCount DESC;

SELECT C.FirstName,
       C.LastName,
       SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
JOIN Orders O
ON C.Id = O.CustomerID
GROUP BY C.FirstName, C.LastName;

SELECT P.Name
FROM Products P
LEFT JOIN Reviews R
ON P.Id = R.ProductID
WHERE R.Id IS NULL;

ALTER TABLE Customers
ADD LoyaltyLevel VARCHAR(20);

UPDATE C
SET LoyaltyLevel =
    CASE
        WHEN O.TotalSpent > 2000 THEN 'Gold'
        WHEN O.TotalSpent > 1000 THEN 'Silver'
        ELSE 'Regular'
    END
FROM Customers C
JOIN
(
    SELECT CustomerID,
           SUM(TotalAmount) AS TotalSpent
    FROM Orders
    GROUP BY CustomerID
) O
ON C.Id = O.CustomerID;

SELECT * FROM Customers;

