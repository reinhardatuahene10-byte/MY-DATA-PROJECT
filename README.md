# Global Electronics Retailer 2016–2021 — Sales & Profitability Analysis

## Project Overview

This project analyzes sales and profitability performance for a global electronics retailer from 2016 to 2021.

The analysis was conducted using SQL in Google BigQuery and Microsoft Excel 365 to investigate sales trends, seasonality, geographical performance, sales channels, product categories, profitability, and delivery performance.

The project focuses on turning raw transactional data into meaningful business insights that can support management decision-making.

## Project Objective

The objective of this project was to investigate key business questions around the company's sales and profitability performance, including:

* How sales and order volume changed over time
* How sales performance varied by month and year
* How online sales compared with in-store sales
* How performance varied across countries and continents
* Which product categories contributed most to revenue and gross profit
* How profitability varied across geographical markets
* How delivery performance changed over time

## Dataset

**Source:** Maven Analytics — Global Electronics Retailer dataset

The original dataset contained **five related tables**. Four tables were used in this analysis based on the business questions and metrics investigated:

* **Sales Table** — transaction and order information
* **Products Table** — product categories, prices, and costs
* **Customers Table** — customer and geographical information
* **Stores Table** — store and sales-channel information

The fifth table was part of the original dataset but was not required for the analyses conducted in this project.

The tables used in the analysis were joined using their relevant keys to support multi-table business analysis.

## Tools & Technologies

* **Google BigQuery**
* **SQL**
* **Microsoft Excel 365**

## Key Metrics

The analysis calculated and evaluated:

* **Revenue** — Quantity × Unit Price USD
* **Gross Profit** — Revenue − Cost
* **Profit Margin** — Gross Profit ÷ Revenue × 100
* **Order Volume** — `COUNT(DISTINCT Order Number)`
* **Average Order Value (AOV)** — Revenue ÷ `COUNT(DISTINCT Order Number)`
* **Delivery Time** — Difference between Delivery Date and Order Date

Orders are counted using distinct Order Numbers because an individual order can contain multiple product records. This prevents order volume and AOV calculations from being overstated.

## Analysis Performed

### Sales Trends & Seasonality

Analyzed yearly and monthly sales performance to identify changes in revenue, order volume, customer activity, and seasonal patterns.

### Online vs. In-Store Performance

Compared online and in-store sales performance using order volume, revenue, and average order value.

### Geographical Performance

Analyzed revenue, order volume, gross profit, profit margin, and revenue contribution across countries and continents.

### Product Category Performance

Evaluated product categories and subcategories to identify major contributors to **revenue and gross profit** and understand differences in overall sales performance.

### Profitability Analysis

Compared revenue, cost, gross profit, and profit margins across different geographical and product segments.

### Delivery Performance

Analyzed delivery times and delivery performance over time, excluding orders with missing delivery dates.

## Key Findings

The analysis identified important differences in sales scale, order volume, revenue contribution, profitability, product-category performance, sales channels, geographical markets, and delivery performance.

For example, **North America generated $34.59M in revenue and $20.25M in gross profit, contributing 62.05% of total company revenue and recording the highest order volume among the three continents.**

Profit margins across the three continents were relatively consistent, ranging from **58.52% to 58.98%**. This indicates that North America's higher total gross profit was primarily associated with its larger revenue and order volume rather than a materially higher profit margin.

Within North America, **Computers generated $11.97M in revenue**, making it an important contributor to the region's overall sales performance.

Additional findings from the analysis are documented in the project workbook.

## Excel Dashboard

The project includes an interactive Excel dashboard presenting:

* Yearly sales and order trends
* Revenue by country
* Revenue by sales channel
* Monthly revenue trends
* Revenue and gross profit by product category
* Total revenue
* Total orders
* Gross profit
* Profit margin

## What This Project Demonstrates

This project demonstrates practical experience in:

* SQL querying and analysis
* Working with multiple related tables
* SQL joins and aggregations
* Distinct-order analysis
* Revenue and profitability calculations
* Year-over-year and seasonal analysis
* Business performance investigation
* Data interpretation and insight generation
* Microsoft Excel analysis and dashboard development
* Translating analytical results into management-focused findings

## Conclusion

This project demonstrates an end-to-end approach to business data analysis, from working with related transactional data in BigQuery to investigating business questions and presenting the results through an interactive Excel dashboard and management-focused findings.

The project is part of my data analytics portfolio and reflects my practical application of **SQL, Google BigQuery, Microsoft Excel, data analysis, and business insight generation**.
