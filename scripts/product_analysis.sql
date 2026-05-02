/* Segment products into cost range and 
count how many products fall into each segment */
With product_segment as (
Select 
	product_key,
	product_name,
	cost,
	Case When cost < 100 Then 'Below 100'
		 When cost Between 100 and 500 Then '100-500'
		 When cost Between 500 and 1000 Then '500-1000'
		 Else 'above 100'
	End cost_range
From gold.dim_products)

Select 
	cost_range,
	Count(product_key) as total_product
	From product_segment
	Group by cost_range
Order by total_product DESC
