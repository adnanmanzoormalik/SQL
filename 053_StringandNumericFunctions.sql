
USE filter_sort_practice;
/*
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    quantity INT,
    product_code VARCHAR(20)
);

INSERT INTO products
    (product_id, product_name, category, price, quantity, product_code)
VALUES
    (1, '  wireless mouse  ', 'Electronics', 799.50, 25, 'EL-MOU-101'),
    (2, 'Mechanical Keyboard', 'Electronics', 2499.99, 12, 'EL-KEY-102'),
    (3, 'USB Cable', 'Accessories', 199.00, 50, 'AC-CAB-103'),
    (4, 'Laptop Stand', 'Accessories', 1499.75, 18, 'AC-STD-104'),
    (5, 'Bluetooth Speaker', 'Electronics', 1899.50, 10, 'EL-SPK-105'),
    (6, 'Webcam HD', 'Electronics', 3299.00, 8, 'EL-WEB-106'),
    (7, 'Desk Lamp', 'Home', 899.25, 20, 'HM-LMP-107'),
    (8, 'Phone Holder', 'Accessories', 349.99, 30, 'AC-HLD-108'),
    (9, '  portable charger  ', 'Electronics', 1199.00, 15, 'EL-CHG-109'),
    (10, 'Notebook', 'Stationery', 99.50, 100, 'ST-NOT-110');
*/

SELECT * FROM products;




-- ### Task 1: Format Product Information

-- Write a single MySQL query that displays the following columns for every product:
-- 1. `product_id`
-- 2. `product_name` with leading and trailing spaces removed
-- 3. `product_name` in uppercase
-- 4. The first three characters of `product_code`
-- 5. `price` rounded to one decimal place
-- 6. The total inventory value, calculated as `price × quantity`, rounded to two decimal places

-- Give the output columns these aliases:
-- - `clean_name`
-- - `uppercase_name`
-- - `code_prefix`
-- - `rounded_price`
-- - `inventory_value`
-- Order the results by `product_id` in ascending order.



SELECT 
    product_id, 
    TRIM(product_name) AS clean_name, 
    UPPER(product_name) AS uppercase_name,
    SUBSTRING(product_code, 1,3) AS code_prefix,
    ROUND(price, 1) AS rounded_price,
    ROUND(price*quantity, 2) AS inventory_value
FROM products;






-- ### Task 2: Calculate Discounted Prices
-- Using the `products` table, write a MySQL query that displays:
-- - `product_name`
-- - `price`
-- - The price after a 15% discount, rounded to two decimal places
-- - The absolute difference between the original price and 1000
-- - The remainder when `product_id` is divided by 3
-- - The square of `quantity`

-- Use these output aliases:
-- - `discounted_price`
-- - `price_difference`
-- - `id_remainder`
-- - `quantity_squared`

-- Sort the results by `discounted_price` from lowest to highest.


SELECT 
    product_name,
    price,
    ROUND(price*85/100, 2) AS discounted_price,
    ABS(price-1000) AS price_difference,
    MOD(product_id, 3) AS id_remainder,
    quantity*quantity AS quantity_squared
FROM products
ORDER BY discounted_price;



-- ### Task 3: Search and Transform Product Names
-- Using the `products` table, write a MySQL query that displays:
-- - `product_id`
-- - `product_name` with leading and trailing spaces removed
-- - The product name with every occurrence of the letter `o` replaced by `0`
-- - The position of the substring `Cable` in `product_name`
-- - The last four characters of `product_code`

-- Use these aliases:
-- - `clean_name`  - `modified_name`   - `cable_position`  - `code_suffix`

-- Return only products whose names contain the letter `o`, regardless of case.
-- Sort the results by `product_id` in ascending order.


SELECT 
    product_id,
    TRIM(product_name) AS clean_name,
    (REPLACE(product_name, 'o','0')) AS modified_name,
    LOCATE('Cable', product_name) AS cable_position,
    RIGHT(product_code, 4) AS code_suffix
FROM products
WHERE product_name LIKE '%o%'
ORDER BY product_id;




-- ### Task 4: Analyze Product Pricing

-- Using the `products` table, write a MySQL query that displays:
-- - `product_name`
-- - `price`
-- - The price rounded to the nearest whole number
-- - The price rounded down to the nearest whole number
-- - The price rounded up to the nearest whole number
-- - The square root of `quantity`, rounded to two decimal places

-- Use these aliases:
-- - `rounded_price`   - `floor_price` - `ceil_price`  - `quantity_sqrt`

-- Return only products whose quantity is greater than 10 and whose price is below 2000.
-- Sort the results by price from highest to lowest.



SELECT 
    product_name,
    price,
    ROUND(price,0) AS rounded_price,
    FLOOR(price) AS floor_price,
    CEIL(price) AS ceil_price,
    ROUND(SQRT(quantity), 2) AS quantity_sqrt
FROM products
WHERE quantity > 10 AND price < 2000
ORDER BY price DESC;






-- ### Task 5: Generate a Product Summary

-- Using the `products` table, write a MySQL query that displays:
-- - `product_id`
-- - The product name in lowercase, with surrounding spaces removed
-- - A combined label in this format: `product_name - category`
-- - The first three characters of `category`, converted to uppercase
-- - The total value of stock, calculated as `price × quantity`, rounded to the nearest whole number
-- - The remainder when `quantity` is divided by 4

-- Use these aliases:
-- - `clean_name`   - `product_label`  - `category_prefix` - `stock_value` - `quantity_remainder`

-- Return only products whose stock value is at least 10000.
-- Sort the results by stock value from highest to lowest, and display only the first five rows.

SELECT 
    product_id,
    LOWER(TRIM(product_name)) AS clean_name,
    CONCAT(product_name,'-',category) AS product_label,
    UPPER(SUBSTRING(category,1,3)) AS category_prefix,
    ROUND(price*quantity, 0) AS stock_value,
    MOD(quantity, 4) AS quantity_remainder
FROM products
WHERE price*quantity >= 10000
ORDER BY stock_value DESC LIMIT 5;


