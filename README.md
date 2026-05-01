# Data Exploratory Project

## Overview
This project focuses on exploratory data analysis (EDA) using SQL Server on a retail sales data warehouse.
The goal of the project is to analyze customer behavior, product performance, sales trends, and business KPIs using SQL queries.
---
The database follows a star schema model with:

Fact Table
gold.fact_sales
Dimension Tables
gold.dim_customers
gold.dim_products

This project demonstrates practical SQL skills commonly used in:

Data Analytics
Business Intelligence
Reporting
Data Warehousing
Database Structure
Fact Table
gold.fact_sales

Contains transactional sales data:

Order details
Product purchases
Revenue
Quantity sold
Dimension Tables
gold.dim_customers

Contains customer-related information:

Customer names
Gender
Country
Birth date
gold.dim_products

Contains product-related information:

Product names
Categories
Subcategories
Product cost
Project Objectives

The project answers important business questions such as:

What are the total sales and total orders?
Which products generate the highest revenue?
Which countries contribute the most sales?
Who are the top customers?
What is the age range of customers?
Which products perform poorly?
What is the sales distribution across categories?
SQL Concepts Used

This project demonstrates the use of:

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

Key Analysis Performed
1. Database Exploration
Explored all tables in the database
Explored all columns in dimension tables

3. Customer Analysis
Customer distribution by country
Customer distribution by gender
Youngest and oldest customers
Top revenue-generating customers
Customers with the fewest orders

5. Product Analysis
Product categories and subcategories
Total products per category
Average product cost by category
Best-performing products
Worst-performing products

7. Sales Analysis
Total sales metrics
Revenue by category
Quantity sold by country
First and last order dates
Sales duration analysis
Business Metrics Generated

The project creates a KPI report including:

Metric	Description
Total Sales	Total revenue generated
Total Quantity	Total items sold
Average Price	Average product price
Total Orders	Number of orders placed
Total Products	Total products available
Total Customers	Total customer count
Sample Insights

Some example business insights obtained from the analysis:

Certain product categories contribute significantly more revenue.
A small number of customers generate a large percentage of total sales.
Sales distribution varies heavily by country.
Some products consistently underperform and may require review.

Tools & Technologies
SQL Server
GitHub
Data Warehouse Concepts
Learning Outcomes

Through this project, I improved my understanding of:

Writing analytical SQL queries
Performing exploratory data analysis using SQL
Working with star schema databases
Using joins and aggregations effectively
Applying window functions for ranking and reporting
Generating business insights from raw data
How to Run the Project
Import the dataset into SQL Server
Create the required schemas and tables
Run the SQL scripts provided in the project
Analyze the query outputs
