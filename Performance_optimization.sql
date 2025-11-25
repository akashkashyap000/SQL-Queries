USE sales;

-- Performance Indexing
CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_orders_status_date ON orders(status, order_date);
CREATE INDEX idx_order_detail_order_product ON order_detail(order_id, product_id);
CREATE INDEX idx_products_price_category ON products(price, category);
CREATE INDEX idx_customers_city_email ON customers(city, email);

-- Query Performance Analysis
EXPLAIN SELECT * FROM orders WHERE customer_id = 1 AND order_date > '2024-01-01';

-- Table Optimization
ANALYZE TABLE customers;
ANALYZE TABLE products;
ANALYZE TABLE orders;
ANALYZE TABLE order_detail;

-- Performance Monitoring Queries
-- Show table sizes
SELECT 
    table_name AS 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)'
FROM information_schema.TABLES 
WHERE table_schema = 'sales'
ORDER BY (data_length + index_length) DESC;

-- Show index usage
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'sales';

-- Optimization Recommendations
SELECT
    CONCAT(table_name, ' - Consider adding index on frequently queried columns') AS recommendation
FROM information_schema.TABLES
WHERE table_schema = 'sales'
AND table_name IN ('orders', 'order_detail', 'customers', 'products');

-- Cache performance (for MySQL)
SHOW STATUS LIKE 'Qcache%';
