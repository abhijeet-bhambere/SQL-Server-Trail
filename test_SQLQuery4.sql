--To check all databases in SQL Server instance
--sp_helpdb test_employeeDB

/*--DDL Alter command - mdf/ldf files: 
ALTER DATABASE test_newEmpDB
Modify NAME = test_newEmployeeDB

--Drop database; Safest method It rolls back any open transactions and disconnects users.
ALTER DATABASE test_newEmployeeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE test_newEmployeeDB*/

--Creating a table in test employeeDB
USE test_employeeDB
CREATE TABLE EmpDetails
(
emp_id INT NOT NULL,
first_name varchar not null,
last_name varchar null,
salary int null,
joined_date date not null
)



----------------------CREATE TABLE: Creating another table in test employeeDB--------------------
USE test_employeeDB
CREATE TABLE new_emp_details
(
emp_id INT NOT NULL,
first_name varchar(50) not null,
last_name varchar(50) null,
salary numeric(10,2) null,
joined_date date not null
);

sp_help empl_details

sp_help EmpDetails


-----------------------------INSERT: to insert new rows into a table----------------------------
INSERT test_employeeDB.dbo.new_emp_details
VALUES
	(1, 'Michael', 'Scott', 60000.00, '2025-09-23'),
	(2, 'Jim', 'Halpert', 52000.00, '2025-09-23'),
	(3, 'Pam', 'Beesly', 45000.00, '2025-09-23'),
	(4, 'Dwight', 'Schrute', 48000.00, '2025-09-23'),
	(5, 'Stanley', 'Hudson', 51000.00, '2025-09-23'),
	(6, 'Phyllis', 'Vance', 49500.00, '2025-09-23'),
	(7, 'Kevin', 'Malone', 47000.00, '2025-09-23'),
	(8, 'Angela', 'Martin', 49000.00, '2025-09-23'),
	(9, 'Oscar', 'Martinez', 50000.00, '2025-09-23'),
	(10, 'Creed', 'Bratton', 45000.00, '2025-09-23'),
	(11, 'Kelly', 'Kapoor', 43000.00, '2025-09-23'),
	(12, 'Ryan', 'Howard', 40000.00, '2025-09-23'),
	(13, 'Toby', 'Flenderson', 46000.00, '2025-09-23');

sp_help new_emp_details

-----------------------ALTER TABLE: to modify column attributes at table-level -----------------------
--Altering the EmpDetails table column attributes with datatype as varchar 
-- This is being done as VARCHAR value was not defined earlier 

ALTER TABLE EmpDetails
ALTER COLUMN first_name VARCHAR(50);

ALTER TABLE EmpDetails
ALTER COLUMN last_name VARCHAR(50);

sp_help EmpDetails


--Now trying to insert rows into EmpDetails
INSERT test_employeeDB.dbo.EmpDetails
VALUES
	(1, 'Michael', 'Scott', 60000.00, '2025-09-23'),
	(2, 'Jim', 'Halpert', 52000.00, '2025-09-23'),
	(3, 'Pam', 'Beesly', 45000.00, '2025-09-23'),
	(4, 'Dwight', 'Schrute', 48000.00, '2025-09-23'),
	(5, 'Stanley', 'Hudson', 51000.00, '2025-09-23'),
	(6, 'Phyllis', 'Vance', 49500.00, '2025-09-23'),
	(7, 'Kevin', 'Malone', 47000.00, '2025-09-23'),
	(8, 'Angela', 'Martin', 49000.00, '2025-09-23'),
	(9, 'Oscar', 'Martinez', 50000.00, '2025-09-23'),
	(10, 'Creed', 'Bratton', 45000.00, '2025-09-23'),
	(11, 'Kelly', 'Kapoor', 43000.00, '2025-09-23'),
	(12, 'Ryan', 'Howard', 40000.00, '2025-09-23'),
	(13, 'Toby', 'Flenderson', 46000.00, '2025-09-23');

sp_help EmpDetails


