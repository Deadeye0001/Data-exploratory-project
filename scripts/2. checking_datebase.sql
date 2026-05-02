-- Explore all objects in the database
Select * 
from INFORMATION_SCHEMA.TABLES

-- Explore all columns in the database
Select * 
from INFORMATION_SCHEMA.COLUMNS
Where table_name = 'dim_customers'

-- Explore all countries our customers come from.
Select Distinct
country
From gold.dim_customers

-- Explore all categories 
Select Distinct 
product_name, category, subcategory 
from gold.dim_products
Order by 1,2,3

-- Find the date oof the first and last order
-- How many years of slaes are available
Select
	Min(order_date) as first_order_date,
	Max(order_date) as first_order_date,
	Datediff(MONTH, Min(order_date), Max(order_date)) as Order_range_months
From gold.fact_sales

-- Find the yougest and the oldest customer
Select 
	Min(birth_date) as oldest_birthdate,
	Cast(Datediff(year, Min(birth_date), Getdate()) as nvarchar)+ ' years'  as oldest_age,
	Max(birth_date) as youngest_birthdate,
	Cast(Datediff(year, Max(birth_date), Getdate()) as nvarchar)+ ' years'  as youngest_age
From gold.dim_customers



-- Generatee a report that shows all key metrices of the business
Select 	'Total Sales' as measure_name, Sum(sales_amount) as measure_value From gold.fact_sales
Union All
Select 'Total Quantity', Sum(quantity) From gold.fact_sales
Union All
Select 	'Average Price', Avg(price) From gold.fact_sales
Union All
Select 'Total Orders', 	Count(order_number) From gold.fact_sales
Union All 
Select ' Total Products', Count(product_key) From gold.dim_products
Union All
Select 'Total Customers', Count(customer_key) From gold.dim_customers
