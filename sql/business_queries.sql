-- ORDER ANALYSIS

-- 1 Total number of orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM supply_chain;


-- 2 Orders by region
SELECT order_region,
       COUNT(DISTINCT order_id) AS total_orders
FROM supply_chain
GROUP BY order_region
ORDER BY total_orders DESC;


-- 3 Orders by shipping mode
SELECT shipping_mode,
       COUNT(DISTINCT order_id) AS total_orders
FROM supply_chain
GROUP BY shipping_mode
ORDER BY total_orders DESC;


-- REVENUE ANALYSIS

-- 4 Total revenue
SELECT SUM(order_item_total) AS total_revenue
FROM supply_chain;


-- 5 Revenue by product category
SELECT category_name,
       SUM(order_item_total) AS revenue
FROM supply_chain
GROUP BY category_name
ORDER BY revenue DESC;


-- 6 Top 10 products by revenue
SELECT product_name,
       SUM(order_item_total) AS revenue
FROM supply_chain
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;

-- PRODUCT DEMAND

-- 7 Top selling products
SELECT product_name,
       SUM(order_item_quantity) AS total_quantity
FROM supply_chain
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 10;


-- 8 Product demand by category
SELECT category_name,
       SUM(order_item_quantity) AS demand
FROM supply_chain
GROUP BY category_name
ORDER BY demand DESC;


-- LOGISTICS PERFORMANCE

-- 9 Average shipping time
SELECT AVG(days_for_shipping_real) AS avg_shipping_time
FROM supply_chain;


-- 10 Average scheduled shipping time
SELECT AVG(days_for_shipment_scheduled) AS avg_scheduled_shipping
FROM supply_chain;


-- 11 Average shipping delay
SELECT AVG(shipping_delay) AS avg_delay
FROM supply_chain;


-- 12 Delay by region
SELECT order_region,
       AVG(shipping_delay) AS avg_delay
FROM supply_chain
GROUP BY order_region
ORDER BY avg_delay DESC;


-- SHIPPING MODE ANALYSIS

-- 13 Shipping mode delay comparison
SELECT shipping_mode,
       AVG(shipping_delay) AS avg_delay
FROM supply_chain
GROUP BY shipping_mode
ORDER BY avg_delay DESC;


-- 14 Shipping mode order distribution
SELECT shipping_mode,
       COUNT(DISTINCT order_id) AS total_orders
FROM supply_chain
GROUP BY shipping_mode
ORDER BY total_orders DESC;


-- LATE DELIVERY ANALYSIS

-- 15 Overall late delivery rate
SELECT 
    AVG(late_delivery_risk) * 100 AS late_delivery_percentage
FROM supply_chain;


-- 16 Late deliveries by region
SELECT order_region,
       AVG(late_delivery_risk) * 100 AS late_delivery_rate
FROM supply_chain
GROUP BY order_region
ORDER BY late_delivery_rate DESC;


-- 17 Late deliveries by shipping mode
SELECT shipping_mode,
       AVG(late_delivery_risk) * 100 AS late_delivery_rate
FROM supply_chain
GROUP BY shipping_mode
ORDER BY late_delivery_rate DESC;


-- PROFITABILITY ANALYSIS

-- 18 Total profit
SELECT SUM(order_profit_per_order) AS total_profit
FROM supply_chain;


-- 19 Profit by category
SELECT category_name,
       SUM(order_profit_per_order) AS total_profit
FROM supply_chain
GROUP BY category_name
ORDER BY total_profit DESC;


-- 20 Profit by region
SELECT order_region,
       SUM(order_profit_per_order) AS total_profit
FROM supply_chain
GROUP BY order_region
ORDER BY total_profit DESC;

-- TIME SERIES ANALYSIS

-- 21 Monthly order trend (SQLite version)
SELECT 
    strftime('%Y-%m', order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM supply_chain
GROUP BY month
ORDER BY month;


-- 22 Monthly revenue trend (SQLite version)
SELECT 
    strftime('%Y-%m', order_date) AS month,
    SUM(order_item_total) AS revenue
FROM supply_chain
GROUP BY month
ORDER BY month;


-- IMPACT ANALYSIS

-- 23 Late vs On-time profit impact
SELECT 
    CASE 
        WHEN late_delivery_risk = 1 THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    AVG(order_profit_per_order) AS avg_profit
FROM supply_chain
GROUP BY delivery_status;


-- 24 Late vs On-time shipping delay
SELECT 
    CASE 
        WHEN late_delivery_risk = 1 THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status,
    AVG(shipping_delay) AS avg_delay
FROM supply_chain
GROUP BY delivery_status;