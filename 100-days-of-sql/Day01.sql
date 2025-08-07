create database sql_100;
use sql_100;

-- Problem 1: Find Zomato Customers Who Ordered More Than 5 Times but Rated Only Once

-- Problem Statement:
-- Identify customers who placed more than 5 orders but gave ratings for only one order in the last 6 months.


CREATE TABLE zomato_orders (
order_id INT,
customer_id INT,
customer_name VARCHAR(50),
order_date DATE
);

CREATE TABLE zomato_ratings (
rating_id INT,
customer_id INT,
rating INT,
rating_date DATE
);

INSERT INTO zomato_orders VALUES
(1, 1001, 'Gowtham', '2025-01-01'),
(2, 1001, 'Gowtham', '2025-01-10'),
(3, 1001, 'Gowtham', '2025-01-20'),
(4, 1001, 'Gowtham', '2025-02-01'),
(5, 1001, 'Gowtham', '2025-02-15'),
(6, 1001, 'Gowtham', '2025-02-25');

INSERT INTO zomato_ratings VALUES
(1, 1001, 4, '2025-01-10');

with cte as(
select customer_id, count(order_id) as order_count
from zomato_orders
group by customer_id
), cte2 as (
select customer_id, count(rating_id) as rating_count
from zomato_ratings
where rating_date >= curdate() - interval 6 month
group by customer_id
)
select ct.customer_id
from cte ct
left join cte2 as ct2 on ct.customer_id = ct2.customer_id
where ct.order_count > 5 and coalesce(ct2.rating_count,0) = 1;




