create database hw17
go
use hw17


DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

WITH AllCombinations AS (
    SELECT DISTINCT r.Region, d.Distributor
    FROM #RegionSales r
    CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) d
)

SELECT 
    a.Region,
    a.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllCombinations a
LEFT JOIN #RegionSales rs
    ON a.Region = rs.Region
   AND a.Distributor = rs.Distributor
ORDER BY a.Distributor, a.Region;


CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);



SELECT 
    e1.name AS ManagerName,
    COUNT(e2.id) AS DirectReports
FROM Employee e1
JOIN Employee e2
    ON e1.id = e2.managerId
GROUP BY e1.name
HAVING COUNT(e2.id) >= 5;


CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);


SELECT 
    p.product_name,
    SUM(o.unit) AS total_units
FROM Products p
JOIN Orders o
    ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' 
  AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;


DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');



DROP TABLE IF EXISTS Orders;
GO

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    [Count] INTEGER NOT NULL,
    Vendor VARCHAR(180) NOT NULL
);
GO

INSERT INTO Orders VALUES
(1, 1081, 12, 'Direct Parts'),
(2, 1081, 54, 'Direct Parts'),
(3, 1081, 32, 'RCHE'),
(4, 2082, 7, 'RCHE'),
(5, 2082, 16, 'RCHE'),
(6, 2082, 5, 'Direct Parts');

WITH VendorCounts AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID, Vendor
),
MaxVendor AS (
    SELECT 
        CustomerID,
        MAX(TotalOrders) AS MaxOrders
    FROM VendorCounts
    GROUP BY CustomerID
)
SELECT 
    v.CustomerID,
    v.Vendor,
    v.TotalOrders
FROM VendorCounts v
JOIN MaxVendor m
    ON v.CustomerID = m.CustomerID 
   AND v.TotalOrders = m.MaxOrders;


   DECLARE @Check_Prime INT = 91; 

   CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');


WITH LocationCount AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS SignalCount
    FROM Device
    GROUP BY Device_id, Locations
),
MaxLocation AS (
    SELECT 
        Device_id,
        MAX(SignalCount) AS MaxSignals
    FROM LocationCount
    GROUP BY Device_id
)
SELECT 
    lc.Device_id,
    COUNT(DISTINCT lc.Locations) AS NumLocations,
    lc.Locations AS MostSignalLocation,
    SUM(lc.SignalCount) AS TotalSignals
FROM LocationCount lc
JOIN MaxLocation ml
    ON lc.Device_id = ml.Device_id 
   AND lc.SignalCount = ml.MaxSignals
GROUP BY lc.Device_id, lc.Locations;

DROP TABLE IF EXISTS Employee;


CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);




SELECT 
    e.EmpID,
    e.EmpName,
    e.Salary
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);


CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);


WITH user_platform AS (
    SELECT 
        Spend_date,
        User_id,
        SUM(Amount) AS TotalAmount,
        COUNT(DISTINCT Platform) AS PlatformCount,
        MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS HasMobile,
        MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS HasDesktop
    FROM Spending
    GROUP BY Spend_date, User_id
)
SELECT 
    Spend_date,
    SUM(CASE WHEN HasMobile = 1 AND HasDesktop = 0 THEN 1 ELSE 0 END) AS mobile_only_users,
    SUM(CASE WHEN HasMobile = 1 AND HasDesktop = 0 THEN TotalAmount ELSE 0 END) AS mobile_only_amount,
    SUM(CASE WHEN HasDesktop = 1 AND HasMobile = 0 THEN 1 ELSE 0 END) AS desktop_only_users,
    SUM(CASE WHEN HasDesktop = 1 AND HasMobile = 0 THEN TotalAmount ELSE 0 END) AS desktop_only_amount,
    SUM(CASE WHEN HasMobile = 1 AND HasDesktop = 1 THEN 1 ELSE 0 END) AS both_users,
    SUM(CASE WHEN HasMobile = 1 AND HasDesktop = 1 THEN TotalAmount ELSE 0 END) AS both_amount
FROM user_platform
GROUP BY Spend_date
ORDER BY Spend_date;

DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);


WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL SELECT n + 1 FROM Numbers WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT g.Product
FROM Grouped g
JOIN Numbers n
  ON n.n <= g.Quantity
ORDER BY g.Product;
