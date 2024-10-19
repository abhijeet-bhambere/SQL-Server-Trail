------EXERCISE 1.1------
SELECT TOP (3000) [Title],
	[LASTNAME],
	[FIRSTNAME]


FROM AdventureWorks2022.Person.Person


------EXERCISE 1.2------
SELECT TOP(500)
	[OrderDate],
	[DueDate],
	[ShipDate],
	[TotalDue]
FROM Sales.SalesOrderHeader

------EXERCISE 1.3------

SELECT TOP(100)
[SALESLASTYEAR],
[SalesYTD]
FROM AdventureWorks2022.Sales.SalesPerson

----------SQL tips & tricks------------
/*EXERCISE 1.1:Using SELECT *, select all columns AND rows from the “Sales.Customer” table .*/
select *
from Sales.Customer

--EXERCISE 1.2: Select all columns and the top 100 rows from the “Production.Product” table, using SELECT *--
select top(100)*

from Production.Product

-------------------------------------------------------------------------------------------------------------------------------
----------------------SECTION 2-----------------------
/*Exercise 1: 
Select any rows from the “Person.Person” table where the value in the “FirstName” column is “Pilar”. 
Include all columns EXCEPT “BusinessEntityID”, “rowguid”, and “ModifiedDate” in your output.*/
SELECT --[BusinessEntityID]
      [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[Suffix]
      ,[EmailPromotion]
      ,[AdditionalContactInfo]
      ,[Demographics]
      --,[rowguid]
      --,[ModifiedDate]
  FROM [AdventureWorks2022].[Person].[Person]
  WHERE [FirstName]='PILAR'



  /*Exercise 2:
  Select any rows from the “Purchasing.Vendor” table where the value in the “Name” column is “Northwind Traders”. 
  Include all columns EXCEPT “BusinessEntityID” and “ModifiedDate” in your output.*/
  SELECT TOP (1000) --[BusinessEntityID]
      [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
      --,[ModifiedDate]
  FROM [AdventureWorks2022].[Purchasing].[Vendor]
  WHERE [Name]='Northwind Traders';

/*Exercise 3: Modify your query from Exercise 2 by commenting out the WHERE statement, and then adding a new criterion that filters for preferred vendors only – 
that is to say, where the value in the “PreferredVendorStatus” column is 1.*/
SELECT [AccountNumber],
      [Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
 
  FROM [AdventureWorks2022].[Purchasing].[Vendor]
  --WHERE [Name]='Northwind Traders'
  WHERE [PreferredVendorStatus]=1
  Order by [Name]

---------Inequalities and NULLs - Exercises------------
/*Exercise 1:Select any records from the “Person.Person” where the person type is not equal to “IN”. 
Do not include the “BusinessEntityID” and “rowguid” fields in your output.*/

SELECT 
	[PersonType],[NameStyle],[Title],[FirstName],[MiddleName],[LastName]
	,[Suffix],[EmailPromotion],[AdditionalContactInfo],[Demographics],[ModifiedDate]
  FROM [AdventureWorks2022].[Person].[Person]
  WHERE [PersonType] != 'IN'

/*Exercise 2: Select all people from the “Person.Person” who have a “Title”. 
Do not include the “BusinessEntityID” and “rowguid” fields in your output.*/
SELECT 
	[PersonType],[NameStyle],[Title],[FirstName],[MiddleName],[LastName]
	,[Suffix],[EmailPromotion],[AdditionalContactInfo],[Demographics],[ModifiedDate]
  FROM [AdventureWorks2022].[Person].[Person]
  WHERE [Title] IS NOT NULL

/*Exercise 3: Select all people from the “Person.Person” who do NOT have a middle name listed. 
Do not include the “BusinessEntityID” and “rowguid” fields in your output.*/
SELECT 
	[PersonType],[NameStyle],[Title],[FirstName],[MiddleName],[LastName]
	,[Suffix],[EmailPromotion],[AdditionalContactInfo],[Demographics],[ModifiedDate]
  FROM [AdventureWorks2022].[Person].[Person]
  WHERE [MiddleName] IS NULL

/*BONUS: Select all people from the “Person.Person” who do NOT have a title of “Mr.”. 
Make sure to include NULL values in your result.*/

SELECT 
	[PersonType],[NameStyle],[Title],[FirstName],[MiddleName],[LastName]
	,[Suffix],[EmailPromotion],[AdditionalContactInfo],[Demographics],[ModifiedDate]
  FROM [AdventureWorks2022].[Person].[Person]
  WHERE [Title] != 'Mr.' OR [Title] IS NULL

--------Multiple Criteria (AND, OR,IN) - Exercises-----------
/*Exercise 1:Select all people from “Person.Person” table with first name of “Laura” 
and last name of “Norman”. Include only the following columns in your output:*/
SELECT [PersonType],[Title],[FirstName],[LastName]
FROM [Person].[Person]
WHERE [FirstName]='Laura' AND [LastName]='Norman'

/*Exercise 2: Modify your query from Exercise 1 as follows: 
Change your criteria to only look for records where the person type is either “SP”, “EM”, or “VC”.*/

SELECT [PersonType],[Title],[FirstName],[LastName]
FROM [Person].[Person]
WHERE (([FirstName]='Laura' AND [LastName]='Norman') AND ([PersonType] IN('SP','EM','VC')))

/*Exercise 3: Streamline your WHERE statement from Q2 by utilizing the IN keyword.*/
--done already--

----------Combining AND and OR - Exercises-----------------
/*Exercise 1: Select all rows from the "HumanResources.Employee" table where gender = "F", AND the job title is either "Network Manager" or "Application Specialist". 
Select all columns using the "SELECT *" shortcut.*/
SELECT *
FROM [HumanResources].[Employee]
WHERE [Gender]='F' AND ([JobTitle] IN ('Network Manager','Application Specialist'))

/*Exercise 3:Select all rows from the "Person.Person" table where person type = "EM", AND there is a NULL value in either the "Title" or "MiddleName" fields. 
Include the following fields in your query:PersonType (aliased as "Person Type"),Title,FirstName (aliased as "First Name"),
MiddleName (aliased as "Middle Name"),LastName (aliased as "Last Name"),Suffix*/
SELECT [PersonType] AS'PERSON TYPE',
	[TITLE],
	[FirstName] AS 'FIRST NAME',
	[MiddleName] AS 'MIDDLE NAME',
	[LastnAME] AS 'LAST NAME',
	Suffix
FROM [Person].[Person]
WHERE [PersonType]='EM' AND (([Title] IS NULL) OR ([MiddleName] IS NULL))
--ALTERNATE--
SELECT
	[PersonType] AS'PERSON TYPE',
	[TITLE],
	[FirstName] AS 'FIRST NAME',
	[MiddleName] AS 'MIDDLE NAME',
	[LastnAME] AS 'LAST NAME',
	Suffix
FROM [Person].[Person]
WHERE [PersonType]='EM' AND (([Title] IS NULL) OR ([MiddleName] IS NULL))


----

/*Modify your query from Exercise 3 such that you are now selecting all rows where person type is either "EM" or "SP" AND there is a 
NULL value in either the "Title", "MiddleName", or "Suffix" fields.*/
SELECT [PersonType] AS'PERSON TYPE',
	[TITLE],
	[FirstName] AS 'FIRST NAME',
	[MiddleName] AS 'MIDDLE NAME',
	[LastnAME] AS 'LAST NAME',
	Suffix
FROM [Person].[Person]
WHERE ([PersonType] IN('EM','SP')) AND (([Title] IS NULL) OR ([MiddleName] IS NULL)OR ([Suffix] IS NULL))

---
---------------------------Selecting Numerical Values By Range - Exercises------------------------------------
/*Exercise 1:Select all rows from the "Purchasing.PurchaseOrderHeader" table where the total due amount is greater than $50,000 and the freight amount is less than $1,000.
Include the following columns in your output: OrderDate,SubTotal,TaxAmt,Freight,TotalDue*/
SELECT OrderDate,
	SubTotal,
	TaxAmt,
	Freight,
	TotalDue

FROM [Purchasing].[PurchaseOrderHeader]
WHERE TotalDue BETWEEN 1000 and 5000
ORDER BY TotalDue 

/*Exercise 2:Using the BETWEEN keyword, modify your query from Exercise 1 such that you are now 
pulling in all rows where the subtotal amount is between $10,000 and $30,000.*/
SELECT OrderDate,
	SubTotal,
	TaxAmt,
	Freight,
	TotalDue

FROM [Purchasing].[PurchaseOrderHeader]
WHERE SubTotal BETWEEN 10000 and 30000
ORDER BY SubTotal

/*Exercise 3:Modify your query from Exercise 2 such that you are NOT including $10,000 and $30,000 in your range of subtotals, 
but still including all amounts between these numbers. In other words, the range should no longer be "inclusive".*/
SELECT OrderDate,
	SubTotal,
	TaxAmt,
	Freight,
	TotalDue

FROM [Purchasing].[PurchaseOrderHeader]
WHERE SubTotal> 10000 AND SubTotal<30000
ORDER BY SubTotal


--------Matching Text Patterns With Wildcards - Exercises-------
/*Exercise 1: Select all rows from the Person.Person table where the first name is abbreviated with a period/dot at the end - for example, "A.".
Select all columns via the "SELECT *" shortcut.*/

SELECT *
  FROM [AdventureWorks2022].[Person].[Person]
  WHERE [FirstName] LIKE '%.'


/*Exercise 2:Select all people from the Person.Person table with the initials "TLC". 
HINT - you'll have to apply criteria to the FirstName, MiddleName, AND LastName columns. select all columns via the "SELECT *" shortcut.*/
SELECT *
	FROM [Person].[Person]
	WHERE ([FirstName] LIKE 'T%' AND [MiddleName] LIKE 'L%' AND [LastName] LIKE 'C%')

/*Exercise 3: Select all rows from the Person.Person table where the first name does not include a vowel (a, e, i, o, or u). 
HINT - you do NOT need to use OR to accomplish this; try using a wildcard with brackets ([ ]) instead. select all columns.*/
SELECT *
	FROM [Person].[Person]
	WHERE ([FirstName] NOT LIKE '%[aeiou]%')

------------------Sorting Data With ORDER BY - Exercises-------------------
/*Exercise 1:Select all rows and the following columns from the HumanResources.Employee table:
OrganizationLevel (alias as "Organization Level") ; JobTitle (alias as "Job Title") ;
VacationHours (alias as "Vacation Hours") ; SickLeaveHours (alias as "Sick Leave Hours")
Sort your output first by OrganizationLevel in ascending order, then VacationHours in descending order.*/

/*Exercise 2: Modify your query from Exercise 1 to use your column aliases,
rather than the actual column names in the database table, in the ORDER BY.*/

SELECT [Organization Level]=[OrganizationLevel],[Job Title] = JobTitle,[Vacation Hours] = VacationHours,[Sick Leave Hours] = SickLeaveHours
FROM [HumanResources].[Employee]
ORDER BY [Organization Level] ASC, [Vacation Hours] DESC


/*Exercise 3: Modify your query from Exercise 2 to use the position of the columns in the query output (for example, 1 for the first column) 
in the ORDER BY as opposed to the column aliases.*/

SELECT [Organization Level]=[OrganizationLevel],[Job Title] = JobTitle,[Vacation Hours] = VacationHours,[Sick Leave Hours] = SickLeaveHours
FROM [HumanResources].[Employee]
ORDER BY 1 ASC, 3 DESC


-----------------Selecting Unique Values With SELECT DISTINCT - Exercises-----------------
/*Exercise 1:Produce a list of the unique person types in the "Person.Person" table, sorted in ascending order.*/
SELECT DISTINCT PersonType
	FROM PERSON.PERSON
	ORDER BY PersonType

/*Exercise 2: Produce a list of the unique full names in the "Person.Person" table - including first name, middle name, and last name.
Only include names that have a value for middle name.The output should be sorted by last name and then by first name, in ascending order.*/
SELECT DISTINCT 
	FirstName,MiddleName,LastName
	FROM PERSON.Person
	WHERE MiddleName IS NOT NULL
	ORDER BY LastName,FirstName ASC

---------Creating Basic Derived Columns - Exercises-----------
/*Exercise 1: Select a derived column from the "Person.Person" table - aliased as "Person Title" 
- that consists of the person's first name, followed by a space, followed by their last name, followed by a hyphen (-), followed by the person type.*/
SELECT [PERSON_TTILE] = FirstName +' ' + LastName + ' - ' + PersonType
FROM PERSON.Person

/*Select all rows from the "HumanResources.Employee" table where "SalariedFlag" = 0. Include the following columns in your output:
BusinessEntityID ; VacationHours ; SickLeaveHours  ; 
Total Time Off - This is a derived column you will calculate by adding vacation hours and sick leave hours
Sort the output by total time off, in ascending order.*/

SELECT BusinessEntityID
		,VacationHours
		,SickLeaveHours
		,[TOTAL_TIME_OFF] = VacationHours + SickLeaveHours
	FROM HumanResources.Employee
	WHERE SalariedFlag = 0
	ORDER BY TOTAL_TIME_OFF

/*Exercise 3:Select all rows from the "HumanResources.EmployeePayHistory" table. Include the following columns in your output:
BusinessEntityID ; Rate ;
Amount Per Paycheck- This is a derived column - assuming 40 hour work week - use employee pay rate from "Rate" column &pay frequency from the "PayFrequency" column.
Sort the output by Amount Per Paycheck in descending order.*/
SELECT 
		BusinessEntityID,
		Rate,
		[AMT_PER_PAYCHECK] = (Rate * 40) * PayFrequency
	FROM HumanResources.EmployeePayHistory
	ORDER BY AMT_PER_PAYCHECK DESC

/*Bonus: Modify your query from Exercise 2 by adding a new derived column called "Total Days Off".
	This column should build on our math for "Total Time Off" by factoring in an assumed 8 hour workday.
	HINT - remember how to keep SQL from performing "integer division" by dividing by a decimal!*/
SELECT BusinessEntityID
		,VacationHours
		,SickLeaveHours
		,[TOTAL_TIME_OFF] = VacationHours + SickLeaveHours
		,[TOTAL_DAYSOFF] = (VacationHours + SickLeaveHours) / 8.0
	FROM HumanResources.Employee
	WHERE SalariedFlag = 0
	ORDER BY TOTAL_TIME_OFF


------Introducing SQL Functions With Text Functions - Exercises-------
/*Exercise 1: Select the following columns (all rows) from the "Sales.CreditCard" table:
CardNumber
Last Four Digits - a derived column with just the last four digits of the credit card number*/
SELECT 
	CardNumber,
	'last_4digits' = RIGHT(CardNumber,4)
	FROM SALES.CreditCard

/*Exercise 2: Select the following columns (all rows) from the "Production.ProductReview" table:
ReviewerName
Comments
Cleaned Comments - a derived column in which all commas from the "Comments" field have been replaced with empty strings*/
SELECT
	ReviewerName,
	Comments,
	'CLEANED_comments' = REPLACE(Comments,',',' ')
	FROM Production.ProductReview

/*Exercise 3: Select the "FirstName" and "LastName" columns from the "Person.Person" table.
Only include rows where the length of the last name is greater than or equal to 10 characters.*/
SELECT FirstName,
	LastName,
	len_lastName = LEN(LastName)
	FROM Person.Person
	WHERE LEN(LastName) >= 10
	ORDER BY len_lastName DESC

/*Bonus:Sort the output of Exercise 3 by the length of the last name, in descending order. 
HINT - you can re-use the expression in your WHERE clause in your ORDER BY, even though it isn't included in the SELECT list!*/
SELECT FirstName,
	LastName,
	len_lastName = LEN(LastName)
	FROM Person.Person
	WHERE LEN(LastName) >= 10
	ORDER BY len_lastName DESC


------------The CONCAT_WS Function - Exercises-----------
/*Exercise 1:Write a query that uses the CONCAT_WS function to combine address components from the Person.Address table into a complete address string. 
The resulting column in your query output should be aliased “FullAddress”.
The address string should incorporate the following fields:
AddressLine1
AddressLine2
City
PostalCode

All components should be separated by spaces. Here’s an example of how a row of your query output should look:
4977 Candlestick Dr. Portland 97205*/

SELECT AddressLine1,
	AddressLine2,
	City,
	PostalCode,
	[FullAddress] = CONCAT_WS(' ',AddressLine1,AddressLine2,City,PostalCode)

	FROM Person.Address
	--WHERE AddressLine1 LIKE('%4977%')

/*EXERCISE 2: write a query against the Production.Product table that concatenates product name and list price together in a single field (called “ProductPrice”), 
separated by a colon and a space.The query results should only include products whose list price exceeds $1,000.
Here’s an example of how a row of your query output should look:
Touring-1000 Blue, 54: $2384.07*/
SELECT [Name],
	[ListPrice],
	[PRODUCT_PRICE] = CONCAT_WS(': $',[Name],[ListPrice])
	FROM Production.Product
	WHERE [ListPrice] > 1000 
	--AND [Name] LIKE('%Touring-1000 Blue%')

--------Advanced Text Manipulation With Nested Functions - Exercises---------
/*Exercise 1: Select the "FirstName" and "LastName" columns from the "Person.Person" table (all rows). 
Now add a derived column called "Nickname", which is created by combining 
the first character of the the first name, a hyphen (-), and the first three characters of the last name.*/
SELECT [FirstName],
	[LastName],
	[NICKNAME] = LEFT([FirstName],1) + '-' + LEFT([LastName],3)
FROM PERSON.Person


/*Exercise 2: Select the following columns (all rows) from the "Production.ProductReview" table:
ReviewerName
Comments
Cleaned Comments - a derived column in which all commas AND periods from the "Comments" field have been replaced with empty strings.*/
SELECT ReviewerName,
	Comments,
	[CLEAN_COMMENTS] = REPLACE(REPLACE(Comments,'.',''),',','')
FROM Production.ProductReview

/*Exercise 3:There are a LOT of text functions in SQL. More than you could possibly scrunch into a single course or book without it turning into an encyclopedia. 
As such, you will frequently find yourself using Google or Bing to look up functions that accomplish specific tasks. Let's practice that here.
Select the "FirstName" column from the "Person.Person" table (all rows). Now add the following derived columns:
FirstNameUpper, which features the first name entirely capitalized
FirstNameLower, which consists of the first name transformed entirely to lowercase
HINT - try searching for what you're trying to do (say, convert text to uppercase)in conjunction with the word "SQL".*/
	SELECT FirstName,
		[FN_UPPER] = UPPER(FirstName),
		[FN_LOWER] = LOWER(FirstName)
	FROM Person.Person


-------------------------DATE & TIME EXERCISES----------------------------
/*Exercise 1:Select the following (not tied to any table in AdventureWorks DB):
A field called "Today" showing the current day and time. A field called "This Month", showing the number of the current month
A field called "This Year", showing the number of the current year. All fields above should be calculated via SQL functions.*/
SELECT GETDATE() AS 'TODAY',
	MONTH(GETDATE()) AS 'THIS MONTH',
	YEAR(GETDATE()) AS 'THIS YEAR'

/*Exercise 2: Select all records from the "Purchasing.PurchaseOrderHeader" table where the order date occurred between 1/1/2011 and 7/31/2011
AND the total amount due is greater than $10,000. Include the following columns:
PurchaseOrderID
OrderDate
TotalDue*/
SELECT PurchaseOrderID,
	OrderDate,
	TotalDue
FROM Purchasing.PurchaseOrderHeader
WHERE TotalDue > 10000
AND (OrderDate BETWEEN DATEFROMPARTS(2011,1,1) AND DATEFROMPARTS(2011,7,31))

-------------------Date Math in SQL - Exercises-------------------------
/*Exercise 1: Use date math - in conjunction with GETDATE - to calculate what date is 100 days from now.*/
SELECT CURR_dATE = GETDATE(),
	LAST_100DAY = GETDATE() - 100;

/*Exercise 2: Use DATEADD to calculate what date is 6 months from now.*/
SELECT CURR_dATE = GETDATE(),
	LAST_6MONTHS_DAY = DATEADD(MONTH,-6,GETDATE());


/*Exercise 3:Use DATEDIFF to select all rows from the "Sales.SalesOrderHeader" table where the order date is 7 or less days before 12/25/2013.
Note that it is possible for DATEDIFF to output a negative number if the "end" date is prior to your "start" date, 
so you may want to use BETWEEN instead of <= in your criteria.
You may select all columns via the SELECT * shorthand.*/
SELECT [SalesOrderID],
	[OrderDate],
	[ShipDate]	
	
FROM Sales.SalesOrderHeader
---WHERE ORDER DATE WAS BEFORE 25th-DEC-2013 WITH GAP OF ATMOST 7 DAYS---
WHERE DATEDIFF(DAY,[OrderDate],DATEFROMPARTS(2013,12,25)) BETWEEN 0 AND 7
--AND OrderDate <= DATEFROMPARTS(2013,12,25)

/*Bonus: Modify your query from Exercise 3 to work for ANY year, not just 2013. */
SELECT [SalesOrderID],
	[OrderDate],
	[ShipDate]	
	
FROM Sales.SalesOrderHeader
WHERE DATEDIFF(DAY,[OrderDate],DATEFROMPARTS(YEAR(OrderDate),12,25)) BETWEEN 0 AND 7

-----------------------Data Types and CASTing - Exercises--------------------------
/*Exercise 1: Calculate yesterday's date dynamically via the GETDATE function.
Convert the value to a DATE datatype, such that it has no timestamp component.*/
SELECT GETDATE(),
	CAST((GETDATE() - 1) AS date)

/*Exercise 2: Calculate the number of days between the current date and the end of the current year via DATEDIFF. 
Use the CAST function to create the end-of-year date.*/
--SELECT TODAY_DATE = CAST(GETDATE() AS DATE),
	--EOY_DATE = DATEDIFF(DAY,GETDATE(),DATEFROMPARTS(2024,12,31)),
	--EOY = CAST((GETDATE() + DATEDIFF(DAY,GETDATE(),DATEFROMPARTS(2024,12,31))) AS date)
	---SOLUTION---
	SELECT DATEDIFF(DAY,GETDATE(),CAST('2024-12-31' AS date))

/*Exercise 3: Select all rows from the "Person.Person" table where the middle name is not NULL, AND 
either the title is not NULL OR the suffix is not NULL. Include the following columns:
Title
FirstName
MiddleName
LastName
Suffix
PersonID - a derived column created by combining the person type, a hyphen(-), and the business entity ID, in that order.*/
SELECT Title,
	FirstName,
	MiddleName,
	LastName,
	Suffix,
	PERSONid = PersonType + '-' + CAST(BusinessEntityID AS varchar)
FROM Person.Person
WHERE MiddleName IS NOT NULL
AND (Title IS NOT NULL OR Suffix IS NOT NULL)


--------------------The FORMAT Function - Exercises--------------------
/*Exercise 1: Write a query against the Sales.SalesPerson table that includes the following fields:
--BusinessEntityID
--SalesQuota: This field should be formatted as currency (specifying culture/locale is optional).
--Bonus: This field should be formatted as currency (specifying culture/locale is optional).
--CommissionPct: This field should be formatted as a percentage.
Query output should include all records from the SalesPerson table.*/
SELECT 
	BusinessEntityID,
	FORMAT(SalesQuota,'C'),
	FORMAT(Bonus,'C'),
	FORMAT(CommissionPct,'p')
FROM Sales.SalesPerson

/*Exercise 2: Write a query against the Purchasing.PurchaseOrderHeader table that includes the following fields:
	--OrderYearMonth: This field should be a reformatted version of the “OrderDate” field, in which the date values are converted to strings consisting of the 4 digit year, a hyphen, and the 2 digit month. 
					For example, the date “2013-04-20” would be converted to the string “2012-04”.
	--TaxAmt: This field should be formatted as currency (specifying culture/locale is optional).
	--Freight: This field should be formatted as currency (specifying culture/locale is optional).
	--TotalDue: This field should be formatted as currency (specifying culture/locale is optional).
Your query output should only include records from the PurchaseOrderHeader table where the order date was in 2013.*/
SELECT 
	ORD_YEAR_MNTH = FORMAT(OrderDate,'yyyy-MM'),
	TAX_AMT = FORMAT(TaxAmt,'C'),
	FREIGHT = FORMAT(Freight,'C'),
	TOTALDUE = FORMAT(TotalDue,'C')
FROM Purchasing.PurchaseOrderHeader
WHERE YEAR(OrderDate) = 2013;

------------Handling NULL Values With ISNULL - Exercises----------------
/*Exercise 1:
Select all rows from the "Production.Product" table where the weight is less than 10 pounds. 
Make sure to include NULL values in your output, and use ISNULL to accomplish this.
Include the following columns in your output: Name ; Color

Exercise 2
Modify the "Color" field of your query from Exercise 1 such that NULL values are replaced with the word "None".*/

SELECT [Name],
	ISNULL([Color],'NONE'),
	[Weight]
FROM Production.Product
WHERE ISNULL(Weight,0)<10

-----------------------------------------------The Mighty CASE Statement - Exercises-------------------------------------------
/*Exercise 1: Select a derived column called "Price Category" from the "Production.Product" table such that:
If the list price is greater than $1,000, return "Premium".
If the list price is greater than $100 and less than $1,000, return "Mid-Range".
If the list price is less than $100, return "Value". This should be the default case.
Also include Name and ListPrice as columns in your output.*/
SELECT ProductID,
	[Name],
	ListPrice = FORMAT(ListPrice,'C'),
	PRICE_CATEGORY = CASE
		WHEN ListPrice >=1000 THEN 'PREMIUM'
		WHEN ListPrice > 100 AND ListPrice < 1000 THEN 'MID-RANGE'
		ELSE 'VALUE'
	END
FROM Production.Product

/*Exercise 2: Select a derived column called "Employee Tenure" from the "HumanResources.Employee" table such that:
If an employee is salaried, and has been with the company 10 or more years (calculated as the DATEDIFF in YEARs between the "HireDate" value and the current date), return "Non-Exempt - 10+ Years".
If an employee is salaried, and has been with the company less than 10 years, return "Non-Exempt - < 10 Years".
If an employee is NOT salaried, and has been with the company 10 or more years (calculated as the DATEDIFF in YEARs between the "HireDate" value and the current date), return "Exempt - 10+ Years".
If an employee is NOT salaried, and has been with the company less than 10 years, return "Exempt - < 10 Years". This should be the default case.
Also include BusinessEntityID, HireDate, and SalariedFlag as columns in your output.*/
SELECT [LoginID],
	[JobTitle],
	[Gender],
	[HireDate],
	[SalariedFlag],
	CURRENTDATE = GETDATE(),
	CALC_TENURE = CAST(DATEDIFF(YEAR,[HireDate],GETDATE()) AS varchar) + ' YEARS',
	EMPLOYEE_TENURE = CASE
			WHEN DATEDIFF(YEAR,[HireDate],GETDATE()) >=10 AND [SalariedFlag]=1 THEN 'Non-Exempt - 10+ Years'
			WHEN DATEDIFF(YEAR,[HireDate],GETDATE()) <10 AND [SalariedFlag]=1 THEN 'Non-Exempt < 10 Years'
			WHEN DATEDIFF(YEAR,[HireDate],GETDATE()) >=10 AND [SalariedFlag]=0 THEN 'Exempt - 10+ Years'
			ELSE  'Exempt < 10 Years'
		END

FROM HumanResources.Employee
ORDER BY 7 DESC


-------------------Stacking Table Rows With UNION - Exercises--------------
/*Exercise 1:Write a query that selects all rows from the "Purchasing.PurchaseOrderDetail" table 
where the line total is greater than $10,000. Include the following columns in your output:
PurchaseOrderID
PurchaseOrderDetailID
OrderQty
LineTotal*/
SELECT PurchaseOrderID,
	PurchaseOrderDetailID,
	OrderQty,
	LineTotal
FROM Purchasing.PurchaseOrderDetail
WHERE LineTotal > 10000

/*Exercise 2:Write a similar query that selects all rows from the "Sales.SalesOrderDetail" table where the line total is greater than $10,000. 
Include the following columns in your output:
SalesOrderID
SalesOrderDetailID
OrderQty
LineTotal*/
SELECT SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	LineTotal
FROM Sales.SalesOrderDetail
WHERE LineTotal > 10000

/*Exercise 3: Combine the rows from your Exercise 1 and Exercise 2 queries by "stacking" them vertically. 
Make sure the similar fields from each table align. Alias the first two columns as "OrderID" and "OrderDetailID", respectively.*/
SELECT [ORDER_ID]=PurchaseOrderID,
	[ORDER_DETAILID]=PurchaseOrderDetailID,
	OrderQty,
	LineTotal
FROM Purchasing.PurchaseOrderDetail
WHERE LineTotal > 10000

UNION
SELECT [ORDER_ID]=SalesOrderID,
	[ORDER_DETAILID]=SalesOrderDetailID,
	OrderQty,
	LineTotal
FROM Sales.SalesOrderDetail
WHERE LineTotal > 10000


/*Exercise 4:Add the following derived fields to your query; remember , you'll need to add them to both components of your query. 
Sort the output of your query by line total in descending order.
"RunDate" - displays the current date
"OrderType" - this should display the string "Purchase" for purchase orders, and "Sale" for sales orders.*/
SELECT [ORDER_ID]=PurchaseOrderID,
	[ORDER_DETAILID]=PurchaseOrderDetailID,
	OrderQty,
	LineTotal,
	[RUNDATE] = GETDATE(),
	[ORDER_TYPE] = 'PURCHASE'
FROM Purchasing.PurchaseOrderDetail
WHERE LineTotal > 10000
	UNION
SELECT [ORDER_ID]=SalesOrderID,
	[ORDER_DETAILID]=SalesOrderDetailID,
	OrderQty,
	LineTotal,
	[RUNDATE] = GETDATE(),
	[ORDER_TYPE] = 'SALES'
FROM Sales.SalesOrderDetail
WHERE LineTotal > 10000
ORDER BY LineTotal DESC

-------------------------------JOINs - Exercises--------------------------------

/*Exercise  1: Write a query that combines the "FirstName" and "LastName" columns from the "Person.Person" table, 
with the "EmailAddress" column from the "Person.EmailAddress" table. HINT - these tables have the "BusinessEntityID" field in common.*/
SELECT  
	P.FirstName,
	P.LastName,
	E.EmailAddress

FROM PERSON.Person P
JOIN PERSON.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID

/*Exercise 2: Write a query that combines "Name" and "ListPrice" columns from the "Production.Product" table, 
with "ReviewerName" and "Comments" from "Production.ProductReview" table. HINT-tables have the "ProductID" field in common.*/

SELECT 
	P.[Name],
	P.ListPrice,
	R.ReviewerName,
	R.Comments
FROM Production.Product P
JOIN Production.ProductReview R
ON P.ProductID = R.ProductID

--------------------------------------------------EXERCISES ON INNER JOIN--------------------------------------------------
/*eXERCISE1: Write a query that combines the "FirstName" and "LastName" columns from the "Person.Person" table, 
with the "EmailAddress" column from the "Person.EmailAddress" table, AND the "PhoneNumber" field from the "Person.PersonPhone" table.
HINT - tables have "BusinessEntityID" field in common.*/
SELECT P.FirstName,	
	P.LastName,
	E.EmailAddress,
	Ph.PhoneNumber
FROM Person.Person P
JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
JOIN Person.PersonPhone Ph
ON P.BusinessEntityID = Ph.BusinessEntityID
ORDER BY P.[FirstName]

/*Exercise 2:Modify query from Exercise1 TO only pull in phone numbers with a Seattle area code - phone numbers startING with "206".
HINT - PhoneNumber is a text field, so you will need a text function to accomplish this. 
Either LEFT or a wildcard used in conjunction with LIKE should work.*/
SELECT P.FirstName,	
	P.LastName,
	E.EmailAddress,
	Ph.PhoneNumber
FROM Person.Person P
JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
JOIN Person.PersonPhone Ph
ON P.BusinessEntityID = Ph.BusinessEntityID
	WHERE PhoneNumber LIKE('206%')
ORDER BY P.[FirstName]

/*Exercise 3:Modify your query from Exercise 2 to pull in each person's city from the "Person.Address" table.
Note that this table has no fields in common with any of the tables already in our join. 
This means we will need to join in another table that we can use as a "bridge" between our Person.Address table and our Person.Person table 
- a table that should have fields we can use to connect it to either table.
The table we need is "Person.BusinessEntityAddress"; note that it has both "BusinessEntityID" AND "AddressID" fields. 
You will need to join this table to Person.Person, and then join Person.Address to this table in order to get your query to work.*/
SELECT P.FirstName,	
	P.LastName,
	E.EmailAddress,
	Ph.PhoneNumber,
	BE.[AddressID],
	PA.[City]
FROM Person.Person P
JOIN Person.EmailAddress E
ON P.BusinessEntityID = E.BusinessEntityID
JOIN Person.PersonPhone Ph
ON P.BusinessEntityID = Ph.BusinessEntityID
JOIN Person.[BusinessEntityAddress] BE
ON P.BusinessEntityID = BE.BusinessEntityID
JOIN Person.[Address] PA
ON BE.[AddressID] = PA.[AddressID]
	WHERE PhoneNumber LIKE('206%')
ORDER BY P.[FirstName]

-------------------------------OUTER JOINs - Exercises------------------------------
/*Exercise 1: Write a query that combines the "BusinessEntityID", "SalesQuota", and "SalesYTD" columns from the "Sales.SalesPerson" table, 
with the "Name" column from the "Sales.SalesTerritory" table. Alias the "Name" column as "TerritoryName".
Make sure to include all rows from the "Sales.SalesPerson" table regardless of whether a match is found in the "Sales.SalesTerritory" table. 
I'll leave it to you to determine which field to use to link the two tables together.*/
SELECT SP.BusinessEntityID,
		SP.SalesQuota,
		SP.SalesYTD,
		[TERRITORRY_NAME] = ST.Name 
FROM SALES.SalesPerson AS SP LEFT OUTER JOIN SALES.SalesTerritory AS ST
ON SP.TerritoryID = ST.TerritoryID

SELECT *FROM SALES.SalesPerson

/*Exercise 2: Modify your query from Exercise 1 to only include rows where the YTD sales are less than $2,000,000.*/
SELECT SP.BusinessEntityID,
		SP.SalesQuota,
		SP.SalesYTD,
		[TERRITORRY_NAME] = ST.Name 
FROM SALES.SalesPerson AS SP LEFT OUTER JOIN SALES.SalesTerritory AS ST
ON SP.TerritoryID = ST.TerritoryID
WHERE SP.SalesYTD < 2000000

/*Exercise 3: Change the join in your query from Exercise 2 from an outer join to an inner join, and take note of the effect on the query output. 
Are the rows with NULL values in the "TerritoryName" column still being included?*/
SELECT SP.BusinessEntityID,
		SP.SalesQuota,
		SP.SalesYTD,
		[TERRITORRY_NAME] = ST.Name 
FROM SALES.SalesPerson AS SP 
INNER JOIN SALES.SalesTerritory AS ST
ON SP.TerritoryID = ST.TerritoryID
WHERE SP.SalesYTD < 2000000
---SINCE INNER JOIN ONLY RETURNS RECORD COMMON IN BOTH TABLES, NULLS ARE NOT PART OF THE RETURNED OUTPUT---
---SO INNER JOIN RETURNED ONLY 6 RECORDS WHILE THE LEFT OUTER JOIN RETURNED 9 RECORDS---


-------------------------------------------------OUTER JOIN EXERCISES PT.2-------------------------------------------------------------
/*Exercise 1: Create a query with the following columns: 
	SalesOrderID, OrderDate, and TotalDue from the "Sales.SalesOrderHeader" table
A derived column called "Percent of Sales YTD", calculated as follows:
The value in the "TotalDue" column from Sales.SalesOrderHeader, 
	divided by the value in the "SalesYTD" field from the Sales.SalesPerson table, then multiplied by 100.
**You can connect the two tables by their "SalesPersonID" and "BusinessEntityID" fields, respectively.
Return all rows from Sales.SalesOrderHeader that have a total due amount greater than $2,000, regardless of whether there is a sales person associated with the sale. 
Sort the output by sales order ID, ascending.*/
SELECT SH.SalesOrderID,
	SH.OrderDate,
	SH.TotalDue,
	'PERCENT_SALES_YTD'= ((SH.TotalDue / SP.SalesYTD)*100) 
FROM Sales.SalesOrderHeader SH
LEFT OUTER JOIN Sales.SalesPerson SP 
ON SH.SalesPersonID = SP.BusinessEntityID
WHERE SH.TotalDue>2000
ORDER BY SH.SalesOrderID ASC

SELECT TOP(3)*FROM SALES.SalesOrderHeader
SELECT TOP(3)*FROM SALES.SalesPerson

/*Exercise 2: Modify your query from  Exercise 1 such that only records from Sales.SalesOrderHeader where the Sales YTD value is 
less than $2,000,000 are included. The overall number of records returned by your query should not change.*/
SELECT SH.SalesOrderID,
	SH.OrderDate,
	SH.TotalDue,
	'PERCENT_SALES_YTD'= ((SH.TotalDue / SP.SalesYTD)*100) 
FROM Sales.SalesOrderHeader SH
LEFT OUTER JOIN Sales.SalesPerson SP 
ON SH.SalesPersonID = SP.BusinessEntityID
AND SP.SalesYTD < 2000000
WHERE SH.TotalDue>2000
ORDER BY SH.SalesOrderID ASC

/*EXERCISE3:Add the "SalesOrderDetailID" and "LineTotal" columns from the "Sales.SalesOrderDetail" table to your Exercise 2 query. 
Only include records in your output where a match is found in this query.
I'll leave it to you to figure out which field to join on (it's pretty intuitive).
NOTE - you are likely to find that the record count of your query increases substantially. 
This is because there is a one to many relationship between Sales.SalesOrderHeader and Sales.SalesOrderDetail, 
with each sales order being composed of potentially many individual items.*/

SELECT SH.SalesOrderID,
	SH.OrderDate,
	SH.TotalDue,
	'PERCENT_SALES_YTD'= ((SH.TotalDue / SP.SalesYTD)*100) ,
	SD.SalesOrderDetailID,
	SD.LineTotal
FROM Sales.SalesOrderHeader SH
LEFT OUTER JOIN Sales.SalesPerson SP 
ON SH.SalesPersonID = SP.BusinessEntityID
AND SP.SalesYTD < 2000000
JOIN Sales.SalesOrderDetail SD
ON SH.SalesOrderID = SD.SalesOrderID

WHERE SH.TotalDue>2000
ORDER BY SH.SalesOrderID ASC


SELECT TOP(9)*FROM Sales.SalesOrderDetail


---------------------------/CODING CHALLENGE-1/-----------------------------
SELECT PD.PurchaseOrderID,
	PD.PurchaseOrderDetailID,
	PD.OrderQty,
	PD.UnitPrice,
	PD.LineTotal,
	PH.OrderDate,
	'OrderSize_Catgry'=CASE
		WHEN PD.OrderQty >500 THEN 'LARGE'
		WHEN PD.OrderQty >50 AND PD.OrderQty<=500 THEN 'MEDIUM'
		ELSE 'SMALL'
	END,
	PR.[Name],
	'Sub_Category' = ISNULL(PSB.[Name],'None'),
	'Category' = ISNULL(PC.[Name],'None')

FROM Purchasing.PurchaseOrderDetail AS PD
JOIN Purchasing.PurchaseOrderHeader AS PH
	ON PD.PurchaseOrderID = PH.PurchaseOrderID
JOIN Production.Product AS PR
	ON PD.ProductID = PR.ProductID
LEFT OUTER JOIN Production.ProductSubcategory AS PSB
	ON PR.ProductSubcategoryID = PSB.ProductSubcategoryID
LEFT OUTER JOIN Production.ProductCategory AS PC
	ON PSB.ProductCategoryID = PC.ProductCategoryID
WHERE MONTH(PH.OrderDate)=12

---------------------------/CODING CHALLENGE-2/-----------------------------
SELECT PD.PurchaseOrderID AS 'OrderId',
	PD.PurchaseOrderDetailID AS 'OrderDetailId',
	PD.OrderQty,
	PD.UnitPrice,
	PD.LineTotal,
	PH.OrderDate,
	'OrderSize_Catgry'=CASE
		WHEN PD.OrderQty >500 THEN 'LARGE'
		WHEN PD.OrderQty >50 AND PD.OrderQty<=500 THEN 'MEDIUM'
		ELSE 'SMALL'
	END,
	PR.[Name],
	'Sub_Category' = ISNULL(PSB.[Name],'None'),
	'Category' = ISNULL(PC.[Name],'None'),
	[ORDER_type] = 'PURCHASE'

FROM Purchasing.PurchaseOrderDetail AS PD
JOIN Purchasing.PurchaseOrderHeader AS PH
	ON PD.PurchaseOrderID = PH.PurchaseOrderID
JOIN Production.Product AS PR
	ON PD.ProductID = PR.ProductID
LEFT OUTER JOIN Production.ProductSubcategory AS PSB
	ON PR.ProductSubcategoryID = PSB.ProductSubcategoryID
LEFT OUTER JOIN Production.ProductCategory AS PC
	ON PSB.ProductCategoryID = PC.ProductCategoryID
WHERE MONTH(PH.OrderDate)=12

UNION ALL

SELECT SD.SalesOrderID AS 'OrderId',
	SD.SalesOrderDetailID AS 'OrderDetailId',
	SD.OrderQty,
	SD.UnitPrice,
	SD.LineTotal,
	SH.OrderDate,
	'OrderSize_Catgry'=CASE
		WHEN SD.OrderQty >500 THEN 'LARGE'
		WHEN SD.OrderQty >50 AND SD.OrderQty<=500 THEN 'MEDIUM'
		ELSE 'SMALL'
	END,
	PR.[Name],
	'Sub_Category' = ISNULL(PSB.[Name],'None'),
	'Category' = ISNULL(PC.[Name],'None'),
	[ORDER_type] = 'SALES'

FROM Sales.SalesOrderDetail AS SD
JOIN Sales.SalesOrderHeader AS SH
	ON SD.SalesOrderID = SH.SalesOrderID
JOIN Production.Product AS PR
	ON SD.ProductID = PR.ProductID
LEFT OUTER JOIN Production.ProductSubcategory AS PSB
	ON PR.ProductSubcategoryID = PSB.ProductSubcategoryID
LEFT OUTER JOIN Production.ProductCategory AS PC
	ON PSB.ProductCategoryID = PC.ProductCategoryID
WHERE MONTH(SH.OrderDate)=12

----/TEST QUERY/----
SELECT TOP(3)* FROM Person.Person
SELECT TOP(3)* FROM Person.[Address]
SELECT TOP(3)* FROM Person.BusinessEntityAddress
SELECT TOP(3)* FROM Person.StateProvince
SELECT TOP(3)* FROM Person.CountryRegion
---------------------------/CODING CHALLENGE-3/-----------------------------
SELECT 
	'FULLNAME' = 
	CASE
		WHEN P.MiddleName IS NOT NULL THEN (P.FirstName +' ' +P.MiddleName +' ' +P.LastName)
		ELSE (P.FirstName +' '  +P.LastName)
	END,
	P.BusinessEntityID,
	P.PersonType,
	'ADDRESS' = PA.AddressLine1,
	PA.City,
	PA.PostalCode,
	'STATE'=PS.[Name],
	'COUNTRY'=PCR.Name

FROM Person.Person P
JOIN Person.BusinessEntityAddress BA
	ON P.BusinessEntityID = BA.BusinessEntityID
JOIN Person.[Address] PA
	ON BA.AddressID = PA.AddressID
JOIN Person.StateProvince PS
	ON PA.StateProvinceID = PS.StateProvinceID
JOIN Person.CountryRegion PCR
	ON PS.CountryRegionCode = PCR.CountryRegionCode
WHERE (P.PersonType='SP') OR ((PA.PostalCode LIKE('9%')) AND ((LEN(PA.PostalCode)=5) AND PCR.[Name]='UNITED STATES'))

---------------------------/CODING CHALLENGE-4/-----------------------------
SELECT 
	'FULLNAME' = 
	CASE
		WHEN P.MiddleName IS NOT NULL THEN (P.FirstName +' ' +P.MiddleName +' ' +P.LastName)
		ELSE (P.FirstName +' '  +P.LastName)
	END,
	P.BusinessEntityID,
	P.PersonType,
	'ADDRESS' = PA.AddressLine1,
	PA.City,
	PA.PostalCode,
	'STATE'=PS.[Name],
	'COUNTRY'=PCR.Name,
	[JobTitle]=ISNULL(HRE.JobTitle,'None'),
	[JobCategory] = CASE
			WHEN (HRE.JobTitle LIKE('%President%')) OR (HRE.JobTitle LIKE('%Manager%')) OR (HRE.JobTitle LIKE('%Executive%')) THEN 'MANAGEMENT'
			WHEN (HRE.JobTitle LIKE('%Engineer%')) THEN 'ENGINEER'
			WHEN (HRE.JobTitle LIKE('%Production%'))THEN 'PRODUCTION'
			WHEN (HRE.JobTitle LIKE('%Marketing')) THEN 'MARKETING'
			WHEN HRE.JobTitle IS NULL THEN 'NA'
			WHEN (HRE.JobTitle IN('Recruiter', 'Benefits Specialist','Human Resources Administrative Assistant')) THEN 'HR'
			ELSE 'OTHER'
		END
		
FROM Person.Person P
JOIN Person.BusinessEntityAddress BA
	ON P.BusinessEntityID = BA.BusinessEntityID
JOIN Person.[Address] PA
	ON BA.AddressID = PA.AddressID
JOIN Person.StateProvince PS
	ON PA.StateProvinceID = PS.StateProvinceID
JOIN Person.CountryRegion PCR
	ON PS.CountryRegionCode = PCR.CountryRegionCode
LEFT OUTER JOIN HumanResources.Employee HRE
	ON P.BusinessEntityID = HRE.BusinessEntityID
WHERE (P.PersonType='SP') OR ((PA.PostalCode LIKE('9%')) AND ((LEN(PA.PostalCode)=5) AND PCR.[Name]='UNITED STATES'))


---------------------------/CODING CHALLENGE-5/-----------------------------
SELECT [TodayDate] = GETDATE(),
	[FirstOfThisMonth] = DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1),
	[NextMonth] = DATEFROMPARTS(YEAR(GETDATE()),(MONTH(GETDATE())+1),1),
	[NextMonth1] = DATEADD(MONTH,1,DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1)),
	[LastOfThisMonth] = DATEADD(DAY,-1,DATEFROMPARTS(YEAR(GETDATE()),(MONTH(GETDATE())+1),1)),
	[DiffDays] = DATEDIFF(DAY,GETDATE(),DATEADD(DAY,-1,DATEFROMPARTS(YEAR(GETDATE()),(MONTH(GETDATE())+1),1)))



---------------------------/Aggregate Functions - Exercises/---------------------------------
/*Exercise 1:Display the number of purchasing orders in the Purchasing.PurchaseOrderHeader table where the total amount due is greater than $20,000.*/

SELECT COUNT(PurchaseOrderHeader.TotalDue)
FROM Purchasing.PurchaseOrderHeader
WHERE TotalDue > 200000

/*Exercise 2: Display the sum of all total amounts due for purchasing orders in the Purchasing.PurchaseOrderHeader table.*/
SELECT SUM(PurchaseOrderHeader.TotalDue)
FROM Purchasing.PurchaseOrderHeader


/*Exercise 3:Display the largest single amount due for a purchasing order in the Purchasing.PurchaseOrderHeader table.*/
SELECT MAX(TotalDue)
FROM Purchasing.PurchaseOrderHeader


/*Exercise 4: Display the average of subtotal + freight for all purchasing orders in the Purchasing.PurchaseOrderHeader table.*/
SELECT AVG(SubTotal + Freight)
FROM Purchasing.PurchaseOrderHeader


-----------------------/Grouping Aggregate Calculations With GROUP BY - Exercises/----------------------------------------------

/*Exercise 1: Display the count of products in the Production.Product table, broken out by color.*/
SELECT COUNT(*),Product.Color FROM Production.Product
GROUP BY Product.Color

/*Exercise 2:Modify your code from Exercise 1 by breaking out the product count by color AND style.
Then add a new column with the sum of the list prices for each group.*/
SELECT 
	[COUNT]=COUNT(*)
	,Product.Color
	,Product.Style
	,[SUM] = SUM(ListPrice) 
FROM Production.Product
GROUP BY Product.Color, Product.Style

/*Exercise 3: You are not limited to only grouping by individual fields in your data; you can actually group by derived fields as well!
You just have to make sure that you include the same derived field in both your SELECT and GROUP BY.
With that in mind, "prettify" your output from Exercise 2 by displaying "No color" in the "Color" column in place of NULL values, and "NA" in the "Style" column in place of NULL values.
HINT: The ISNULL function could be handy here.*/

SELECT 
	ISNULL(Product.Color,'NO COLOR'),
	ISNULL(Product.Style,'NA')
	,[COUNT]=COUNT(*)
	,[SUM] = SUM(ListPrice) FROM Production.Product
GROUP BY Product.Color, Product.Style

-------------------------/Filtering Aggregate Calculations With HAVING - Exercises/----------------------------
/*Exercise 1:Identify all first names in the Person.Person table which are shared by more than 50 people.
Sort the output in descending order by the count of the name.*/
SELECT 
	Person.FirstName,
	COUNT(Person.FirstName)
FROM Person.Person
GROUP BY Person.FirstName
	HAVING COUNT(Person.FirstName) > 50
ORDER BY COUNT(Person.FirstName) DESC

/*Exercise 2: Identify all products in the Production.Products table - by name - 
with total sales in the Purchasing.PurchaseOrderDetail table of less than $10,000.
-> Also include a column with a count of sales by product in your output. 
-> Sort the output by total sales amount, in ascending order.*/

SELECT	
	P.[Name],
	[Total_Sales]=SUM(PD.LineTotal),
	[Count_Sales]=COUNT(*)
FROM Production.Product P
JOIN Purchasing.PurchaseOrderDetail PD
	ON P.ProductID=PD.ProductID
GROUP BY P.[Name]
	HAVING SUM(PD.LineTotal) < 10000
ORDER BY SUM(PD.LineTotal)

---
SELECT TOP(3)* FROM Production.Product
SELECT TOP(3)* FROM Purchasing.PurchaseOrderDetail
---

/*Exercise 3: Modify your query from Exercise 2 by filtering out products whose name includes a number.
HINT: You will need to use a wildcard with LIKE; 
review the example code provided in the course section on pattern matching with wildcards if you need a refresher*/

SELECT	
	P.[Name],
	[Total_Sales]=SUM(PD.LineTotal),
	[Count_Sales]=COUNT(*)
FROM Production.Product P
JOIN Purchasing.PurchaseOrderDetail PD
	ON P.ProductID=PD.ProductID
	WHERE P.[Name] NOT LIKE('%[0-9]%')
GROUP BY P.[Name]
	HAVING SUM(PD.LineTotal) < 10000
ORDER BY SUM(PD.LineTotal)

--------------------------------/The STRING_AGG Function - Exercises/---------------------------------
/*Exercise: Create a query that - for each distinct “SalesOrderID” in the Sales.SalesOrderDetail table - provides the sum of “LineTotal” 
(from the Sales.SalesOrderDetail table), as well as a comma-separated list of all the product names (which you can find in the “Name” field of the Production.Product table) associated with that sales order ID.
Additionally, you should filter the output of your query, such that only rows where the sum of line totals is greater than 5000 are returned.*/
SELECT 
	S.SalesOrderID,
	[LineTotal_Sum] = SUM(S.LineTotal),
	[All_Products] = STRING_AGG(P.[Name],', ')
FROM SALES.SalesOrderDetail S
JOIN Production.Product P
	ON S.ProductID = P.ProductID
GROUP BY S.SalesOrderID
	HAVING SUM(S.LineTotal) >5000

-------------------------------------/WINDOW FUNCTIONS/----------------------------------------
/*EXERCISE 1: Create a query with the following columns:
FirstName and LastName, from the Person.Person table**
JobTitle, from the HumanResources.Employee table**
Rate, from the HumanResources.EmployeePayHistory table**
A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row*/

SELECT 
	P.FirstName,
	P.LastName,
	E.JobTitle,
	EP.Rate,
	[AverageRate] = AVG(EP.Rate) OVER()
FROM Person.Person P
JOIN HumanResources.Employee E
	ON P.BusinessEntityID = E.BusinessEntityID
JOIN HumanResources.EmployeePayHistory EP
	ON EP.BusinessEntityID=P.BusinessEntityID

/*Exercise 2:Enhance your query from Exercise 1 by adding a derived column called
"MaximumRate" that returns the largest of all values in the "Rate" column, in each row.*/
SELECT 
	P.FirstName,
	P.LastName,
	E.JobTitle,
	EP.Rate,
	[AverageRate] = AVG(EP.Rate) OVER(),
	[MaxRate] = MAX(EP.Rate) OVER()
FROM Person.Person P
JOIN HumanResources.Employee E
	ON P.BusinessEntityID = E.BusinessEntityID
JOIN HumanResources.EmployeePayHistory EP
	ON EP.BusinessEntityID=P.BusinessEntityID


/*Exercise 3: Enhance your query from Exercise 2 by adding a derived column called
"DiffFromAvgRate" that returns the result of the following calculation:
An employees's pay rate, MINUS the average of all values in the "Rate" column.*/

SELECT 
	P.FirstName,
	P.LastName,
	E.JobTitle,
	EP.Rate,
	[AverageRate] = AVG(EP.Rate) OVER(),
	[MaxRate] = MAX(EP.Rate) OVER(),
	[DiffFromAvgRate] = ep.Rate - (AVG(EP.Rate) OVER())
FROM Person.Person P
JOIN HumanResources.Employee E
	ON P.BusinessEntityID = E.BusinessEntityID
JOIN HumanResources.EmployeePayHistory EP
	ON EP.BusinessEntityID=P.BusinessEntityID


/*Exercise 4:Enhance your query from Exercise 3 by adding a derived column called
"PercentofMaxRate" that returns the result of the following calculation:
An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100.*/

SELECT 
	P.FirstName,
	P.LastName,
	E.JobTitle,
	EP.Rate,
	[AverageRate] = AVG(EP.Rate) OVER(),
	[MaxRate] = MAX(EP.Rate) OVER(),
	[DiffFromAvgRate] = EP.Rate - (AVG(EP.Rate) OVER()),
	[PercentofMaxRate] = ((EP.Rate/MAX(EP.Rate) OVER())*100)
FROM Person.Person P
JOIN HumanResources.Employee E
	ON P.BusinessEntityID = E.BusinessEntityID
JOIN HumanResources.EmployeePayHistory EP
	ON EP.BusinessEntityID=P.BusinessEntityID


-----------------/PARTITION BY - Exercises/----------------------

/*Exercise 1: Create a query with the following columns:
“Name” from the Production.Product table, which can be alised as “ProductName”
“ListPrice” from the Production.Product table
“Name” from the Production. ProductSubcategory table, which can be alised as “ProductSubcategory”*
“Name” from the Production.ProductCategory table, which can be alised as “ProductCategory”***/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory'
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID

/*Exercise 2: Enhance your query from Exercise 1 by adding a derived column called
"AvgPriceByCategory " that returns the average ListPrice for the product category in each given row.*/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory',
	[AvgPriceByCategory] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name])
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID

