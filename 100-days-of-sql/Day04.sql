-- Problem 4: Find Zomato Customers Who Ordered Only on Weekends in Last 3 Months

-- Problem Statement:
-- Identify customers who placed orders only on Saturdays and Sundays in the last 3 months.

create database zomato;
use zomato;

CREATE TABLE zomato_orders (
order_id INT,
customer_id INT,
customer_name VARCHAR(50),
order_date DATE
);
INSERT INTO zomato_orders VALUES
(1, 1001, 'David', '2025-04-05'), -- Saturday
(2, 1001, 'David', '2025-04-06'), -- Sunday
(3, 1001, 'David', '2025-04-12'); -- Saturday


select distinct customer_id, customer_name
from zomato_orders
where order_date >= curdate() - interval 3 month
group by customer_id, customer_name
having count(*) = sum(
case when dayofweek(order_date) in (1,7) then 1 else 0 end);

