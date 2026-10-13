-- CREATE DATABASE subquery_practice;
USE subquery_practice;

/*
-- TABLE 1: CUSTOMERS
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers
(customer_id, customer_name, city)
VALUES
(1, 'Adnan', 'Srinagar'),
(2, 'Meera', 'Delhi'),
(3, 'Kabir', 'Jammu'),
(4, 'Sana', 'Srinagar'),
(5, 'Rohan', 'Delhi');


-- TABLE 2: ORDERS
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

INSERT INTO orders
(order_id, customer_id, order_date, total_amount)
VALUES
(1001, 1, '2026-09-01', 2500),
(1002, 2, '2026-09-03', 1200),
(1003, 1, '2026-09-10', 800),
(1004, 3, '2026-09-12', 3200),
(1005, 4, '2026-09-15', 1500),
(1006, 2, '2026-09-20', 2500),
(1007, 3, '2026-09-25', 600);


-- TABLE 3: PRODUCTS
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO products
(product_id, product_name, category, price)
VALUES
(201, 'Laptop', 'Electronics', 65000),
(202, 'Mouse', 'Electronics', 1200),
(203, 'Keyboard', 'Electronics', 3500),
(204, 'Chair', 'Furniture', 7000),
(205, 'Desk', 'Furniture', 12000),
(206, 'Notebook', 'Stationery', 100),
(207, 'Pen', 'Stationery', 50),
(208, 'Lamp', 'Home', 1800),
(209, 'Bottle', 'Home', 600);


-- TABLE 4: ORDER ITEMS
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO order_items
(order_id, product_id, quantity)
VALUES
(1001, 201, 1),
(1001, 202, 2),
(1002, 204, 1),
(1002, 206, 5),
(1003, 207, 10),
(1004, 205, 1),
(1004, 203, 1),
(1005, 208, 1),
(1005, 204, 1),
(1006, 203, 1),
(1006, 202, 1),
(1007, 206, 2);
*/

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM order_items;


-- Q1. Find the product or products with the second-highest distinct price. Display product_name and price.
SELECT product_id, product_name, price
FROM products 
WHERE price = (
    SELECT MAX(price)
    FROM products WHERE price < (
        SELECT MAX(price) FROM products
    )
);

-- Q2. Find customers who have placed at least one order. Display customer_id and customer_name.
SELECT c.customer_id, c.customer_name 
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);

-- Q3. Find orders whose total_amount is greater than the average amount of all orders. Display order_id and total_amount.
SELECT order_id, total_amount FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount) FROM orders
);

-- Q4. Find all products belonging to any category that contains a product priced above 5000. Display product_name, category and price.
SELECT product_name, category, price
FROM products
WHERE category IN (
    SELECT category
    FROM products
    WHERE price > 5000
);

-- Q5. Display every customer alongside their number of orders, including customers with zero orders. Display customer_name and order_count.
SELECT 
    c.customer_name,
    (SELECT COUNT(o.order_id) FROM orders AS o
    WHERE c.customer_id = o.customer_id) AS number_of_orders 
    FROM customers AS c;

-- Q6. Find products that have never appeared in order_items. Display product_id and product_name.
SELECT p.product_id, p.product_name FROM products AS p
WHERE NOT EXISTS(
    SELECT product_id FROM order_items AS o
    WHERE o.product_id = p.product_id
);

-- Q7. Find products whose price is greater than the average price of their own category. Display product_name, category and price.
SELECT p1.product_name, p1.category, p1.price FROM products AS p1
WHERE price > (
    SELECT AVG(price) FROM products AS p2
    WHERE p2.category = p1.category
);

-- Q8. Calculate the average total_amount among orders whose total_amount is greater than 1000. Return one column named average_order_amount.
SELECT AVG(total_amount) AS average_order_amount FROM (
    SELECT total_amount FROM orders where total_amount > 1000
) AS total_amount;

-- Q9. Find products whose price is greater than at least one product price in the Stationery category. Display product_name and price.
SELECT product_name, price FROM products
WHERE price > (
    SELECT MIN(price) FROM products WHERE category = "Stationery"
);
-- or we can also do this
SELECT product_name, price FROM products
WHERE price > ANY(
    SELECT price FROM products WHERE category = "Stationery"
);

-- Q10. Find products whose price is greater than the price of every product in the Stationery category. Display product_name and price.
SELECT product_name, price FROM products
WHERE price > ALL (
    SELECT price FROM products WHERE category = "Stationery"
);


