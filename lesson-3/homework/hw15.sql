create database hw15
go 
use hw15

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000);

select 
	id,
	name,
	salary
from employees
where salary =( select min(salary) from employees);


CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);



select 
	id, 
	product_name,
	price
from products
WHERE price >(select avg(price)from products);



CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);


DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);

SELECT 
    name
FROM employees
WHERE department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'Sales'
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);




SELECT 
    name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders
);


DROP TABLE IF EXISTS products;


CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);



SELECT 
    p.id,
    p.product_name,
    p.price,
    p.category_id
FROM products p
WHERE p.price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;


CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);


SELECT 
    e.id,
    e.name,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d
    ON e.department_id = d.id
WHERE e.department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);



SELECT 
    e.id,
    e.name,
    e.salary,
    e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

SELECT 
    s.name,
    g.course_id,
    g.grade
FROM grades g
JOIN students s 
    ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);



DROP TABLE IF EXISTS products;


CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);


SELECT 
    id,
    product_name,
    price,
    category_id
FROM (
    SELECT 
        id,
        product_name,
        price,
        category_id,
        DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rank_num
    FROM products
) ranked_products
WHERE rank_num = 3;

DROP TABLE IF EXISTS employees;


CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);


SELECT 
    id,
    name,
    salary,
    department_id
FROM employees e
WHERE 
    salary > (SELECT AVG(salary) FROM employees)
    AND salary < (
        SELECT MAX(salary)
        FROM employees
        WHERE department_id = e.department_id
    );
