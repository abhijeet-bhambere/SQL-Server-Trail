--1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database.
---Sort the result set in ascending order on jobtitle.
use AdventureWorks2022;
go

select BusinessEntityID,LoginID, JobTitle, Gender
from HumanResources.Employee
order by JobTitle

--2. From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table. 
---The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.
select FirstName, LastName, BusinessEntityID as EmployeeID
from Person.Person
order by LastName


--3. Write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'.
---Return productid, productnumber, and name. Arranged the output in ascending order on name.
select ProductID, ProductNumber, [Name], ProductLine
from Production.Product
where (SellStartDate is not null) and (ProductLine='T')
order by Name

--4.  to return all rows from the salesorderheader table i& calculate the percentage of tax on the subtotal have decided.
---Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal.

select SalesOrderID, CustomerID, OrderDate, SubTotal ,
	cast((TaxAmt/SubTotal)*100 as decimal(18,2)) as tax_prcent
from Sales.SalesOrderHeader
order by SubTotal

--5. create a list of unique jobtitles in the employee table in Adventureworks database.
---Return jobtitle column and arranged the resultset in ascending order.

select distinct JobTitle
from HumanResources.Employee
order by JobTitle

--6.to calculate the total freight paid by each customer.
---Return customerid and total freight. Sort the output in ascending order on customerid.
select CustomerID, cast(sum(Freight) as decimal(18,2)) as total_freight
from sales.SalesOrderHeader
group by CustomerID order by CustomerID

--7. find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal.
---Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
select CustomerID , sum(SubTotal) as total_subtotal, avg(subtotal) as avg_subtotal
from sales.SalesOrderHeader
group by CustomerID order by CustomerID

--8. retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. 
---Return productid and sum of the quantity. Sort the results according to the productid in ascending order.

select ProductID, sum(quantity) as total_qnty
from Production.ProductInventory
where Shelf in('A', 'C', 'H')
group by ProductID
having sum(quantity) > 500
order by ProductID

--9.  find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. 
---Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal
select SalesPersonID, CustomerID, sum(SubTotal) as sum_subtotal
from Sales.SalesOrderHeader
where SalesPersonID is not null
group by rollup(SalesPersonID, CustomerID)


--10. find the sum of the quantity of all combination of group of distinct locationid and shelf column. 
---Return locationid, shelf and sum of quantity as TotalQuantity.
select LocationID, Shelf, sum(Quantity) as total_qnty
from Production.ProductInventory
group by cube(LocationID, Shelf)


--11. total quantity for each locationid and calculate the grand-total for all locations.
---Return locationid and total quantity. Group the results on locationid.
select locationID,sum(Quantity) as total_qnty
from Production.ProductInventory
group by grouping sets([LocationID],())
order by total_qnty desc

--12. retrieve the total sales for each year. Return the year part of order date and total due amount.
---Sort the result in ascending order on year part of order date.
select datepart(YEAR, OrderDate) as 'year',
		sum(TotalDue) as totalDueAmt
from sales.SalesOrderHeader
group by datepart(YEAR, OrderDate) 
order by [year]


--13. retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2013.
select datepart(YEAR, OrderDate) as 'year',
		sum(TotalDue) as totalDueAmt
from sales.SalesOrderHeader
where datepart(YEAR, OrderDate) <=2013
group by datepart(YEAR, OrderDate) 
order by [year]

--14. make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. 
---Sort the result set in ascending order of LastName, and FirstName.

--person p - firstname lastname beID <> becontact be - personid ;
--- be contacttypeid <> contacttype ct - contacttypeid
select p.FirstName, p.LastName , p.BusinessEntityID
from Person.Person p
join Person.BusinessEntityContact be
on p.BusinessEntityID = be.PersonID
join Person.ContactType ct
on be.ContactTypeID =ct.ContactTypeID
where ct.[Name] ='Purchasing Manager'
order by p.LastName, p.FirstName


--Q to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. 
---Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. 
---Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.

---Sales.SalesPerson sp salesytd territory | ---Person.Person pp lastname	| ---Person.Address pa postalcode
---Person..BusinessEntityAddress pba  <-- intermediate table, used to link  BusinessEntity to Address ID

select ROW_NUMBER() over(partition by pa.postalcode order by sp.SalesYTD desc) as RowNo,
		pp.LastName , sp.TerritoryID, sp.SalesYTD,  pa.PostalCode		
from sales.SalesPerson sp
join Person.Person pp
on sp.BusinessEntityID = pp.BusinessEntityID
join Person.BusinessEntityAddress pba
on pp.BusinessEntityID = pba.BusinessEntityID
join Person.[Address] pa
on pba.AddressID = pa.AddressID
where (sp.TerritoryID is not null) and (sp.SalesYTD <>0 )


--Q count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. 
---Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.


select pc.ContactTypeID,pc.[Name] as CTypeName ,count(*) as BusinessEntityContact
from Person.ContactType pc
join Person.BusinessEntityContact pb
on pc.ContactTypeID = pb.ContactTypeID
group by pc.ContactTypeID,pc.[Name] 
having count(*)>=100
order by count(*) desc


--Q retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees.
---In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.

--fullname >> concat_ws | weekly salary>> Rate *40 | RateChangedate >> date format

select	cast(eph.RateChangeDate as date) as RateChangeDate ,
		concat(p.LastName,',',p.FirstName,' ',p.MiddleName) as NameInFull,
		(eph.Rate * 40) as WeeklySalary
from Person.Person p
join HumanResources.EmployeePayHistory eph
on p.BusinessEntityID = eph.BusinessEntityID
order by NameInFull


