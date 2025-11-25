USE sales;

-- 1. Customer Lifetime Value (CLV)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value,
    MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_spent DESC;

-- 2. Monthly Growth Rate
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_amount) AS monthly_revenue
    FROM orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(
        ((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month)) / 
        LAG(monthly_revenue) OVER (ORDER BY month)) * 100, 2
    ) AS growth_percentage
FROM monthly_sales;

-- 3. RFM Analysis (Recency, Frequency, Monetary)
SELECT 
    customer_id,
    DATEDIFF(CURDATE(), MAX(order_date)) AS recency_days,
    COUNT(order_id) AS frequency,
    SUM(total_amount) AS monetary,
    CASE 
        WHEN DATEDIFF(CURDATE(), MAX(order_date)) <= 30 THEN 'High'
        WHEN DATEDIFF(CURDATE(), MAX(order_date)) <= 90 THEN 'Medium'
        ELSE 'Low'
    END AS recency_score,
    CASE 
        WHEN COUNT(order_id) >= 5 THEN 'High'
        WHEN COUNT(order_id) >= 2 THEN 'Medium'
        ELSE 'Low'
    END AS frequency_score
FROM orders
GROUP BY customer_id
ORDER BY recency_days ASC, frequency DESC, monetary DESC;

-- 4. Products never sold
SELECT p.product_id, p.product_name, p.category, p.price
FROM products p
LEFT JOIN order_detail od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;

-- 5. Top selling products by category
SELECT 
    p.category,
    p.product_name,
    SUM(od.quantity) AS total_units_sold,
    SUM(od.quantity * od.price) AS total_revenue,
    RANK() OVER (PARTITION BY p.category ORDER BY SUM(od.quantity * od.price) DESC) AS rank_in_category
FROM products p
JOIN order_detail od ON p.product_id = od.product_id
GROUP BY p.category, p.product_name
ORDER BY p.category, total_revenue DESC;

-- 6. Customer retention analysis
WITH monthly_orders AS (
    SELECT 
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS order_month
    FROM orders
    GROUP BY customer_id, DATE_FORMAT(order_date, '%Y-%m')
),
retention AS (
    SELECT 
        customer_id,
        order_month,
        LEAD(order_month) OVER (PARTITION BY customer_id ORDER BY order_month) AS next_month
    FROM monthly_orders
)
SELECT 
    order_month,
    COUNT(customer_id) AS total_customers,
    COUNT(CASE WHEN next_month IS NOT NULL THEN 1 END) AS retained_customers,
    ROUND((COUNT(CASE WHEN next_month IS NOT NULL THEN 1 END) / COUNT(customer_id)) * 100, 2) AS retention_rate
FROM retention
GROUP BY order_month
ORDER BY order_month;
