CREATE DATABASE  DZ0106

USE DZ0106

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NULL,
    Salary DECIMAL(10,2) NULL,
    DepartmentID INT NOT NULL
);

INSERT INTO Employees VALUES
(1, 'Ivan', 'Petrenko', 70000, 1),
(2, 'Olena', 'Ivanova', 50000, 1),
(3, 'Petro', 'Sydorenko', 45000, 2),
(4, 'Maria', 'Koval', 62000, 2),
(5, 'Andriy', 'Bondar', NULL, 3),
(6, 'Oksana', 'Shevchenko', 30000, 3);
 
DECLARE @IncreasePercent DECIMAL(5,2) = 10;

UPDATE Employees
SET Salary = Salary + (Salary * @IncreasePercent / 100)
WHERE DepartmentID = 1;
 
DECLARE @Counter INT = 1;
DECLARE @MaxID INT;
DECLARE @Name VARCHAR(50);

SELECT @MaxID = MAX(EmployeeID) FROM Employees;

WHILE @Counter <= @MaxID
BEGIN
    SELECT @Name = FirstName
    FROM Employees
    WHERE EmployeeID = @Counter;

    IF @Name IS NOT NULL
        PRINT @Name;

    SET @Counter = @Counter + 1;
END;
 
SELECT
    EmployeeID,
    FirstName,
    Salary,
    CASE
        WHEN Salary >= 60000 THEN 'High Salary'
        WHEN Salary >= 40000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS SalaryStatus
FROM Employees;
 
DECLARE @SalaryLimit DECIMAL(10,2) = 55000;

SELECT *
FROM Employees
WHERE Salary > @SalaryLimit;
 
UPDATE Employees
SET Salary =
    Salary +
    CASE
        WHEN Salary > 60000 THEN Salary * 0.05
        ELSE Salary * 0.03
    END
WHERE Salary IS NOT NULL;
 
DECLARE @DeptID INT = 1;
DECLARE @MaxDeptID INT;
DECLARE @TotalSalary DECIMAL(18,2);

SELECT @MaxDeptID = MAX(DepartmentID)
FROM Employees;

WHILE @DeptID <= @MaxDeptID
BEGIN
    SELECT @TotalSalary = ISNULL(SUM(Salary),0)
    FROM Employees
    WHERE DepartmentID = @DeptID;

    PRINT 'Department ' + CAST(@DeptID AS VARCHAR)
          + ': Total salary - '
          + CAST(@TotalSalary AS VARCHAR);

    SET @DeptID = @DeptID + 1;
END;
 
SELECT *
FROM Employees e
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
)
AND DepartmentID IN
(
    SELECT DepartmentID
    FROM Employees
    GROUP BY DepartmentID
    HAVING AVG(Salary) > 55000
);
 
DECLARE @MinSalary DECIMAL(10,2) = 35000;

DELETE FROM Employees
WHERE DepartmentID = 3
AND Salary < @MinSalary;
 
SELECT
    DepartmentID,
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;
 
DECLARE @AverageSalary DECIMAL(10,2);

SELECT @AverageSalary = AVG(Salary)
FROM Employees
WHERE Salary IS NOT NULL;

UPDATE Employees
SET Salary = @AverageSalary
WHERE Salary IS NULL;

SELECT * FROM Employees;