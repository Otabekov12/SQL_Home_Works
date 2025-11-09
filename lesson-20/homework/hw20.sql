create  database hw20
go 
use hw20;

CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);


INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');


SELECT DISTINCT S.CustomerName
FROM #Sales S
WHERE EXISTS (
    SELECT 1
    FROM #Sales AS Sub
    WHERE Sub.CustomerName = S.CustomerName
      AND Sub.SaleDate BETWEEN '2024-03-01' AND '2024-03-31'
);


SELECT Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = (
    SELECT MAX(Total)
    FROM (
        SELECT SUM(Quantity * Price) AS Total
        FROM #Sales
        GROUP BY Product
    ) AS Sub
);


SELECT MAX(Quantity * Price) AS SecondHighestSale
FROM #Sales
WHERE (Quantity * Price) < (
    SELECT MAX(Quantity * Price)
    FROM #Sales
);



SELECT 
    DATEPART(MONTH, SaleDate) AS MonthNumber,
    DATEPART(YEAR, SaleDate) AS YearNumber,
    (
        SELECT SUM(Quantity)
        FROM #Sales AS S2
        WHERE DATEPART(MONTH, S2.SaleDate) = DATEPART(MONTH, S1.SaleDate)
          AND DATEPART(YEAR, S2.SaleDate) = DATEPART(YEAR, S1.SaleDate)
    ) AS TotalQuantity
FROM #Sales AS S1
GROUP BY DATEPART(MONTH, SaleDate), DATEPART(YEAR, SaleDate)
ORDER BY YearNumber, MonthNumber;



SELECT DISTINCT S1.CustomerName
FROM #Sales AS S1
WHERE EXISTS (
    SELECT 1
    FROM #Sales AS S2
    WHERE S2.Product = S1.Product
      AND S2.CustomerName <> S1.CustomerName
);



SELECT DISTINCT S1.CustomerName
FROM #Sales AS S1
WHERE EXISTS (
    SELECT 1
    FROM #Sales AS S2
    WHERE S2.Product = S1.Product
      AND S2.CustomerName <> S1.CustomerName
);


create table Fruits(Name varchar(50), Fruit varchar(50))
insert into Fruits values ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Orange'),
							('Francesko', 'Banana'), ('Francesko', 'Orange'), ('Li', 'Apple'), 
							('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'), ('Mario', 'Apple'), ('Mario', 'Apple'), 
							('Mario', 'Apple'), ('Mario', 'Banana'), ('Mario', 'Banana'), 
							('Mario', 'Orange')


SELECT 
    Name,
    Fruit,
    COUNT(*) AS FruitCount
FROM Fruits
GROUP BY Name, Fruit
ORDER BY Name, Fruit;




create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)


WITH FamilyTree AS (
    SELECT ParentId, ChildID
    FROM Family
    UNION ALL
    SELECT f.ParentId, c.ChildID
    FROM Family f
    JOIN FamilyTree c ON f.ChildID = c.ParentId
)
SELECT DISTINCT ParentId AS PID, ChildID AS CHID
FROM FamilyTree
ORDER BY PID, CHID;




CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);


INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

SELECT *
FROM #Orders AS O
WHERE O.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders AS CA
      WHERE CA.CustomerID = O.CustomerID
        AND CA.DeliveryState = 'CA'
  );


  create table #residents(resid int identity, fullname varchar(50), address varchar(100))

insert into #residents values 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22')


  UPDATE #residents
SET address = address + ' name=' + fullname
WHERE address NOT LIKE '%name=%';


CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);


WITH RouteCTE AS (
    SELECT 
        DepartureCity, 
        ArrivalCity, 
        CAST(DepartureCity + ' -> ' + ArrivalCity AS VARCHAR(200)) AS Path,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    
    UNION ALL
    
    SELECT 
        r.DepartureCity,
        r.ArrivalCity,
        CAST(c.Path + ' -> ' + r.ArrivalCity AS VARCHAR(200)),
        c.Cost + r.Cost
    FROM #Routes r
    JOIN RouteCTE c ON r.DepartureCity = c.ArrivalCity
)
SELECT TOP 1 'Cheapest route' AS Type, Path, Cost
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC

UNION ALL

SELECT TOP 1 'Most expensive route' AS Type, Path, Cost
FROM RouteCTE
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost DESC;





CREATE TABLE #RankingPuzzle
(
     ID INT
    ,Vals VARCHAR(10)
)

 
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),
(2,'a'),
(3,'a'),
(4,'a'),
(5,'a'),
(6,'Product'),
(7,'b'),
(8,'b'),
(9,'Product'),
(10,'c')



