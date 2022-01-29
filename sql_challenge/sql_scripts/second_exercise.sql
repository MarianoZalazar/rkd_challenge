WITH temp AS (
	SELECT 
		c.seller_id, 
		EXTRACT(year FROM a.date_ordered) years,
		EXTRACT(month FROM a.date_ordered) months,
		d.first_name,
		d.last_name,
		COUNT(a.order_id) sales_count,
		COUNT(c.item_id) items_count,
		SUM(c.price_per_unit*a.quantity) amount_sold,
		ROW_NUMBER() OVER (PARTITION BY EXTRACT(month FROM a.date_ordered) ORDER BY SUM(c.price_per_unit*a.quantity) DESC) rank
	FROM orders a
	INNER JOIN categoryitem b ON a.item_id=b.item_id
	INNER JOIN items c on c.item_id=a.item_id
	INNER JOIN customers d ON d.customer_id=c.seller_id
	WHERE a.date_ordered BETWEEN '2020-01-01' AND '2020-12-31' AND b.category_name='Celular'
	GROUP BY 1,2,3,4,5
	ORDER BY months DESC, amount_sold DESC
)
SELECT * FROM temp WHERE rank <= 5;
