create database hw22
go
use hw22


CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')





	SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS RunningTotalSales
FROM sales_data
ORDER BY customer_id, order_date;


SELECT 
    product_category,
    COUNT(*) AS NumberOfOrders
FROM sales_data
GROUP BY product_category
ORDER BY product_category;



SELECT 
    product_category,
    MAX(total_amount) AS MaxTotalAmount
FROM sales_data
GROUP BY product_category
ORDER BY product_category;


SELECT 
    product_category,
    MIN(unit_price) AS MinUnitPrice
FROM sales_data
GROUP BY product_category
ORDER BY product_category;


SELECT
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAverage3Days
FROM sales_data
ORDER BY order_date;


SELECT
    region,
    SUM(total_amount) AS TotalSales
FROM sales_data
GROUP BY region
ORDER BY region;



SELECT
    customer_id,
    customer_name,
    SUM(total_amount) AS TotalPurchase,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS CustomerRank
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY CustomerRank;



SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS DifferenceFromPreviousSale
FROM sales_data
ORDER BY customer_id, order_date;


SELECT
    product_category,
    product_name,
    unit_price
FROM (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rn
    FROM sales_data
) AS RankedProducts
WHERE rn <= 3
ORDER BY product_category, unit_price DESC;



SELECT
    region,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY region
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS CumulativeSales
FROM sales_data
ORDER BY region, order_date;


SELECT
    product_category,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY product_category
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS CumulativeRevenue
FROM sales_data
ORDER BY product_category, order_date;


SELECT
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS CumulativeSum
FROM sales_data
ORDER BY order_date;



CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);


SELECT
    Value,
    SUM(Value) OVER (
        ORDER BY (SELECT NULL) 
        ROWS UNBOUNDED PRECEDING
    ) AS SumIncludingPrevious
FROM OneColumn;


SELECT 
    customer_id,
    customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;


SELECT
    customer_id,
    customer_name,
    region,
    total_amount
FROM sales_data sd
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM sales_data
    WHERE region = sd.region
);



SELECT
    customer_id,
    customer_name,
    region,
    SUM(total_amount) AS TotalSpending,
    RANK() OVER (
        PARTITION BY region
        ORDER BY SUM(total_amount) DESC
    ) AS CustomerRank
FROM sales_data
GROUP BY customer_id, customer_name, region
ORDER BY region, CustomerRank;



SELECT
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;


WITH MonthlySales AS (
    SELECT
        YEAR(order_date) AS SaleYear,
        MONTH(order_date) AS SaleMonth,
        SUM(total_amount) AS MonthlyTotal
    FROM sales_data
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    SaleYear,
    SaleMonth,
    MonthlyTotal,
    LAG(MonthlyTotal) OVER (ORDER BY SaleYear, SaleMonth) AS PreviousMonthTotal,
    CASE 
        WHEN LAG(MonthlyTotal) OVER (ORDER BY SaleYear, SaleMonth) IS NULL THEN NULL
        ELSE (MonthlyTotal - LAG(MonthlyTotal) OVER (ORDER BY SaleYear, SaleMonth)) 
             * 100.0 / LAG(MonthlyTotal) OVER (ORDER BY SaleYear, SaleMonth)
    END AS growth_rate
FROM MonthlySales
ORDER BY SaleYear, SaleMonth;



WITH LastOrder AS (
    SELECT
        customer_id,
        total_amount AS LastOrderAmount,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM sales_data
)
SELECT
    sd.customer_id,
    sd.customer_name,
    sd.order_date,
    sd.total_amount,
    lo.LastOrderAmount
FROM sales_data sd
JOIN LastOrder lo
    ON sd.customer_id = lo.customer_id
WHERE lo.rn = 1
  AND sd.total_amount > lo.LastOrderAmount;


  SELECT
    product_name,
    unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);

CREATE TABLE MyData ( Id INT, Grp INT, Val1 INT, Val2 INT ); INSERT INTO MyData VALUES (1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

SELECT
    Id,
    Grp,
    Val1,
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp)
        ELSE NULL
    END AS GroupTotal
FROM MyData
ORDER BY Grp, Id;



CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);


SELECT
    ID,
    SUM(Cost) AS TotalCost,
    SUM(Quantity) AS TotalQuantity
FROM TheSumPuzzle
GROUP BY ID;



CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 




WITH OrderedSeats AS (
    SELECT
        SeatNumber,
        ROW_NUMBER() OVER (ORDER BY SeatNumber) AS rn
    FROM Seats
)
SELECT
    MIN(SeatNumber) AS StartSeat,
    MAX(SeatNumber) AS EndSeat
FROM OrderedSeats
GROUP BY SeatNumber - rn
ORDER BY StartSeat;
