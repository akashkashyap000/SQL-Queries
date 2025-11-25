USE sales;

-- Insert sample customers
INSERT INTO customers (first_name, last_name, email, phone, city) VALUES
('Aarav', 'Sharma', 'aarav.sharma@email.com', '9876543210', 'Mumbai'),
('Priya', 'Patel', 'priya.patel@email.com', '9876543211', 'Delhi'),
('Rohan', 'Kumar', 'rohan.kumar@email.com', '9876543212', 'Bangalore'),
('Ananya', 'Singh', 'ananya.singh@email.com', '9876543213', 'Chennai'),
('Vikram', 'Reddy', 'vikram.reddy@email.com', '9876543214', 'Hyderabad');

-- Insert sample products
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('iPhone 14', 'Electronics', 79999.00, 50),
('Samsung Galaxy', 'Electronics', 59999.00, 30),
('Nike Air Max', 'Fashion', 12999.00, 100),
('Adidas Ultraboost', 'Fashion', 15999.00, 75),
('MacBook Pro', 'Electronics', 199999.00, 20),
('Dell XPS', 'Electronics', 149999.00, 25),
('Levi''s Jeans', 'Fashion', 3999.00, 200),
('Sony Headphones', 'Electronics', 29999.00, 40);

-- Insert sample orders
INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES
(1, '2024-01-15', 79999.00, 'completed'),
(2, '2024-01-16', 12999.00, 'completed'),
(3, '2024-01-17', 199999.00, 'completed'),
(1, '2024-01-18', 29999.00, 'pending'),
(4, '2024-01-19', 59999.00, 'completed');

-- Insert sample order details
INSERT INTO order_detail (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 79999.00),
(2, 3, 1, 12999.00),
(3, 5, 1, 199999.00),
(4, 8, 1, 29999.00),
(5, 2, 1, 59999.00);
