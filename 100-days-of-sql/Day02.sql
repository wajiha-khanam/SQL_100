-- Problem 2: Find Flipkart Customers Who Purchased Products in More Than 3 Categories

-- Problem Statement:
-- Identify customers who bought products from more than 3 different categories in the last year.


create database flipkart_purchase;
use flipkart_purchase;

CREATE TABLE flipkart_purchases (
purchase_id INT,
customer_id INT,
customer_name VARCHAR(50),
product_category VARCHAR(50),
purchase_date DATE
);
INSERT INTO flipkart_purchases VALUES
(1, 201, 'Bob', 'Electronics', '2024-09-10'),
(2, 201, 'Bob', 'Books', '2024-10-15'),
(3, 201, 'Bob', 'Fashion', '2025-01-20'),
(4, 201, 'Bob', 'Home & Kitchen', '2025-03-10');

select customer_id, customer_name, count(distinct product_category) as category_count
from flipkart_purchases
where purchase_date >= curdate() - interval 12 month
group by customer_id, customer_name
having category_count > 3;