/*Exercise 3:Enhance your query from Exercise 2 by adding a derived column called
"AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.*/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory',
	[AvgPriceByCategory] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[AvgPriceByCategoryAndSubcategory] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name],PS.[Name])
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID
/*Exercise 4:Enhance your query from Exercise 3 by adding a derived column called
"ProductVsCategoryDelta" that returns the result of the following calculation:
A product's list price, MINUS the average ListPrice for that product’s category.*/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory',
	[AvgPriceByCategory] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[AvgPriceByCategoryAndSubcategory] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name],PS.[Name]),
	[ProductVsCategoryDelta] = P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY PC.[Name])
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID

----------------------/ROW_NUMBER/----------------------
/*Exercise 2: Enhance your query from Exercise 1 by adding a derived column called
"Price Rank " that ranks all records in the dataset by ListPrice, in descending order. 
So the most expensive priced-product should have a rank of 1, and least expensive product should have a rank equal to the number of records in the dataset.*/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory',
	[AvgPriceByCategory] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[AvgPriceByCategoryAndSubcategory] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name],PS.[Name]),
	[ProductVsCategoryDelta] = P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[PriceRank] = ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC)
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID 

/*Exercise 3:Enhance your query from Exercise 2 by adding a derived column called
"Category Price Rank" that ranks all products by ListPrice – within each category - in descending order. 
In other words, every product within a given category should be ranked relative to other products in the same category.*/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory',
	[AvgPriceByCat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[AvgPriceByCatAndSubcat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name],PS.[Name]),
	[ProdVsCatDelta] = P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[PriceRank] = ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC),
	[CatPriceRank] = ROW_NUMBER() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC)
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID 

