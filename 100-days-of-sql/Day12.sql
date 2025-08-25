-- Problem 12: Identify Customers with Increasing Monthly Ride Counts Over Last 6 Months

-- Problem Statement:
-- Find customers whose number of rides increased every month for the last 6 months.

use rides;

CREATE TABLE monthly_rides (
customer_id INT,
customer_name VARCHAR(50),
ride_date DATE
);
INSERT INTO monthly_rides VALUES
(1, 'Alice', '2024-12-15'),
(1, 'Alice', '2025-01-20'),
(1, 'Alice', '2025-02-10'),
(1, 'Alice', '2025-03-25'),
(2, 'Bob', '2024-12-01'),
(2, 'Bob', '2025-01-05');

select * from monthly_rides;

with cte as (
select customer_id, customer_name, month(ride_date) as ride_month, count(*) as ride_count
from monthly_rides
where ride_date >= curdate() - interval 12 month
group by customer_id, customer_name, month(ride_date)
order by customer_id, ride_month
), cte2 as (
select customer_id, customer_name, ride_month, ride_count,
lag(ride_count) over(partition by customer_id order by ride_month) as prev_month_ride_count
from cte 
)
select distinct customer_id, customer_name
from cte2 
group by customer_id, customer_name
having min(ride_count > prev_month_ride_count) = 1;
