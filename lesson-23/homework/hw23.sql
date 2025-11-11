create database hw23
go 
use hw23

CREATE TABLE Dates ( Id INT, Dt DATETIME ); 
INSERT INTO Dates VALUES 
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');



SELECT
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthWithZero
FROM Dates;



CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);



CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);



SELECT
    Id,
    rID,
    SUM(MaxVals) AS SumOfMaxVals
FROM (
    SELECT
        Id,
        rID,
        MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) AS MaxPerId
GROUP BY Id, rID
ORDER BY Id, rID;


CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');

SELECT *
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;


CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);
INSERT INTO TestMaximum VALUES
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);



SELECT t.ID, t.Item, t.Vals
FROM TestMaximum t
JOIN (
    SELECT ID, MAX(Vals) AS MaxVals
    FROM TestMaximum
    GROUP BY ID
) m ON t.ID = m.ID AND t.Vals = m.MaxVals
ORDER BY t.ID;


CREATE TABLE SumOfMax (
    DetailedNumber INT,
    Vals INT,
    Id INT
);
INSERT INTO SumOfMax VALUES
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);

SELECT
    Id,
    SUM(MaxVals) AS SumOfMaxVals
FROM (
    SELECT
        Id,
        DetailedNumber,
        MAX(Vals) AS MaxVals
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) AS MaxPerDetail
GROUP BY Id
ORDER BY Id;



CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);


SELECT 
    Id,
    a,
    b,
    CASE 
        WHEN a - b <> 0 THEN CAST(a - b AS VARCHAR(20))
        ELSE ''
    END AS Difference
FROM TheZeroPuzzle;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Country VARCHAR(50)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


SELECT 
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;


SELECT 
    AVG(UnitPrice) AS AverageUnitPrice
FROM Sales;

SELECT 
    COUNT(*) AS TotalSalesTransactions
FROM Sales;


SELECT 
    MAX(QuantitySold) AS HighestUnitsSold
FROM Sales;


SELECT 
    Category,
    SUM(QuantitySold) AS TotalProductsSold
FROM Sales
GROUP BY Category;


SELECT TOP 1 
    Product,
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;


SELECT 
    SaleID,
    SaleDate,
    (QuantitySold * UnitPrice) AS Revenue,
    SUM(QuantitySold * UnitPrice) 
        OVER (ORDER BY SaleDate) AS RunningTotalRevenue
FROM Sales;



SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) as CategoryRevenue,
    SUM(QuantitySold * UnitPrice) * 100.0 / (SELECT SUM(QuantitySold * UnitPrice) FROM Sales) as ContributionPercentage
FROM Sales
GROUP BY Category
ORDER BY CategoryRevenue DESC;


SELECT 
    s.SaleID,
    s.Product,
    s.Category,
    s.QuantitySold,
    s.UnitPrice,
    s.SaleDate,
    s.Region,
    c.CustomerName
FROM Sales s
INNER JOIN Customers c ON s.CustomerID = c.CustomerID;



CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    JoinDate DATE
);

INSERT INTO Customers (CustomerName, Region, JoinDate) VALUES
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region, CustomerID) VALUES
('Laptop', 'Electronics', 2, 1200.00, '2024-03-01', 'North', 1),
('Smartphone', 'Electronics', 1, 800.00, '2024-03-02', 'West', 2),
('T-Shirt', 'Clothing', 3, 25.00, '2024-03-03', 'East', 3),
('Microwave', 'Appliances', 1, 200.00, '2024-03-04', 'South', 1),
('Washing Machine', 'Appliances', 1, 700.00, '2024-03-05', 'North', 2),
('Oven', 'Appliances', 1, 500.00, '2024-03-06', 'West', 3),
('Gaming Console', 'Electronics', 1, 320.00, '2024-03-07', 'East', 1);

SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Region,
    c.JoinDate
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleID IS NULL;

SELECT * FROM Customers;

SELECT * FROM Sales;

select * from Customers;


SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Region,
    SUM(s.QuantitySold * s.UnitPrice) as TotalRevenue
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Region
ORDER BY TotalRevenue DESC;


SELECT TOP 1
    c.CustomerID,
    c.CustomerName,
    c.Region,
    SUM(s.QuantitySold * s.UnitPrice) as TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Region
ORDER BY TotalRevenue DESC;


SELECT 
    c.CustomerID,
    c.CustomerName,
    c.Region,
    SUM(s.QuantitySold) as TotalSales
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Region
ORDER BY TotalSales DESC;



CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2)
);
INSERT INTO Products (ProductName, Category, CostPrice, SellingPrice)
VALUES
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);

SELECT DISTINCT 
    Product,
    Category
FROM Sales
WHERE QuantitySold > 0;

SELECT TOP 1
    ProductID,
    ProductName,
    Category,
    UnitPrice
FROM Products
ORDER BY UnitPrice DESC;

SELECT 
    p1.ProductID,
    p1.ProductName,
    p1.Category,
    p1.UnitPrice,
    (SELECT AVG(p2.UnitPrice) FROM Products p2 WHERE p2.Category = p1.Category) as AvgCategoryPrice
FROM Products p1
WHERE p1.UnitPrice > (SELECT AVG(p2.UnitPrice) FROM Products p2 WHERE p2.Category = p1.Category)
ORDER BY p1.Category, p1.UnitPrice DESC;
