CREATE DATABASE DZ1805;

USE DZ1805;

CREATE TABLE Employees
(
    Employee_id INT PRIMARY KEY,
    Employee_name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

ALTER TABLE Employees
ADD Hire_date DATE NOT NULL;

ALTER TABLE Employees
ADD CONSTRAINT CHK_Salary
CHECK (Salary >= 0);

ALTER TABLE Employees
ADD CONSTRAINT DF_Department
DEFAULT 'Невідомо' FOR Department;

ALTER TABLE Employees
ADD CONSTRAINT UQ_Employee_Name
UNIQUE (Employee_name);