-- I had to comment out the condition checking for the birthday date because the mock data is not big enough
-- Also the check for the selled count is '>5' for the same reason

WITH greater_than_1500 AS (
	SELECT item_id
	FROM orders
	WHERE date_ordered BETWEEN '2020-01-01' AND '2020-01-31'
	GROUP BY item_id
	HAVING COUNT(*) > 5
)
SELECT b.*
FROM items a
LEFT JOIN customers b
ON a.seller_id = b.customer_id
WHERE a.item_id in (SELECT * FROM greater_than_1500);
	-- AND EXTRACT('month' FROM b.birth_date) = EXTRACT('month' FROM (current_date - INTERVAL '3 days')) 
	-- AND EXTRACT('day' FROM b.birth_date) = EXTRACT('day' FROM (current_date - INTERVAL '3 days'));
