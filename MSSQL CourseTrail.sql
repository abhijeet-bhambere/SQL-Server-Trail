--Aliasing (1.10): Basically renaming the columns in the db for a better understanding
	select
		--Showing various ways of aliasing
		[Org Level] = [OrganizationLevel],
		[JobTitle] as Designation,
		[HireDate] as "Hired on",
		[VacationHours] as "Vacation Hrs"

	from AdventureWorks2019.HumanResources.Employee

/*Exercise 1: Modify the query in the “Aliasing Columns – Example Code.sql” file
such that all column names in the query output have spaces between the words.*/
--Aliasing a column name in SQL
	SELECT 
		   [Organization Level] = [OrganizationLevel]
		  ,[JobTitle] as "Job Title"
		  ,[HireDate] as "Hire Date"
		  ,[VacationHours] as "Vacation Hours"
	  
	FROM [AdventureWorks2019].[HumanResources].[Employee]

/*Exercise 2: 
Write a query that outputs the “Name” and “ListPrice” fields from the “Production.Product” table. 
These column names in the query output should read “Product Name” and “List Price $$”, respectively.*/

	select 
		[Name] as "Product Name",
		[ListPrice] as "List Price $$"

	from Production.Product

/*Exercise 3:
Write a query that outputs the “PurchaseOrderID”, “OrderQty”, and “LineTotal” fields from the “Purchasing.PurchaseOrderDetail” table. 
“PurchaseOrderID” should be renamed to “OrderID”, and “OrderQty” to “OrderQuantity”. “LineTotal” can remain unchanged.*/
	select 
		[PurchaseOrderId] as "OrderID",
		[OrderQty] as "OrderQuantity",
		[LineTotal]

	from Purchasing.PurchaseOrderDetail

--Entering columns with custom values( simple strings or calculated fields)
	select top(10)
		[PurchaseOrderID],
		[OrderQty],
		[UnitPrice],
		[UnitPrice]*[OrderQty] as "TotalPrice"
	from Purchasing.PurchaseOrderDetail

/*Exercise 1:
Write a query that selects your first name and age. Name the columns “First Name”, and “Age”, respectively.*/
	select
		[FirstName] = 'AB',
		[Age] = 29

/*
Exercise 2:
Write a query that outputs:
All columns from the Sales.SalesOrderHeader table EXCEPT “rowguid” and “ModifiedDate”.
A column called “Query Run By” that outputs your first name. This should be the first column in the query output.
The query should only output the top 5000 rows from the table.*/

	SELECT TOP (5000) [Query Run By] = 'AB'
			,[SalesOrderID]
		  ,[RevisionNumber]
		  ,[OrderDate]
		  ,[DueDate]
		  ,[ShipDate]
		  ,[Status]
		  ,[OnlineOrderFlag]
		  ,[SalesOrderNumber]
		  ,[PurchaseOrderNumber]
		  ,[AccountNumber]
		  ,[CustomerID]
		  ,[SalesPersonID]
		  ,[TerritoryID]
		  ,[BillToAddressID]
		  ,[ShipToAddressID]
		  ,[ShipMethodID]
		  ,[CreditCardID]
		  ,[CreditCardApprovalCode]
		  ,[CurrencyRateID]
		  ,[SubTotal]
		  ,[TaxAmt]
		  ,[Freight]
		  ,[TotalDue]
		  ,[Comment]

	  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]


  /*Exercise 1:
Using SELECT *, select all columns AND rows from the “Sales.Customer” table .*/

	select*
	from Sales.Customer

/*Exercise 2:
Select all columns and the top 100 rows from the “Production.Product” table, using SELECT *.*/
	select top(100)
		*
	from Production.Product

/*Exercise 3:
Copy and paste the queries from the first two exercises into a single query editor window, one below the other. 
Try running them individually, and then both at the same time.*/
	select*
	from [Sales].[Customer]



	select top(100)
		*
	from Production.Product

