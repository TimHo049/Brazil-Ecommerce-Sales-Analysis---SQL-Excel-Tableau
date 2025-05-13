SELECT
    ord.order_id,
    cus.customer_id,
    cus.customer_city,
    cus.customer_state,
    CAST(ord.order_purchase_timestamp AS DATE) AS order_date,  -- Cast to date for easier analysis
    COUNT(ite.order_item_id) AS total_units,  -- Count of total items in each order
    SUM(ite.price) AS total_revenue,  -- Total revenue for each order
    pro.product_category_name,  -- Category of the product
    sel.seller_zip_code_prefix AS store_zip,  -- Seller location by zip code
    ite.seller_id  -- Seller ID for identifying which seller made the sale
FROM olist_orders ord
JOIN olist_customers cus
    ON ord.customer_id = cus.customer_id
JOIN olist_order_items ite
    ON ite.order_id = ord.order_id
JOIN olist_products pro
    ON ite.product_id = pro.product_id
JOIN olist_sellers sel
    ON ite.seller_id = sel.seller_id
WHERE ord.order_status NOT IN ('canceled', 'unavailable')  -- Excluding canceled and unavailable orders
GROUP BY 
    ord.order_id,
    cus.customer_id,
    cus.customer_city,
    cus.customer_state,
    CAST(ord.order_purchase_timestamp AS DATE),
    pro.product_category_name,
    sel.seller_zip_code_prefix,
    ite.seller_id;