--Attempting to Add a new row with values present only for select fields
INSERT test_employeeDB.dbo.EmpDetails(emp_id, first_name, salary)
VALUES(14,'John', 50000);
--NOTE : this will throw an error since we defined that 'first_name' & 'joined_date' column cannot have NULL value
--Attempting again
INSERT INTO test_employeeDB.dbo.EmpDetails(emp_id, first_name, salary, joined_date)
VALUES(14,'John', 50000, '2025-09-27');


----------------------IDENTITY COLUMN: Creating a new table that contains a column that auto-generates values on adding new rows-------------------
--useful for adding a 'Serial No.s' columns. NOTE: IDENTITY columns by default are persistent & not 
CREATE TABLE TEST_EmpDetails
(emp_id INT IDENTITY(1000,1) NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(70) NOT NULL,
salary INT NULL,
join_date DATE NOT NULL
);

--Now insert rows into TEST_EmpDetails
INSERT INTO TEST_EmpDetails(first_name, last_name, salary, join_date)
VALUES
	('Michael', 'Scott', 75000, '1992-04-15'),   -- Regional Manager since early 90s
	('Dwight', 'Schrute', 55000, '1998-06-20'),  -- Joined before series, Assistant to the RM
	('Jim', 'Halpert', 50000, '2001-02-12'),     -- Around 8 years before Season 5
	('Pam', 'Beesly', 40000, '2003-05-01'),      -- Receptionist since early 2000s
	('Angela', 'Martin', 42000, '2002-11-10'),   -- Head of Accounting dept
	('Kevin', 'Malone', 39000, '2002-11-10'),    -- Same hiring wave as Angela
	('Oscar', 'Martinez', 45000, '1999-09-01'),  -- Long-time accountant
	('Stanley', 'Hudson', 48000, '1996-03-15'),  -- Sales veteran
	('Phyllis', 'Vance', 47000, '1994-08-05'),   -- Sales, long-time employee
	('Creed', 'Bratton', 30000, '1971-01-01');   -- Mysteriously there forever
--The EmployeeID values are added auto-generated in serial order of the values

--Now trying to add new employee with an existing employeeID:
INSERT INTO TEST_EmpDetails(emp_id, first_name, last_name, salary, join_date)
VALUES 
	(1000, 'John', 'Wick', 75000, '1992-04-15');   -- babaYaga

--We get IDENTITY INSERT Error as we cannot have the specify explicit values for emplloyeeID column
--Workaround is to set IDENTITY_INSERT ON and OFF after inserting a row with existing IDENTITY value

--But this won't occur normally since very aim of an IDENTITY column is to serve as a Primary Key
--So, gaps are normal after table row deletions

---------------------------------------ALTER TABLE (more operations)------------------------------------------------
--Adding an email column to the existing TEST_EmpDetails table
--concatenated values of first_name.last_name@email.com
ALTER TABLE TEST_EmpDetails
ADD email VARCHAR(150);

------------------DEFAULT CONTRAINTS: Also adding phone no.s & country column with default value-----------------
--It'll add default value to all new rows that'll be added to this table ; DOESN'T modify existing rows
ALTER TABLE TEST_EmpDetails
ADD phone VARCHAR(40),
	country VARCHAR(100) DEFAULT 'United States';

--Now adding a new value, default value is added for this new entry in the country column:
INSERT INTO TEST_EmpDetails(first_name, last_name, join_date)
VALUES('sheldon' , 'cooper', '2005-01-12');

-----------------------DROP COLUMN: deleting an entire column altogether------------------------
ALTER TABLE TEST_EmpDetails
DROP COLUMN phone


SELECT TOP(100) * FROM TEST_EmpDetails
sp_help TEST_EmpDetails --table overview


-------------------------------DROP TABLE: to permanently delete a table from a dB--------------------------------
--Triggers, Constraint, Indexes are dropped automatically
--But user need to ensure to also drop all the dependent objects such as views, procedures etc.
DROP TABLE empl_details;