-------------------------------------------------------------------------------------------------------------------------------
----------------------SECTION 2-----------------------
----Filtering using WHERE clause----
---The basic clause for filtering in SQL---
  SELECT --[BusinessEntityID]
      [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
      --,[ModifiedDate]
  FROM [AdventureWorks2022].[Purchasing].[Vendor]
  --WHERE [Name]='Northwind Traders'
  WHERE [PreferredVendorStatus]=1
  Order by [Name]

  ----Filtering for NULL values----
  ---IS NULL clause returns rows for which the specified column value was NULL
  ---Null does nt mean zero ; its a datatype that denotes 
SELECT [AccountNumber],[Name],[CreditRating],
	[PreferredVendorStatus],[ActiveFlag],[PurchasingWebServiceURL]
	FROM [AdventureWorks2022].[Purchasing].[Vendor]
	WHERE [PurchasingWebServiceURL] IS NULL
Order by [Name]

  -------------EXAMPLE 2-------------------
  	SELECT --[BusinessEntityID]
      [AccountNumber]
      ,[Name]
      ,[CreditRating]
      ,[PreferredVendorStatus]
      ,[ActiveFlag]
      ,[PurchasingWebServiceURL]
      --,[ModifiedDate]
  FROM [AdventureWorks2022].[Purchasing].[Vendor]
  WHERE [PurchasingWebServiceURL] IS NOT NULL
  Order by [Name]


-------------Multiple criteria using AND/OR/IN----------------
SELECT [BusinessEntityID],[NationalIDNumber],[LoginID]
    ,[OrganizationNode],[OrganizationLevel],[JobTitle],[BirthDate]
    ,[MaritalStatus],[Gender],[HireDate]
FROM [AdventureWorks2022].[HumanResources].[Employee]
WHERE [JobTitle] = 'Sales Representative'
AND [MaritalStatus] = 'M' 

SELECT [BusinessEntityID],[NationalIDNumber],[LoginID]
    ,[JobTitle],[BirthDate],[MaritalStatus],[Gender],[HireDate]
FROM [AdventureWorks2022].[HumanResources].[Employee]
WHERE ([JobTitle] = 'Sales Representative' OR [JobTitle] = 'Senior Design Engineer ')

----------Using IN for multiple OR conditions---------------
SELECT [BusinessEntityID],[NationalIDNumber],[LoginID]
    ,[JobTitle],[BirthDate],[MaritalStatus],[Gender],[HireDate]
FROM [AdventureWorks2022].[HumanResources].[Employee]
WHERE [JobTitle] IN('Sales Representative','Senior Design Engineer','Research and Development Engineer')

--------------FILTETERING A NUMERICAL RANGE: USING BETWEEN KEYWORD--------------------

SELECT TOP (1000) [SalesOrderID],[TotalDue]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[AccountNumber]
      ,[CustomerID]
      ,[TerritoryID]
      
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
  WHERE [TotalDue] BETWEEN 20000 AND 30000
	ORDER BY [TotalDue]


--------------FILTETERING WITH TEXTS PATTERNS: LIKE KEYWORD WITH WILDCARD CHARACTERS--------------------
--------Select all Person names starting with firstName 'T..m..' and lastName 'B..'
SELECT [BusinessEntityID],[PersonType],[Title],[FirstName],[LastName],[Suffix],[EmailPromotion],[Demographics]

  FROM [AdventureWorks2022].[Person].[Person]
  WHERE [FirstName] LIKE 'T%M%' AND [LastName] LIKE 'B%'
  
-------Using OR-kind of condition to Select all names with firstNames starting with either L, M or N--------
SELECT [BusinessEntityID],[PersonType],[Title],[FirstName],[LastName],[Suffix],[EmailPromotion],[Demographics]

  FROM [AdventureWorks2022].[Person].[Person]
  WHERE [FirstName] LIKE '[LMN]%'

-------Select all Job Titles containing numeric characters--------
SELECT [BusinessEntityID]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      
  FROM [AdventureWorks2022].[HumanResources].[Employee]
  WHERE [JobTitle] LIKE '%[0-9]%'

-------Select all Job Titles that DO NOT contain numeric characters--------
SELECT [BusinessEntityID]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SalariedFlag]
      
  FROM [AdventureWorks2022].[HumanResources].[Employee]
  WHERE [JobTitle] NOT LIKE '%[0-9]%'



--------------SORT THE DATASET--USING ORDER BY--------------------
-----EIther column name, alias name or column no. can be used in the ORDER BY clause-----
SELECT TOP (1000) [SalesOrderID],[OrderDate],[Total Amount Due]=[TotalDue]
  
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
	WHERE [TotalDue] >10000
	ORDER BY [Total Amount Due] DESC


---Using the column name
SELECT TOP (1000) [SalesOrderID],[OrderDate],[Total Amount Due]=[TotalDue]
  
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
	WHERE [TotalDue] >10000
	ORDER BY 1 DESC

--------------------------------------------------------------

