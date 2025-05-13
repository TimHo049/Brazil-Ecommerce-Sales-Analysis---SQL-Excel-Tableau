SELECT
    ord.order_id,
    cus.customer_id,
    cus.customer_city,
    cus.customer_state,
    CAST(ord.order_purchase_timestamp AS DATE) AS order_date,
    COUNT(ite.order_item_id) AS total_units,
	SUM(ite.price) AS total_revenue,
	pro.product_category_name,
	sel.seller_zip_code_prefix AS store_zip,
	ite.seller_id
FROM olist_orders ord
JOIN olist_customers cus
    ON ord.customer_id = cus.customer_id
JOIN olist_order_items ite
    ON ite.order_id = ord.order_id
JOIN olist_products pro
	ON ite.product_id = pro.product_id
JOIN olist_sellers sel
	ON ite.seller_id = sel.seller_id
WHERE ord.order_status NOT IN ('canceled', 'unavailable')
GROUP BY 
    ord.order_id,
    cus.customer_id,
    cus.customer_city,
    cus.customer_state,
    CAST(ord.order_purchase_timestamp AS DATE),
	pro.product_category_name,
	sel.seller_zip_code_prefix,
	ite.seller_id; 