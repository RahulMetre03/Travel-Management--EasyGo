DROP DATABASE tax_calculator;
CREATE DATABASE tax_calculator;

USE tax_calculator;

DROP TABLE Emp;
CREATE TABLE Emp (empno INT PRIMARY KEY,ename VARCHAR(50),salary INT);

DROP TABLE Slabs;
CREATE TABLE Slabs (minsal INT PRIMARY KEY,maxsal INT,tax FLOAT);

DELETE FROM Emp;
INSERT INTO Emp VALUES(100, 'Ajay', 400000);
INSERT INTO Emp VALUES(200, 'Vijay', 900000);
INSERT INTO Emp VALUES(300, 'Ramesh', 1500000);
SELECT * FROM Emp;

DELETE FROM Slabs;
INSERT INTO Slabs VALUES(250001, 500000, 0.05);
INSERT INTO Slabs VALUES(500001, 1000000, 0.20);
INSERT INTO Slabs VALUES(1000001, 999999999, 0.30);
SELECT * FROM Slabs;

DROP FUNCTION calculate_tax;

DELIMITER &&
CREATE FUNCTION calculate_tax(p_empno INT) RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total_income INT;
DECLARE tax_rate FLOAT;
DECLARE tax_amount INT;

SELECT salary INTO total_income FROM Emp WHERE empno = p_empno;

SELECT tax INTO tax_rate FROM Slabs 
WHERE total_income BETWEEN minsal AND maxsal;
SET tax_amount = total_income * tax_rate;
RETURN tax_amount;
END&&
DELIMITER ;

SELECT empno, ename, salary,calculate_tax(empno) FROM EMP;
