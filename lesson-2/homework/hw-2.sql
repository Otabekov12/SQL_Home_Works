create database hw2
go
use hw2

create table Employees ( 
 EmpID INT, 
 NAME Varchar(50), 
 Salary DECIMAL(10,2)
 );

 insert into Employees 
  Values(1, 'Rustam', 12000.20);

  
 insert into Employees (EmpID, Name, Salary)
  Values(2, 'Guli', 15000.90);

 insert into Employees (EmpID, Name, Salary)
 Values (3, 'Otabek', 1800.00),(4, 'Dilshod', 2000.25);

UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;


DELETE FROM Employees
WHERE EmpID = 2;


  --select * from Employees;

-- Give a brief definition for difference between DELETE, TRUNCATE, and DROP.


-- DELETE: 1.Removes specific rows from a table, 2.Can use WHERE to filter which rows to delete. 3.Table structure remains.

-- TRUNCATE: 1.Removes all rows from a table at once, 2.Cannot use WHERE, 3.Table structure remains.

-- DROP: Deletes the entire table including its structure and data.


ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);


ALTER TABLE Employees
ADD Department VARCHAR(50);

ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);


  --select * from Departments;


  TRUNCATE TABLE Employees;

  INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR'
UNION ALL
SELECT 2, 'IT'
UNION ALL
SELECT 3, 'Logistics'
UNION ALL
SELECT 4, 'Finance'
UNION ALL
SELECT 5, 'Marketing';


UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

TRUNCATE TABLE Employees;

ALTER TABLE Employees
DROP COLUMN Department;

EXEC sp_rename 'Employees', 'StaffMembers';


select * from StaffMembers;

DROP TABLE Departments;


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


select * from Products;

ALTER TABLE Products
ADD CONSTRAINT chk_price CHECK (Price > 0);

ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES
    (1, 'Laptop', 'Electronics', 1200.00, 30),
    (2, 'Smartphone', 'Electronics', 800.00, 50),
    (3, 'Refrigerator', 'Home Appliances', 1500.00, 20),
    (4, 'Table', 'Furniture', 250.00, 100),
    (5, 'Shoes', 'Fashion', 75.00, 200);



SELECT * INTO Products_Backup FROM Products;


select * from Products;
select * from Products_Backup;


EXEC sp_rename 'Products', 'Inventory';


select * from Inventory;
select * from Products_Backup;

-- ... avvalgi kodlar ...

EXEC sp_rename 'Products', 'Inventory';


ALTER TABLE Inventory DROP CONSTRAINT chk_price;

ALTER TABLE Inventory ALTER COLUMN Price FLOAT;

ALTER TABLE Inventory ADD CONSTRAINT chk_price CHECK (Price > 0);

select * from Inventory;
select * from Products_Backup;

