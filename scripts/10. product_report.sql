/* 
Product Report

Purpose : 
	- This report consolidates key product metrics and behaviors.

Highlights:
	1. Gathers essential fields such as product name, category, subcategory, and cost
	2. Segment products by revenu to identify High-Performers, Mid-Range, or Low-Performers.
	3. Aggregates product-level metrics:
		- total orders
		- total sales
		- total quantity sold
		- total customers (unique)
		- lifespan ( in months)
	4. Calculate valuable KPIs:
		- recency (months since last sale)
		- average order revenue (AOR)
		- average montly revenue
*/

Create View gold.report_products as 
with base_query as (
-- 1. Base Query: Selecting key columns
Select
	f.order_number,
	f.order_date,
	f.customer_key,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
From gold.fact_sales f
Left Join gold.dim_products P
ON f.product_key = p.product_key
Where f.order_date is not null
)

, product_aggregation as (
-- 2. Product Aggregation: Summarizes key metrics at the product level
Select 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	datediff(month, Min(order_date), Max(order_date)) as lifespan,
	Max(order_date) as last_sale_order,
	Count(Distinct order_number) as total_order,
	Count(Distinct customer_key) as total_customers,
	Sum(sales_amount) as total_sales,
	Sum(quantity) as total_quantity,
	Round(Avg(cast(sales_amount as float)/ 
	NullIf(quantity, 0)), 1) as avg_selling_price
From base_query
Group by 
	product_key,
	product_name,
	category,
	subcategory,
	cost
)

-- 3. Final Query: Combines all product result inot one output
Select 
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	Datediff(month, last_sale_order, getdate()) as receny_in_months,
	Case When total_sales > 50000 Then 'High-Performer'
		 When total_sales >= 10000 Then 'Mid-Range'
		 Else 'Low-Performer'
	End as product_segment,
	lifespan,
	last_sale_order,
	total_order,
	total_customers,
	total_sales,
	total_quantity,
	avg_selling_price,
	-- Average order revenue
	Case When total_order = 0 Then 0
		 Else total_sales / total_order
	End as avg_order_revenue,

	-- Average Monthly Revenue
	Case 
		When lifespan = 0 Then total_sales
		Else total_sales / lifespan
	End as avg_monthly_revenue
From product_aggregation
