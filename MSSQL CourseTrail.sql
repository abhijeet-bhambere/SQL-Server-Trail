--Aliasing (1.10): Basically renaming the columns in the db for a better understanding
	select
		--Showing various ways of aliasing
		[Org Level] = [OrganizationLevel],
		[JobTitle] as Designation,
		[HireDate] as "Hired on",
		[VacationHours] as "Vacation Hrs"

	from AdventureWorks2019.HumanResources.Employee

/*Exercise 1: Modify the query in the �Aliasing Columns � Example Code.sql� file
such that all column names in the query output have spaces between the words.*/
--Aliasing a column name in SQL
	SELECT 
		   [Organization Level] = [OrganizationLevel]
		  ,[JobTitle] as "Job Title"
		  ,[HireDate] as "Hire Date"
		  ,[VacationHours] as "Vacation Hours"
	  
	FROM [AdventureWorks2019].[HumanResources].[Employee]

/*Exercise 2: 
Write a query that outputs the �Name� and �ListPrice� fields from the �Production.Product� table. 
These column names in the query output should read �Product Name� and �List Price $$�, respectively.*/

	select 
		[Name] as "Product Name",
		[ListPrice] as "List Price $$"

	from Production.Product

/*Exercise 3:
Write a query that outputs the �PurchaseOrderID�, �OrderQty�, and �LineTotal� fields from the �Purchasing.PurchaseOrderDetail� table. 
�PurchaseOrderID� should be renamed to �OrderID�, and �OrderQty� to �OrderQuantity�. �LineTotal� can remain unchanged.*/
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
Write a query that selects your first name and age. Name the columns �First Name�, and �Age�, respectively.*/
	select
		[FirstName] = 'AB',
		[Age] = 29

/*
Exercise 2:
Write a query that outputs:
All columns from the Sales.SalesOrderHeader table EXCEPT �rowguid� and �ModifiedDate�.
A column called �Query Run By� that outputs your first name. This should be the first column in the query output.
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
Using SELECT *, select all columns AND rows from the �Sales.Customer� table .*/

	select*
	from Sales.Customer

/*Exercise 2:
Select all columns and the top 100 rows from the �Production.Product� table, using SELECT *.*/
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

--------------------------------------------JOINS------------------------------------------------
---UNIONS: combining two tables such that output is a table with rows stacked on one another to create a single unified dataset---
---combining  customer orders & vendor orders placed in 2013 into a single table---
SELECT SalesOrderID,
	OrderDate,
	[OrderType] = 'Customer Order'
FROM SALES.SalesOrderHeader
WHERE YEAR(OrderDate) = 2013

	UNION
SELECT PurchaseOrderID,
	OrderDate,
	[OrderType] = 'Vendor Order'
FROM Purchasing.PurchaseOrderHeader
WHERE YEAR(OrderDate) = 2013

ORDER BY OrderDate

-------UNION ALL SIMPLY COMBINES TABLES TOGETHER INCLUDING DUPLICATE ROWS---------
SELECT SalesOrderID,
	OrderDate,
	[OrderType] = 'Customer Order'
FROM SALES.SalesOrderHeader
WHERE YEAR(OrderDate) = 2013

	UNION ALL
SELECT PurchaseOrderID,
	OrderDate,
	[OrderType] = 'Vendor Order'
FROM Purchasing.PurchaseOrderHeader
WHERE YEAR(OrderDate) = 2013

ORDER BY OrderDate


------------------------------------------------------JOINS-----------------------------------------------------------
----------------INNER JOIN: ITS AN INTERSECTION & HENCE RETURNS RECORDS COMMON IN BOTH THE TABLES----------------
-----FINDING INFO OF THE SALES PERSONS (IN SALES.SALESPERSON TABLE) FROM THE PERSON.PERSON TABLE------ 
---WE CAN SEE THAT THE BUSINESSENTITY_ID IS THE COMMON FIELD IN BOTH TABLE
SELECT 
	P.[FirstName]
	,P.[MiddleName]
	,P.[LastName]
	,P.[Demographics]
	,SP.[BusinessEntityID]
	,SP.[SalesYTD]
	,SP.[SalesLastYear]
  FROM [AdventureWorks2022].[Sales].[SalesPerson] SP
