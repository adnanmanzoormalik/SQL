USE filter_sort_practice;
/*
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    shipped_at DATETIME,
    delivery_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20)
);

INSERT INTO orders
    (order_id, customer_name, order_date, shipped_at, delivery_date, amount, status)
VALUES
    (1, 'Ayaan',  '2026-01-05', '2026-01-06 10:30:00', '2026-01-09', 2500.00, 'Delivered'),
    (2, 'Sara',   '2026-02-12', '2026-02-14 14:15:00', '2026-02-18', 4800.00, 'Delivered'),
    (3, 'Rohan',  '2026-03-03', '2026-03-04 09:00:00', '2026-03-08', 1200.00, 'Delivered'),
    (4, 'Diya',   '2026-04-20', NULL,                  NULL,          6500.00, 'Processing'),
    (5, 'Arjun',  '2026-05-11', '2026-05-13 16:45:00', NULL,          3200.00, 'Shipped'),
    (6, 'Meera',  '2026-06-07', NULL,                  NULL,          8900.00, 'Processing'),
    (7, 'Kabir',  '2026-07-15', '2026-07-16 11:20:00', '2026-07-20', 1500.00, 'Delivered'),
    (8, 'Zoya',   '2026-08-22', '2026-08-25 08:10:00', NULL,          7200.00, 'Shipped'),
    (9, 'Ishaan', '2026-09-10', NULL,                  NULL,          4100.00, 'Cancelled'),
    (10, 'Anaya', '2026-10-02', '2026-10-03 13:00:00', '2026-10-06', 5500.00, 'Delivered');
*/
SELECT * FROM orders;




### Task 1: Analyze Order Shipping Times
-- Using the `orders` table, write a MySQL query that displays:
-- - `order_id`
-- - `customer_name`
-- - `order_date`
-- - The date portion of `shipped_at`
-- - The number of days between `order_date` and `shipped_at`
-- Use these aliases for the last two calculated columns:
-- - `shipping_date`
-- - `shipping_days`
-- Include only orders that have a recorded shipping timestamp.
-- Sort the results by `shipping_days` from highest to lowest.

SELECT 
    order_id, 
    customer_name,
    order_date,
    DATE(shipped_at) AS shipping_date,
    DATEDIFF(shipped_at, order_date) AS shipping_days
FROM orders
WHERE shipped_at IS NOT NULL
ORDER BY DATEDIFF(shipped_at, order_date) DESC;



-- ### Task 2: Classify Orders by Amount
-- Using the `orders` table, write a MySQL query that displays:
-- - `order_id`
-- - `customer_name`
-- - `amount`
-- - A classification called `order_category`, based on these rules:
--   - Amount greater than or equal to 6000: `High`
--   - Amount greater than or equal to 3000 but below 6000: `Medium`
--   - Amount below 3000: `Low`
-- Also display a column called `final_amount` that contains the order amount converted to an integer.
-- Include all orders and sort them by `amount` from highest to lowest.

SELECT 
    order_id,
    customer_name,
    amount,
    (CASE
        WHEN amount >= 6000 THEN "High"
        WHEN amount >= 3000 THEN "Medium"
        ELSE "Low"
    END
    ) AS order_category,
    CAST(amount AS SIGNED) AS final_amount
FROM orders
ORDER BY amount DESC;  



-- ### Task 3: Find Orders Due at Month-End
-- Using the `orders` table, write a MySQL query that displays:
-- - `order_id`
-- - `customer_name`
-- - `order_date`
-- - The last calendar day of the month in which the order was placed, as `month_end`
-- - The number of days between the order date and that month-end date, as `days_until_month_end`

-- Include only orders placed in the year 2026.
-- Sort the results by `order_date` in ascending order.

SELECT 
    order_id,
    customer_name,
    order_date,
    LAST_DAY(order_date) AS month_end,
    ABS(DATEDIFF(order_date, LAST_DAY(order_date))) AS days_until_month_end
FROM orders
WHERE YEAR(order_date) = 2026
ORDER BY order_date;



-- ### Task 4: Identify Orders That Need Follow-Up

-- Using the `orders` table, write a MySQL query that displays:
-- - `order_id`
-- - `customer_name`
-- - `status`
-- - `delivery_date`
-- - A column called `delivery_status` with these rules:
--      - If `delivery_date` is NULL, return `Pending Delivery`.
--      - If `delivery_date` is not NULL and the status is `Delivered`, return `Completed`.
--      - Otherwise, return `In Transit`.
-- Also display a column called `delivery_date_display` that replaces a NULL delivery date with the text `Not Delivered`.
-- Include only orders whose status is not `Cancelled`.
-- Sort the results by `order_id` in ascending order.


SELECT 
    order_id, 
    customer_name,
    status,
    delivery_date,
    (CASE
        WHEN delivery_date IS NULL THEN "Pending Delivery"
        WHEN delivery_date IS NOT NULL THEN "Completed"
        ELSE "In Transit"
    END) AS delivery_status,
    IFNULL(delivery_date, "Not Delivered") AS delivery_date_display
FROM orders
WHERE status != "Cancelled"
ORDER BY order_id;




-- ### Task 5: Calculate Order Age and Priority
-- Using the `orders` table, write a MySQL query that displays:
-- - `order_id`
-- - `customer_name`
-- - `order_date`
-- - `amount`
-- - The number of complete months between `order_date` and the current date, as `months_since_order`
-- - A column called `order_priority` with these rules:
--     - If the amount is at least 6000, return `High`.
--     - Otherwise, if the order date is before 2026-06-01, return `Review`.
--     - Otherwise, return `Normal`.
-- - Also display a column called `order_year` containing the year of the order.
-- Include all orders and sort them by `order_date` from oldest to newest.

SELECT
    order_id, 
    customer_name,
    order_date,
    amount,
    TIMESTAMPDIFF(MONTH, order_date, CURDATE()) AS months_since_order,
    (CASE
        WHEN amount >= 6000 THEN "High"
        WHEN order_date < '2026-06-01' THEN "Review"
        ELSE "Normal"
    END) AS order_priority,
    YEAR(order_date) AS order_year
FROM orders
ORDER BY order_date;









