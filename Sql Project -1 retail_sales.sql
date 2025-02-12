create database sql_project_1;
use sql_project_1;
create table retail_sales(transactions_id int ,
						sale_date date,
                        sales_time time,
                        customer_id	int,
                        gender varchar(10),
                        age int,
				        category varchar(20),
                        quantiy varchar(10),
                        price_per_unit	float,
                        cogs float,
                        total_sale float);
                        
select * from retail_sales;

select * from retail_sales
where 
transactions_id is null or
sale_date is null or
sales_time is null or
customer_id is null or
gender is null or
age is null or
category is null or 
quantiy is null or
price_per_unit is null or
cogs is null or
total_sale is null;


--  Data Exploration
-- How many sales we have
 select count(total_sale) from retail_sales;
 
 -- How many unique customers we have
 select count(distinct customer_id) from retail_sales;
 
 -- How many unique Categories we have ?
 
 select count(distinct category) from retail_sales;
 
 -- Data Analysis
 
 -- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'
 select * from retail_sales
 where sale_date ='2022-11-05';
 
 -- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022?
 
 select transactions_id from retail_sales
 where category='clothing' and quantiy >4
 and sale_date BETWEEN '2020-11-01' AND '2020-11-30';
 
 SELECT *  
FROM retail_sales  
WHERE category = 'Clothing'  
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'  
  AND quantiy >= 4;
  
  -- 3.Write a SQL query to calculate the total sales (total_sale) for each category
  select category,sum(total_sale) as net_sales from retail_sales
  group by category;
  
  
  -- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
  select avg(age) as customer_age
  from retail_sales
 where Category='Beauty';
 
 -- 5.Write a SQL query to find all transactions where the total_sale is greater than 1000
 select transactions_id from retail_sales
 where total_sale > 1000;
 
 -- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
select gender,category,count(*) as total_transactions 
from retail_sales
group by gender,category
order by gender;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
 
SELECT year, month, avg_sale  
FROM (  
    SELECT  
        EXTRACT(YEAR FROM sale_date) AS year,  
        EXTRACT(MONTH FROM sale_date) AS month,  
        AVG(total_sale) AS avg_sale,  
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rnk  
    FROM retail_sales  
    GROUP BY year, month  
) AS ranked_sales  
WHERE rnk = 1;

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales 
select customer_id,sum(total_sale) as total_sales
 from retail_sales
 group by customer_id
 order by total_sales desc
 limit 5;
 
 -- 9. Write a SQL query to find the number of unique customers who purchased items from each category
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- 10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sales_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sales_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
  



 

 
 