--------------------------DELETE TABLE: preserves table structure while only deleting data-----------------------
--We can also selectively delete rows based on filtering
--NOTE that DELETE 
DELETE FROM EmpDetails 
WHERE salary < 46000 
--Checking the table again after the operation we can see the rows that matched the criteria have been deleted
SELECT * FROM EmpDetails
--Now deleting all entries
DELETE FROM EmpDetails
--Checking the table again we can see all rows have been deleted but the struture has been retained
SELECT * FROM TEST_EmpDetails



USE test_employeeDB
-------------------------------------------------CREATE SCHEMA-------------------------------------------------------
--creating logical orginization & namespace that holds tables, views, procedures & other dB objects
--This makes it easier to maintain dB structure ; identify & control user roles to portions of the dB

--Creating a sample dB - Department that will house different schemas for HR , IT , R&D etc.
CREATE DATABASE Test_Dept
USE Test_Dept

CREATE SCHEMA HR;
CREATE SCHEMA IT;
CREATE SCHEMA RD;

--Example-1: Specifying schema name during table creation step
CREATE TABLE HR.Employees
(emp_id INT IDENTITY(100,1) NOT NULL,
first_name VARCHAR(50) not null,
last_name VARCHAR(50) null
);

--Example-2: using ALTER SCHEMA to transfer schema AFTER creating table; 
CREATE TABLE Employees
(emp_id INT IDENTITY(100,1) NOT NULL,
first_name VARCHAR(50) not null,
last_name VARCHAR(50) null
);
--this creates the table in the default dbo schema 

--Now altering table schema to shift the table's schema from dbo to IT
ALTER SCHEMA IT --destination
TRANSFER dbo.Employees --tsble to transferred


-------------------------------------------------CONSTRAINTS------------------------------------------------------------
USE test_employeeDB

--Creating a department table that will be linked to employees table
CREATE SCHEMA dept;

CREATE TABLE dept.departments
(	deptID INT IDENTITY(200,1) PRIMARY KEY,
	dept_name VARCHAR(50) not null,
	emp_count INT DEFAULT 1
);
INSERT INTO dept.departments(dept_name)
VALUES('HR'),
		('IT'),
		('Legal'),
		('Sales'),
		('Management'),
		('Accounting'),
		('Support');

SELECT * FROM dept.departments

/*ALTER DATABASE test_employeeDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
drop table dept.deptartments;

USE master;
GO

ALTER DATABASE test_employeeDB
SET MULTI_USER;
GO

SELECT 
    session_id,    login_name,   host_name,    program_name,    status
FROM sys.dm_exec_sessions
WHERE database_id = DB_ID('test_employeeDB');*/

---------------------------------------------------------------------------------------------------------
--Creating a new table with constraints to maintain data integrity
CREATE TABLE sep1_Emp_Details
(
EmpId int PRIMARY KEY,
FirstName VARCHAR(50) ,
LastName VARCHAR(50),
SALARY INT,
JoinDate date,
Dept INT REFERENCES dept.departments(deptID)
);


--Ensure the column values containing FK are valid & present in the referenced table
INSERT sep1_Emp_Details
VALUES
	(1001, 'Michael', 'Scott', 60000, '2025-09-23',204),
	(1002, 'Jim', 'Halpert', 52000, '2025-09-23',203);

--If not esured, SQL will throw error FK conflict error
INSERT sep1_Emp_Details
VALUES
	(1003, 'Pam', 'Beesley', 45000, '2025-09-23',301);



-------------------------------------------CHECK Constraint----------------------------------------------------
--Ensures only values that match the criteria are added into the dB table
--Creating a new table for example
CREATE TABLE sep2_Emp_Details
(
EmpId int IDENTITY(10001,1) PRIMARY KEY,--EmpID set to auto-generate
FirstName VARCHAR(50) ,
LastName VARCHAR(50),
SALARY DECIMAL(10,2),
Dept INT REFERENCES dept.departments(deptID),
City VARCHAR(50) CONSTRAINT chkCity CHECK(City in ('Scranton','New York','Chicago', 'Seattle')),--added CHECK constraint
Age INT
);
--Inserting a sample value
INSERT INTO sep2_Emp_Details(FirstName, City)
VALUES( 'Pam', 'New York');
--Trying to insert a city outside of defined constraints
INSERT INTO sep2_Emp_Details(FirstName, City)
VALUES( 'Jim', 'Los Angeles');
--It gives the conflict error for CHECK constraint since LA is not in the pre-defined allowed city names.