JOIN   [AdventureWorks2022].[Person].[Person] P
ON P.BusinessEntityID = SP.BusinessEntityID


----------------------------JOINING MULTIPLE TABLES---------------------------
---The connecting field must be common in atleast two of the tables---
SELECT 
	P.[FirstName]
	,P.[MiddleName]
	,P.[LastName]
	,P.[Demographics]
	,SP.[BusinessEntityID]
	,SP.[SalesYTD]
	,SP.[SalesLastYear]
	,ST.[TerritoryID]
	,ST.[Name]
	,ST.[CountryRegionCode]
	,ST.[Group]
	,ST.[SalesYTD]

	FROM [AdventureWorks2022].[Sales].[SalesPerson] SP
JOIN   [AdventureWorks2022].[Person].[Person] P
ON P.BusinessEntityID = SP.BusinessEntityID
JOIN [AdventureWorks2022].[Sales].[SalesTerritory] ST
ON SP.TerritoryID = ST.TerritoryID
-----tHE RESULTANT JOIN CAN BE FILTERED------
WHERE ST.[Group]='Europe'


---------------------------OUTER JOINS---------------------------------
SELECT 
	A.BusinessEntityID,
	A.FirstName,
	A.LastName,
	B.JobTitle,
	B.VacationHours,
	B.SickLeaveHours

FROM Person.Person A
LEFT OUTER JOIN HumanResources.Employee B
ON A.BusinessEntityID = B.BusinessEntityID
WHERE FirstName = 'JOHN'

-------------COMBINING INNER & OUTER JOINS-----------
SELECT 
	A.BusinessEntityID,
	A.FirstName,
	A.LastName,
	B.JobTitle,
	B.VacationHours,
	B.SickLeaveHours

FROM Person.Person A 
LEFT OUTER JOIN HumanResources.Employee B 
	ON A.BusinessEntityID = B.BusinessEntityID
--ADDING BELOW CONDITION WILL ALSO GIVE SAME OUTPUT BUT MAKE THE RECORDS CONTAINING <50 VACATION HRS AS 'NULL'--
--AND B.VacationHours > 50
LEFT OUTER JOIN PERSON.EmailAddress C
	ON B.BusinessEntityID = C.BusinessEntityID

WHERE FirstName = 'JOHN'

---------ENTITY RELATIONSHIP DIAGRAMS--------

---------Formatting SQL queries--------


----------------------------------/AGGREGATIONS/-----------------------------------------------
SELECT 
	JobTitle,
	Gender,
	['Emp_Count'] = COUNT(JobTitle)
FROM HumanResources.Employee
GROUP BY JobTitle,Gender

ORDER BY JobTitle

--------------------------------------AVG STD-PRICE V/S LIST-PRICE-------------------------------------

SELECT
	'Prod_MainCategory'=PC.[Name],
	'Prod_SubCategory'=PSC.[Name],
	'AVG_Std_Cost'=AVG(P.StandardCost),
	'AVG_List_Price'=AVG(P.ListPrice)

FROM Production.Product P
JOIN Production.ProductSubcategory PSC
	ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PSC.ProductCategoryID=PC.ProductCategoryID
GROUP BY PC.[Name],PSC.[Name]
ORDER BY PC.[Name],PSC.[Name]

----
SELECT
	'Prod_MainCategory'=PC.[Name],
	'Prod_SubCategory'=PSC.[Name],
	'Std_Cost'=(P.StandardCost),
	'List_Price'=(P.ListPrice)

FROM Production.Product P
JOIN Production.ProductSubcategory PSC
	ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
JOIN Production.ProductCategory PC
	ON PSC.ProductCategoryID=PC.ProductCategoryID
ORDER BY PC.[Name],PSC.[Name]


------------------------------------/FILTERING AGGREGATIONS--USING HAVING CLAUSE ON AGGREGATE QUERIES/--------------------------------------
------------------IDENTIFY PRODUCTS WITH LINETOTALs greater than $10,000---------------
SELECT 
	
	[PRODUCT]=P.[Name],
	[TOTAL_SUM]=SUM(S.LineTotal),
	P.Size
FROM Production.Product P
JOIN Sales.SalesOrderDetail S
	ON P.ProductID = S.ProductID
GROUP BY P.[Name],P.Size
	HAVING SUM(S.LineTotal)>10000