/*Exercise 4:Enhance your query from Exercise 3 by adding a derived column called
"Top 5 Price In Category" that returns the string “Yes” if a product has one of the top 5 list prices in its product category, 
and “No” if it does not. You can try incorporating your logic from Exercise 3 into a CASE statement to make this work.*/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory',
	[AvgPriceByCat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[AvgPriceByCatAndSubcat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name],PS.[Name]),
	[ProdVsCatDelta] = P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[PriceRank] = ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC),
	[CatPriceRank] = ROW_NUMBER() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC),
	[Top5InCat] = CASE
					WHEN (ROW_NUMBER() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC)<=5) THEN 'YES'
					ELSE 'NO'
				END
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID 


----------------------------------------/RANK and DENSE_RANK - Exercises/-------------------------------------------
/*Exercise 1:Using your solution query to Exercise 4 from the ROW_NUMBER exercises as a staring point, add a derived column called 
“Category Price Rank With Rank” that uses the RANK function to rank all products by ListPrice within each category in descend order.
Observe the differences between the “Category Price Rank” and “Category Price Rank With Rank” fields.*/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory',
	[AvgPriceByCat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[AvgPriceByCatAndSubcat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name],PS.[Name]),
	[ProdVsCatDelta] = P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[PriceRank] = ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC),
	[CatPriceRank] = ROW_NUMBER() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC),
	[Top5InCat] = CASE
					WHEN (ROW_NUMBER() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC)<=5) THEN 'YES'
					ELSE 'NO'
				END,
	[CatPrice _Rank] = RANK() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC)
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID 