--Q find the sum, average, and number of order quantity for those orders whose ids are 43659 and 43664 and product id starting with '71'. 
---Return SalesOrderID, OrderNumber,ProductID, OrderQty, sum, average, and number of order quantity.

---* the question asks for both - both the individual row-level detail AND the aggregated values side by side.
---GROUP BY collapses rows - individual OrderQty will be lost.
---By using window function, every original row is retained & the aggregated values are stamped alongside each row — it does not replace them.

---salesorderid , ordernumber, productid, orderqty, sum , avg, no. of order qnty

select SalesOrderID, ProductID,  
		sum(OrderQty)	over(order by SalesOrderID, ProductID)	as sum_Qnty, 
		avg(OrderQty)	over(partition by SalesOrderID order by SalesOrderID, ProductID)	as avg_Qnty,
		count(OrderQty) over(order by SalesOrderID, ProductID rows between unbounded preceding and 1 following)  as no_Qnty
from  Sales.SalesOrderDetail
where (SalesOrderID in (43659, 43664)) and (cast(ProductID as varchar(50))like '71%') -- Numeric will be converted to Str


--Q retrieve the total cost of each salesorderID that exceeds 100000. Return SalesOrderID, total cost.

--*the probelems intends to apply groupby to a calculated field (UnitPrice * OrderQnty) 
---and then filter the aggregated column (total_cost >100000)
select SalesOrderID, 
		sum(OrderQty * UnitPrice) as total_cost
from sales.SalesOrderDetail
group by SalesOrderID
having sum(OrderQty * UnitPrice) >100000

--Q retrieve products whose names start with 'Lock Washer'. 
---Return product ID, and name and order the result set in ascending order on product ID column.

--productname = 'lock washer', prodid , name, 
select ProductID, [Name] 
from Production.[Product]
where [Name] like 'Lock Washer%'
order by ProductID asc

--Q ordered the BusinessEntityID column descendingly when SalariedFlag set to 'true' and BusinessEntityID in ascending order when SalariedFlag set to 'false'.
---Return BusinessEntityID, SalariedFlag columns.

select BusinessEntityID, SalariedFlag 
from  HumanResources.Employee
order by case SalariedFlag when 'true' then BusinessEntityID end desc,
		case SalariedFlag when 'false' then BusinessEntityID end ;

--Q  set the result in order by the column TerritoryName when the column CountryRegionName is equal to 'United States' and by CountryRegionName for all other rows.

select *
from sales.vSalesPerson
where TerritoryName is not null
order by case CountryRegionName when 'United States' then TerritoryName
			else CountryRegionName end
			
--Q skip the first 5 rows and return the next 5 rows from the sorted result set.
select * from  HumanResources.Department
order by DepartmentID 
	offset 5 rows
	fetch next 5 rows only;

--Q  list all the products that are Red or Blue in color. Return name, color and listprice.Sorts this result by the column listprice.
select Name, Color, ListPrice
from   Production.[Product]
where color in ('Red','Blue')
order by ListPrice

--Q retrieve the product name and salesorderid. Both ordered and unordered products are included in the result set.


--*inner join will only give product name for ordered products; but we need ordered + unordered product names
select pp.[name], sso.SalesOrderID 
from   Production.[Product] pp
left outer join Sales.SalesOrderDetail sso
on pp.productID = sso.productID
order by pp.[Name]

--Q get all product product names and sales order IDs. Order the result set on product name column
select pp.[Name], ssd.SalesOrderID
from   Production.[Product] pp
inner join Sales.SalesOrderDetail ssd
on pp.ProductID = ssd.ProductID
order by pp.[Name]



--Q retrieve individuals from the following table with a businessentityid inside 1500, a lastname starting with 'Al', and a firstname starting with 'M'.
select BusinessEntityID, FirstName, LastName
from Person.Person
where BusinessEntityID <1500 and LastName like 'Al%' and FirstName like'M%'
order by BusinessEntityID


--Q find the average number of sales orders for all the years of the sales representatives.

--> find avg no. of count of orders >> count by salesorderids where salesperson is non-null

select avg(t.count_orders) from
(select SalesPersonID, count(*) as count_orders
from   Sales.SalesOrderHeader
where SalesPersonID is not null -- only orders with known sales perosn
group by SalesPersonID) as t ;--per salesperson 

--same result by CTEs
WITH Sales_CTE (SalesPersonID, NumberOfOrders)
AS(
    -- Query to calculate the number of orders per salesperson
    SELECT SalesPersonID, COUNT(*) AS NumberOfOrders
    -- From the SalesOrderHeader table in the Sales schema
    FROM Sales.SalesOrderHeader
    -- Filtering out rows where SalesPersonID is not NULL
    WHERE SalesPersonID IS NOT NULL
    -- Grouping the results by SalesPersonID
    GROUP BY SalesPersonID
	)
-- Query to calculate the average number of orders per salesperson
SELECT AVG(NumberOfOrders) AS "Average Sales Per Person"
FROM Sales_CTE;

--Q retrieve the mailing address for any company that is outside the United States (US) and in a city whose name starts with Pa. 
---Return Addressline1, Addressline2, city, postalcode, countryregioncode columns

--* join on stateprovinceid , cols- addrline1 addrline2 city(filter)  postalcode country(filter)

select pa.AddressLine1, pa.AddressLine2, pa.City,pa.PostalCode
from   Person.[Address] pa inner join  Person.StateProvince psp
on pa.StateProvinceID = psp.StateProvinceID
where pa.City like'Pa%' and psp.CountryRegionCode not in ('US');



select * from   Person.[Address]
select * from Person.StateProvince