ORDER BY SUM(S.LineTotal) DESC


-----ADDDING WHERE CLAUSE TO THE AGREGATION QUERY TO REMOVE ROWS WHERE 'SIZE' HAS NULL VALUES----
SELECT 	
	[PRODUCT]=P.[Name],
	[TOTAL_SUM]=SUM(S.LineTotal),
	P.Size

FROM Production.Product P
JOIN Sales.SalesOrderDetail S
	ON P.ProductID = S.ProductID
	WHERE P.Size IS NOT NULL
GROUP BY P.[Name],P.Size
	HAVING SUM(S.LineTotal)>10000
ORDER BY SUM(S.LineTotal) DESC


----------------------------------------------STRING AGGREGATIONS------------------------------------------------
-----------USED WHEN MULTIPLE STRINGS ARE PART OF THE SAME GROUP & THESE CAN BE ROLLED OVER INTO ONE ROW BY SOME DELIMITER---------------

SELECT 
	[cATEGORY] = PC.[Name],
	[SUBCATEGORY] = PS.[Name]
FROM Production.ProductCategory PC
JOIN Production.ProductSubcategory PS
	ON PC.ProductCategoryID = PS.ProductCategoryID
	----NOW WE CAN SEE THAT EACH CATEGORY HAS MULTIPLE SUBCATEGORIES----

SELECT 
	[CATEGORY] = PC.[Name],
	[SUBCATEGORY] = STRING_AGG(PS.[Name],', ')
FROM Production.ProductCategory PC
JOIN Production.ProductSubcategory PS
	ON PC.ProductCategoryID = PS.ProductCategoryID
GROUP BY PC.[Name]

---------------------------/WINDOW FUNCTIONS/-------------------------------

SELECT TOP (1000) [BusinessEntityID]
      ,[TerritoryID]
      ,[SalesQuota]
      ,[Bonus]
      ,[CommissionPct]
      ,[SalesYTD]
      ,[SalesLastYear]
	  ,[Overall_AvgSales] = AVG([SalesYTD]) OVER()
  FROM [AdventureWorks2022].[Sales].[SalesPerson]

 ------------------------/PARTION BY /--------------------------
 ----the regular group by clause----
SELECT ProductID,
	OrderQty,
	LineTotal = SUM(LineTotal)
 FROM Sales.SalesOrderDetail
GROUP BY ProductID,OrderQty
ORDER BY 1,2
---Notice that all fields not passed in Aggregate function (SUM) are passed in the GROUP BY clause---
---So, we cannot have any row-level granularity---

-----now, using OVER & Partition we can retain indivual SalesOrderId-----
SELECT 
	SalesOrderID,
	ProductID,
	OrderQty,
	LineTotal = SUM(LineTotal) OVER(PARTITION BY ProductID,OrderQty)
 FROM Sales.SalesOrderDetail
ORDER BY 2,3


-------------------------/ROW_NUMBER/------------
---assigns Row number for each partitioned set of rows in the query result
SELECT 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	[ProductIDLineTotal] = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
	--RANK EACH SalesOrderId GROUP BY LineTotal--
	[Ranking] = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal )
FROM SALES.SalesOrderDetail
ORDER BY SalesOrderID
----
SELECT 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	[ProductIDLineTotal] = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
	--RANK EACH SalesOrderId GROUP BY LineTotal--
	[Rank(Row_No)] = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM SALES.SalesOrderDetail
ORDER BY SalesOrderID

-------------------------------------RANK & DENSE_RANK-----------------------------------
---IN CASE OF TIE, THE ROW FUNCTION WILL ASSIGN EACH OF THE ROWS DIFFERENT VALUES. BUT , THIS MIGHT NOT BE THE DESIRED RESULT SOMETIMES--
SELECT 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	[ProductIDLineTotal] = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
	--RANK EACH SalesOrderId GROUP BY LineTotal--
	[Rank(Row_No)] = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
	[Rank(Rank func)] = RANK() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
	

