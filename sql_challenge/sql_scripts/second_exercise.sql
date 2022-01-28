WITH cell_items AS 
(
	SELECT item_id
	FROM categoryitem
	WHERE category_name = 'Celular'
), order_values AS
(
	SELECT total_values.*, 
		   RANK() OVER (partition by total_values.month order by total_values.total_selled desc) as rank
	FROM (SELECT 
			a.month,
			a.seller_id,
			SUM(a.total_selled) as total_selled,
			SUM(a.total_order_qty) as total_order_qty, 
			SUM(a.total_product_selled) as total_product_selled
	 	FROM (
				SELECT 
					b.seller_id, 
					DATE_TRUNC('month',a.date_ordered) as month,
					COUNT(a.item_id) as total_order_qty, 
					SUM(a.quantity) as total_product_selled, 
					SUM(a.quantity * b.price_per_unit) as total_selled
				FROM orders a 
				LEFT JOIN items b
				ON a.item_id = b.item_id
				WHERE a.item_id in (SELECT * FROM cell_items) AND EXTRACT('year' FROM a.date_ordered) = '2020'
				GROUP BY DATE_TRUNC('month', a.date_ordered), b.seller_id, a.item_id
			 ) a
	 	GROUP BY a.month, a.seller_id) total_values
)

SELECT  '2020' as year, 
		EXTRACT('month' FROM a.month) AS month, 
		a.rank,
		b.first_name, 
		b.last_name, 
		a.total_selled, 
		a.total_order_qty, 
		a.total_product_selled
FROM order_values a 
LEFT JOIN customers b 
ON a.seller_id = b.customer_id
WHERE a.rank <= 5
ORDER BY a.month, a.rank;
