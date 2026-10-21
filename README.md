# ☕ Coffee Data Analysis with SQL

## Overview
This project uses SQL to analyze coffee shop sales data and explore purchasing patterns, revenue, and customer transaction behavior. I used PostgreSQL and DBeaver to organize the data into relational tables, transform the raw data, and write queries to answer business questions about coffee sales.

## Tools & Technologies
- **SQL (PostgreSQL)** — Data modeling, transformation, and analysis
- **DBeaver** — SQL development and database management

## Project Structure

```text
Coffee-Sales-Analysis/
├── Coffee Project.sql
├── create coffee sales info.sql
├── sqlquries.sql
└── README.md
```

### SQL Files

| File | Description |
|---|---|
| `Coffee Project.sql` | Creates the database schema and tables, including sales, coffee, payment, date, time, and staging tables. |
| `create coffee sales info.sql` | Loads staging data, populates the relational tables, creates a sales view, and runs data validation queries. |
| `sqlquries.sql` | Contains SQL queries that analyze sales trends, revenue, popular coffee types, payment methods, and transaction patterns. |

## Database Design

The project organizes coffee sales data into related tables to make analysis easier and reduce data duplication.

- **coffee** — Stores unique coffee names.
- **payment** — Stores payment methods.
- **date_dim** — Stores dates and calendar attributes, including weekdays and months.
- **time_dim** — Stores transaction times, hours, and time-of-day categories.
- **category** — Stores coffee category information.
- **coffee_category** — Connects coffee types to categories.
- **sales** — Stores transaction amounts and links each sale to its coffee, payment method, date, and time.
- **staging_coffee** — Temporarily holds the source data before it is transformed and loaded into the relational tables.

A `coffee_sales_view` combines information from the sales, coffee, payment, date, and time tables for easier querying.

## Data Preparation
I used SQL to:
- Create a relational database schema with primary and foreign keys.
- Load source data into a staging table.
- Populate dimension tables with distinct coffee types, payment methods, dates, and times.
- Join the tables to associate each transaction with the correct coffee, payment method, date, and time.
- Create a reusable view for transaction-level analysis.
- Validate the data using row counts and sample queries.

## Analysis Questions

The project explores 23 business questions, including:

- What is the total revenue from coffee sales?
- Which coffee types sell most frequently?
- Which coffee types generate the highest revenue?
- What are the busiest weekdays for morning sales?
- Which hours and times of day have the most transactions?
- How does revenue change throughout the day and across months?
- Which coffee is most popular in each month?
- Which coffee types generate the most revenue by payment method?
- What is the average spending per transaction?
- What are the highest and lowest transaction amounts?

## SQL Concepts Used
- `SELECT`, `WHERE`, `ORDER BY`, and `DISTINCT`
- Aggregate functions such as `SUM()`, `COUNT()`, `AVG()`, `MIN()`, and `MAX()`
- `GROUP BY` and `HAVING`-style analytical workflows
- `JOIN` operations across related tables
- Subqueries and common table relationships
- Window functions, including `ROW_NUMBER()`
- Database schemas, primary keys, and foreign keys
- Views, data loading, and validation queries

## Key Takeaways
This project strengthened my ability to design relational databases, prepare data for analysis, and use SQL to investigate business questions. It also gave me practical experience connecting transaction data across multiple tables to analyze sales performance and purchasing patterns.

---

*Built as a hands-on SQL and data analytics project using PostgreSQL and DBeaver.*

