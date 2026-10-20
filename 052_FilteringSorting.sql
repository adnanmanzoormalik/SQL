CREATE DATABASE IF NOT EXISTS filter_sort_practice;

USE filter_sort_practice;
/*
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    age INT,
    salary DECIMAL(10,2),
    city VARCHAR(40),
    email VARCHAR(100)
);

INSERT INTO employees
    (employee_id, employee_name, department, age, salary, city, email)
VALUES
    (1, 'Ayaan',  'IT',      24, 45000.00, 'Srinagar', 'ayaan@example.com'),
    (2, 'Sara',   'HR',      29, 52000.00, 'Jammu',    'sara@example.com'),
    (3, 'Rohan',  'IT',      32, 68000.00, 'Delhi',    'rohan@example.com'),
    (4, 'Diya',   'Finance', 26, 48000.00, 'Srinagar', NULL),
    (5, 'Arjun',  'HR',      22, 35000.00, 'Delhi',    'arjun@example.com'),
    (6, 'Meera',  'Finance', 35, 75000.00, 'Jammu',    'meera@example.com'),
    (7, 'Kabir',  'IT',      28, 52000.00, 'Mumbai',   NULL),
    (8, 'Zoya',   'Sales',   19, 28000.00, 'Srinagar', 'zoya@example.com'),
    (9, 'Ishaan', 'Sales',   31, 61000.00, 'Delhi',    'ishaan@example.com'),
    (10, 'Anaya', 'Finance', 24, 45000.00, 'Mumbai',   'anaya@example.com');
*/


SELECT * FROM employees;


-- Query 1 of 5 — Filtering with Multiple Conditions

-- Write a MySQL query to find employees who satisfy all of these conditions:
-- 1. Their department is either `IT` or `Finance`.
-- 2. Their salary is greater than or equal to ₹45,000.
-- 3. Their age is below 30.

-- **Required output columns:**
-- - `employee_name`
-- - `department`
-- - `age`
-- - `salary`
-- **Requirements:**
-- - Use `WHERE`.
-- - Combine conditions using `AND` and `OR` correctly.
-- - Use parentheses where necessary to control logical grouping.
-- - Do not use `SELECT *`.
SELECT employee_name, department, age, salary
FROM employees
WHERE department IN ('IT', 'Finance') AND salary >= 45000 AND age < 30;







-- Query 2 of 5
-- Using the existing `employees` table, write a MySQL query to find employees whose names:
-- 1. Start with the letter `A` or `I`.
-- 2. Have a salary greater than ₹40,000.
-- 3. Have a non-NULL email address.

-- **Required output columns:**
-- - `employee_name`
-- - `salary`
-- - `email`
-- **Requirements:**
-- - Use `LIKE` for name matching.
-- - Use `OR` correctly with parentheses where necessary.
-- - Use `IS NOT NULL` to check the email.
-- - Sort the results by salary from highest to lowest.

SELECT employee_name, salary, email
FROM employees
WHERE (employee_name LIKE 'A%' OR 'I%') AND salary > 40000 AND email IS NOT NULL;






### Query 3 of 5
-- Using the existing `employees` table, retrieve the employees ranked from highest to lowest salary.
-- Return only the third, fourth, and fifth employees in that ranking.

-- Display these columns:
-- - `employee_id`
-- - `employee_name`
-- - `department`
-- - `salary`
-- Write a single MySQL query.
SELECT employee_id, employee_name, department, salary FROM employees
ORDER BY salary DESC
LIMIT 3 OFFSET 2;




-- Query 4 of 5
-- Using the existing `employees` table, find employees who meet these requirements:

-- - Their city is either Srinagar or Delhi.
-- - Their age is between 25 and 35, inclusive.
-- - Their salary is not between ₹40,000 and ₹60,000, inclusive.

-- Display these columns:
-- - `employee_name`
-- - `city`
-- - `age`
-- - `salary`

-- Sort the results by city alphabetically, then by age from youngest to oldest.
-- Write one MySQL query.

SELECT * FROM employees;
SELECT employee_name, city, age, salary
FROM employees
WHERE (city IN ('Srinagar', 'Delhi')) AND (age BETWEEN 25 AND 35) AND (salary NOT BETWEEN 40000 AND 60000)
ORDER BY city ASC, age ASC;







-- Query 5 of 5
-- Using the existing `employees` table, retrieve employees who:

-- - Have no email address stored.
-- - Earn at least ₹45,000.
-- - Are not in the Finance department.

-- Display these columns:
-- - `employee_name`
-- - `department`
-- - `salary`
-- - `email`

-- Sort the results by salary from highest to lowest.
-- Write one MySQL query.
SELECT employee_name, department, salary, email
FROM employees
WHERE email IS NULL AND salary >= 45000 AND department != 'Finance'
ORDER BY salary DESC;



