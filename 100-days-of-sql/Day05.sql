-- Problem 5: Find Flipkart Customers Who Returned More Than 20% of Orders in Last 6 Months

-- Problem Statement:
-- Identify customers who had a return rate greater than 20% of their total orders in the last 6 months.

create database flipkart_orders;
use flipkart_orders;

CREATE TABLE flipkart_orders (
order_id INT,
customer_id INT,
customer_name VARCHAR(50),
order_status VARCHAR(20),
order_date DATE
);
INSERT INTO flipkart_orders VALUES
(1, 501, 'Alice', 'Delivered', '2025-01-10'),
(2, 501, 'Alice', 'Returned', '2025-02-10'),
(3, 501, 'Alice', 'Delivered', '2025-03-15'),
(4, 502, 'Bob', 'Delivered', '2025-01-20'),
(5, 502, 'Bob', 'Returned', '2025-02-25');

select * from flipkart_orders;

with cte as (
select customer_id, count(order_id) as total_order_count
from flipkart_orders
where order_date >= curdate() - interval 6 month 
group by customer_id
)
select f.customer_id, count(f.order_id)*100.0/ct.total_order_count as return_rate
from flipkart_orders f
join cte ct on ct.customer_id = f.customer_id
where order_status = 'Returned' and f.order_date >= curdate() - interval 6 month 
group by customer_id
having return_rate > 20;
