/* Group customers into three segments based on their spending behavior.
		vip : at least 12 month of history and spending more than 5000
		regular: at least 12 month of history but spending 5000 or less
		new : customers with a lifespan less than 12 months
And find the total number of customer by each group
*/
With customer_spending as (
Select
	c.customer_key,
	Sum(f.sales_amount) as total_spending,
	Min(order_date) as first_order,
	Max(order_date) as last_order,
	Datediff(month, Min(order_date), Max(order_date)) as lifespan

From gold.fact_sales f
Left Join gold.dim_customers c
On c.customer_key = f.customer_key
Group by c.customer_key
)

Select
	customer_segment,
	Count(customer_key) as total_customers
From (
Select 
	customer_key,
	total_spending,
	lifespan,
	Case When lifespan >= 12 and total_spending > 5000 Then 'VIP'
		 When lifespan >= 12 and total_spending <= 5000 Then 'Regular'
		 Else 'New'
	End customer_segment
From customer_spending)t
Group by customer_segment
Order by total_customers DESC
