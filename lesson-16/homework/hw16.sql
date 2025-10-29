create database hw16
go
use hw16 


CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'Garc?a', 77000.00),
(10, 1, 'William', 'Mart?nez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);


select * from Numbers1;
select * from FindSameCharacters;
select * from RemoveDuplicateIntsFromNames;
select * from Example;
select * from Employees;
select * from Departments;
select * from Sales;
select * from Products;

WITH Numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM Numbers
    WHERE num < 1000
)
SELECT num
FROM Numbers
OPTION (MAXRECURSION 0); 

SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) s
ON e.EmployeeID = s.EmployeeID;


WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT AvgSalary
FROM AvgSalaryCTE;


SELECT 
    p.ProductID,
    p.ProductName,
    s.MaxSales
FROM Products p
JOIN (
    SELECT 
        ProductID,
        MAX(SalesAmount) AS MaxSales
    FROM Sales
    GROUP BY ProductID
) s
ON p.ProductID = s.ProductID;


WITH Doubles AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2
    FROM Doubles
    WHERE num * 2 < 1000000
)
SELECT num
FROM Doubles;

WITH SalesCountCTE AS (
    SELECT 
        EmployeeID,
        COUNT(*) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT 
    e.FirstName,
    e.LastName,
    s.TotalSales
FROM Employees e
JOIN SalesCountCTE s
    ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 5;


WITH ProductSalesCTE AS (
    SELECT 
        ProductID,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT 
    p.ProductID,
    p.ProductName,
    s.TotalSales
FROM Products p
JOIN ProductSalesCTE s
    ON p.ProductID = s.ProductID
WHERE s.TotalSales > 500;

WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Salary
FROM Employees e
CROSS JOIN AvgSalaryCTE
WHERE e.Salary > AvgSalaryCTE.AvgSalary;

SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s.TotalOrders
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        COUNT(*) AS TotalOrders
    FROM Sales
    GROUP BY EmployeeID
) s
ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalOrders DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;



SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s.TotalOrders
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        COUNT(*) AS TotalOrders
    FROM Sales
    GROUP BY EmployeeID
) s
ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalOrders DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

SELECT 
    p.CategoryID,
    SUM(s.SalesAmount) AS TotalSales
FROM Sales s
JOIN Products p
    ON s.ProductID = p.ProductID
GROUP BY p.CategoryID;



WITH FactorialCTE AS (
    SELECT 
        Number,
        Number AS n,
        1 AS fact
    FROM Numbers1

    UNION ALL

    SELECT 
        f.Number,
        f.n - 1,
        f.fact * (f.n - 1)
    FROM FactorialCTE f
    WHERE f.n > 1
)
SELECT 
    Number,
    MAX(fact) AS Factorial
FROM FactorialCTE
GROUP BY Number
ORDER BY Number;


WITH SplitCTE AS (
    SELECT 
        Id,
        LEFT(String, 1) AS Character,
        RIGHT(String, LEN(String) - 1) AS Remaining
    FROM Example

    UNION ALL

    SELECT 
        Id,
        LEFT(Remaining, 1),
        RIGHT(Remaining, LEN(Remaining) - 1)
    FROM SplitCTE
    WHERE LEN(Remaining) > 0
)
SELECT Id, Character
FROM SplitCTE
ORDER BY Id;


WITH MonthlySales AS (
    SELECT 
        MONTH(SaleDate) AS MonthNumber,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY MONTH(SaleDate)
)
SELECT 
    m1.MonthNumber AS CurrentMonth,
    m1.TotalSales AS CurrentSales,
    m2.TotalSales AS PreviousSales,
    (m1.TotalSales - m2.TotalSales) AS SalesDifference
FROM MonthlySales m1
LEFT JOIN MonthlySales m2
    ON m1.MonthNumber = m2.MonthNumber + 1;


SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    q.Quarter,
    q.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
    HAVING SUM(SalesAmount) > 45000
) q
ON e.EmployeeID = q.EmployeeID
ORDER BY q.Quarter, q.TotalSales DESC;


WITH Fibonacci AS (
    SELECT 1 AS n, 0 AS fib
    UNION ALL
    SELECT 2, 1
    UNION ALL
    SELECT n + 1, fib + LAG(fib) OVER (ORDER BY n)
    FROM Fibonacci
)
SELECT * FROM Fibonacci
WHERE n <= 10;


DECLARE @n INT = 5;

WITH Numbers AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(50)) AS sequence
    UNION ALL
    SELECT num + 1, sequence + CAST(num + 1 AS VARCHAR)
    FROM Numbers
    WHERE num < @n
)
SELECT * FROM Numbers;


SELECT e.EmployeeID, e.FirstName, e.LastName, t.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) AS t
ON e.EmployeeID = t.EmployeeID
WHERE t.TotalSales = (
    SELECT MAX(SUM(SalesAmount))
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
);

