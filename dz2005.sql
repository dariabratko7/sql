CREATE DATABASE DZ2005HOSPITAL

USE DZ2005HOSPITAL


CREATE TABLE Patients 
(
	PatientID INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Age INT,
	Department VARCHAR(50),
	AdmissionDate DATE,
	DischargeDate DATE,
	Disease VARCHAR(100),
	Doctor VARCHAR(50),
	MobileOperator VARCHAR(50)
);

INSERT INTO Patients VALUES
(1,'Ivan','Petrenko',25,'Cardiology','2026-04-01',NULL,'Arrhythmia','Dr. Kovalenko','Kyivstar'),

(2,'Olena','Romanenko',18,'Neurology','2025-11-10','2025-12-20','Migraine','Dr. Shevchenko','Vodafone'),

(3,'Andrii','Bondarenko',45,'Surgery','2026-03-15',NULL,'Appendicitis','Dr. Ivanov','Lifecell'),

(4,'Maria','Polishchuk',30,'Cardiology','2025-10-15','2025-11-25','Hypertension','Dr. Kovalenko','Kyivstar'),

(5,'Petro','Rudenko',20,'Neurology','2026-05-01',NULL,'Epilepsy','Dr. Shevchenko','Vodafone'),

(6,'Svitlana','Melnyk',50,'Therapy','2025-12-01','2026-01-15','Pneumonia','Dr. Petrov','Lifecell'),

(7,'Roman','Pavlenko',17,'Cardiology','2026-02-01',NULL,'Arrhythmia','Dr. Kovalenko','Kyivstar'),

(8,'Dmytro','Rak',35,'Surgery','2025-11-05','2025-12-10','Fracture','Dr. Ivanov','Vodafone'),

(9,'Iryna','Koval',28,'Therapy','2025-10-20','2025-12-01','Bronchitis','Dr. Petrov','Kyivstar'),

(10,'Viktor','Rybak',22,'Neurology','2026-04-10',NULL,'Migraine','Dr. Shevchenko','Lifecell');

SELECT * FROM Patients;

SELECT *
FROM Patients
WHERE Department = 'Cardiology';

SELECT DISTINCT Department
FROM Patients;

SELECT *
FROM Patients
WHERE DischargeDate IS NULL
AND DATEDIFF(DAY, AdmissionDate, GETDATE()) > 30
ORDER BY AdmissionDate ASC;

SELECT *
FROM Patients
WHERE MONTH(DischargeDate) = MONTH(DATEADD(MONTH,-1,GETDATE()))
AND YEAR(DischargeDate) = YEAR(DATEADD(MONTH,-1,GETDATE()));

SELECT *
FROM Patients
WHERE Department = 'Neurology'
AND AdmissionDate BETWEEN
    DATEFROMPARTS(YEAR(GETDATE())-1,10,1)
AND
    DATEFROMPARTS(YEAR(GETDATE())-1,12,31);

SELECT TOP 1
    FirstName,
    LastName,
    Age
FROM Patients
ORDER BY Age ASC;

SELECT *
FROM Patients
WHERE Department IN ('Cardiology','Neurology','Surgery');

SELECT *
FROM Patients
WHERE LastName LIKE 'R%';

SELECT *
FROM Patients
WHERE Doctor = 'Dr. Kovalenko'
AND Disease = 'Arrhythmia';

SELECT *
FROM Patients
WHERE MobileOperator = 'Kyivstar';

UPDATE Patients
SET Department = 'Internal Medicine'
WHERE Department = 'Therapy';

DELETE FROM Patients
WHERE DischargeDate IS NOT NULL
AND DATEDIFF(MONTH, DischargeDate, GETDATE()) > 6;
