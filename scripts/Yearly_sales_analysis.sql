/* Analyze the yearly performance of products by comparing their sales
to both the avergae sales performance of the product and the previous year's sales */
With yearly_product_sales as (
Select 
	Year(f.order_date) as order_year,
	p.product_name,
	sum(f.sales_amount) as current_sales,
	Avg(Sum(f.sales_amount)) Over(Partition by p.product_name) as avg_sales,	
	Lag(sum(f.sales_amount)) Over(Partition by p.product_name 
		Order by year(f.order_date)) as previous_sales
From gold.fact_sales f
Left Join gold.dim_products p
on f.product_key = p.product_key
Where f.order_date is not null
Group by Year(f.order_date), p.product_name
)


Select
	order_year,
	product_name,
	current_sales,
	avg_sales,
	current_sales - avg_sales as diff_avg,
	Case When current_sales - avg_sales > 0 Then 'Above avg'
		When current_sales - avg_sales < 0 Then 'Below avg'
		Else 'Avg'
	End avg_change,
	previous_sales,
	current_sales - previous_sales as diff_previous_year,
	Case When current_sales - previous_sales > 0 Then 'Increase'
		When current_sales - previous_sales < 0 Then 'Decrease'
		Else 'No Change'
	End Previous_year_change
From yearly_product_sales
order by product_name, order_year