--Now also altering the Age column to check if age is within limits
ALTER TABLE sep2_Emp_Details
ADD CONSTRAINT chkAge CHECK(Age BETWEEN 18 AND 70)
--Inserting new valieto test constraint added on Age column
INSERT INTO sep2_Emp_Details(FirstName, City, Age)
VALUES( 'Jim', 'Scranton', 27);
--The row was addded only when all constraints were met

select * from sep2_Emp_Details;


----------------------IMPORTING FROM EXCEL FILES: Using SQL Server Import Export Wizard-------------------------
CREATE DATABASE SuperStoreDB
--Renaming the tables using a system stored procedure - sp_rename
EXEC sp_rename 'Returns$', 'Returns';

USE SuperStoreDB

SELECT  TOP(5)*  FROM dbo.Orders;
SELECT  *  FROM dbo.People;
SELECT *  FROM dbo.Returns;

-------------------------Using Distinct keyword--------------------
SELECT DISTINCT [Segment]
FROM Orders

SELECT DISTINCT [State]
FROM Orders ORDER BY [State]


------------------Using WHERE condition for filtering-------------------
--Selecting 10 orders from state of Florida
SELECT TOP(10) * FROM ORDERS
WHERE [State] = 'Florida'

--Selecting orders from state of California with multiple Logical conditions
SELECT  * FROM ORDERS
WHERE [State] = 'California' AND ([City]='Los Angeles' OR [City]='San Francisco')

-----------------------USING LOGICAL COMPARISON-------------------------
--selecting all orders with Order Qnty greater than 10
SELECT * FROM ORDERS
WHERE [Quantity] > 10
--seleting all orders where segment state is NOT Ohio
SELECT * FROM ORDERS
WHERE [State] <> 'Ohio'

---------Filtering on multiple conitions (using AND / OR in WHERE)-----------
--Filtering same-day deliveries in Seattle
SELECT * FROM Orders
WHERE [Ship Mode]='Same Day' AND [City]='Seattle'

SELECT DISTINCT [sub-category]
FROM Orders ORDER BY [Sub-Category]


--Filtering orders from June onwards in Corporate segment
SELECT * FROM Orders
WHERE (MONTH([Order Date]) >= 06) AND [Segment]='Home Office'

--------------------------------------Filtering with Range operators----------------------------------------------
--Using Between operator - its inclusive of min & max limits
SELECT * FROM Orders
WHERE ([Sales] BETWEEN 5000 AND 20000)

--Adding more criteria in same filter
SELECT * FROM Orders
WHERE ([Sales] BETWEEN 5000 AND 20000) AND ([City]='New York City' )

-------------------------List Operators - IN & NOT IN oprators---------------------
--Works like a multi-OR statement ; Checks whether or not a value is in a list of places
SELECT * FROM Orders
WHERE [State] IN('New York', 'Texas', 'Utah')

-------------------------Wildcards in SQL server - helps to search for string pattern--------------------------------
--fetch all orders from States that start with string 'New'
SELECT * FROM Orders
WHERE [State] LIKE 'New%'

--fetch all orders from states ending with 'y'
SELECT * FROM Orders
WHERE [State] LIKE '%Y'

--fetch all orders from states having 'y' in second place
SELECT * FROM Orders
WHERE [State] LIKE '_y%'

-----------------------------Using RegEx in LIKE filters-----------------------------------
--fetch all orders from Cities that start with string 'D' & ending with either 's' or 'a'
SELECT * FROM Orders
WHERE [City] LIKE 'D%[s|a]'

--------------------------UPDATE keyword - to modify existing field values-------------------------
USE test_employeeDB

