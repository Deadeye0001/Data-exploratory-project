-- Which categories contribute the most to overall sales
with category_sales as (
Select
category,
Sum(sales_amount) as total_sales,
Sum(Sum(sales_amount)) Over() Overall_sales
From gold.fact_sales f
Left Join gold.dim_products p
On p.product_key = f.product_key
Group by category
)
Select
*,
Concat(Round((cast(total_sales as float) / Overall_sales) * 100, 2), '%')  as percentage_of_total 
From category_sales
Order by total_sales Desc
