
create database sql_project_1

use sql_project_1

create table retail_sales(
	transactions_id	int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(15),
	age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs   Float,
	total_sale  Float

);

SELECT TOP 10 *
FROM [dbo].[data 1];

select 
   count(*) 
from [dbo].[data 1];

--
select * from [dbo].[data 1] where transactions_id is null

select * from retail_sales where(
     transactions_id is null 
	 or 
	 sale_date is null 
	 or
	 sale_time is null
	 or 
	 customer_id is null 
	 or 
	 gender is null 
	 or 
	 age is null 
	 or 
	 category is null 
	 or 
	 quantiy is null 
	 or 
	 price_per_unit is null
	 or 
	 cogs is null 
	 or 
	 total_sale is null
)

delete from [dbo].[data 1] where (

 transactions_id is null 
	 or 
	 sale_date is null 
	 or
	 sale_time is null
	 or 
	 customer_id is null 
	 or 
	 gender is null 
	 or 
	 age is null 
	 or 
	 category is null 
	 or 
	 quantiy is null 
	 or 
	 price_per_unit is null
	 or 
	 cogs is null 
	 or 
	 total_sale is null

)

-- DATA EXPLORATION
select count(*) as total_sale from [dbo].[data 1];

-- how many unique customers we have 

select count(distinct(customer_id)) as total_customer from  [dbo].[data 1];

-- how many categories we have 

select count(distinct(category)) as total_customer from  [dbo].[data 1];

-- Data analysis & business key problems & answers 

--Q1. write a sql query to retrieve all column for sales made on '2022-11-05'

select * from [dbo].[data 1] where sale_date='2022-11-05'


-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing'
-- and the quantity sold is more than 4 in the month of Nov-2022:

select * from [dbo].[data 1] 
where category ='Clothing' and format(sale_date,'yyyy-MM') ='2022-11' and quantiy >= 4;

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.

select sum(total_sale) as total_sale ,category , count(*) as total_orders from  [dbo].[data 1] group by category; 

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age) from [dbo].[data 1] where category='Beauty';

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from [dbo].[data 1] 
 where total_sale >1000

 --Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

 select gender,category, count(transactions_id) from [dbo].[data 1] group by gender, category order by 1

 --Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT year, month , avg_total_sale 
from (  
 select YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_total_sale,
	rank() over (partition by year(sale_date) order by AVG(total_sale) desc) as rank
FROM [dbo].[data 1]
GROUP BY YEAR(sale_date), MONTH(sale_date)  

) as t1 
where rank =1  ;

--Q8.Write a SQL query to find the top 5 customers based on the highest total sales **

select top 5
      customer_id ,
	  sum(total_sale)as total_sales

from [dbo].[data 1]
group by customer_id  order by 2 desc

-- Q9 .Write a SQL query to find the number of unique customers who purchased items from each category.:

select category, count(distinct customer_id)
  from [dbo].[data 1]
  group by category

-- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


with hourly_sale as (
select *,
    case 
	when datepart(hour,sale_time) <12  then 'Morning' 
	when datepart(hour,sale_time) between 12 and 17 then 'Afternoon' 
	else 'Evening'
	end as shift
from [dbo].[data 1]) 
select shift, count(*)as total_orders from hourly_sale

group by shift 
;



