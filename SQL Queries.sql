-- DATABASE CREATION

create database retail_sales

USE retail_sales



CREATE TABLE retail_sales_table (
transactions_id int,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float

)


SELECT 
	count(*) 
FROM retail_sales_table

SELECT 
	* 
FROM retail_sales_table 
LIMIT 100




-- DATA CLEANING

SELECT 
	* 
FROM retail_sales_table 
WHERE 
concat(
transactions_id,
sale_date,
sale_time,
customer_id,
gender,
age,
category,
quantiy,
price_per_unit,
cogs,
total_sale)
is NULL

DELETE
	FROM retail_sales_table 
WHERE 
concat(
transactions_id,
sale_date,
sale_time,
customer_id,
gender,
age,
category,
quantiy,
price_per_unit,
cogs,
total_sale)
is NULL


-- DATA EXPLORATION


-- How many sales are there?
SELECT 
	count(*) 
	as 
	Total_Sales 
FROM retail_sales_table 


-- How many Customers we have?
SELECT 
	count(customer_id) 
	as 
	Total_Customers 
FROM retail_sales_table


-- How many Distinct Categories are there?
SELECT 
	DISTINCT category 
	as 
	Categories 
FROM retail_sales_table





-- Business Key Problems

-- Sales made on 5th Nov 2022?
SELECT 
	* 
FROM retail_sales_table 
WHERE 
	sale_date = '2022-11-05'

-- Transactions happened in Nov 2022 made for Clothing Category and quantity is more than 3?
SELECT 
	*
FROM retail_sales_table
WHERE 
	category = 'Clothing'
	and 
	DATE_FORMAT(sale_date,'%Y-%m') = '2022-11'
	and 
	quantiy >= 3
	
	
	
-- Total Sales and Orders for each Category
SELECT
	category as Categories, SUM(total_sale) as Total_Sale, COUNT(*) as Total_Order
from retail_sales_table
	group by category
	
	
	
-- Average Customers Age who purchase items from beauty Category
select 
	category as Categories, Round(AVG(age),0) as Average_Age
from retail_sales_table
where category = 'Beauty'
group by category
	


-- Transactions where Total Sales are greater than 1000
select 
	transactions_id, total_sale
from 
	retail_sales_table
where 
	total_sale > 1000
order by total_sale desc


-- Total Number of Transactions made by each gender in each category
select 
	category as Category, gender as Gender, COUNT(transactions_id)
from
	retail_sales_table
group by 1,2
order by 1 desc


-- Average Sale for each Month, Best Selling Month in each year
select * from (
	select 
		year(sale_date) as Years, month(sale_date) as Months, round(avg(total_sale),2) as Avg_Total_Sales, 
		RANK() over(partition by year(sale_date) order by avg(total_sale) desc ) as Ranking
	from retail_sales_table
	group by 1,2
) as sq1
where 
	Ranking = 1
	
	
	
	
-- Top 5 Customers with highest Total Sales
select * from (
select 
	customer_id as Customer_ID, sum(total_sale) as Total_Sales,
	RANK() over (order by sum(total_sale) desc) as Ranking
from retail_sales_table
group by 1
) as sq2
where Ranking <= 5

-- OR Second Approach
select 
	customer_id as Customer_ID, sum(total_sale) as Total_Sales
from retail_sales_table
group by 1
order by 2 desc
limit 5


-- Unique Customers who purchased items from each category

select 
	count(distinct customer_id) as Unique_Customer_ID, category as Category
from retail_sales_table
group by 2




-- Create Day Shifts and Provide orders counts in them
with Shift_Sale
as (
	select *,
		case 
			when HOUR(sale_time) < 12 then 'Morning'
			when HOUR(sale_time) between 12 and 17 then 'Afternoon'
			else 'Evening'
		end as Shift
	from retail_sales_table
)
select 
	count(transactions_id) as Total_Orders, Shift
from 
	Shift_Sale
group by Shift
order by 1 


	




