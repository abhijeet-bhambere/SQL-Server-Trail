---------------------->>Using sample databases + AdventureWorks<<-------------------
--Loading the SuperStore db
use master; 
go

--creating the db in SQL server
create database Super_StoreDB;

-->>data tables imported from excel file

--==================================================================================
----------------->>Selecting , Filtering , Grouping & Aggregating<<-----------------
--==================================================================================
use Super_StoreDB;
go

--selecting top 10 rows from orders table
select top(10) * from Super_StoreDB.dbo.Orders;

--select unique order IDs & customer IDs
---table contains 5009 unique order IDs
select distinct [Order ID] from Super_StoreDB.dbo.Orders;

---table contains 793 cstomer IDs/ Customer names
select distinct [Customer ID] from Super_StoreDB.dbo.Orders;
select distinct [Customer Name] from Super_StoreDB.dbo.Orders;

--orders have 17 sub-categoies in 3 main categories
select distinct [Category] from Super_StoreDB.dbo.Orders;
select distinct [Sub-Category] from Super_StoreDB.dbo.Orders;

--check distinct order addresses
----All orders are from the US only
select distinct [Country] from Super_StoreDB.dbo.Orders;
----Orders are from 49 states, 531 cities
select distinct [State] from Super_StoreDB.dbo.Orders; 
select distinct [City] from Super_StoreDB.dbo.Orders;

select distinct [Customer Name] from Super_StoreDB.dbo.Orders;

select distinct Person from Super_StoreDB.dbo.People;

--Filtering with comparison & logical operators
---Show all sales greater than $2K - 140 such records
select * from Super_StoreDB.dbo.Orders
where [Sales] > 2000;
---Show orders with order quantity >10
select * from Super_StoreDB.dbo.Orders
where Quantity > 10;
---Show orders from LA in the Furniture category
select * from Super_StoreDB.dbo.Orders
where (City = 'Los Angeles') and (Category = 'Furniture');

--Filtering with range operators - inclusive of limits
select * from Super_StoreDB.dbo.Orders
where Sales between 500 and 600;
---alternate method for range 
select * from Super_StoreDB.dbo.Orders
where (Sales>500) and (Sales<600);
---excluding range of values
select * from Super_StoreDB.dbo.Orders
where Sales not between 10 and 5000;

--List operators IN/NOT IN
---Select all orders from New York , LosAngeles Or Houston
select * from Super_StoreDB.dbo.Orders
where [City] in ('New York City' , 'Los Angeles' , 'Houston');

select * from Super_StoreDB.dbo.Orders
where [Customer Name] in ('Cassandra Brandow', 'Chuck Magee');


--Wildcard operators - REGEX-like filtering
select * from Super_StoreDB.dbo.Orders
where [City] like '%t' and [State] like 'N%'
---Filter all states having North or Sounth in their names
select * from Super_StoreDB.dbo.Orders
where [State] like '[A-Z]%th%' ;


--Null/Not Null operators
---Select all rows where postal code is empty
select * from Super_StoreDB.dbo.[Orders]
where [Postal Code] is null;

--Aggregate functions--
---Count(*) includes NULL values
select COUNT(*) from Super_StoreDB.dbo.[Orders];

---Count() includes only non-null values
select COUNT([City]) from Super_StoreDB.dbo.[Orders]
where [State]='California';

select sum([Profit]) as 'total_profits_LA' from Super_StoreDB.dbo.[Orders] 
where City='Los Angeles';

select max([Profit]) as 'max_profit_LA' from Super_StoreDB.dbo.[Orders] 
where City='Los Angeles';

select avg([Sales]) as 'avg_Sales' from Super_StoreDB.dbo.[Orders];

select max(City) as 'max_City', min(City) as 'min_City' from Super_StoreDB.dbo.[Orders];

select max([Order Date]) as 'max_OrderDate', min([Order Date]) as 'min_OrderDate' from Super_StoreDB.dbo.[Orders];

--========================================================================
--------------------------->>Group by clause<<----------------------------
--========================================================================
select * from Super_StoreDB.dbo.Orders
--show region-wise total sales
select [Region], 
		round(sum([Sales]),2) as 'total_sales' 
