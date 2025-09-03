-- Problem 14: Identify Drivers With Consistently High Ratings but Low Number of Rides

-- Problem Statement:
-- Find drivers who have an average rating above 4.8 but completed less than 20 rides in the last 3 month.

use rides;

CREATE TABLE driver_ratings (
driver_id INT,
driver_name VARCHAR(50),
ride_id INT,
rating DECIMAL(2,1),
ride_date DATE
);
INSERT INTO driver_ratings VALUES
(501, 'John', 1, 4.9, '2025-06-01'),
(501, 'John', 2, 5.0, '2025-06-03'),
(502, 'Jane', 3, 4.7, '2025-06-05'),
(503, 'Shaily', 4, 4.9, '2025-06-07');

select * from driver_ratings;


select driver_id, driver_name, 
avg(rating) as avg_rating, 
count(rating) as ride_count
from driver_ratings
where ride_date >= curdate() - interval 3 month
group by driver_id, driver_name
having avg_rating > 4.8 and 
ride_count < 20 ;