-- ================================================
-- Preparing the database for the e-commerce store
-- ================================================
/*
-- Create database
CREATE DATABASE ecommerce_store;
USE ecommerce_store;

-- ================================================
-- Create Customers table
-- ================================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50),
    registration_date DATE
);

-- ================================================
-- Create Products table
-- ================================================
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2)
);

-- ================================================
-- Create Sales table
-- ================================================
CREATE TABLE sales (
    sale_id INT,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ================================================
-- Insert sample data for customers
-- ================================================
INSERT INTO customers (customer_id, customer_name, age, gender, city, registration_date) VALUES
(1, 'Ahmed Ali', 28, 'Male', 'Riyadh', '2023-01-15'),
(2, 'Fatima Hassan', 34, 'Female', 'Jeddah', '2023-02-20'),
(3, 'Omar Mohammed', 25, 'Male', 'Dammam', '2023-01-30'),
(4, 'Aisha Abdullah', 29, 'Female', 'Riyadh', '2023-03-10'),
(5, 'Khalid Ibrahim', 42, 'Male', 'Mecca', '2023-02-05'),
(6, 'Nour Salem', 31, 'Female', 'Medina', '2023-01-25'),
(7, 'Saeed Ahmad', 38, 'Male', 'Jeddah', '2023-04-12'),
(8, 'Layla Youssef', 27, 'Female', 'Taif', '2023-03-18'),
(9, 'Hassan Ali', 33, 'Male', 'Al-Ahsa', '2023-02-28'),
(10, 'Maryam Faisal', 26, 'Female', 'Riyadh', '2023-04-05');

-- ================================================
-- Insert sample data for products
-- ================================================
INSERT INTO products (product_id, product_name, category, unit_price, cost_price) VALUES
(1, 'iPhone 15', 'Electronics', 4999.00, 3499.00),
(2, 'Samsung Galaxy S24', 'Electronics', 3999.00, 2799.00),
(3, 'iPad Pro', 'Electronics', 2499.00, 1749.00),
(4, 'Nike Shoes', 'Fashion', 399.00, 279.00),
(5, 'Adidas T-Shirt', 'Fashion', 89.00, 62.00),
(6, 'Coffee Maker', 'Home', 199.00, 139.00),
(7, 'Bluetooth Speaker', 'Electronics', 149.00, 104.00),
(8, 'Jeans', 'Fashion', 199.00, 139.00),
(9, 'Smart Watch', 'Electronics', 999.00, 699.00),
(10, 'Perfume', 'Beauty', 299.00, 209.00);

-- ================================================
-- Insert sample data for sales
-- ================================================
INSERT INTO sales (sale_id, customer_id, product_id, sale_date, quantity) VALUES
(1, 1, 1, '2024-01-15', 1),
(1, 1, 4, '2024-01-15', 2),
(2, 2, 2, '2024-01-18', 1),
(3, 3, 5, '2024-01-20', 3),
(3, 3, 6, '2024-01-20', 1),
(4, 4, 3, '2024-02-05', 1),
(5, 5, 7, '2024-02-08', 2),
(6, 1, 8, '2024-02-10', 1),
(7, 6, 9, '2024-02-15', 1),
(8, 7, 10, '2024-02-18', 1),
(9, 8, 1, '2024-03-01', 1),
(10, 9, 4, '2024-03-05', 2),
(11, 10, 5, '2024-03-08', 1),
(12, 2, 6, '2024-03-12', 1),
(13, 3, 7, '2024-03-15', 3),
(14, 4, 8, '2024-03-18', 1),
(15, 5, 9, '2024-03-20', 1);
*/

-- ================================================
-- Verify inserted data
-- ================================================

-- ================================================
-- Exercise 1: Basic Queries
-- ================================================

-- 1️⃣ Show all customers from Riyadh
SELECT * 
FROM customers 
WHERE city = 'الرياض';

-- 2️⃣ Show products with a price greater than 500 SAR
SELECT * 
FROM products 
WHERE unit_price > 500;

-- 3️⃣ Show the number of customers grouped by gender
SELECT gender, COUNT(customer_id) AS customer_count
FROM customers 
GROUP BY gender;

-- 4️⃣ Show the average age of customers
SELECT AVG(age) AS avg_age
FROM customers;

-- 5️⃣ Show the latest 5 sales
SELECT * 
FROM sales 
ORDER BY sale_date DESC 
LIMIT 5;



-- ================================================
-- Exercise 2: Advanced Queries (JOIN)
-- ================================================

-- 1️⃣ Show sales details with customer and product names
SELECT 
    sl.sale_id,
    cus.customer_name,
    ps.product_name,
    sl.sale_date,
    sl.quantity
FROM customers AS cus
JOIN sales AS sl ON cus.customer_id = sl.customer_id
JOIN products AS ps ON ps.product_id = sl.product_id;

-- 2️⃣ Calculate the total sales amount for each customer
SELECT 
    cus.customer_name,
    SUM(sl.quantity * ps.unit_price) AS total_amount
FROM customers AS cus
JOIN sales AS sl ON cus.customer_id = sl.customer_id
JOIN products AS ps ON ps.product_id = sl.product_id
GROUP BY cus.customer_name
ORDER BY total_amount DESC;

-- 3️⃣ Show the best-selling products (by quantity)
SELECT 
    ps.product_name,
    SUM(sl.quantity) AS total_sold
FROM sales AS sl
JOIN products AS ps ON ps.product_id = sl.product_id
GROUP BY ps.product_name
ORDER BY total_sold DESC;

-- 4️⃣ Show the total profit for each product category
SELECT 
    ps.category,
    SUM((ps.unit_price - ps.cost_price) * sl.quantity) AS total_profit
FROM sales AS sl
JOIN products AS ps ON ps.product_id = sl.product_id
GROUP BY ps.category
ORDER BY total_profit DESC;

-- 5️⃣ Show customers who did not purchase anything
SELECT *
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM sales);



-- ================================================
-- Advanced Analytical Questions
-- ================================================

-- 1️⃣ What is the total sales amount per month?
SELECT 
    DATE_FORMAT(sl.sale_date, '%Y-%m') AS year_month,
    SUM(sl.quantity * ps.unit_price) AS total_sales
FROM sales AS sl
JOIN products AS ps ON ps.product_id = sl.product_id
GROUP BY year_month
ORDER BY year_month;

-- 2️⃣ Which customer spent the highest amount?
SELECT 
    cus.customer_name,
    SUM(sl.quantity * ps.unit_price) AS total_spent
FROM customers AS cus
JOIN sales AS sl ON cus.customer_id = sl.customer_id
JOIN products AS ps ON ps.product_id = sl.product_id
GROUP BY cus.customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- 3️⃣ Which product category is the most profitable?
SELECT 
    ps.category,
    SUM((ps.unit_price - ps.cost_price) * sl.quantity) AS total_profit
FROM sales AS sl
JOIN products AS ps ON ps.product_id = sl.product_id
GROUP BY ps.category
ORDER BY total_profit DESC
LIMIT 1;

-- 4️⃣ How many different products has each customer purchased?
SELECT 
    cus.customer_name,
    COUNT(DISTINCT sl.product_id) AS distinct_products
FROM customers AS cus
JOIN sales AS sl ON cus.customer_id = sl.customer_id
GROUP BY cus.customer_name;

-- 5️⃣ What is the average order value?
SELECT 
    SUM(sl.quantity * ps.unit_price) / COUNT(DISTINCT sl.sale_id) AS avg_order_value
FROM sales AS sl
JOIN products AS ps ON ps.product_id = sl.product_id;