from Super_StoreDB.dbo.Orders
group by Region
order by total_sales

--show category-wise total profit by region
select [Region], [Category],[Sub-Category],
		round(sum(Profit),2) as 'total_profit'
from Super_StoreDB.dbo.Orders
group by Region, Category, [Sub-Category]
order by Region, Category, [Sub-Category]

--show category-wise total profit by region with profit > $10K
select [Region], [Category],
		total_profit= cast(sum(Profit) as decimal(18,2))
from Super_StoreDB.dbo.Orders
group by Region, Category
having sum(Profit) > 10000
order by Region, Category


--using WHERE & HAVING in same group-by query
---show category-wise total profit by region from Consumer segment atleast $5K profit
select [Region], [Category],
		total_profit= round(sum(Profit),2) 
from Super_StoreDB.dbo.Orders
where Segment='Consumer'
group by Region, Category
having sum(Profit) > 5000
order by Region, Category

--show max sales for each city in California
select [State],[City], max([Sales]) as 'max_sales' from Super_StoreDB.dbo.Orders
group by [State],[City]
having [State]= 'California'
order by [City]

select top(2)* from Super_StoreDB.dbo.Orders
where [State]='California' order by [Sales] desc;

--view all columns in a table
select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='Orders'

sp_help 'Orders'

--->>Display top 2 regions based on no. of orders along with manager. 
---Only consider the consumer segment where no. of orders >1000

/*select top(2) Region, count([Order ID]) as 'no_of_orders' 
from Super_StoreDB.dbo.Orders
group by Region
having count([order id]) >1000
order by no_of_orders*/

select top(2) o.Region, count(*) as 'no_of_orders', p.Person from Super_StoreDB.dbo.Orders o
inner join Super_StoreDB.dbo.People p
on o.Region = p.Region
where Segment='Consumer'
group by o.Region, p.Person
having count(*) >1000
order by no_of_orders desc


select distinct Segment from Super_StoreDB.dbo.Orders 

--=========================================================================================
------------------------------------->>Joins<<---------------------------------------------
--=========================================================================================
select top(10)*from Super_StoreDB.dbo.Orders
select top(10)*from Super_StoreDB.dbo.People
select *from Super_StoreDB.dbo.[Returns]
--Left join--
---Pull Orders info for all Return orders
select *from Super_StoreDB.dbo.Orders o
inner join Super_StoreDB.dbo.[Returns] r on o.[Order ID]=r.[Order ID]

--Pull Orders info for all entries of Customers table
select *from Super_StoreDB.dbo.Orders o
inner join Super_StoreDB.dbo.People p on o.[Customer Name]=p.Person
order by p.Person

select *from Super_StoreDB.dbo.People p
left join Super_StoreDB.dbo.Orders o on o.[Customer Name]=p.Person
order by p.Person

---Joins: adding filter using AND
select *from Super_StoreDB.dbo.People p
left join Super_StoreDB.dbo.Orders o 
on o.[Customer Name]=p.Person
and o.[State]='Kentucky'

---pull order details of all returned orders
select r.Returned,r.[Order ID], o.[Customer Name], o.City,o.[State], cast(o.[Order Date] as date) as 'OrderDate'  from Super_StoreDB.dbo.[Returns] r
left join Super_StoreDB.dbo.Orders o
on r.[Order ID] = o.[Order ID]
order by r.[Order ID]

---full outer join
select r.Returned,r.[Order ID], o.[Customer Name], o.City,o.[State], cast(o.[Order Date] as date) as 'OrderDate'  from Super_StoreDB.dbo.[Returns] r
full join Super_StoreDB.dbo.Orders o
on r.[Order ID] = o.[Order ID]
order by o.[Order ID]

select distinct [Order ID] from Super_StoreDB.dbo.Orders

--==========================================================================================
-------------------------------------->>Functions<<-----------------------------------------
--==========================================================================================
----------------------------->>String functions<<-------------------------------
select * from Super_StoreDB.dbo.Orders

select [Customer Name], UPPER([Customer Name]) as 'All_Caps'
from Super_StoreDB.dbo.Orders