FROM SALES.SalesOrderDetail
ORDER BY SalesOrderID
---
---BUT SIMPLY THE RANK FUNCTION WILL ASSIGN AN ABSOLUTE VALUE TO THE ROW, BASED ON ITS RELATIVE POSITION IN THE QUERY RESULT--
---BASICALLY IF 3 ROWS HAVE SAME RANK OF 4, THEN NEXT DIFFERNT VALUE-ROW WILL BE ASSIGNED A RANK OF 7 , AND SO ON...---
---THE DENSE_RANK FUNC ADDRESSES THIS IN HELPING TO RETAIN THE SEQUENTIAL ORDER OF RANKING IN THE QUERY RESULT--
SELECT 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	[ProductIDLineTotal] = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
	--RANK EACH SalesOrderId GROUP BY LineTotal--
	[Rank(Row_No)] = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
	[Rank(Rank func)] = RANK() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
	[Dense_Rank] = DENSE_RANK() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)

FROM SALES.SalesOrderDetail
ORDER BY SalesOrderID

---SO,ROW_NUMBER GIES A STRAIGHT SEQUENTIAL RANKING DISREGARDING TIES; 
---RANK() ACCOUNTS FOR TIES BUT SKIPS GAPS IN THE RANKING, MAINTAINING THE ABSOLUTE RANKS;
---WHILE DENSE_RANK HELPS MAINTAIN THE SEQUENTIAL RANKING--
---Usage of the above ROW/RANK/DENSE_RANK funcs depends on the scenario

--------------------------------------------/LEAD & LAG/-------------------------------------------------
---LEAD() and LAG() are window functions in SQL that allow you to access values from preceding or subsequent rows within a partition.---
---They are particularly useful for performing calculations that involve comparing a row's value to the values of neighboring rows.---
SELECT 
	SalesOrderID,
	OrderDate,
	CustomerID,
	--PAST TOTAL DUE: LEAD[fetch previous value from this column; and jump by how many values]
	[PastTotalDue] = LAG(TotalDue,1,0) OVER(ORDER BY SalesOrderID),
	[PresentTotalDue]=TotalDue,
	--NEXT TOTAL DUE: LEAD[fetch next value from this column; and jump by how many values]--
	[NextTotalDue] = LEAD(TotalDue,1,0) OVER(ORDER BY SalesOrderID)

FROM SALES.SalesOrderHeader
ORDER BY SalesOrderID

-----------In above query the LEAD/LAG func was applied to entire table---
------------Now introducing PARTITION clause will 'group' the data based on the specified column name---
SELECT 
	SalesOrderID,
	OrderDate,
	CustomerID,
	--PAST TOTAL DUE: LEAD[fetch previous value from this column; and jump by how many values]
	[PastTotalDue] = LAG(TotalDue,1) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID),
	[PresentTotalDue]=TotalDue,
	--NEXT TOTAL DUE: LEAD[fetch next value from this column; and jump by how many values]--
	[NextTotalDue] = LEAD(TotalDue,1) OVER(PARTITION BY CustomerID ORDER BY SalesOrderID)

FROM SALES.SalesOrderHeader
ORDER BY CustomerID,SalesOrderID

-------------------------------------/FIRST VALUE/----------------------------------------
----USEFUL FOR CASES REQUIRING TO FURTHER DRILL DOWN INTO A PARTITION & ONLY FETCH THE 'MOST RECENT'/ 'LATEST' VALUE
----AND GIVE IT A ROW-LEVEL VISIBILITY IN AN ADJACENT COLUMN AGAINST EACH ROW---
SELECT 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	--RANK EACH SalesOrderId GROUP BY LineTotal--
	[Ranking] = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
	[HighestTotal] = FIRST_VALUE(LineTotal) OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC),
	[LowestTotal] = FIRST_VALUE(LineTotal) OVER(PARTITION BY SalesOrderID ORDER BY LineTotal )
FROM SALES.SalesOrderDetail
ORDER BY SalesOrderID


SELECT 
	CustomerID,
	SalesOrderID,
	OrderDate,
	TotalDue,
	FirstOrderDate = FIRST_VALUE(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate),
	FirstOrderAmt = FIRST_VALUE(TotalDue) OVER(PARTITION BY CustomerID ORDER BY OrderDate),
	MostRecentOrderAmt = FIRST_VALUE(TotalDue) OVER(PARTITION BY CustomerID ORDER BY OrderDate DESC)
FROM SALES.SalesOrderHeader
ORDER BY CustomerID,OrderDate