/*Exercise 2: Modify your query from Exercise 2 by adding a derived column called "Category Price Rank With Dense Rank" that 
uses the DENSE_RANK function to rank all products by ListPrice – within each category - in descending order. 
Observe the differences among “Category Price Rank”, “Category Price Rank With Rank”, & “Category Price Rank With Dense Rank” fields.*/
SELECT 
	P.[Name] AS 'ProductName',
	P.ListPrice,
	PS.[Name] AS 'ProductSubcategory',
	PC.[Name] AS 'ProductCategory',
	[AvgPriceByCat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[AvgPriceByCatAndSubcat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name],PS.[Name]),
	[ProdVsCatDelta] = P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[PriceRank] = ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC),
	[Top5InCat] = CASE
					WHEN (ROW_NUMBER() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC)<=5) THEN 'YES'
					ELSE 'NO'
				END,
	[CatPriceRank] = ROW_NUMBER() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC),
	[CatPrice _Rank] = RANK() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC),
	[CatPrice _DenseRank] = DENSE_RANK() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC)
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID 

/*Exercise 3: Examine the code you wrote to define the “Top 5 Price In Category” field back in the ROW_NUMBER exercises.
Now that you understand the differences among ROW_NUMBER, RANK, and DENSE_RANK, consider which of these functions would be most appropriate 
to return a true top 5 products by price, assuming we want to see the top 5 distinct prices AND we want “ties” (by price) to all share the same rank.*/
SELECT 
	P.[Name] AS 'ProdName',
	P.ListPrice,
	PS.[Name] AS 'ProdSubcategory',
	PC.[Name] AS 'ProdCategory',
	[AvgPriceByCat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[AvgPriceByCat&Subcat] = AVG(P.ListPrice) OVER(PARTITION BY PC.[Name],PS.[Name]),
	[ProdVsCatDelta] = P.ListPrice - AVG(P.ListPrice) OVER(PARTITION BY PC.[Name]),
	[PriceRank] = ROW_NUMBER() OVER(ORDER BY P.ListPrice DESC),
	[CatPriceRank] = ROW_NUMBER() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC),
	[CatPrice_Rank] = RANK() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC),
	[CatPrice _DenseRank] = DENSE_RANK() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC),
	[Top5InCat] = CASE
					WHEN (DENSE_RANK() OVER(PARTITION BY PC.[Name] ORDER BY P.ListPrice DESC)<=5) THEN 'YES'
					ELSE 'NO'
				END