select [State], [City], CONCAT_WS('_',[State], [City]) from Super_StoreDB.dbo.Orders

select Region, [State], CONCAT_WS('_', Region,[State]) as 'concat_ws'
from Super_StoreDB.dbo.Orders
order by Region asc, [State]

select distinct Region, [State], CONCAT_WS('_', Region,[State]) as 'concat_ws'
from Super_StoreDB.dbo.Orders
order by Region asc, [State] desc

------------------------------->>Date functions<<--------------------------------
----GETDATE returns current datetime in ISO format
select  current_datetime= GETDATE(),
		descr='GETDATE returns current datetime in ISO format';
----DATEADD(int,inc,exp) increases
select  current_datetime= GETDATE(), 
		added_datetime= DATEADD(HOUR,12, GETDATE()),
		current_datetime = 'Increased current Hour of current datetime by 12';
----DATEDIFF calculates difference between two datetimes
----calculate difference in terms of days 
select  current_datetime= GETDATE(), 
		added_datetime= DATEADD(day,3, GETDATE()),
		diff_in_hrs = DATEDIFF(hour, GETDATE(),DATEADD(day,3, GETDATE()) );
----Extract specific parts of the datetime
-----Method-1:
select  current_datetime= GETDATE(), 
		get_month= DATEPART(month,GETDATE()) ;
-----Method-2
select  current_datetime= GETDATE(), 
		get_month= MONTH(GETDATE()) ;
-----get end of month
select  current_datetime= GETDATE(), 
		get_last_day_of_month= DAY(EOMONTH(GETDATE())) ;
-----Get only date part from GETDATE (as Date dtype/ String formats)
select  current_datetime= GETDATE(), 
		in_dateformat= CAST(GETDATE() AS DATE),
		in_stringformat= CONVERT(DATE,GETDATE()) ;

--Using STRNG_AGG
select STRING_AGG(cast([Customer Name] as varchar(max)),' , ') as 'max_sales_order' from
(select top(2)[Customer Name] from Super_StoreDB.dbo.Orders order by Sales desc) as top_sales



------------------------------>>Math Functions<<------------------------------
--CEILING: returns smallest integer >= val
--FLOOR: returns largest integer <=val
select [Sales], [ceiling]= CEILING([Sales]), [floor]= FLOOR([Sales])
from Super_StoreDB.dbo.Orders;

--COALESCE -- returns the first non-null value from a column
select [Postal Code], coalesce(cast([Postal Code] as varchar(10)), 'no value') as 'Coalesced_col'
from Super_StoreDB.dbo.Orders
order by Coalesced_col desc;

--==========================================================================================
---------------------------->>Conditional logic (IF-ELSE , CASE)<<--------------------------
--==========================================================================================
---CASE-WHEN-THEN is similar to if-else logic
select top(10) [Order ID], [Product Name], [Sub-Category],
	case [Sub-Category]
		when 'Bookcases'	then 'b'
		when 'chairs'		then 'chr'
		when 'Tables'		then 'T'
		when 'art'			then 'a'
		when 'Furnishings'	then 'f'
	end as 'SC_Code'	
from Super_StoreDB.dbo.Orders;
--Categorize Order Quantity into 4 categories & display those in a column
select top(10) [Order ID], [Customer Name], [City] ,[Sales], [Quantity],
	case 
		when Quantity>0 and Quantity<=2 then 'low'
		when Quantity>2 and Quantity<5 then 'medium'
		--when Quantity>=5 and Quantity<10 then 'high'
		--else 'v. high'
	end as 'Order_volume'
from  Super_StoreDB.dbo.Orders
--same as above but usng the BETWEEN...AND operator
select top(10) [Order ID], [Customer Name], [City] ,[Sales], [Quantity],
	case 
		when Quantity between 0 and 1 then 'low'
		when Quantity between 2 and 5 then 'medium'
		when Quantity between 6 and 10 then 'high'
		else 'v. high'
	end as 'Order_volume'
from  Super_StoreDB.dbo.Orders


