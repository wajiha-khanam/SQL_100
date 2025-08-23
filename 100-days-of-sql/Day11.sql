-- Problem 11: Find Customers Who Referred Friends Frequently but Had Low Ride Activity

-- Problem Statement:
-- Identify customers who referred more than 5 friends in the last year but completed less than 10 rides.

create database rides;
use rides;

CREATE TABLE referrals (
referral_id INT,
customer_id INT,
referral_date DATE
);

CREATE TABLE rides (
ride_id INT,
customer_id INT,
ride_status VARCHAR(20),
ride_date DATE
);
INSERT INTO referrals VALUES
(1, 1001, '2024-08-01'),
(2, 1001, '2024-09-15'),
(3, 1002, '2024-10-20');
INSERT INTO rides VALUES
(1, 1001, 'Completed', '2025-01-10'),
(2, 1001, 'Completed', '2025-02-12'),
(3, 1002, 'Completed', '2025-03-15');

select * from rides;
select * from referrals;

with cte as (
select customer_id,
count(*) as total_referrals
from referrals
where referral_date >= curdate() - interval 1 year
group by customer_id
), cte2 as (
select customer_id,
count(*) as total_rides
from rides
where ride_date >= curdate() - interval 1 year
and ride_status = 'Completed'
group by customer_id
)
select ct.customer_id,
    ct.total_referrals,
    COALESCE(ct2.total_rides, 0) AS total_rides
from cte ct
left join cte2 ct2 on ct.customer_id = ct2.customer_id
where ct.total_referrals > 5 and COALESCE(ct2.total_rides, 0) < 10;