---------------------------/SUB-QUERIES/----------------------------------
--/Run a query AND THEN filter its result set / OR utilize the ouptut into another query/--
---Following query ranks every record in the table based on LineTotal, however if we wanted to view only one record of LineTotal 
---per SalesOrder, for e.g, only the max LineTotal (or highest ranked) record, then we'd need to apply below query AFTER the result of another sub-query

SELECT 
	SalesOrderID,
	SalesOrderDetailID,
	LineTotal,
	[Rank(Row_No)] = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
FROM SALES.SalesOrderDetail
ORDER BY SalesOrderID
-----------------------------------------------------

--/this is the outer final query, it fetches from the virtual table created in the innner sub-query/
SELECT *
FROM
	--/this is the inner sub_query, the main virtual table/--
	(SELECT 
		SalesOrderID,
		SalesOrderDetailID,
		LineTotal,
		[LineTotalRanking] = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)
	FROM SALES.SalesOrderDetail
	)A
	--/Filter criteria is applied to the inner sub-query/
WHERE [LineTotalRanking] = 1


--------------------------------/ROWS BETWEEN -- useful for Rolling calculations/--------------------------------------
---Rolling 3-Day total: Query to find rolling to sum for past 3 days for a given day---
---Using this as the base query---
SELECT OrderDate,
	SumTotalDue_forDay = ROUND(SUM(TotalDue),2)
	--AvgTotalDue_forDay = ROUND(AVG(TotalDue),2)
FROM SALES.SalesOrderHeader
WHERE YEAR(OrderDate) = 2014
GROUP BY OrderDate
ORDER BY OrderDate

---
SELECT OrderDate,
	TotalDue=SUM(TotalDue)
FROM SALES.SalesOrderHeader
WHERE CONVERT(DATE,OrderDate) IN('2014-01-01','2014-01-02','2014-01-03','2014-01-04','2014-01-05','2014-01-06')
GROUP BY OrderDate
ORDER BY OrderDate