SELECT 
    ID,
    Vals,
    SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END) 
        OVER (ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductRank
FROM #RankingPuzzle;




CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);



SELECT 
    e.EmployeeName,
    e.Department,
    e.SalesAmount
FROM #EmployeeSales e
JOIN (
    SELECT 
        Department,
        AVG(SalesAmount) AS AvgSales
    FROM #EmployeeSales
    GROUP BY Department
) AS deptAvg
    ON e.Department = deptAvg.Department
WHERE e.SalesAmount > deptAvg.AvgSales;



SELECT 
    e.EmployeeName,
    e.Department,
    e.SalesAmount,
    e.SalesMonth,
    e.SalesYear
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales s
    WHERE s.SalesMonth = e.SalesMonth
      AND s.SalesYear = e.SalesYear
    GROUP BY s.SalesMonth, s.SalesYear
    HAVING e.SalesAmount = MAX(s.SalesAmount)
);


SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT s.SalesMonth
    FROM #EmployeeSales s
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales x
        WHERE x.EmployeeName = e.EmployeeName
          AND x.SalesMonth = s.SalesMonth
    )
);


CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    Name        VARCHAR(50),
    Category    VARCHAR(50),
    Price       DECIMAL(10,2),
    Stock       INT
);

INSERT INTO Products (ProductID, Name, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1200.00, 15),
(2, 'Smartphone', 'Electronics', 800.00, 30),
(3, 'Tablet', 'Electronics', 500.00, 25),
(4, 'Headphones', 'Accessories', 150.00, 50),
(5, 'Keyboard', 'Accessories', 100.00, 40),
(6, 'Monitor', 'Electronics', 300.00, 20),
(7, 'Mouse', 'Accessories', 50.00, 60),
(8, 'Chair', 'Furniture', 200.00, 10),
(9, 'Desk', 'Furniture', 400.00, 5),
(10, 'Printer', 'Office Supplies', 250.00, 12),
(11, 'Scanner', 'Office Supplies', 180.00, 8),
(12, 'Notebook', 'Stationery', 10.00, 100),
(13, 'Pen', 'Stationery', 2.00, 500),
(14, 'Backpack', 'Accessories', 80.00, 30),
(15, 'Lamp', 'Furniture', 60.00, 25);


SELECT Name, Price
FROM Products 
WHERE Price > (
    SELECT AVG(Price)
    FROM Products 
);


SELECT Name, Stock
FROM Products
WHERE Stock < (
    SELECT MAX(Stock)
    FROM Products
);


SELECT Name
FROM Products
WHERE Category = (
    SELECT Category 
    FROM Products 
    WHERE Name = 'Laptop'
);


SELECT Name, Price, Category
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);


CREATE TABLE Orders (
    OrderID    INT PRIMARY KEY,
    ProductID  INT,
    Quantity   INT,
    OrderDate  DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 2, '2024-03-01'),
(2, 3, 5, '2024-03-05'),
(3, 2, 3, '2024-03-07'),
(4, 5, 4, '2024-03-10'),
(5, 8, 1, '2024-03-12'),
(6, 10, 2, '2024-03-15'),
(7, 12, 10, '2024-03-18'),
(8, 7, 6, '2024-03-20'),
(9, 6, 2, '2024-03-22'),
(10, 4, 3, '2024-03-25'),
(11, 9, 2, '2024-03-28'),
(12, 11, 1, '2024-03-30'),
(13, 14, 4, '2024-04-02'),
(14, 15, 5, '2024-04-05'),
(15, 13, 20, '2024-04-08');



SELECT 
    p.Name, 
    p.Category, 
    p.Price
FROM Products p
WHERE p.Price > (
    SELECT AVG(p2.Price)
    FROM Products p2
    WHERE p2.Category = p.Category
);


SELECT ProductID
FROM Orders
GROUP BY ProductID
HAVING COUNT(*) >= 1;



SELECT p.Name
FROM Products p
WHERE p.ProductID IN (
    SELECT o.ProductID
    FROM Orders o
    GROUP BY o.ProductID
    HAVING AVG(o.Quantity) > (SELECT AVG(Quantity) FROM Orders)
);

SELECT ProductID, Name
FROM Products
WHERE ProductID NOT IN (SELECT DISTINCT ProductID FROM Orders WHERE ProductID IS NOT NULL);



SELECT 
    p.ProductID,
    p.Name,
    SUM(o.Quantity) as TotalQuantity
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
HAVING SUM(o.Quantity) = (
    SELECT MAX(TotalQty) 
    FROM (
        SELECT SUM(Quantity) as TotalQty
        FROM Orders
        GROUP BY ProductID
    ) as SubQuery
);