Select * from [dbo].TEST_EmpDetails
---Updating Country where employee salary is less than 40000
--So there's two records matching this salary filter ; updating country to 'USA
UPDATE TEST_EmpDetails
SET [country] = 'USA'
WHERE [salary] < 40000

--Checking the updated rows
SELECT * FROM TEST_EmpDetails
WHERE [salary]<40000


---------------------------------------SORTing rows in a table---------------------------------------------
--can be sorted for multiple columns
SELECT * FROM TEST_EmpDetails
ORDER BY [first_name] DESC

USE SuperStoreDB
SELECT TOP(50) * From Orders
ORDER BY [Order Date] DESC

-------------------------------------------------AGGREGATE FUNCTIONS------------------------------------------------------
--Aggregate functions are applied on multiple rows of a single column of a table & return an output as a single value
--Selecting distinct cout of states that are mentioned in the State column
SELECT COUNT(DISTINCT [State] )
FROM Orders

--Fetch average sales 
SELECT AVG([Sales]) AS 'Avg Sales'
FROM Orders

--fetch Max & Min profits
SELECT MAX([Profit]) AS 'Max Profit',
	MIN([Profit]) AS 'Min Profit'
FROM Orders


----------------------------------------------------------GROUP BY clause--------------------------------------------------------
--Used in a SELECT statement to organize rows that have the same values in one or more specified columns into a summary set of rows.
--The summary is usually achieved by an aggregating function such as avg / min/ max/ count etc.
USE SuperStoreDB

--Counting no. of orders by each state & city
SELECT [State], 
		[City],
		COUNT([Order ID]) AS'Order Count'
FROM Orders
GROUP BY [State],[City]
ORDER BY [State] ASC, 'Order Count' DESC

--Sum of sales By state
SELECT [State], 
		SUM([Sales]) AS 'Total Sales'
FROM Orders
GROUP BY [State]
ORDER BY 'Total Sales' DESC

--Adding multiple aggregrate columns - count of orders AND sum of sales By state
SELECT [State], 
		COUNT([Order ID]) AS 'Orders Count',
		SUM([Sales]) AS 'Total Sales'
FROM Orders
GROUP BY [State]
ORDER BY 'Orders Count' DESC,'Total Sales' DESC

-----------------------------------------------USING GROUP BY - HAVING clause--------------------------------------------------------
--HAVING clause helps to filter on the aggregate column
--Filtering rows with
SELECT [State], 
		total_profit = SUM([Profit])
FROM Orders
GROUP BY [State]
HAVING SUM([Profit]) > 10000
ORDER BY total_profit DESC


-----------------------------------------------USING String functions--------------------------------------------------------
--SQL Server string functions are used to manipulate and retrieve information from string data.
--These functions are essential for tasks such as data cleaning, formatting, and extraction of specific parts of text.

--Performing string operations on City & state columns
SELECT DISTINCT
		[City], UPPER([City]) AS 'City_AllCaps',
		[State], LOWER([State]) AS 'State_AllLower'
FROM Orders ORDER BY [City]

USE SuperStoreDB
--Using SUBSTRING function to extract Sub-Category from the full ProductID column
--specify>> [column],start_index , stop_index
SELECT [Product ID], SUBSTRING([Product ID],5, 2) AS 'SubCats'
FROM Orders

--Using LEFT ; outer TRIM helps to address trailing whitespaces
SELECT [Customer Name], TRIM(LEFT([Customer Name],CHARINDEX(' ',[Customer Name]))) AS 'FirstName_Extract'
FROM Orders

SELECT * FROM Orders

------------------------------------Using DATETIME functions-------------------------------------------
--Funcs used to specifically manipulate values in fields with the datetime data type
--Calculating difference between order date & shipping date
SELECT [Order ID], [Order Date], [Ship Date],
		DATEDIFF(day, [Order Date], [Ship Date]) AS 'O2S'
FROM Orders
--ORDER BY 'O2S' DESC --optional

--Convert datetime column (in YYYY-MM-DD HH:MM:SS) in desired format to simply date
SELECT [Order Date] , FORMAT([Order Date] , 'yyyy-MMM-dd')
FROM Orders

