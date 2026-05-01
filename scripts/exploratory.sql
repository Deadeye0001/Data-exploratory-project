/* 
Purpose : Exploring the dataset and tables to answer business questions.
          Aggrigated the data through countries, costomers,
          products to find the top performing and least performing 
		  customers and products.
*/

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



-- Find the total number of customer by countries
Select 
	country,
	Count(customer_key) As total_customers
From gold.dim_customers	
Group by country
Order by total_customers Desc

-- Find the total customer by gender
Select 
	gender,
	Count(customer_key) As total_customers
From gold.dim_customers	
Group by gender
Order by total_customers Desc

-- Find total products by category
Select 
	category,
	Count(product_key) As total_products
From gold.dim_products
Group by category
Order by total_products Desc

-- What is the average cost in each category
Select 
	category,
	avg(cost) As average_cost
From gold.dim_products
Group by category
Order by average_cost Desc

-- What is the total revenue generated for each category
Select 
	p.category,
	sum(f.sales_amount) as total_revenue
From gold.fact_sales f
Left Join gold.dim_products p
On p.product_key = f.product_key
Group by p.category
Order by total_revenue Desc

--  What is the total reevenue customers by each customer
Select Top 10
	c.customer_key,
	c.first_name,
	c.last_name,
	Sum(f.sales_amount) as total_revenue
From gold.fact_sales f
Left Join gold.dim_customers c
On c.customer_key = f.customer_key
Group by c.customer_key, c.first_name, c.last_name
Order by total_revenue Desc

-- What is the distribution of sold items across countries.
Select 
	c.country,
	Sum(f.quantity) as total_sold_items
From gold.fact_sales f
Left Join gold.dim_customers c
On c.customer_key = f.customer_key
Group by c.country
Order by total_sold_items Desc



-- Which 5 products generate the highest revenue
Select Top 5
	p.product_name,
	sum(f.sales_amount) as total_revenue
From gold.fact_sales f
Left Join gold.dim_products p
On p.product_key = f.product_key
Group by p.product_name
Order by total_revenue Desc

-- Same result using the window functions
Select
*
From (
Select 
	p.product_name,
	sum(f.sales_amount) as total_revenue,
	Row_number() Over (Order by sum(f.sales_amount) DESC) as flag
From gold.fact_sales f
Left Join gold.dim_products p
On p.product_key = f.product_key
Group by p.product_name) t
Where flag <=5

-- what are the 5 worst performing products in termss of sales
Select Top 5
	p.product_name,
	sum(f.sales_amount) as total_revenue
From gold.fact_sales f
Left Join gold.dim_products p
On p.product_key = f.product_key
Group by p.product_name
Order by total_revenue 

-- Find the top 10 cystiners wgi gave generated the highest revenue
Select Top 10
	c.customer_key,
	c.first_name,
	c.last_name,
	Sum(f.sales_amount) as total_revenue
From gold.fact_sales f
Left Join gold.dim_customers c
On c.customer_key = f.customer_key
Group by c.customer_key, c.first_name, c.last_name
Order by total_revenue Desc

-- Top 3 customers with the fewest orders placed
Select Top 3
	c.customer_key,
	c.first_name,
	c.last_name,
	Count( Distinct f.order_number) as total_orders
From gold.fact_sales f
Left Join gold.dim_customers c
On c.customer_key = f.customer_key
Group by c.customer_key, c.first_name, c.last_name
Order by total_orders 