--==========================================================================================
---------------------------------------->>Variables<<---------------------------------------
--==========================================================================================
----Declaring variables
declare @name varchar(50);
declare @age int;
----Setting/ assigning values to the variables
set @name = 'John Wick';
set @age = 40;

select @name as 'Person_Name';
select @age as 'Person_Age';

--Print statement - shows result in the messages tab
declare @name1 varchar(50);
set @name1= 'Joey';

print'Hello '+ @name1 + '! How you doin? ' ;

print 'Today"s date is ' + CONVERT(VARCHAR,GETDATE(),105);

--IF-ELSE Statements - operate similar to other languages. ELSE-IF also can be used.
declare @value1 int;
declare @value2 int;

set @value1 = 103;
set @value2 = 201;

if @value1< @value2
	begin
		print cast(@value1 as varchar(10)) + ' is low';
	end
else
	begin
		print cast(@value1 as varchar(10)) + ' is high';
	end

-- Set operators (UNION, UNION ALL)

---Concatenating two subsets of the table
select * from  Super_StoreDB.dbo.Orders
where City = 'Henderson'
UNION
select * from  Super_StoreDB.dbo.Orders
where City = 'Los Angeles';

-- Set operators (INTERSECT)
--Only returns rows common to both subsets /tables
select top(10)* from  Super_StoreDB.dbo.Orders
where City = 'Henderson' 
INTERSECT
select top(20)* from  Super_StoreDB.dbo.Orders
where City = 'Henderson' and [Row ID]>1000
order by [Row ID];


-- Set operators (EXCEPT)
--Only returns rows from Left table that are NOT present in right table
select top(10)* from  Super_StoreDB.dbo.Orders
where City = 'Henderson'
EXCEPT
select top(20)* from  Super_StoreDB.dbo.Orders
where City = 'Henderson' and [Row ID]>1900
order by [Row ID];

--==========================================================================================
--------------------------------------->>Views<<--------------------------------------------
--==========================================================================================
select top(10) * from  Super_StoreDB.dbo.Orders;
go
--Creating the view
create view view_ReturnOrders
as
select o.[Order ID],o.[Customer Name], o.[Product ID] 
from Super_StoreDB.dbo.Orders o
inner join [Returns] r
on o.[Order ID] = r.[Order ID];

--Calling the view
select * from view_ReturnOrders
go
--Altering the view
create or alter view view_ReturnOrders
as
select o.[Order ID],o.[Customer Name], o.[Product ID], o.[Category],o.[Region]
from Super_StoreDB.dbo.Orders o
inner join [Returns] r
on o.[Order ID] = r.[Order ID];
go

select * from view_ReturnOrders

--Joiining views
select * from Super_StoreDB.dbo.Orders
select * from Super_StoreDB.dbo.People
go 

create view view_OrdersManagers
as(
select p.[Person] as 'Sales_Mngr'
from Super_StoreDB.dbo.Orders o
left join Super_StoreDB.dbo.People p
on o.Region = p.Region
);
go

drop view view_OrdersManagers

select * from Super_StoreDB.dbo.People


select o.[Order ID],o.[Customer Name], o.[Product ID], o.[Category],o.[Region],p.[Person] as 'Sales_Mngr'
from Super_StoreDB.dbo.Orders o
inner join [Returns] r
on o.[Order ID] = r.[Order ID]
left join Super_StoreDB.dbo.People p
on o.Region = p.Region

--Practical example - create 4 views - 
--each contains Orders details for each of the regions


select * from view_ReturnOrders ro
left join People om
on ro.Region=om.Region

--===========================================================================================
------------------------------------>>Sub-queries & CTEs<<-----------------------------------
--===========================================================================================
--------------------------------->>SUB-QUERY<<--------------------------------------
--Sub-querie consists of nested queries- Result of inner query is used by outer one
use ScrantonPaperCo;
go

select * from ScrantonPaperCo.dbo.Employees
select * from ScrantonPaperCo.dbo.Performance_Reviews

--Pull first & last name of the employee with highest salary
---This query references itself in both - outer as well as inner queries
select first_name,last_name , dept_id,is_active
	from ScrantonPaperCo.dbo.Employees
	--Outer sub-query uses result from inner sub-query to compare