FROM Production.Product P
JOIN Production.ProductSubcategory PS
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PS.ProductCategoryID = PC.ProductCategoryID 

-------------------------------------/LEAD and LAG - Exercises/------------------------------------------
/*Exercise 1: Create a query with the following columns:
“PurchaseOrderID” from the Purchasing.PurchaseOrderHeader table ; 
“OrderDate” from the Purchasing.PurchaseOrderHeader table
“TotalDue” from the Purchasing.PurchaseOrderHeader table ; 
“Name” from the Purchasing.Vendor table, which can be aliased as “VendorName”
-------Apply the following criteria to the query: --------
------->>Order must have taken place on or after 2013
------->>TotalDue must be greater than $500*/
SELECT 
	POH.PurchaseOrderID,
	POH.OrderDate,
	POH.TotalDue,
	[VendorName] = PV.[Name]
FROM Purchasing.PurchaseOrderHeader POH
JOIN Purchasing.Vendor PV
	ON POH.VendorID = PV.BusinessEntityID
	WHERE (YEAR(POH.OrderDate) >=2013) AND (POH.TotalDue > 500)

/*Exercise 2: Modify your query from Exercise 1 by adding a derived column called
"PrevOrderFromVendorAmt", that returns the “previous” TotalDue value (relative to the current row) within the group of all orders 
with the same vendor ID. We are defining “previous” based on order date.*/
SELECT 
	POH.PurchaseOrderID
	,POH.OrderDate
	,[VendorName] = PV.[Name]
	,POH.TotalDue
	,PrevOrdVendorAmt = LAG(POH.TotalDue,1) OVER(PARTITION BY PV.[Name]  ORDER BY POH.OrderDate)
