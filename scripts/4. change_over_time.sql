-- Change Over Time Analysis

Select
	Datetrunc(year, order_date) as order_date,
	Sum(sales_amount) as total_sales,
	Count(Distinct customer_key) as total_customer,
	Sum(quantity) as total_quantity
From gold.fact_sales
Where order_date is not null
Group by Datetrunc(month, order_date)
Order by Datetrunc(month, order_date)

-- Calculate the total sales per month
-- and the running total of sales over time
Select 
	*,
	Sum(total_sales) Over (Order by order_date) as running_total,
	Avg(avg_price) Over (order by order_date) as running_average
From
(
	Select
		Datetrunc(year, order_date) as order_date,
		Sum(sales_amount) as total_sales,
		Avg(price) as avg_price
	From gold.fact_sales
	where order_date is not null
	Group by Datetrunc(year, order_date)
)t

