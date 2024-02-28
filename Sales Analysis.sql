Create database Walmart;

CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6 , 4 ) NOT NULL,
    total DECIMAL(12 , 4 ) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10 , 2 ) NOT NULL,
    gross_margin_pct FLOAT(11 , 9 ),
    gross_income DECIMAL(12 , 4 ),
    rating FLOAT(2 , 1 )
);

use walmart;
SELECT 
    *
FROM
    sales;
    
   

alter table sales
add column Time_of_day varchar(10);

UPDATE sales 
SET 
    Time_of_day = (CASE
        WHEN Time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN TIme BETWEEN '12:00:01' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END);

alter table sales
add column Day_name varchar (10);

UPDATE sales 
SET 
    day_name = DAYNAME(date);

alter table sales
add column Month_name varchar (10);

UPDATE sales 
SET 
    Month_name = MONTHNAME(date);

SELECT DISTINCT
    (city)
FROM
    sales;

SELECT DISTINCT
    (branch), city
FROM
    sales
ORDER BY 1;

SELECT 
    COUNT(DISTINCT product_line)
FROM
    sales;

SELECT 
    payment, COUNT(payment)
FROM
    sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT 
    product_line, COUNT(product_line) AS Total
FROM
    sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT 
    Month_name, SUM(total) AS Total_revenue
FROM
    sales
GROUP BY 1
ORDER BY 2 DESC;

SELECT 
    Month_name, SUM(cogs) AS Total_COGS
FROM
    sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT 
    product_line, SUM(total) AS Total_revenue
FROM
    sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT 
    city, SUM(total) AS Total_revenue
FROM
    sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT 
    product_line, SUM(Tax_pct) AS Total_VAT
FROM
    sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


SELECT 
    product_line,
    AVG(total) AS AVG_sales,
    (CASE
        WHEN
            (SELECT 
                    AVG(total)
                FROM
                    sales) < AVG(total)
        THEN
            'Good'
        ELSE 'Bad'
    END) AS remark
FROM
    sales
GROUP BY 1;

SELECT 
    branch, AVG(quantity)
FROM
    sales
GROUP BY 1
HAVING AVG(quantity) > (SELECT 
        AVG(quantity)
    FROM
        sales);


SELECT 
    Gender, product_line, COUNT(gender) AS 'Count'
FROM
    sales
GROUP BY 1 , 2
ORDER BY 3 DESC;

SELECT 
    product_line, ROUND(AVG(rating), 2) AS Avg_Rating
FROM
    sales
GROUP BY 1
ORDER BY 2 DESC;



/* Sales Question */

Select * from sales;

Select time_of_day ,Count(invoice_id) as Total_sales
from sales
group by 1
order by 2 ;

Select customer_type ,round(sum(total),2) as Total_revenue
from sales
group by 1 
order by 2 desc
limit 1;


Select city ,round(sum(tax_pct),2) as Total_VAT
from sales
group by city
order by 2 desc ;


Select customer_type ,round(Sum(tax_pct),2) as Total_VAT
from sales
group by 1
order by 2 desc
limit 1;

/* Customer Question */

select * from sales;

select distinct(customer_type) from sales;

select distinct(payment) from sales;

Select customer_type, count(customer_type) As Total
from sales 
group by 1
order by 2 desc
limit 1;

select Gender, count(gender) as Total_customer 
from sales
group by 1;

select branch , gender , count(*) 
from sales
group by 1,2
ORDER BY 1;


SELECT time_of_day ,round(avg(rating),2) As Most_rating
from sales
group by 1
order by 2 desc;

with cte as (Select Branch,TIme_of_day,round(avg(rating),2) as Avg_rating,
row_number() over (partition by branch order by round(avg(rating),2) desc)  as 'Count'
from sales
group by 1,2)
select Branch,TIme_of_day,avg_rating
from cte
where  count = 1;

select day_name, round(avg(rating),2) as Avg_rating
from sales
group by 1
order by 2 desc;


with cte as (Select Branch,day_name,round(avg(rating),2) as Avg_rating,
row_number() over (partition by branch order by round(avg(rating),2) desc)  as 'Count'
from sales
group by 1,2)
select Branch,day_name,avg_rating
from cte
where  count = 1;