where salary = (--Inner sub-query is evaluated first 
				select max(salary)
				from ScrantonPaperCo.dbo.Employees
				);

--Multiple nested sub-queries
--Select second highest salary & return first name last name:
select first_name , last_name 
from Employees
where salary =( select max(salary) 
				from Employees
				where salary <> (select max(salary) 
								from Employees
								));

--Group by in a sub-query:
-->>Pull data for departments where employee count is 3 or less:

---first checking the internal sub-query
select dept_id,count(*)
from Employees
group by dept_id
having count(*)<=3

---final query
select first_name, last_name,dept_id
from Employees
where dept_id in (
					select dept_id
					from Employees
					group by dept_id
					having count(*)<=3
				);
---Note that IN keyword expects a list of single column,
---so we avoided displaying count(*) colummn from the inner query 

-->>Show highest salary of each department alongwith employee name who earns it

--the inner sub-query
select dept_id, max(salary) from Employees
group by dept_id

select * from Employees

select first_name , last_name ,salary, t1.dept_id, d.dept_name
from Employees t1
inner join(
			select dept_id,max(salary) as 'max_salary'
			from Employees
			group by dept_id) as t2
on t1.dept_id = t2.dept_id and t1.salary = t2.max_salary
--added dept_names to the result set
inner join (select dept_id, dept_name from Departments) as d
on t2.dept_id = d.dept_id
order by t1.dept_id;

---NOTE: that join is applied on two key both - dept_id as well as salary<-->max_salary

-->>Show employee names along with salary & whether its above/below the Overall Avg 
---Use of CASE keyword to 

select * from ScrantonPaperCo.dbo.Employees

select first_name, last_name, salary,
	case 
		when salary > (select avg(salary) from Employees) then 'Above Average'
		else 'Below Average'
	end
from Employees;
/*where salary > (--inner query
				select cast(avg(salary) as decimal(18,2) ) 
				from Employees)*/

---Below query is simpler one - but it only pulls rows having Salary > AVG(Salary)
select first_name, last_name, salary
from Employees
where salary > (--inner query
				select avg(salary)
				from Employees)

-->>Find average sales across the regions
use Super_StoreDB;
go

select * from Super_StoreDB.dbo.Orders

select Region,cast(avg(Sales)as decimal(18,2)) as 'avg_sales'
from Orders
group by Region


-->>Show salary of employees from each department who earn more than dept average

--the inner sub-query
select d.dept_id,d.dept_name, cast(e.avg_salary as decimal(18,2)) as dept_avg
from ScrantonPaperCo.dbo.Departments d
inner join (select dept_id, avg(salary) as avg_salary
			from ScrantonPaperCo.dbo.Employees
			group by dept_id) as e
on e.dept_id = d.dept_id
--the entire query - Note that join allows bringing columns from inner query
--to the outer query & into the final result set
select first_name , last_name ,salary, t1.dept_id, d.dept_name
from ScrantonPaperCo.dbo.Employees t1
inner join(
			select dept_id,avg(salary) as 'avg_salary'
			from ScrantonPaperCo.dbo.Employees
			group by dept_id) as t2
on t1.dept_id = t2.dept_id and t1.salary > t2.avg_salary
--added dept_names to the result set
inner join (select dept_id, dept_name from ScrantonPaperCo.dbo.Departments) as d
on t2.dept_id = d.dept_id
order by t1.dept_id;

--Correlated sub-query - Inner query is re-executed for every row of the outer query
--NOTE: we cannot bring columns from inner query to the outer query & into the final result
select t1.first_name , t1.last_name ,t1.salary, t1.dept_id
from ScrantonPaperCo.dbo.Employees t1
where t1.salary > ( select avg(salary) as 'avg_salary'
					from ScrantonPaperCo.dbo.Employees t2
					where t1.dept_id = t2.dept_id) 

