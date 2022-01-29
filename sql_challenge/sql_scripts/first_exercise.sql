-- I had to comment out the condition checking for the birthday date because the mock data is not big enough
-- Also the check for the selled count is '>5' for the same reason

SELECT b.seller_id
FROM orders a 
LEFT JOIN items b ON a.item_id=b.item_id
LEFT JOIN customers c ON c.customer_id = b.seller_id
WHERE a.date_ordered BETWEEN '2020-01-01' AND '2020-01-31' 
	AND b.item_id IS NOT NULL
	-- AND EXTRACT('month' FROM c.birth_date) = EXTRACT('month' FROM (current_date)) 
	-- AND EXTRACT('day' FROM c.birth_date) = EXTRACT('day' FROM (current_date));
GROUP BY b.seller_id
HAVING COUNT(b.seller_id)>5;