SELECT [BusinessEntityID],[Title],[LastName],[FirstName]
  FROM [AdventureWorks2022].[Person].[Person]
  ORDER BY [LastName] DESC,[FirstName]

---------------------------------------------------------------

SELECT TOP (1000) [BusinessEntityID],[Title],[FirstName],[LastName]      
  FROM [AdventureWorks2022].[Person].[Person]
  ORDER BY [FirstName] DESC



------------SELECTING ONLY UNIQUE VALUES FROM A COLUMN(s)-USING SELECT DISTINCT------------
------SELECTING ONLY UNIQUE JOB TITLES FROM THE EMPLOYEE TABLE-----
SELECT DISTINCT [JobTitle]
FROM HumanResources.Employee

------SELECTING ONLY UNIQUE PRODUCTIDs FROM SALESORDERDETAIL TABLE-----
SELECT DISTINCT ProductID
  FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]
  ORDER BY ProductID


---------------------------------------DERIVED COLUMNS----------------------------------------
----Temporary columns created on-the-fliy & only exist in the context of the present query---
---Example : to show the First & LAst names of person as one complete name
SELECT FirstName,LastName,FULL_NAME = FirstName + ' ' + LastName

FROM Person.Person
ORDER BY FULL_NAME

-----EXAMPLE 2-----
SELECT FirstName,MiddleName,LastName,FULL_NAME = FirstName + ' ' + MiddleName + ' '+ LastName

FROM Person.Person
WHERE MiddleName IS NOT NULL

----ALTERNATIVE TO HANDLE NULLs IN ANY OF THE FIELDS----
SELECT FirstName,
	MiddleName,
	LastName,
	FULL_NAME = FirstName + ' ' + MiddleName + ' '+ LastName,
	ANOTHER_WAY = FirstName + ISNULL(' ' + MiddleName,'') + ' ' + LastName

FROM Person.Person


-------USING MATH OPERATIONS--------
--USING THE SALESPERSON TABLE--
SELECT [BusinessEntityID],[TerritoryID],[SalesQuota],[Bonus]
	,[BONUS_FAIRNESS] = (Bonus / SalesYTD) *100
    ,[CommissionPct]
	,[COMMISION_YTD] = SalesYTD * CommissionPct
    ,[SalesYTD]
	,[INCOME_YTD] = (SalesYTD * CommissionPct) + Bonus
    ,[SalesLastYear]
	,[SALES_DIFF] = SalesYTD - SalesLastYear
      
  FROM [AdventureWorks2022].[Sales].[SalesPerson]
	ORDER BY INCOME_YTD DESC

---For divison, Ensure to convert integer to float value---
SELECT [SafetyStockLevel]
      ,[ReorderPoint]
	  ,[integer_div] = ReorderPoint / SafetyStockLevel
	  ,[actual_div] = (ReorderPoint * 1.0) / SafetyStockLevel
      
  FROM [AdventureWorks2022].[Production].[Product]

-------------------------SQL FUNCTIONS--------------------------
------LEFT FUNC TO TRIM CHARACTERS FROM A STRING------
---EXTRACT AREA CODES FORM PHONE NO.S---
SELECT 
      [PhoneNumber],
      [Area_code] = LEFT(PhoneNumber,3)
  FROM [AdventureWorks2022].[Person].[PersonPhone]
  WHERE [PhoneNumber] NOT LIKE '%(%'

---RIGHT FUNC TO OBTAIN RETURN THE LENGHTH OF A STRING---
SELECT 
		[AccountNumber]  
		,[LAST_6CHARS] = RIGHT(AccountNumber,6)
		,[len of char] = LEN(AccountNumber)
	FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

-----REPLACE FUNCTION------
--REPLACING THE DOMAIN NAME FROM THE EMAIL ADDRESS
SELECT EmailAddressID,
		EmailAddress,
		'MODIFIED_EMAILid' = REPLACE(EmailAddress,'adventure-works','northwind.com')
	FROM Person.EmailAddress

---------------------UNSING CONCAT_WS FUNCTION---------------------
---HELPS TO IGNORE NULL VALUES IF PRESENT---
SELECT FirstName,
	MiddleName,
	LastName,
	without_concatWS = FirstName + ISNULL(' ' +MiddleName,'') + ' ' + LastName,
	with_concatWS = CONCAT_WS(' ',FirstName,MiddleName,LastName)
	FROM Person.Person