--Scalar sub-query - it's used when you want to show a calculated reference value 
--alongside each row without doing a full JOIN
-- Show each employee's salary alongside company-wide average
SELECT 
    first_name,
    last_name,
    salary,
    (SELECT cast(AVG(salary)as int) FROM ScrantonPaperCo.dbo.Employees)  AS company_avg,
    salary - (SELECT cast(AVG(salary)as int) FROM ScrantonPaperCo.dbo.Employees) AS diff_from_avg
FROM ScrantonPaperCo.dbo.Employees;


--==========================================================================================
----------------------------->>CTE - Common Table Expressions<<-----------------------------
--==========================================================================================
--CTEs can be referenced like a table or view but are not stored in db
--It provides a flexible concise way to organize & reuse complex queries
--This allows for recursive queries - where a query references itself
use ScrantonPaperCo;
go

--Show firstname lastname Salary of employees earning > $40K
select * from ScrantonPaperCo.dbo.Employees;

--A CTE must be immediately followed by the query that uses it
--Hence, both queries should be run together
with high_earners as (
select * from ScrantonPaperCo.dbo.Employees
where salary>40000)

--referring to CTE
select first_name,last_name,salary,dept_id 
from high_earners;

-->>Identify dept where dept-wise total salaries are higher than Overall Average salaries

select dept_id,cast(sum(salary) as decimal(18,2)) as sum_salary
from Employees
group by dept_id
--Attempting a complex sub-query
select cast(avg(total_salary) as decimal(18,2)) as avg_salary
from(select dept_id,sum(salary) as total_salary
	from Employees
	group by dept_id) as t2

select *
from (select dept_id,cast(sum(salary) as decimal(18,2)) as sum_salary
		from Employees
		group by dept_id) as table1
join
(select cast(avg(total_salary) as decimal(18,2)) as avg_salary
from(select dept_id,sum(salary) as total_salary
	from Employees
	group by dept_id) as table2) as table3
on table1.sum_salary > table3.avg_salary

--Better solution - CTEs

---creating first CTE
with cte_total_salary 
as(
	select dept_id,
	cast(sum(salary) as decimal(18,2)) as sum_salary
	from Employees
	group by dept_id
),
---creating second CTE
cte_avg_salary
as (
	select cast(avg(total_salary) as decimal(18,2)) as avg_salary
	from(select dept_id,sum(salary) as total_salary
	from Employees
	group by dept_id) as table2
)
select ts.dept_id, ts.sum_salary, avs.avg_salary, d.dept_name
from cte_total_salary ts
inner join cte_avg_salary avs
on ts.sum_salary > avs.avg_salary
inner join ScrantonPaperCo.dbo.Departments d
on ts.dept_id = d.dept_id


--==========================================================================================
------------------------------->>Sample Question<<------------------------------------------
--==========================================================================================
use Super_StoreDB;
go

select * from Super_StoreDB.dbo.Orders;
go

with cte_topten 
as(
	select * from Super_StoreDB.dbo.Orders
	)
select [Customer Name], STRING_AGG([State],', ')
from cte_topten
group by [Customer Name],[State]
order by [Customer Name]


-->>From Orders table, retrieve customers who've placed orders in multiple states
---Display customer name along with states using string aggregation
select * from Super_StoreDB.dbo.Orders;

select table1.[Customer Name], STRING_AGG(table1.[State], ', ') as [States]
from 
(select [Customer Name],[State]
from Super_StoreDB.dbo.Orders
group by [Customer Name],[State]) as table1
group by table1.[Customer Name]

---But we only want customers who've ordered from 1+ states
---Adding the HAVING clause to filter
select table1.[Customer Name], STRING_AGG(table1.[State], ', ') as [States]
from 
(select [Customer Name],[State]
from Super_StoreDB.dbo.Orders
group by [Customer Name],[State]) as table1
group by table1.[Customer Name]
having count(table1.[State])>1


--==========================================================================================
---------------------------------->>Sample Question #2<<------------------------------------
--==========================================================================================
--Show all customers who've ordered from all 3 categories
select * from Super_StoreDB.dbo.Orders;

select distinct category from Super_StoreDB.dbo.Orders


select [Customer Name] 
from Super_StoreDB.dbo.Orders
group by [Customer Name]
having count(distinct Category)=3
order by [Customer Name]

