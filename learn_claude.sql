-- ================================================
-- إعداد قاعدة البيانات للمتجر الإلكتروني
-- ================================================
/*
-- إنشاء قاعدة البيانات
CREATE DATABASE ecommerce_store;
USE ecommerce_store;

-- ================================================
-- إنشاء جدول العملاء (Customers)
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
-- إنشاء جدول المنتجات (Products)
-- ================================================
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2)
);

-- ================================================
-- إنشاء جدول المبيعات (Sales)
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
-- إضافة بيانات تجريبية للعملاء
-- ================================================
INSERT INTO customers (customer_id, customer_name, age, gender, city, registration_date) VALUES
(1, 'Ahmed Ali', 28, 'Male', 'الرياض', '2023-01-15'),
(2, 'Fatima Hassan', 34, 'Female', 'جدة', '2023-02-20'),
(3, 'Omar Mohammed', 25, 'Male', 'الدمام', '2023-01-30'),
(4, 'Aisha Abdullah', 29, 'Female', 'الرياض', '2023-03-10'),
(5, 'Khalid Ibrahim', 42, 'Male', 'مكة', '2023-02-05'),
(6, 'Nour Salem', 31, 'Female', 'المدينة', '2023-01-25'),
(7, 'Saeed Ahmad', 38, 'Male', 'جدة', '2023-04-12'),
(8, 'Layla Youssef', 27, 'Female', 'الطائف', '2023-03-18'),
(9, 'Hassan Ali', 33, 'Male', 'الأحساء', '2023-02-28'),
(10, 'Maryam Faisal', 26, 'Female', 'الرياض', '2023-04-05');

-- ================================================
-- إضافة بيانات تجريبية للمنتجات
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
-- إضافة بيانات تجريبية للمبيعات
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
-- التأكد من البيانات
-- ================================================
select * from customers where city = "الرياض";
select * from products where unit_price > 500;
select * from customers;
select gender,count(customer_name) as gender_cline from customers group by gender;
select avg(age) from customers;
select * from sales order by sale_date desc limit 5;
USE ecommerce_store;
select * from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id;
select cus.customer_name,sum(unit_price) as total_amount from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id group by cus.customer_id order by total_amount DEsc;
select ps.product_name,sl.quantity from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id order by quantity desc;
select * from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id;
select ps.category,sum(ps.unit_price - ps.cost_price) as Interest from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id group by ps.category;
select * from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id where cus.customer_id not in (sl.customer_id);
/*SELECT 
    cus.customer_id,
    ps.product_name,
    sl.quantity,
    ps.unit_price,
    sl.sale_date,
    DATE_FORMAT(sl.sale_date, '%Y-%m') AS "year_month",
    SUM(sl.quantity * ps.unit_price) OVER (
        PARTITION BY DATE_FORMAT(sl.sale_date, '%Y-%m')
    ) AS total_sales_month
FROM customers AS cus
JOIN sales AS sl ON cus.customer_id = sl.customer_id
JOIN products AS ps ON ps.product_id = sl.product_id
ORDER BY "year_month", sl.sale_date;
SELECT 
    DATE_FORMAT(sl.sale_date, '%Y-%m') AS "year_month",
    SUM(sl.quantity * ps.unit_price) AS total_sales
FROM customers AS cus
JOIN sales AS sl ON cus.customer_id = sl.customer_id
JOIN products AS ps ON ps.product_id = sl.product_id
GROUP BY "year_month"
ORDER BY "year_month;*/

-- select cus.customer_name,sum(sl.quantity * ps.unit_price) as "total_amount" from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id group by cus.customer_name order by "total_amount" desc limit 1;
select ps.category,sum(ps.unit_price - ps.cost_price) as Nes_pnfit from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id group by ps.category order by Nes_pnfit DESC;
select cus.customer_name,count(sl.product_id) from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id group by cus.customer_name ;
select sum(ps.unit_price * sl.quantity)/count(distinct sl.sale_id)  from customers as cus join sales as sl on cus.customer_id = sl.customer_id join products as ps on ps.product_id = sl.product_id;