---Constructing the full query---
---Consists of 3 past days totalDue sum, last 2 days + current day inclusive---
SELECT OrderDate,
	SumTotalDue_forDay,
	Last3DaysTotal = SUM(SumTotalDue_forDay) OVER(ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
	FROM
		(SELECT OrderDate,
				--TotalDue,
				SumTotalDue_forDay = ROUND(SUM(TotalDue),2)
		FROM SALES.SalesOrderHeader
			WHERE YEAR(OrderDate) = 2014
		GROUP BY OrderDate)X

---Query to call 3 past days' totalDue sum, strictly last 3 days---	
SELECT OrderDate,
	SumTotalDue_forDay,
	Last3DaysTotal = SUM(SumTotalDue_forDay) OVER(ORDER BY OrderDate ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING)
	FROM
		(SELECT OrderDate,
				--TotalDue,
				SumTotalDue_forDay = ROUND(SUM(TotalDue),2)
		FROM SALES.SalesOrderHeader
			WHERE YEAR(OrderDate) = 2014
		GROUP BY OrderDate)X

---Query to call 3 days' totalDue sum, Consisting of past 1 day, current day & next 1 day---
SELECT OrderDate,
	SumTotalDue_forDay,
	Last3DaysTotal = SUM(SumTotalDue_forDay) OVER(ORDER BY OrderDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
	FROM
		(SELECT OrderDate,
				--TotalDue,
				SumTotalDue_forDay = ROUND(SUM(TotalDue),2)
		FROM SALES.SalesOrderHeader
			WHERE YEAR(OrderDate) = 2014
		GROUP BY OrderDate)X

-----------------------------------------------/ROLLING AVERAGE/----------------------------------------------------
----/Create query to look at rolling 3 day average consisting of past 2days & current day inclusive/----
SELECT OrderDate,
	SumTotalDue_forDay,
	Last3DaysTotal = AVG(SumTotalDue_forDay) OVER(ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
	FROM
		(SELECT OrderDate,
				--TotalDue,
				SumTotalDue_forDay = ROUND(SUM(TotalDue),2)
		FROM SALES.SalesOrderHeader
			WHERE YEAR(OrderDate) = 2014
		GROUP BY OrderDate)X
---------------------------------------------------/Types of Sub-Query/--------------------------------------------------------
---1. Scalar sub-query: SINGLE-COLUMN SINGLE VALUE. Useful when checking if row value is above or below average
SELECT AVG(ListPrice)
FROM Production.Product

---Example-1: Using Product listPrice as example; to check if a product's listPrice is above / below average
SELECT ProductID,
	[NAME],
	StandardCost,
	ListPrice,
	--[AvgPrice] = AVG(ListPrice) OVER(),
	--another variation to obtain Avg ListPrice:
	[AvgPrice] = (SELECT AVG(ListPrice) FROM Production.Product),
	[Result] = ListPrice - (SELECT AVG(ListPrice) FROM Production.Product)
FROM Production.Product


---Example-2: Using Product listPrice as example; to check if a product's listPrice is above / below average
SELECT ProductID,
	[NAME],
	StandardCost,
	ListPrice,
	--another variation to obtain Avg ListPrice--
	[AvgPrice] = (SELECT AVG(ListPrice) FROM Production.Product),
	[Result] = ListPrice - (SELECT AVG(ListPrice) FROM Production.Product),
	[Stmt] = CASE WHEN ListPrice < (SELECT AVG(ListPrice) FROM Production.Product) THEN 'Below Avg'
		WHEN ListPrice > (SELECT AVG(ListPrice) FROM Production.Product) THEN 'Above Avg'
		ELSE 'Same As Avg'
	END
FROM Production.Product
--WHERE ListPrice <= (SELECT AVG(ListPrice) FROM Production.Product)


---------------------------------------CORRELATED SUBQUERIES----------------------------------------------
---References the outer query & operates on each row of the outer query's result:
---Example: Retriveing the count of items in each sales order where the count is >1

	---first, working on the inner query:---
	SELECT SalesOrderID,
		OrderQty

	FROM Sales.SalesOrderDetail
	WHERE SalesOrderID = 43659
	ORDER BY SalesOrderID

---Now, making the outer query
SELECT 
	SalesOrderID,
	OrderDate,
	TotalDue,
	---These many orders for that SalesOrderID contained more than 1 order items--
	MultiOrderCount=
					(SELECT COUNT(*)
					FROM Sales.SalesOrderDetail B
					---/this is how outer query is referenced to the internal query/---
					WHERE B.SalesOrderID = A.SalesOrderID
					AND B.OrderQty>1)			
FROM Sales.SalesOrderHeader A
-----------------------------------------------EXISTS Clause-------------------------------------------------
----Its a logical operator used to check whether a subquery returns any rows. 
---If the subquery returns at least one row, the EXISTS condition is satisfied & evaluates to TRUE; otherwise, it evaluates to FALSE.
--Example: For given SalesOrderID , check if (atleast one) any order exists that is greater than $ 10K
SELECT A.SalesOrderID
	,A.OrderDate
	,A.TotalDue
FROM Sales.SalesOrderHeader A
	--check & return those SalesOrderId with OrderDetails meeting the LineTotal criteria, if yes, inlcude that SalesORder in the result set
	WHERE EXISTS(
				SELECT 1
				FROM SALES.SalesOrderDetail B
				WHERE A.SalesOrderID = B.SalesOrderID
				AND B.LineTotal >10000)
ORDER BY 1
---
SELECT *
FROM Sales.SalesOrderDetail
WHERE SalesOrderID=43683 AND LineTotal>10000
---
SELECT *
FROM Sales.SalesOrderHeader
WHERE SalesOrderID=43683


--------------------------------------NOT EXISTS CLAUSE-----------------------------------------
--Example: check & return those salesORderIDs  for which NONE of its orderDetails are above $10K
SELECT A.SalesOrderID
	,A.OrderDate
	,A.TotalDue
FROM Sales.SalesOrderHeader A
	---check if such SalesOrderID exists that dont have ANY orderDetails with lineTotal more than criteria
	WHERE NOT EXISTS(
				SELECT 1
				FROM SALES.SalesOrderDetail B
				WHERE B.LineTotal >10000
				AND A.SalesOrderID = B.SalesOrderID)
ORDER BY 1
-----verifiy by individual queries------
select *
from sales.SalesOrderDetail
where SalesOrderID=43659 and LineTotal<10000

select *
from sales.SalesOrderHeader
where SalesOrderID=43659


-------------------------------------------------[FOR XML PATH / STUFF]-----------------------------------------------------
---Flatening: basically concat-ing  several rows from the inner subquery into one row against the main outer query---
----Useful where we want to 'see' all the rows instead of an aggregated / scalar value---
---Example: Lets 'see' the all the OrderDetails for a particular SalesOrderId instead of just the count
SELECT S.SalesOrderID
	,COUNT(SalesOrderID) AS SalesCount
FROM Sales.SalesOrderDetail S
GROUP BY S.SalesOrderID
---
SELECT *
FROM Sales.SalesOrderDetail S
WHERE S.SalesOrderID = 43659
----Now we want to see the all line totals in a single cell for each SalesOrderId
SELECT S.LineTotal
FROM Sales.SalesOrderDetail S
WHERE S.SalesOrderID = 43659
FOR XML PATH('')
-----Above query gives result in XML format. Need to figure out a way to improve the display...----
SELECT 
	',' + CAST(CAST(S.LineTotal AS money) AS varchar)
FROM Sales.SalesOrderDetail S
WHERE S.SalesOrderID = 43659
FOR XML PATH('')
----Above query now gives a comma-separate list of the LineTotal values----
SELECT
STUFF(
		(SELECT 
			',' + CAST(CAST(S.LineTotal AS money) AS varchar)
		FROM Sales.SalesOrderDetail S
		WHERE S.SalesOrderID = 43659
		FOR XML PATH(''))
		,1,1,'')
---Using STUFF function , allows string manipulation for an XML result---
---Now using above subquery into a a main query---
SELECT SH.SalesOrderID
	,SH.OrderDate
	,SH.TotalDue
	,LineTotals=STUFF(
						(SELECT ',' + CAST(CAST(S.LineTotal AS money) AS varchar)
							FROM Sales.SalesOrderDetail S
							WHERE S.SalesOrderID = SH.SalesOrderID
							FOR XML PATH('')),1,1,'')
FROM Sales.SalesOrderHeader SH
---As seen in output of the above query, all LineTotals from inner subquery are shown gathered together for each SalesOrderID

-----------------------------------------------------[PIVOT in MS SQL Server]----------------------------------------------------------
---The PIVOT function in SQL Server is used to transform rows into columns, essentially turning tabular data into a summarized, more readable format.
---It is especially useful for reporting and cross-tabulation, where you want to summarize and aggregate data based on certain column values.
---Example: Linking the LineTotal from SalesORderDetail table & ProductCategory table, We'll be pivoting the result of this query to gain more insights
SELECT
[Bikes],[Clothing],[Accessories],[Components]
FROM
	-----The inner subQuery-----
	(SELECT
		   ProductCategoryName = D.[Name]
		   ,A.LineTotal

	FROM AdventureWorks2019.Sales.SalesOrderDetail A
		JOIN AdventureWorks2019.Production.Product B
			ON A.ProductID = B.ProductID
		JOIN AdventureWorks2019.Production.ProductSubcategory C
			ON B.ProductSubcategoryID = C.ProductSubcategoryID
		JOIN AdventureWorks2019.Production.ProductCategory D
			ON C.ProductCategoryID = D.ProductCategoryID
	)A
PIVOT(
		SUM([LineTotal])
		FOR ProductCategoryName IN([Bikes],[Clothing],[Accessories],[Components])
		)B

-------Improving in previous pivot query------
SELECT *
FROM-----The inner subQuery-----
	(SELECT
		   ProductCategoryName = D.[Name]
		   ,A.LineTotal
		   ,A.OrderQty
	FROM AdventureWorks2019.Sales.SalesOrderDetail A
		JOIN AdventureWorks2019.Production.Product B
			ON A.ProductID = B.ProductID
		JOIN AdventureWorks2019.Production.ProductSubcategory C
			ON B.ProductSubcategoryID = C.ProductSubcategoryID
		JOIN AdventureWorks2019.Production.ProductCategory D
			ON C.ProductCategoryID = D.ProductCategoryID
	)A
PIVOT(
		SUM([LineTotal])
		FOR ProductCategoryName IN([Bikes],[Clothing],[Accessories],[Components])
		)B
ORDER BY 1

------------------------------------[CTEs - Common Table Expressions]-------------------------------------------------
----/EXAMPLE/----
---Identify Top10 sales orders per month , Aggregate these into sum total by month , 
---Compare each month's total to previous months total on same row
-----Constructed base query------
select s.OrderDate
		,s.TotalDue
		,EachMonth = DATEFROMPARTS(YEAR(s.OrderDate),MONTH(s.OrderDate),1)
		,SalesRank = ROW_NUMBER() over(partition by DATEFROMPARTS(YEAR(s.OrderDate),MONTH(s.OrderDate),1) order by s.TotalDue)
from sales.SalesOrderHeader s
-----Now filtering Top10------
-----Constructed base query------
select EachMonth
	,Top10Total = sum(TotalDue)
from
	(select s.OrderDate
			,s.TotalDue
			,EachMonth = DATEFROMPARTS(YEAR(s.OrderDate),MONTH(s.OrderDate),1)
			,SalesRank = ROW_NUMBER() over(partition by DATEFROMPARTS(YEAR(s.OrderDate),MONTH(s.OrderDate),1) order by s.TotalDue)
		from sales.SalesOrderHeader s)x
	where SalesRank <=10
group by EachMonth
order by EachMonth



---E.g.:To identify & sum up the top10 sales of the present month. ALso compare with top10sales of previous month.
---1.find Top 10 sales order grouped by each month. Sum these for Top10Total.
---2.Repeat for all months & then bring each previous row's value to current row for comparison

SELECT 
A.OrderMonth,
A.Top10Total,
Prev10Total = B.Top10Total
FROM

	(SELECT 
		OrderMonth,
		Top10Total = SUM(TotalDue)
	FROM
		---Nesting in a subquery since window funcs can be called only in a SELECT or ORDER BY clause
		(SELECT 
			OrderDate,
			TotalDue,
			OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
			OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM Sales.SalesOrderHeader)X
	WHERE OrderRank <=10
	GROUP BY OrderMonth)A
LEFT JOIN
	(SELECT 
		OrderMonth,
		Top10Total = SUM(TotalDue)
	FROM
		---Nesting in a subquery since window funcs can be called only in a SELECT or ORDER BY clause
		(SELECT 
			OrderDate,
			TotalDue,
			OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
			OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM Sales.SalesOrderHeader)X
	WHERE OrderRank <=10
	GROUP BY OrderMonth)B
ON A.OrderMonth=DATEADD(MONTH,1,B.OrderMonth)
ORDER BY A.OrderMonth

--------------------------------------------/Common Table Expressions/-----------------------------------------------
--Above example demonstrates how complexisty increases if we have to use multiple subqueries
--CTE allows us to declare subqueries that can then be used throughout in the SQL file . So instead of nested queries that'd increase complexity (& also performance?), 
--one can create CTEs which can be referenced later in the SQL query
WITH Sales AS(
		SELECT 
			OrderDate,
			TotalDue,
			OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
			OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM Sales.SalesOrderHeader
		),
---The 2nd CTE refereces from earlier defined one---
Top10 AS(
		SELECT 
			OrderMonth,
		Top10Total = SUM(TotalDue)
		FROM Sales
		WHERE OrderRank <=10
		GROUP BY OrderMonth
		)
---Selecting top10 totaldue of present month, joining with same table (Top10) but with one month previous
SELECT 
 A.OrderMonth,
 A.Top10Total,
 'PrevTop10Total' = B.Top10Total
FROM Top10 A
LEFT JOIN Top10 B
	ON A.OrderMonth=DATEADD(MONTH,1,B.OrderMonth)
ORDER BY 1

-------------------------------/Recursive CTEs/-------------------------------------
---Genearating a series of values using recursion; numbers from 1 to 100
with numberSeries as(
---anchor member
select 1 as myNumber

union all
---recursive member
select myNumber + 1
from numberSeries
---limiting condition
where myNumber<100
)

select myNumber
from numberSeries

---Generating a calender with dates & --
with DateSeries as(
---anchor member
select cast('01-01-2024' as date) as myDate

union all
---recursive member
select 
DATEADD(day,1,myDate)
from DateSeries
---limiting condition
where myDate<cast('12-31-2024' as date)
)

select myDate
from DateSeries
option(maxrecursion 365)