FROM Purchasing.PurchaseOrderHeader POH
JOIN Purchasing.Vendor PV 
	ON POH.VendorID = PV.BusinessEntityID
	WHERE (YEAR(POH.OrderDate) >=2013) AND (POH.TotalDue > 500)
--added these 2 cols later as per solution, need to focus more on this aspect
ORDER BY POH.VendorID,POH.OrderDate

/*Exercise 3:Modify your query from Exercise 2 by adding a derived column called
"NextOrderByEmployeeVendor", that returns the “next” vendor name (the “name” field from Purchasing.Vendor) within the group of all orders 
that have the same EmployeeID value in Purchasing.PurchaseOrderHeader. 
Similar to the last exercise, we are defining “next” based on order date.*/
SELECT 
	POH.EmployeeID
	,POH.PurchaseOrderID
	,POH.OrderDate
	,[VendorName] = PV.[Name]
	,POH.TotalDue
	,[NextOrdByEmpVendor] = LEAD(POH.TotalDue,1) OVER(PARTITION BY POH.EmployeeID  ORDER BY POH.OrderDate)
FROM Purchasing.PurchaseOrderHeader POH
JOIN Purchasing.Vendor PV 
	ON POH.VendorID = PV.BusinessEntityID
	WHERE (YEAR(POH.OrderDate) >=2013) AND (POH.TotalDue > 500)
