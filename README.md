# Data Exploratory Project

## Overview
- This project focuses on exploratory data analysis (EDA) using SQL Server on a retail sales data warehouse.
- The goal of the project is to analyze customer behavior, product performance, sales trends, and business KPIs using SQL queries.

---

### The database follows a star schema model with:

1. Fact Table : gold.fact_sales
2. Dimension Tables : gold.dim_customers, gold.dim_products

- This project demonstrates practical SQL skills commonly used in:

1. Data Analytics
2. Business Intelligence
3. Reporting

---

### Contains transactional sales data:

- Order details
- Product purchases
- Revenue
- Quantity sold
- Dimension Tables
- gold.dim_customers

### Contains customer-related information:

- Customer names
- Gender
- Country
- Birth date
- gold.dim_products

### Contains product-related information:

- Product names
- Categories
- Subcategories
- Product cost
- Project Objectives

---

### The project answers important business questions such as:

-What are the total sales and total orders?
-Which products generate the highest revenue?
-Which countries contribute the most sales?
-Who are the top customers?
-What is the age range of customers?
-Which products perform poorly?
-What is the sales distribution across categories?
-SQL Concepts Used

---

### This project demonstrates the use of:

SELECT
DISTINCT
GROUP BY
ORDER BY
JOIN
AGGREGATE FUNCTIONS
SUM()
AVG()
COUNT()
MIN()
MAX()
DATEDIFF()
UNION ALL
WINDOW FUNCTIONS
ROW_NUMBER()
TOP
CAST()

---

Key Analysis Performed
1. Database Exploration
Explored all tables in the database
Explored all columns in dimension tables

2. Customer Analysis
Customer distribution by country
Customer distribution by gender
Youngest and oldest customers
Top revenue-generating customers
Customers with the fewest orders

3. Product Analysis
Product categories and subcategories
Total products per category
Average product cost by category
Best-performing products
Worst-performing products

4. Sales Analysis
Total sales metrics
Revenue by category
Quantity sold by country
First and last order dates
Business Metrics Generated

---

### Some example business insights obtained from the analysis:

Certain product categories contribute significantly more revenue.
A small number of customers generate a large percentage of total sales.
Sales distribution varies heavily by country.
Some products consistently underperform and may require review.

---

### Tools & Technologies
SQL Server
GitHub
Data Warehouse Concepts

---

## 🛡️ License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and share this project with proper attribution.
