USE sales;

-- 1. List all customers
SELECT * FROM customers;

-- 2. List all products
SELECT * FROM products;

-- 3. List all orders
SELECT * FROM orders;

-- 4. Find electronics products
SELECT * FROM products WHERE category = 'Electronics';

-- 5. Products above 50000
SELECT * FROM products WHERE price > 50000;

-- 6. Total customers count
SELECT COUNT(*) AS total_customers FROM customers;

-- 7. Orders per customer
SELECT customer_id, COUNT(*) AS total_orders 
FROM orders 
GROUP BY customer_id;

-- 8. Total quantity sold per product
SELECT product_id, SUM(quantity) AS total_sold 
FROM order_detail 
GROUP BY product_id;

-- 9. Revenue per product
SELECT product_id, SUM(quantity * price) AS total_revenue 
FROM order_detail 
GROUP BY product_id;

-- 10. Orders with customer names
SELECT o.order_id, o.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS full_name,
       o.order_date, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 11. Top 5 customers by spending
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 12. Monthly sales report
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS total_sales,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 13. Category-wise revenue
SELECT 
    p.category,
    SUM(od.quantity * od.price) AS total_revenue
FROM order_detail od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;
