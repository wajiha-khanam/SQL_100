-- Problem 6: Identify Users Who Took Rides in Multiple Cities in the Same Month

-- Problem Statement:
-- Find users who took rides in more than one city within the same calendar month in the last 6 months.

create database rides;
use rides;

CREATE TABLE user_rides (
ride_id INT,
user_id INT,
user_name VARCHAR(50),
city VARCHAR(50),
ride_date DATE
);
INSERT INTO user_rides VALUES
(1, 601, 'Alice', 'Chennai', '2025-02-15'),
(2, 601, 'Alice', 'Bangalore', '2025-02-20'),
(3, 602, 'Charlie', 'Chennai', '2025-03-10'),
(4, 602, 'Charlie', 'Chennai', '2025-03-15');

select * from user_rides;


select user_id, user_name, month(ride_date) as month, count(distinct city) as city_count
from user_rides
where ride_date >= curdate() - interval 6 month
group by user_id, user_name, month
having city_count > 1;
