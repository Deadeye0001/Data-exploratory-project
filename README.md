# Retail Sales Data Analysis & Reporting Project

## Overview
This project focuses on performing Exploratory Data Analysis (EDA) and building advanced analytical reporting views using SQL Server on a retail sales data warehouse.

The project analyzes customer behavior, product performance, sales trends, and business KPIs by transforming raw transactional data into business-ready analytical reports.

The solution combines:
- Exploratory Data Analysis (EDA)
- Customer Analytics
- Product Performance Reporting
- KPI Generation
- SQL-based Reporting Architecture

---

# Database Schema

The database follows a **Star Schema Model** consisting of fact and dimension tables.

| Table Type | Table Name |
|---|---|
| Fact Table | `gold.fact_sales` |
| Dimension Table | `gold.dim_customers` |
| Dimension Table | `gold.dim_products` |

---

# Project Objectives

- Explore and understand the dataset structure
- Analyze customer purchasing behavior
- Identify high-performing and low-performing products
- Generate customer and product KPIs
- Analyze sales trends over time
- Build reusable analytical SQL views
- Practice advanced SQL concepts on real-world business scenarios

---

# Reporting Views Created

| View Name | Purpose |
|---|---|
| `gold.report_customers` | Customer behavior and KPI analysis |
| `gold.report_products` | Product performance and revenue analysis |

These views simplify reporting and can directly support Power BI dashboards and business reporting solutions.

---

# Customer Report Analysis

## Purpose
The customer report consolidates customer transaction history, purchasing behavior, segmentation, and customer KPIs into a single analytical view.

---

## Customer Metrics

| KPI | Description |
|---|---|
| `total_orders` | Total unique orders placed |
| `total_sales` | Total revenue generated |
| `total_quantity` | Total quantity purchased |
| `total_product` | Unique products purchased |
| `lifespan` | Customer activity duration in months |
| `recency` | Months since last order |
| `avg_order_value` | Average revenue per order |
| `avg_monthly_spend` | Average monthly customer spending |

---

## Customer Segmentation

Customers are segmented based on sales performance and relationship duration.

| Segment | Criteria |
|---|---|
| VIP | Lifespan ≥ 12 months and Sales > 5000 |
| Regular | Lifespan ≥ 12 months and Sales ≤ 5000 |
| New | Lifespan < 12 months |

---

## Age Group Classification

| Age Group | Criteria |
|---|---|
| Under 20 | Age < 20 |
| 20-29 | Age between 20 and 29 |
| 30-39 | Age between 30 and 39 |
| 40-49 | Age between 40 and 49 |
| 50 and above | Age ≥ 50 |

---

# Product Report Analysis

## Purpose
The product report consolidates product-level sales performance, customer reach, and revenue metrics into a reusable analytical reporting view.

---

## Product Metrics

| KPI | Description |
|---|---|
| `total_order` | Total unique orders |
| `total_customers` | Unique customers purchasing the product |
| `total_sales` | Total product revenue |
| `total_quantity` | Total quantity sold |
| `lifespan` | Product selling duration in months |
| `avg_selling_price` | Average selling price per unit |
| `avg_order_revenue` | Average revenue generated per order |
| `avg_monthly_revenue` | Average monthly product revenue |
| `recency_in_months` | Months since last product sale |

---

## Product Segmentation

Products are categorized based on total revenue generated.

| Segment | Criteria |
|---|---|
| High-Performer | Sales > 50000 |
| Mid-Range | Sales between 10000 and 50000 |
| Low-Performer | Sales < 10000 |

---

# Business Questions Answered

| Business Question | SQL Concept Used |
|---|---|
| Which products generate the highest sales? | Aggregation |
| Which customers spend the most money? | GROUP BY |
| Which countries generate the most revenue? | Joins + Aggregation |
| Which products underperform? | Ranking & KPI Analysis |
| What are the monthly and yearly sales trends? | Date Functions |
| Which customers are most valuable? | Customer Segmentation |
| Which products have the highest customer reach? | Distinct Counts |

---

# SQL Concepts Used

## Data Exploration
- `SELECT`
- `DISTINCT`
- `WHERE`
- `ORDER BY`

---

## Aggregations
- `SUM()`
- `AVG()`
- `COUNT()`
- `MIN()`
- `MAX()`
- `GROUP BY`
- `HAVING`

---

## Joins
- `INNER JOIN`
- `LEFT JOIN`

---

## Advanced SQL Concepts
- Common Table Expressions (CTEs)
- Views
- Analytical Reporting
- Business KPI Calculations
- Data Transformation
- Window Functions
- Ranking Functions
- Stored Procedures

---

# Functions Used

| Function | Purpose |
|---|---|
| `SUM()` | Aggregation |
| `COUNT()` | Counting records |
| `AVG()` | Average calculations |
| `MAX()` | Latest transaction date |
| `MIN()` | Earliest transaction date |
| `DATEDIFF()` | Time calculations |
| `ROUND()` | Decimal formatting |
| `NULLIF()` | Prevent divide-by-zero errors |
| `CONCAT()` | Full name generation |

---

# Example SQL Query

## Top Performing Products

```sql
SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_sales DESC;
```

---

## Yearly Product Sales

```sql
WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY
        YEAR(f.order_date),
        p.product_name
)

SELECT *
FROM yearly_product_sales;
```

---

# Data Engineering & Reporting Practices

## Data Cleaning
- Removed records with NULL order dates
- Prevented divide-by-zero errors using `NULLIF()`

---

## Business Logic Implementation
- Customer segmentation logic
- Product segmentation logic
- Revenue categorization
- Age group classification
- Customer lifecycle analysis

---

## Reporting Optimization
The reporting views were designed to:
- Simplify dashboard development
- Improve reporting consistency
- Standardize KPI calculations
- Reduce repeated query writing
- Enable reusable reporting structures

---

# Key Insights Generated

- Identified top revenue-generating products
- Found high-value and loyal customers
- Analyzed customer purchasing patterns
- Evaluated product performance by revenue
- Discovered underperforming products
- Measured customer recency and retention
- Analyzed monthly and yearly sales behavior

---

# Tools & Technologies

| Tool | Purpose |
|---|---|
| SQL Server | Database & Analysis |
| T-SQL | Query Development |
| GitHub | Version Control |
| Power BI | Dashboard Visualization |

---

# Learning Outcomes

Through this project, I improved my understanding of:

- Writing complex SQL queries
- Building analytical reporting views
- Customer and product KPI generation
- Data aggregation and transformation
- SQL-based reporting architecture
- Business-oriented data analysis
- Structuring SQL portfolio projects
- Preparing datasets for BI dashboards

---

# Future Improvements

## Customer Analytics
- Add Customer Lifetime Value (CLV)
- Add churn analysis
- Add repeat purchase rate
- Add customer ranking using window functions

---

## Product Analytics
- Add profit margin analysis
- Add YoY sales growth
- Add seasonal trend analysis
- Add category-level rankings

---

# Author

**Your Name**

Data Analytics Enthusiast  
SQL | Power BI | Data Analysis
