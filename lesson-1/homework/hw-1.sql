-- 1. Define the following terms: data, database, relational database, and table. 

-- Data is can be numbers 12, word "tea", the date 12.12.1999 these individual pieces are data points.

-- Database is an organized collection  of related data, it is structured to be easily accessed, managed, updated, and controlled.

-- Relational database a collection of multiple tables that can be linked together a students table and a university table.

-- Table it's a collection of related data organized in a structured format of rows and columns. Each table is dedicated to representing
-- a specific entity or subject (e.g., 'Users', 'Products', 'Employees').

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 2.List five key features of SQL Server.

--  1) High performance and scalability: in-memory OLTP, columnstore indexes, query optimizer.
--  2) Robust security features: transparent data encryption, always encrypted.
--  3) Comprehensive business intelligence (BI) and analytics: integration services(SSIS), reporting services(SSRS), analysis services(SSAS).
--  4) High availability and disaster recovery: always on availability groups, failover cluster instances.
--  5) Deep integration with the microsoft ecosystem and cloud (Azure): microsoft azure integration.

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2):

--  1. Windows authentication mode -When a user attempts to connect, SQL Server checks the Windows principal token provided by the OS.
--It verifies if the user has been granted access to the SQL Server instance.

--  2. Mixed Mode Authentication (SQL Server and Windows Authentication)Users can connect either with their Windows credentials or by 
--providing a dedicated SQL Server login name and password. The famous sa (system administrator) account is a SQL Server login created
--during installation when Mixed Mode is selected.

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 4 Create a new database in SSMS named SchoolDB.

create database SchoolDB;
use SchoolDB;

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 5 Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

select * from Students ;

-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--  6 Describe the differences between SQL Server, SSMS, and SQL.

-- SQL Server is the software that hosts, manages, and secures your databases.

-- SQL is the language you use to talk to a database.

-- SSMS is the client tool you install on your PC to work with and manage your SQL Server.

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.

--  1) Data Query Language (DQL) retrieves data from databases, Key Commands: INSERT, UPDATE, DELETE
--  2) Data Manipulation Language (DML) modifies data within tables (insert, update, delete) Key Commands: INSERT, UPDATE, DELETE
--  3) Data Definition Language (DDL) defines or modifies database structures. Key Commands: CREATE, ALTER, DROP, TRUNCATE, RENAME 
--  4) Data Control Language (DCL) manages access permissions and security. Key Commands: GRANT, REVOKE 
--  5) Transaction Control Language (TCL) manages transactions to ensure data consistency Key Commands: COMMIT, ROLLBACK, SAVEPOINT.

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- 8. Write a query to insert three records into the Students table.


INSERT INTO Students (StudentID,  Name, age)
VALUES 
(1, 'Valiyev', 20),
(2, 'Rasulova', 21),
(3, 'Hakimov', 22);


