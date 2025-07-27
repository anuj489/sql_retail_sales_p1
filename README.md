# 📊 Retail Sales Analysis

## 🏷️ Project Title: Retail Sales Analysis

**Database**: `p1_retail_db`

---

## 📜 Project Overview

This SQL-based project demonstrates essential data analysis techniques by exploring and analyzing retail sales data. The project is structured to help beginner data analysts learn SQL skills like database creation, data cleaning, EDA, and answering business questions using queries.

---

## 🌟 Objectives

* Set up a retail sales database with appropriate schema.
* Clean the data by identifying and removing null values.
* Perform exploratory data analysis (EDA).
* Solve real-world business problems using SQL.

---

## 🗂️ Project Structure

### 1. 🛠️ Database Setup

#### ✅ Create Database:

```sql
CREATE DATABASE p1_retail_db;
USE p1_retail_db;
```

#### ✅ Create Table:

```sql
CREATE TABLE [data 1] (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

### 2. 🔍 Data Exploration & Cleaning

#### 🔸 View Sample Data:

```sql
SELECT TOP 10 * FROM [dbo].[data 1];
```

#### 🔸 Count Total Records:

```sql
SELECT COUNT(*) FROM [dbo].[data 1];
```

#### 🔸 Count Unique Customers:

```sql
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM [dbo].[data 1];
```

#### 🔸 Count Unique Categories:

```sql
SELECT COUNT(DISTINCT category) AS total_categories FROM [dbo].[data 1];
```

#### 🔸 Check for NULL Values:

```sql
SELECT * FROM [dbo].[data 1]
WHERE
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
```

#### 🔸 Delete Rows with NULLs:

```sql
DELETE FROM [dbo].[data 1]
WHERE
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantity IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
```

---

### 3. 📈 Business Questions & SQL Solutions

#### Q1. Sales on '2022-11-05':

```sql
SELECT * FROM [dbo].[data 1] WHERE sale_date = '2022-11-05';
```

#### Q2. Clothing transactions with quantity > 4 in Nov 2022:

```sql
SELECT * FROM [dbo].[data 1]
WHERE category = 'Clothing'
  AND FORMAT(sale_date, 'yyyy-MM') = '2022-11'
  AND quantity > 4;
```

#### Q3. Total sales and number of orders by category:

```sql
SELECT category, SUM(total_sale) AS total_sales, COUNT(*) AS total_orders
FROM [dbo].[data 1]
GROUP BY category;
```

#### Q4. Average age of customers in 'Beauty' category:

```sql
SELECT AVG(age) AS avg_age
FROM [dbo].[data 1]
WHERE category = 'Beauty';
```

#### Q5. Transactions where total\_sale > 1000:

```sql
SELECT * FROM [dbo].[data 1]
WHERE total_sale > 1000;
```

#### Q6. Number of transactions by gender and category:

```sql
SELECT gender, category, COUNT(transactions_id) AS total_transactions
FROM [dbo].[data 1]
GROUP BY gender, category
ORDER BY gender;
```

#### Q7. Best selling month by average sale per year:

```sql
SELECT year, month, avg_total_sale
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_total_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM [dbo].[data 1]
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t
WHERE rank = 1;
```

#### Q8. Top 5 customers by total sales:

```sql
SELECT TOP 5 customer_id, SUM(total_sale) AS total_sales
FROM [dbo].[data 1]
GROUP BY customer_id
ORDER BY total_sales DESC;
```

#### Q9. Unique customers per category:

```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM [dbo].[data 1]
GROUP BY category;
```

#### Q10. Sales shift classification (Morning, Afternoon, Evening):

```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN DATEPART(hour, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(hour, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM [dbo].[data 1]
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

---

## 🏁 Final Notes

This project demonstrates foundational SQL skills including:

* Table creation
* NULL handling
* Data aggregation
* Time-based filtering
* Ranking and grouping techniques

