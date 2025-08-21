-- Problem 10: Gowtham Wants to Find Customers Who Used Only Bike Rides for 2 Months Continuously

-- Problem Statement:
-- Find customers who used only bike rides (no car or other vehicle types) for 2 consecutive months in the last 8 months.

use rides;

CREATE TABLE ride_types (
ride_id INT,
customer_id INT,
customer_name VARCHAR(50),
ride_date DATE,
vehicle_type VARCHAR(20) -- e.g., 'Bike', 'Car', 'Auto'
);
INSERT INTO ride_types VALUES
(1, 1001, 'Alice', '2025-01-15', 'Bike'),
(2, 1001, 'Alice', '2025-02-10', 'Bike'),
(3, 1001, 'Alice', '2025-03-05', 'Car'),
(4, 1002, 'Bob', '2025-01-20', 'Bike'),
(5, 1002, 'Bob', '2025-02-25', 'Bike');


select * from ride_types;

with cte as (
select customer_id, customer_name,
month(ride_date) as ride_month
from ride_types
where ride_date >= curdate() - interval 8 month
group by customer_id, customer_name, month(ride_date) 
having sum(case when vehicle_type <> 'Bike' then 1 else 0 end) = 0
)
select distinct ct.customer_id, ct.customer_name
from cte ct 
join cte ct1 on ct.customer_id = ct1.customer_id 
and ct1.ride_month = ct.ride_month + 1 