----------------------------USING NESTED FUNCTIONS------------------------------
----EXTRACT ONLY THE NAMES FROM EMAILIDs. USE NEXTED FUNCS (LEFT + LEN) TO REMOVE THE DOMAIN PART----
SELECT EmailAddress,
	[EMAIL_LEN] = LEN(EMAILADDRESS),
	[EXTRACTED_NAME] = LEFT(EmailAddress,(LEN(EMAILADDRESS) - 20)),
	[EXTRACTED_LEN] = LEN(EMAILADDRESS) - 20
FROM PERSON.EmailAddress

-----ZERO-PADDING - TO ADD LEADING ZEROS TO THE COLUMN VALUES-----
--USEEFUL WHEN VALUES IN GIVEN COLUMN HAVE UNEQUAL LENGTHS ; HELPS TO BRING UNIFORMITY TO THE COLUMN LENGTH AND/OR FORMAT--
SELECT [NationalIDNumber],
	[ID_LENGTH] =LEN([NationalIDNumber]),
	--SO, ID LENGTHS ARE VARYING, ADD LEADING ZEROS TO BRING UNIFORMITY--
	[CORRECTED_ID_LENGTH] = RIGHT('000000000' + [NationalIDNumber],9)
FROM [AdventureWorks2022].[HumanResources].[Employee]
ORDER BY 2 DESC
---AS SEEN FROM RESULTING GRID, LEADING ZEROS WERE ADDED TO THE ID COLUMN WHERE ID LENGTH WAS <9


----------------------DATE & TIME FUNCTIONS------------------------
SELECT GETDATE() AS GET_DATE,
	SYSDATETIME() AS SYSTEM_DATE,
	GETUTCDATE() AS UTC_DATE,
	SYSDATETIMEOFFSET() TIME_W_UTC_OFFSET;

--------FINDING ORDERS BETWEEN 2013 AND 2014 - USE OF DATEFROMPARTS() AND YEAR()----------
SELECT [SalesOrderID]
      ,[OrderDate]
      ,[ORDER_YEAR] = YEAR(OrderDate)
	  ,[Status]
      ,[CustomerID]
	  ,[TotalDue]
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE YEAR(OrderDate) BETWEEN 2012 AND 2013

SELECT [SalesOrderID]
      ,[OrderDate]
      ,[ORDER_YEAR] = YEAR(OrderDate)
	  ,[Status]
      ,[CustomerID]
	  ,[TotalDue]
FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]
WHERE [OrderDate] BETWEEN DATEFROMPARTS(2013,1,1) AND DATEFROMPARTS(2014,1,1)

------------------USE THE FIRST /LAST DATE OF THE GIVEN DATE----------------
SELECT YEAR(GETDATE()) AS 'GET CURR YEAR',
	MONTH(GETDATE()) AS'GET CURR MONTH',
	DAY(GETDATE()) AS 'GET CURR DAY',
	EOMONTH(GETDATE()) AS 'GET EOM'

-----------------------DATE MATH OPERATION--------------------------
------WORKING ON A DYNAMIC DATE RANGE IS VERY IMP.------
SELECT GETDATE() AS CURR_DATE,
	GETDATE() - 7 AS PREV_WEEK_DATE;

---GIVEN CURRENT DATE, CALCULATE FIRST & LAST DAY OF CURR/PREV MONTH---
SELECT CURR_DATE = GETDATE(),
	FIRST_OFMONTH = DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1),
	FIRST_OF_PREVMONTH = DATEADD(MONTH,-1, DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1)),
	MONTH_TODATE = DATEADD(MONTH,-1, GETDATE()),
	LASTDAY_PREVMONTH = DATEADD(DAY,-1,DATEFROMPARTS(YEAR(GETDATE()),MONTH(GETDATE()),1));


----CALCULATING ELASPED TME FOR DETERMINIG GO-LIVE TIME,TIME-TO-SHIP, SLAs ETC.-----
----CALCULATING TIME TO SHOP----
SELECT [OrderDate],
	[ShipDate],
	[TIME_TO_SHIP(DAYS)] = DATEDIFF(DAY,[OrderDate],[ShipDate])
	FROM [Sales].[SalesOrderHeader]

-------------------------------DATA TYPES & CASTING--------------------------------
----CAST KEYWORD HELPS TO CONVERT DATA TYPES----
SELECT 
	TotalDue,
	CALC_TOTALDUE = CAST(TotalDue AS int)
FROM Sales.SalesOrderHeader

-----RETAIN JUST HTE DATE COMPONENT-----
SELECT CAST('2023-01-01 00:00' AS date)

