CREATE DATABASE  DZ0306

USE DZ0306

CREATE TABLE Employees (
    ID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(50),
    Position NVARCHAR(50),
    Department NVARCHAR(50)
);

CREATE TABLE EmployeeDetails (
    ID INT PRIMARY KEY IDENTITY,
    EmployeeID INT FOREIGN KEY REFERENCES Employees(ID),
    Email NVARCHAR(50),
    PhoneNumber NVARCHAR(15)
);


CREATE PROCEDURE AddEmployee
    @Name NVARCHAR(50),
    @Position NVARCHAR(50),
    @Department NVARCHAR(50),
    @Email NVARCHAR(50),
    @PhoneNumber NVARCHAR(15)
AS
BEGIN
    DECLARE @EmployeeID INT;

    INSERT INTO Employees(Name, Position, Department)
    VALUES (@Name, @Position, @Department);

    SET @EmployeeID = SCOPE_IDENTITY();

    INSERT INTO EmployeeDetails(EmployeeID, Email, PhoneNumber)
    VALUES (@EmployeeID, @Email, @PhoneNumber);
END;
GO


CREATE PROCEDURE GetEmployees
AS
BEGIN
    SELECT
        e.ID,
        e.Name,
        e.Position,
        e.Department,
        ed.Email,
        ed.PhoneNumber
    FROM Employees e
    INNER JOIN EmployeeDetails ed
        ON e.ID = ed.EmployeeID;
END;
GO


CREATE PROCEDURE UpdateEmployee
    @ID INT,
    @Name NVARCHAR(50),
    @Position NVARCHAR(50),
    @Department NVARCHAR(50),
    @Email NVARCHAR(50),
    @PhoneNumber NVARCHAR(15)
AS
BEGIN
    UPDATE Employees
    SET
        Name = @Name,
        Position = @Position,
        Department = @Department
    WHERE ID = @ID;

    UPDATE EmployeeDetails
    SET
        Email = @Email,
        PhoneNumber = @PhoneNumber
    WHERE EmployeeID = @ID;
END;
GO


CREATE PROCEDURE DeleteEmployee
    @ID INT
AS
BEGIN
    DELETE FROM EmployeeDetails
    WHERE EmployeeID = @ID;

    DELETE FROM Employees
    WHERE ID = @ID;
END;
GO


CREATE PROCEDURE SearchEmployees
    @Department NVARCHAR(50) = NULL,
    @Position NVARCHAR(50) = NULL
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE
        (@Department IS NULL OR Department = @Department)
        AND
        (@Position IS NULL OR Position = @Position);
END;
GO


CREATE PROCEDURE GetEmployeeInfo
    @EmployeeID INT,
    @EmployeeName NVARCHAR(50) OUTPUT,
    @EmployeeEmail NVARCHAR(50) OUTPUT
AS
BEGIN
    SELECT
        @EmployeeName = e.Name,
        @EmployeeEmail = ed.Email
    FROM Employees e
    INNER JOIN EmployeeDetails ed
        ON e.ID = ed.EmployeeID
    WHERE e.ID = @EmployeeID;
END;
GO

EXEC AddEmployee
    'Іван Петренко',
    'Менеджер',
    'Продажі',
    'ivan@gmail.com',
    '0501234567';

EXEC GetEmployees;

EXEC UpdateEmployee
    1,
    'Іван Петренко',
    'Старший менеджер',
    'Продажі',
    'ivan_new@gmail.com',
    '0671112233';

EXEC DeleteEmployee 1;

EXEC SearchEmployees @Department = 'Продажі';
EXEC SearchEmployees @Position = 'Менеджер';
EXEC SearchEmployees;

DECLARE @Name NVARCHAR(50);
DECLARE @Email NVARCHAR(50);

EXEC GetEmployeeInfo
    @EmployeeID = 1,
    @EmployeeName = @Name OUTPUT,
    @EmployeeEmail = @Email OUTPUT;

SELECT @Name AS EmployeeName,
       @Email AS EmployeeEmail;