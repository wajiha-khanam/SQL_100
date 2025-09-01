-- Problem 13: Find Customers Who Cancelled More Than 5 Rides But Have a High Completion Rate

-- Problem Statement:
-- Identify customers who have cancelled more than 5 rides but maintain a completion rate above 80% in the last 8 months.

use rides;

CREATE TABLE customer_ride_status (
ride_id INT,
customer_id INT,
customer_name VARCHAR(50),
ride_status VARCHAR(20), -- 'Completed' or 'Cancelled'
ride_date DATE
);

INSERT INTO customer_ride_status VALUES
	(1, 1001, 'Alice', 'Completed', '2025-01-10'),
	(2, 1001, 'Alice', 'Cancelled', '2025-02-15'),
	(3, 1001, 'Alice', 'Cancelled', '2025-03-20'),
	(4, 1001, 'Alice', 'Completed', '2025-04-05'),
	(5, 1002, 'Bob', 'Cancelled', '2025-01-10'),
	(6, 1002, 'Bob', 'Cancelled', '2025-02-20'),
	(7, 1002, 'Bob', 'Completed', '2025-03-15');

select * from customer_ride_status;


with cte as (
select customer_id, customer_name,
sum(case when ride_status = 'Cancelled' then 1 else 0 end) as cancelled_count,
sum(case when ride_status = 'Completed' then 1 else 0 end)*100.0/count(*) completion_rate
from customer_ride_status
where ride_date >= curdate() - interval 8 month
group by customer_id, customer_name
)
select customer_id, customer_name
from cte
where cancelled_count > 5 and completion_rate > 80;
