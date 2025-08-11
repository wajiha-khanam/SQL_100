-- Problem 3: Identify Dating App Users Who Matched With More Than 5 Users But Sent Messages to Less Than 3

-- Problem Statement:
-- Find users who matched with more than 5 users but sent messages to less than 3 of them in the last 3 months.

create database matches;
use matches;

CREATE TABLE matches (
match_id INT,
user_id INT,
matched_user_id INT,
match_date DATE
);
CREATE TABLE messages (
message_id INT,
sender_id INT,
receiver_id INT,
message_date DATE
);

insert into matches VALUES
(1, 301, 401, '2025-01-01'),
(2, 301, 402, '2025-01-05'),
(3, 301, 403, '2025-01-10'),
(4, 301, 404, '2025-01-15'),
(5, 301, 405, '2025-01-20'),
(6, 301, 406, '2025-01-25');

INSERT INTO messages VALUES
(1, 301, 401, '2025-01-10'),
(2, 301, 402, '2025-01-15');

select * 
from messages;

with cte as (
select user_id, count(match_id) as match_count
from matches 
where match_date >= curdate()-interval 3 month
group by user_id
), cte2 as(
select sender_id, count(distinct receiver_id) as messages_sent
from messages
where message_date >= curdate()-interval 3 month
group by sender_id
)
select ct.user_id
from cte as ct
left join cte2 as ct2 on ct.user_id = ct2.sender_id
where ct.match_count > 5 and coalesce(ct2.messages_sent ,0) < 3;




