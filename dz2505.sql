CREATE DATABASE DZ2505ORDER

USE DZ2505ORDER

CREATE TABLE Orders
(
    OrderId INT IDENTITY PRIMARY KEY,
    CustomerId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    OrderDate DATE NOT NULL
);

INSERT INTO Orders (CustomerId, ProductId, Quantity, Price, OrderDate)
VALUES
(1, 101, 2, 100.00, '2025-01-10'),
(1, 102, 1, 200.00, '2025-01-10'),
(2, 101, 5, 100.00, '2025-01-11'),
(2, 103, 3, 150.00, '2025-01-12'),
(3, 101, 4, 100.00, '2025-01-12'),
(3, 104, 2, 300.00, '2025-01-13'),
(1, 101, 3, 100.00, '2025-01-14'),
(4, 102, 6, 200.00, '2025-01-14'),
(4, 103, 2, 150.00, '2025-01-15'),
(5, 101, 10, 100.00, '2025-01-15'),
(5, 104, 1, 300.00, '2025-01-16'),
(1, 101, 2, 100.00, '2025-01-17'),
(2, 101, 1, 100.00, '2025-01-17'),
(3, 101, 2, 100.00, '2025-01-18'),
(4, 101, 1, 100.00, '2025-01-18');

SELECT
    ProductId,
    SUM(Quantity * Price) AS TotalRevenue
FROM Orders
GROUP BY ProductId;

SELECT
    CustomerId,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerId;

SELECT
    CustomerId,
    SUM(Quantity * Price) AS TotalRevenue
FROM Orders
GROUP BY CustomerId;

SELECT TOP 1
    OrderDate,
    COUNT(*) AS OrdersCount
FROM Orders
GROUP BY OrderDate
ORDER BY OrdersCount DESC;

SELECT TOP 1
    OrderDate,
    SUM(Quantity * Price) AS Revenue
FROM Orders
GROUP BY OrderDate
ORDER BY Revenue DESC;

SELECT
    ProductId,
    SUM(Quantity) AS TotalQuantity
FROM Orders
GROUP BY ProductId
HAVING SUM(Quantity) >= 10;

SELECT
    CustomerId,
    SUM(Quantity * Price) AS TotalSpent
FROM Orders
GROUP BY CustomerId
HAVING SUM(Quantity * Price) > 1000;

SELECT
    CustomerId,
    COUNT(DISTINCT OrderDate) AS DifferentDates
FROM Orders
GROUP BY CustomerId
HAVING COUNT(DISTINCT OrderDate) >= 3;

SELECT
    CustomerId,
    COUNT(*) AS OrdersCount
FROM Orders
GROUP BY CustomerId
HAVING COUNT(*) >= 5;

SELECT
    CustomerId
FROM Orders
GROUP BY CustomerId
HAVING COUNT(DISTINCT ProductId) = 1;

