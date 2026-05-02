/*
Customer Report
========================================
Purpose: 
	- This report consolidates key customers metrics and behaviors

Heighlights:  
	1. Gathers essential fields such as name, ages, and  transaction details.
	2. Segments customers into categories (Vip, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- lifespan (in months)
	4. Calculates valuable KPIs:
		- recency (months since last order)
		- average order value
		- average monthly spend
*/

Create View gold.report_customers as
With base_query as (
-- 1. base query : retrieve core columns from tables.
Select 
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
Concat(c.first_name, ' ', c.last_name) as customer_name,
Datediff(year, c.birth_date, getdate()) as age
From gold.fact_sales f
Left Join gold.dim_customers c
On c.customer_key = f.customer_key
Where f.order_date is not null)

, customer_aggregation as (
-- 2. Customer aggregation : Summarizes key metrics at the customer level
Select 
	customer_key,
	customer_number,
	customer_name,
	age, 
	Count(Distinct order_number) as total_orders,
	Sum(sales_amount) as total_sales,
	Sum(quantity) as total_quantity,
	Count(Distinct product_key) as total_product,
	Max(order_date) as last_order,
	Datediff(month, Min(order_date), Max(order_date)) as lifespan
From base_query
Group by 
	customer_key,
	customer_number,
	customer_name,
	age
)

Select 
	customer_key,
	customer_number,
	customer_name,
	age,
	Case When age < 20 Then 'Under 20'
		 When age Between 20 and 29 Then '20-29'
		 When age Between 30 and 39 Then '30-39'
		 When age Between 40 and 49 Then '40-49'
		 Else '50 and above'
	End age_group,
	Case When lifespan >= 12 and total_sales > 5000 Then 'VIP'
		 When lifespan >= 12 and total_sales <= 5000 Then 'Regular'
		 Else 'New'
	End customer_segment,
	last_order,
	Datediff(month, last_order, getdate()) as recency,
	total_orders,
	total_sales,
	total_quantity,
	total_product,
	lifespan,
	-- compute avergae order value
	Case When total_orders = 0 Then 0
		 Else total_sales/total_orders
	End as avg_order_value,
	-- Compute average monthly spend
	Case When lifespan = 0 Then  total_sales
		 Else total_sales/lifespan
	End as avg_monthly_spend
From customer_aggregation