-----------------------------FORMAT FUNCTION---------------------------------
---------------FORMATTING CURRENCY---------------
SELECT FORMAT(StandardCost,'C','EN-US'),
	FORMAT(ListPrice,'C','EN-US'),
	JUST_PROFIT = (ListPrice - StandardCost) / StandardCost,
	PROFIT_PERC = FORMAT(((ListPrice - StandardCost) / StandardCost),'P')

FROM Production.Product
WHERE StandardCost >0
---------------------------------------

SELECT FORMAT(StandardCost,'C','EN-GB'),
	FORMAT(ListPrice,'C','EN-GB'),
	JUST_PROFIT = (ListPrice - StandardCost) / StandardCost,
	PROFIT_PERC = FORMAT(((ListPrice - StandardCost) / StandardCost),'P')

FROM Production.Product
WHERE StandardCost >0

--------------------FORMATTING DATE &TIME-------------------
---RE-FORMAT DATE FROM YYYY-MM-DD TO DD/MM/YYYY---
SELECT 
	CAST(OrderDate AS date),
	NEW_ORDERDATE = FORMAT(OrderDate,'dd-MMM-yy'),
	CAST(ShipDate AS date),
	NEW_SHIPDATE = FORMAT(ShipDate,'dd/MMM/yyyy'),
	TotalDue
FROM Sales.SalesOrderHeader

--------------------------------HANDLING NULL VALUES IN A FIELD---------------------------------------
---USING ISNULL() FUNC TO SHOW A SPECIFIED FALL-BACK VALUE WHEN NULL VALUE IS ENCOUNTERED---
---HELPS IMPROVE READABILITY OF THE DB FOR N/A OR NULL DATA---
SELECT Title,
	MOD_TITLE = ISNULL(Title,'No Title'),
	FirstName,
	MiddleName,
	LastName
FROM Person.Person

----
------SELECT ALL SALES_QUOTA NOT 250000 ; BUT INCLUDE NULL------
SELECT *
FROM Sales.SalesPerson
WHERE ISNULL(SalesQuota,0) !=250000


----------------CONDITIONAL LOGIC FLOW - using CASE STATEMENT ---------------
-----------------------IMPLEMENT A IF-THEN-ELSE LOGIC---------------------
-------USE CASE: WRAPPING RANGES INTO CATEGORY BUCKETS--------
-----Add a column that groups similar JobTitles by domain---
SELECT DISTINCT JobTitle,
	DOMAIN = 
		CASE
			WHEN JobTitle LIKE('PRODUCTION%') THEN 'PRODUCTION'
			WHEN JobTitle LIKE('FINANCE%') THEN 'FINANCE'
			WHEN JobTitle LIKE('QUALITY%') THEN 'QA'
			WHEN JobTitle LIKE('NETWORK%') THEN 'NETWORKING'
			--Notice for Engineering Mngr, the Engineering domain was applied as that condition precedes
			---the management condition
			WHEN JobTitle LIKE('%Engin%') THEN 'ENGINEERING'
			WHEN JobTitle LIKE('%Manager%') THEN 'MANAGEMENT'
						
			WHEN JobTitle LIKE('SALES%') THEN 'SALES'
			WHEN JobTitle LIKE('SHIPPING%') THEN 'LOGISTICS'
			ELSE 'MISC'
		END
FROM HumanResources.Employee

------------------------------CASE-WHEN STATEMENT FOR DATE-TIME VALUES-----------------------------
---CALCULATE ORDER_DATE ELAPSED TILL 31-JUL-2013 ; THEN CATEGORIZE BASED ON DATE GAP---
SELECT 
	SalesOrderID,
	OrderDate,
	CURR_DATE = CAST('2013-07-31' AS DATE),
	ELAPSED_DATE = DATEDIFF(DAY,OrderDate,CAST('2013-07-31' AS DATE)),
	--USING THE DATEDIFF CALCULATION IN THE CASE STATEMENT--
	ORD_BUCKET = CASE
		WHEN DATEDIFF(DAY,OrderDate,CAST('2013-07-31' AS DATE)) < 10 THEN '<10 DAYS'
		WHEN DATEDIFF(DAY,OrderDate,CAST('2013-07-31' AS DATE)) BETWEEN 10 AND 19 THEN '10-19 DAYS'
		ELSE '20+DAYS'
	END
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN DATEFROMPARTS(2013,07,01) AND DATEFROMPARTS(2013,07,31)



