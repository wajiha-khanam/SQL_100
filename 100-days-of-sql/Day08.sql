-- Problem 8: List Drivers with Highest Cancellation Rates in the Last Month

-- Problem Statement:
-- Identify drivers with the highest cancellation rates (percentage of cancelled rides to total rides) in the last 3 month.

create database ride2;
use ride2;

CREATE TABLE driver_ride_status (
ride_id INT,
driver_id INT,
driver_name VARCHAR(50),
ride_status VARCHAR(20),
ride_date DATE
);

INSERT INTO driver_ride_status VALUES
(1, 801, 'John', 'Completed', '2025-06-01'),
(2, 801, 'John', 'Cancelled', '2025-06-02'),
(3, 802, 'Bella', 'Cancelled', '2025-06-01'),
(4, 802, 'Bella', 'Cancelled', '2025-06-05'),
(5, 802, 'Bella', 'Completed', '2025-06-10');

select * from driver_ride_status;


select driver_id, (sum(case when ride_status = 'Cancelled' then 1 end)) * 100.0/count(*) 
as cancelled_percentage
from driver_ride_status
where ride_date >= curdate() - interval 3 month
group by driver_id
order by cancelled_percentage desc
limit 10;


