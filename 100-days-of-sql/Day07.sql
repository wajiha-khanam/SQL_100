-- Problem 7: Identify Customers Who Paid Cash for All Rides in the Last 6 Months

-- Problem Statement:
-- Find customers who paid cash for every ride in the last 6 months (no digital payments).

create database ride_payments;
use ride_payments;

CREATE TABLE ride_payments (
payment_id INT,
customer_id INT,
customer_name VARCHAR(50),
payment_mode VARCHAR(20),
ride_date DATE
);
INSERT INTO ride_payments VALUES
(1, 701, 'Alice', 'Cash', '2025-01-10'),
(2, 701, 'Alice', 'Cash', '2025-03-05'),
(3, 702, 'Charlie', 'Credit Card', '2025-02-15'),
(4, 702, 'Charlie', 'Cash', '2025-04-20');

select * from ride_payments;


select customer_id, Customer_name
from ride_payments
where ride_date >= curdate() - interval 6 month
group by customer_id, Customer_name
having sum('payment_mode' != 'Cash') = 0;