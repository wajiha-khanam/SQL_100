-- Problem 9: Identify Users Who Spent More Than ₹10,000 on Rides Last 3 Month

-- Problem Statement:
-- Find users who spent over ₹10,000 on rides in the last 3 month.

use ride2;

CREATE TABLE user_ride_payments (
payment_id INT,
user_id INT,
user_name VARCHAR(50),
amount_paid DECIMAL(10,2),
payment_date DATE
);
INSERT INTO user_ride_payments VALUES
(1, 901, 'John', 3500.00, '2025-06-05'),
(2, 901, 'John', 7000.00, '2025-06-20'),
(3, 902, 'Mili', 5000.00, '2025-06-15'),
(4, 902, 'Mili', 3000.00, '2025-06-18');


select * from user_ride_payments;


select user_id, user_name
from user_ride_payments
where payment_date >= curdate() - interval 3 month
group by user_id, user_name
having sum(amount_paid) > 10000;