create database hw3;
go 
use hw3; 

-- 1) Define and explain the purpose of BULK INSERT in SQL Server:
-- BULK INSERT ? loads data from an external file into a table.
-- Much faster and more efficient for large datasets than using many single INSERT statements.

-- 2) List four file formats that can be imported into SQL Server: CSV (Comma-Separated Values), TXT (Text file), 
-- XML (eXtensible Markup Language),JSON (JavaScript Object Notation).

create table Products (
	ProductID INT PRIMARY KEY, 
	ProductName VARCHAR (50),
	Price DECIMAL(10,2)
);


INSERT INTO Products (ProductID, ProductName, Price )VALUES 
	(1, 'Laptop', 1200.50),
	(2, 'Smartphone', 800.00),
	(3, 'Refrigerator', 1500.75);

-- SELECT * FROM Products;

-- Explain the difference between NULL and NOT NULL: NULL ? value can be empty, NOT NULL ? value is required.

ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

-- Write a comment in a SQL query explaining its purpose: --? used for single-line comments. SQL ignores everything after -- on that line,

-- /* ... */ ? used for multi-line comments. SQL ignores everything between the markers.

ALTER TABLE Products
ADD CategoryID INT;

-- SELECT * FROM Products;

CREATE TABLE Categories (
	CategoryID INT PRIMARY KEY,
	CategoryName  VARCHAR (50) UNIQUE
);

--  Explain the purpose of the IDENTITY column in SQL Server: The IDENTITY column in SQL Server is a special property that automatically
-- generates sequential numbers for a column.


TRUNCATE TABLE Products;




BULK INSERT Products
FROM 'C:\ProductsData.csv'
WITH (
    FIELDTERMINATOR = ',',   
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2           
);

--	


ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES  Categories(CategoryID);

UPDATE Products
SET CategoryID = 1
WHERE CategoryID NOT IN (SELECT CategoryID FROM Categories);


-- Explain the differences between PRIMARY KEY and UNIQUE KEY: PRIMARY KEY = the main unique identifier of a table, UNIQUE KEY = ensures other columns also stay unique.

ALTER TABLE Products
ADD CONSTRAINT CHK_Price CHECK (Price > 0);

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

-- SELECT * FROM Products;

SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;

-- Describe the purpose and usage of FOREIGN KEY constraints in SQL Server: FOREIGN KEY ? creates a relationship between tables, Ensures data is valid and consistent across 
-- related tables.

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    Age INT,
    CONSTRAINT CHK_Customer_Age CHECK (Age >= 18)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(100,10) PRIMARY KEY,
    CustomerName VARCHAR(50),
    Amount DECIMAL(10,2)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
);

-- Explain the use of COALESCE and ISNULL functions for handling NULL values: ISNULL ? simple, works with two values, COALESCE ? more powerful, checks multiple values until
-- it finds one that isn’t NULL.

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE,
    Salary DECIMAL(10,2)
);

-- SELECT * FROM Employees;