--instead of hard-coding count value, use sub-query

select [Customer Name] 
from Super_StoreDB.dbo.Orders
group by [Customer Name]
having count(distinct Category) = (select count(distinct Category)
								from Super_StoreDB.dbo.Orders)
order by [Customer Name]


--==========================================================================================
------------------------------------>>Window functions<<------------------------------------
--==========================================================================================
select * from Super_StoreDB.dbo.Orders;

select distinct [Order ID] from Super_StoreDB.dbo.Orders

--query to select sample dataset (OrderIDs containing 2+ items)
select [Order ID] ,count([Order ID]) as 'no_of_orders' from Super_StoreDB.dbo.Orders
group by [Order ID]
having count([Order ID])>2
go

create or alter view vordersinfo as(
select [Order ID],category,Region,City, [Product Name], Quantity, Sales 
from Super_StoreDB.dbo.Orders
where [Order ID] in ('CA-2011-100895','CA-2011-100762','CA-2011-103429','CA-2011-111451'));
go

select * from vordersinfo;


--Aggregate window functions
---Show total quantity per order
select [Order ID],
		Category, 
		Quantity,
		sum(quantity) over(partition by [order id])as total_qty,  --defining a window
		avg(quantity) over(partition by [order id]) as avg_qty,
		max(quantity) over(partition by [order id]) as max_qty
from vordersinfo;

--Ranking window functions
---Add Row numbers ,partitioned on Order ID
select [Order ID], Category, Quantity, Sales,
		ROW_NUMBER() over(partition by [Order ID] order by Quantity) as RowNo,
		RANK() over(partition by [Order ID] order by Quantity) as RankNo,
		DENSE_RANK() over(partition by [Order ID] order by Quantity) as DenseRankNo,
		cast(PERCENT_RANK() over(partition by [Order ID] order by Quantity)as decimal(18,2)) as PercentRank,
		NTILE(4) over(partition by [Order ID]order by Quantity) as NtileRank
from vordersinfo;

--ROW BETWEEN window function
---Used to define the window frame that is relative to the current row.
---uses PRECEDING/ FOLLOWING keywords define range & direction of the included rows
select * from vordersinfo;


--Add a column of Cumulative sum to include every sales for entire table
select [order id],Sales,Category, City,
		sum(Sales) over(order by [order id] rows between unbounded preceding and current row) as CmTotal
from vordersinfo;

--Add a column of Cumulative sum for each Order ID
select [order id],Sales,Category, Quantity,
		sum(Sales) over(order by [order id] rows between unbounded preceding and current row) as CmTotalSales,
		sum(Sales) over( partition by [order id ]order by [order id] rows between unbounded preceding and current row) as CmTotal_byOrder,
		sum(Sales) over(partition by [order id] order by  [order id] rows between unbounded preceding and unbounded following) as CmTotal_Sales,
		sum(Sales) over(partition by [order id] order by  [order id] rows between unbounded preceding and current row) as CmTotal_byQnty,
		sum(Sales) over(order by  [order id] rows between 1 preceding and 1 following) as TotalbyQnty_1p1f
from vordersinfo;

--LEAD LAG functions
---Note that both columns are partitioned over OrderID.
---So Lag_col shows NULL for first value of evey partition
---And Lag_col shows NULL for last value of evry partition
select [order id],Sales,Category, Quantity,
		LAG(Quantity) over(partition by [order id] order by [quantity]) as Lag_col,
		LEAD(Quantity) over(partition by [order id] order by [quantity]) as Lead_col
from vordersinfo;

--Specifying Offset= 2 ; i.e. lead/ lag by 2 cells
--Also, Default set to 0 ;it returns this value where value would've been NULL
select [order id],Sales,Category, Quantity,
		LAG(Quantity,2,0) over(partition by [order id] order by [quantity]) as Lag_col,
		LEAD(Quantity,2,0) over(partition by [order id] order by [quantity]) as Lead_col
from vordersinfo;

select [order id],Category, 
		LAG(Category,1,'NA') over(partition by [order id] order by [quantity]) as Lag_col
		--LEAD(Quantity,2,0) over(partition by [order id] order by [quantity]) as Lead_col
