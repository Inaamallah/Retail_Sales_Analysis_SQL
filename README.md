# Retail Sales Analysis SQL Project

## Project Overview

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `retail_sales`.
- **Table Creation**: A table named `retail_sales_table` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database retail_sales;

USE retail_sales;

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
);

```

### 2. Data Exploration & Cleaning

* **Record Count**: Determine the total number of records in the dataset.
* **Customer Count**: Find out how many unique customers are in the dataset.
* **Category Count**: Identify all unique product categories in the dataset.
* **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT count(*) FROM retail_sales_table;
SELECT count(customer_id) as Total_Customers FROM retail_sales_table;
SELECT DISTINCT category as Categories FROM retail_sales_table;

SELECT * FROM retail_sales_table 
WHERE 
    concat(transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantiy, price_per_unit, cogs, total_sale) is NULL;

DELETE FROM retail_sales_table 
WHERE 
    concat(transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantiy, price_per_unit, cogs, total_sale) is NULL;

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Sales made on 5th Nov 2022?**:

```sql
SELECT * FROM retail_sales_table 
WHERE sale_date = '2022-11-05';

```

2. **Transactions happened in Nov 2022 made for Clothing Category and quantity is more than 3**:

```sql
SELECT *
FROM retail_sales_table
WHERE 
    category = 'Clothing'
    and 
    DATE_FORMAT(sale_date,'%Y-%m') = '2022-11'
    and 
    quantiy >= 3;

```

3. **Total Sales and Orders for each Category?**:

```sql
SELECT
    category as Categories, 
    SUM(total_sale) as Total_Sale, 
    COUNT(*) as Total_Order
FROM retail_sales_table
GROUP BY category;

```

4. **Average Customers Age who purchase items from beauty Category?**:

```sql
SELECT 
    category as Categories, 
    Round(AVG(age),0) as Average_Age
FROM retail_sales_table
WHERE category = 'Beauty'
GROUP BY category;

```

5. **Transactions where Total Sales are greater than 1000?**:

```sql
SELECT transactions_id, total_sale
FROM retail_sales_table
WHERE total_sale > 1000
ORDER BY total_sale desc;

```

6. **Total Number of Transactions made by each gender in each category?**:

```sql
SELECT 
    category as Category, 
    gender as Gender, 
    COUNT(transactions_id)
FROM retail_sales_table
GROUP BY 1,2
ORDER BY 1 desc;

```

7. **Average Sale for each Month, Best Selling Month in each year?**:

```sql
SELECT * FROM (
    SELECT 
        year(sale_date) as Years, 
        month(sale_date) as Months, 
        round(avg(total_sale),2) as Avg_Total_Sales, 
        RANK() over(partition by year(sale_date) order by avg(total_sale) desc ) as Ranking
    FROM retail_sales_table
    GROUP BY 1,2
) as sq1
WHERE Ranking = 1;

```

8. **Top 5 Customers with highest Total Sales**:

```sql
SELECT * FROM (
    SELECT 
        customer_id as Customer_ID, 
        sum(total_sale) as Total_Sales,
        RANK() over (order by sum(total_sale) desc) as Ranking
    FROM retail_sales_table
    GROUP BY 1
) as sq2
WHERE Ranking <= 5;
```
*OR Second Approach**

```sql
select 
	customer_id as Customer_ID, sum(total_sale) as Total_Sales
from retail_sales_table
group by 1
order by 2 desc
limit 5
```



9. **Unique Customers who purchased items from each category?**:

```sql
SELECT 
    count(distinct customer_id) as Unique_Customer_ID, 
    category as Category
FROM retail_sales_table
GROUP BY 2;

```

10. **Create Day Shifts and Provide orders counts in them**:

```sql
WITH Shift_Sale AS (
    SELECT *,
        CASE 
            WHEN HOUR(sale_time) < 12 THEN 'Morning'
            WHEN HOUR(sale_time) between 12 and 17 THEN 'Afternoon'
            ELSE 'Evening'
        END as Shift
    FROM retail_sales_table
)
SELECT 
    count(transactions_id) as Total_Orders, 
    Shift
FROM Shift_Sale
GROUP BY Shift
ORDER BY 1;

```

## Findings

* **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
* **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
* **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
* **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

* **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
* **Trend Analysis**: Insights into sales trends across different months and shifts.
* **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Author - Inaamallah

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!


Thank you for your support, and I look forward to connecting with you!

```

```