--Get current date in a datetime format (YYYY-MM-DD HH:MM:SS)
SELECT GETDATE();

------------------------------------------Using DATEPART --------------------------------------------------
--Extracts and returns a specified part of a given date as an integer value.
SELECT [Order Date], 
		DATEPART(DAY,[Order Date]) AS 'Day_only',--DATEPART returns specified part as integer
		DATENAME(MONTH,[Order Date]) AS 'Month_only',--DATENAME returns specified part as string
		DATEPART(YEAR,[Order Date]) AS 'Year_only'
FROM Orders

----------------------------------------MATH functions--------------------------------------------
--Used to perform calculations on numeric data ranging from simple arithmetic to complex statistical analysis.
--Funcs such as ABS, CEILING, FLOOR, ROUND, SQRT, POWER etc.
--Example-1
SELECT [Profit]
		, ABS([Profit]) AS 'Absolute'
		, ROUND([Profit],2) AS 'RoundOff'
		, CEILING([Profit]) AS 'Ceiling' --Gives highest closest integer
		, FLOOR([Profit]) AS 'Floor' --Gives lowest closest integer
FROM Orders

--Example-2
SELECT [Profit]
		, ABS([Profit]) AS 'Absolute'
		, ROUND([Profit],2) AS 'RoundOff'
		, CEILING([Profit]) AS 'Ceiling' --Gives highest closest integer
		, FLOOR([Profit]) AS 'Floor' --Gives lowest closest integer
FROM Orders WHERE [Profit] <1

--Filtering profit values having >3 decimal places
SELECT [Profit]
FROM Orders WHERE [Profit] <> ROUND([Profit],3)

--------------------------------Data Conversion functions-----------------------------------------
--CAST: to convert data type ; Here we convert the OrderID form float to string to concat it with another string
SELECT [Order ID] , [Customer Name] ,cast([Order ID] AS VARCHAR(10)) + '_' + [Customer Name] AS 'final'
FROM Orders;

SELECT GETDATE() AS 'Default format', CAST(GETDATE() AS VARCHAR(30)) AS 'final';

--CONVERT: offers more control on output format e.g. for datetime values
SELECT GETDATE() AS 'Default', CONVERT(varchar(50),GETDATE(),101) AS 'Converted string'


-------------------------------------------COALESCE and ISNULL-------------------------------------------
--COALESCE(): only evaluates expressions in the list until it finds the first non-null value
--If all values in evaluate to null, then returns NULL (or alt_value as mentioned in the expression)

USE test_employeeDB
	--Adding some more values to the table
	INSERT INTO sep2_Emp_Details(FirstName,LastName,SALARY)
	VALUES
		('Michael', 'Scott', 75000),   -- Regional Manager since early 90s
		('Dwight', NULL, NULL),  -- Joined before series, Assistant to the RM
		(NULL, 'Martinez', 45000),  -- Long-time accountant
		(NULL, 'Hudson', 48000) -- Sales veteran

--Example: fetch First Name OR if its not available, Last name for each EmpID
SELECT [EmpId],[FirstName], [LastName] , COALESCE( [FirstName],[LastName]) AS 'final'
FROM sep2_Emp_Details
--We can see that rows with no First Names, Last name was fetched in the 'final' column

--ISNULL(): T-SQL specific func that 'replaces' a single NULL value with a specified replacement value. 
--NOTE THAT underlying data in the table remains unchanged 
--Example: representing NULLs in employees table with 'Missing Data' 
SELECT EmpId, FirstName,  ISNULL(LastName,'Missing data') 
FROM sep2_Emp_Details

----------------------------------------------------STRING_AGG function------------------------------------------------------
--CONCAT works across columns in a single row while STRING_AGG works all rows in a single column

SELECT STRING_AGG(FirstName,',')
FROM sep2_Emp_Details

SELECT LEN([FirstName])
from sep2_Emp_Details

SELECT * FROM sep2_Emp_Details


select * from orders