ORDER BY POH.EmployeeID,POH.OrderDate

/*Exercise 4:Modify your query from Exercise 3 by adding a derived column called "Next2OrderByEmployeeVendor" that returns, 
within the group of all orders that have the same EmployeeID, the vendor name offset TWO orders into the “future” relative to the order 
in the current row. The code should be very similar to Exercise 3, but with an extra argument passed to the Window Function used.*/
SELECT 
	POH.EmployeeID
	,POH.PurchaseOrderID
	,POH.OrderDate
	,[VendorName] = PV.[Name]
	,POH.TotalDue
	,[NextOrdByEmpVendor] = LEAD(PV.[Name],1) OVER(PARTITION BY POH.EmployeeID  ORDER BY POH.OrderDate)
	,[Next2OrderByEmployeeVendor] = LEAD(PV.[Name],2) OVER(PARTITION BY POH.EmployeeID  ORDER BY POH.OrderDate)
FROM Purchasing.PurchaseOrderHeader POH
JOIN Purchasing.Vendor PV 
	ON POH.VendorID = PV.BusinessEntityID
	WHERE (YEAR(POH.OrderDate) >=2013) 
			AND (POH.TotalDue > 500)
ORDER BY POH.EmployeeID,POH.OrderDate

---------------------------------------/FIRST_VALUE - Exercises/---------------------------------------------
/*Exercise 1
Create a query that returns all records - and the following columns - from the HumanResources.Employee table:
a. BusinessEntityID (alias this as “EmployeeID”)
b. JobTitle
c. HireDate
d. VacationHours
To make the effect of subsequent steps clearer, also sort the query output by "JobTitle" and HireDate, both in ascending order.*/
SELECT 
	BusinessEntityID AS 'EmployeeID'
	,JobTitle
	,HireDate
	,VacationHours
