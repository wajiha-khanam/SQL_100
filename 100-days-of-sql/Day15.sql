-- Problem 15: Find Customers Who Took Rides in Multiple Cities and Spent Over ₹5000 Last 4 Month

-- Problem Statement:
-- Find customers who took rides in more than one city and spent more than ₹5000 in the last 4 month.

use rides;

CREATE TABLE ride_payments (
payment_id INT,
customer_id INT,
customer_name VARCHAR(50),
city VARCHAR(50),
amount DECIMAL(10,2),
payment_date DATE
);
INSERT INTO ride_payments VALUES
(1, 1001, 'Alice', 'Chennai', 3000.00, '2025-06-05'),
(2, 1001, 'Alice', 'Bangalore', 2500.00, '2025-06-20'),
(3, 1002, 'Bob', 'Chennai', 2000.00, '2025-06-10');


select * from ride_payments;


select customer_id, customer_name, count(distinct city) as city_count, sum(amount) as total_spent
from ride_payments
where payment_date >= curdate() - interval 4 month
group by customer_id, customer_name
having count(distinct city) > 1 and sum(amount) > 5000;