from vordersinfo;

--FIRST_VALUE & LAST_VALUE functions
--Both have the implicit clause(ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
--For both funcs, its important to understand if partition is to be considered or entire table

select [order id],Category, Quantity,
		FIRST_VALUE(Quantity) over(order by Quantity) as first_val,
		FIRST_VALUE(Quantity) over(partition by [order id] order by Quantity) as first_val1		
from vordersinfo;

--Below example shows how output of the keyword can be cntrolled using ROW BETWEEN function
select [order id],Category, Quantity,
		LAST_VALUE(Quantity) over(order by Quantity) as last_val,
		LAST_VALUE(Quantity) over(partition by [order id] order by Quantity rows between unbounded preceding and unbounded following) as last_val1		
from vordersinfo;



--==========================================================================================
------------------------------------>>Stored Procedures<<-----------------------------------
--==========================================================================================
--A stored procedure is a precompiled collection of SQL statements stored in the database 
--that can be executed as a single unit. Basically a function for the db

--Get distinct order IDs from vordersinfo subset

select * from Super_StoreDB.dbo.Orders;
go

--A simple SP example
create procedure sp_GetDistinctOrders
as
	begin 
		select distinct([Order ID]) 
		from Super_StoreDB.dbo.Orders;
	end
go
--Running a stored procedure
exec sp_GetDistinctOrders;
go 

sp_helptext sp_GetDistinctOrders;
go
--Stored Procedure with input parameters

--Take User input for City & sub-category
create procedure sp_GetOrderDetails
@city_name varchar(100),
@sub_category varchar(100)
as 
	begin
		select * 
		from Super_StoreDB.dbo.Orders
		where City = @city_name and [Sub-Category] = @sub_category
	end
---Runing the stored procedure
exec sp_GetOrderDetails 'Seattle', 'Art';
go

---Runing the stored procedure
exec sp_GetOrderDetails @city_name = 'Los Angeles', @sub_category='Art';
go

--Stored procedures with an output parameter - there can be ultiple outputs returned
--Show no. of orders for a city & sub-category
create procedure sp_GetOrderCount
@city_name varchar(100),
@sub_category varchar(100),
@result int output
as
	begin
		select @result = count(*)
		from Super_StoreDB.dbo.Orders
		where City = @city_name and [Sub-Category] = @sub_category
	end;
go

declare @new_result int;
exec sp_GetOrderCount @city_name = 'Los Angeles', @sub_category='Art' ,@result = @new_result output;
print(convert(varchar(10),@new_result));

select distinct [City]from Orders

select *  from Super_StoreDB.dbo.Orders o
where o.City='Seattle'

go
--Calling one stored proc from another
---Get order details by only specifying the ORder ID; One stored proc accepts only OrderID
---It internally calls another stored proc that fetches order details.
----Creating stored procedure #1 (internal query)
create procedure sp_GetORderDetails1
@orderID  varchar(50),
@orderDate date output,
@productID varchar(50) output,
@sales float output,
@quantity int output
as
	begin
		if exists(select * from Super_StoreDB.dbo.Orders where [Order ID]=@orderID)
			begin 
				(select @orderDate, @sales,@quantity, @productID,@sales, @quantity
				from Super_StoreDB.dbo.Orders
				where [Order ID] = @orderID)
				return 1
			end
		else 
			return 0
	end;
go

----Creating stored procedure #2 (user-facing procedure)
create procedure sp_GetOrderID
@orderID varchar(50)
as 
	begin
		declare @orderDate date 
		declare @productID varchar(50) 
		declare @sales float 
		declare @quantity int 
		declare @returnValue int
		exec @returnValue = sp_GetORderDetails1 @orderID , @productID output,@sales output,@quantity output,@quantity output
		if(@returnValue=1)
			begin
				print'customer ID is ' + @orderID
				select * from Orders where  [Order ID] = @orderID
			end
		else 
			print 'no order ID exists' 
	end


exec sp_GetOrderID 'CA-2011-115812';

select count (distinct [Order ID]) 
from Super_StoreDB.dbo.Orders