FROM HumanResources.Employee
ORDER BY JobTitle,HireDate

/*Now add a derived column called “FirstHireVacationHours” that displays – for a given job title – 
the amount of vacation hours possessed by the first employee hired who has that same job title. 
For example, if 5 employees have the title “Data Guru”, and the one of those 5 with the oldest hire date has 99 vacation hours, 
“FirstHireVacationHours” should display “99” for all 5 of those employees’ corresponding records in the query.*/
SELECT 
	BusinessEntityID AS 'EmployeeID'
	,JobTitle
	,HireDate
	,VacationHours
	,FirstHireVacationHours = FIRST_VALUE(VacationHours) OVER(PARTITION BY JobTitle ORDER BY HireDate)
FROM HumanResources.Employee
ORDER BY JobTitle,HireDate

/*Exercise 2: Create a query with the following columns:
a. “ProductID” from the Production.Product table
b. “Name” from the Production.Product table (alias this as “ProductName”)
c. “ListPrice” from the Production.ProductListPriceHistory table
d. “ModifiedDate” from the Production.ProductListPriceHistory*/
SELECT 
	P.ProductID,
	'ProductName' = P.[Name],
	PLH.ListPrice,
	PLH.ModifiedDate
FROM Production.Product P
JOIN Production.ProductListPriceHistory PLH
	ON P.ProductID = PLH.ProductID
/*2.To make the effect of subsequent steps clearer, also sort the query output by ProductID and ModifiedDate, both in ascending order.*/
ORDER BY P.ProductID, PLH.ModifiedDate

/*3.Now add a derived column called “HighestPrice” that displays – for a given product – the highest price that product has been listed at.
So even if there are 4 records for a given product, this column should only display the all-time highest list price for that product in each of those 4 rows.*/
SELECT 
	P.ProductID,
	'ProductName' = P.[Name],
	PLH.ListPrice,
	PLH.ModifiedDate,
	---All-time highest ListPrice
	'HighestPrice' = FIRST_VALUE(PLH.ListPrice) OVER(PARTITION BY P.ProductID ORDER BY PLH.ListPrice DESC)
FROM Production.Product P
JOIN Production.ProductListPriceHistory PLH
	ON P.ProductID = PLH.ProductID
ORDER BY P.ProductID, PLH.ModifiedDate
/*4.Similarly, create another derived column called “LowestCost” that displays the all-time lowest price for a given product.*/
SELECT 
	P.ProductID,
	'ProductName' = P.[Name],
	PLH.ListPrice,
	PLH.ModifiedDate,
	---All-time highest ListPrice
	'HighestPrice' = FIRST_VALUE(PLH.ListPrice) OVER(PARTITION BY P.ProductID ORDER BY PLH.ListPrice DESC),
	'LowestCost' = FIRST_VALUE(PLH.ListPrice) OVER(PARTITION BY P.ProductID ORDER BY PLH.ListPrice),
/*5.create A derived column “PriceRange” that for given product, reflects the difference between its highest &lowest ever list prices.*/
	'PriceRange' = (FIRST_VALUE(PLH.ListPrice) OVER(PARTITION BY P.ProductID ORDER BY PLH.ListPrice DESC)) - (FIRST_VALUE(PLH.ListPrice) OVER(PARTITION BY P.ProductID ORDER BY PLH.ListPrice))
FROM Production.Product P
JOIN Production.ProductListPriceHistory PLH
	ON P.ProductID = PLH.ProductID
ORDER BY P.ProductID, PLH.ModifiedDate


---------------------------/Introducing Subqueries - Exercises/--------------------------------
/*Exercise 1: Write a query that displays the three most expensive orders, per vendor ID, from the Purchasing.PurchaseOrderHeader table.
There should ONLY be three records per Vendor ID, even if some of the total amounts due are identical. 
"Most expensive" is defined by the amount in the "TotalDue" field.
Include the following fields in your output:
PurchaseOrderID
VendorID
OrderDate
TaxAmt
Freight
TotalDue*/

SELECT *
FROM
	(SELECT
		PurchaseOrderID,
		VendorID,
		OrderDate,
		TaxAmt,
		Freight,
		TotalDue,
		Rank_TotalDue = ROW_NUMBER() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)
	FROM Purchasing.PurchaseOrderHeader)A
WHERE Rank_TotalDue <=3
	---
	SELECT TOP(3)*FROM Purchasing.PurchaseOrderHeader
	SELECT TOP(3)* FROM Purchasing.Vendor

/*Exercise 2:Modify your query from the first problem, such that the top three purchase order amounts are returned, regardless of how many records are returned per Vendor Id.
In other words, if there are multiple orders with the same total due amount, all should be returned as long as the total due amount for these orders is one of the top three.
Ultimately, you should see three distinct total due amounts (i.e., the top three) for each group of like Vendor Ids. However, there could be multiple records for each of these amounts.*/

SELECT *
FROM
	(SELECT
		PurchaseOrderID,
		VendorID,
		OrderDate,
		TaxAmt,
		Freight,
		TotalDue,
		Rank_TotalDue = DENSE_RANK() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)
	FROM Purchasing.PurchaseOrderHeader)A
WHERE Rank_TotalDue <=3



	---
	SELECT TOP(3)*FROM Purchasing.PurchaseOrderHeader
	SELECT TOP(3)* FROM Purchasing.Vendor

