USE college;
/*
-- 1. Create the table
CREATE TABLE IF NOT EXISTS emps2 (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    bonus INT NULL,
    manager_id INT NULL
);
-- 2. Insert the records
INSERT INTO emps2 (id, name, department, salary, bonus, manager_id) VALUES
(1, 'Adnan', 'IT', 40000, 5000, 101),
(2, 'Aisha', 'HR', 35000, NULL, 102),
(3, 'Rahul', 'IT', 60000, 8000, NULL),
(4, 'Sara', 'Sales', 45000, 3000, 101),
(5, 'Zoya', 'HR', 30000, NULL, 104);
*/
SELECT * FROM emps2;


-- >>> CASE WHEN lets you return different values depending on whether conditions are true. Think of it like if / elif / else in Python. (general SQL)
/* Syntax:
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
*/
SELECT name, salary,
CASE
    WHEN salary >= 50000 THEN "High Salary"
    WHEN salary >= 35000 THEN "Average Salary"
    ELSE "Low Salary" -- >>> If you omit ELSE, the result is NULL when no condition matches.
END AS salary_category 
FROM emps2;

SELECT name,
CASE
    WHEN department="IT" THEN "Technology"
    WHEN department="HR" THEN "Human Resources"
    WHEN department="Sales" THEN "Sales Team"
    ELSE "NO DEPTT"
END AS deptt_grp
FROM emps2;



-- >>> IF() function evaluates one condition and returns one of two values. (it is a MySQL specific function)
-- Syntax: IF(condition, value_if_true, value_if_false)
SELECT name,
IF(department="HR", "SHITTY", "NOT SHITTY") AS dept_rating
FROM emps2;



-- >>> IFNULL() returns a replacement value when the first expression is NULL.
-- Syntax: IFNULL(expression, replacement_value)
SELECT name, bonus,
IFNULL(bonus, 0) AS display_bonus
FROM emps2;

SELECT name,
IFNULL(bonus, 0)+salary AS total_pay
FROM emps2;
-- This calculates total pay without producing a NULL total just because the bonus is missing.
-- Without IFNULL(), adding a NULL bonus to a salary normally produces NULL.



-- >>> COALESCE() checks multiple expressions from left to right and returns the first value that is not NULL.
SELECT name, COALESCE(manager_id, 0) AS display_mng_id FROM emps2;
SELECT name, COALESCE(bonus, salary, 0) AS display_pay1 FROM emps2;



-- >>> CAST() explicitly converts an expression to a specified type.
/* Syntax: CAST(expression AS data_type) 
use cases:
0. using calculations on numbers written as text
1. Preserving Decimals in Division
2. Stripping Time from Timestamps
3. Fixing Alphabetical Sorting on Numbers
4. Text Concatenation and Formatting
5. Matching Column Types for UNION
etc etc
MySQL types used with CAST():
CHAR                Character string
SIGNED              Signed integer
UNSIGNED            Non-negative integer representation
DECIMAL(p,s)        Decimal number with precision and scale
DATE                Date value
DATETIME            Date and time value
*/
SELECT CAST(salary AS CHAR) AS salary_text FROM emps2;
SELECT CAST("450000" AS SIGNED)/12 AS converted_monthly_salary;
SELECT CAST(salary AS DECIMAL(10,2)) AS decimal_sal FROM emps2;
SELECT "2026-10-02" AS string_date, CAST("2026-10-03" AS DATE) AS date_date;




-- >>> CONVERT() — Another way to convert data types
-- MySQL's CONVERT() can also change the data type of an expression.
-- Syntax: CONVERT(expression, data_type)
SELECT "2026-10-03" AS string_date, CONVERT("2026-10-03", DATE) AS date_date;
SELECT CONVERT(salary, DECIMAL(10,3)) AS decimal_sal FROM emps2;


-- >>> IMPLICIT and EXPLICIT conversion

-- Implicit conversion: MySQL may automatically convert a value when an operation requires a compatible type.
SELECT CONCAT(500, "100");
SELECT "100" + 50;
-- Best practice: When a conversion matters to the logic of your query, use explicit conversion so your intention is clear. Avoid relying on implicit conversion for messy or unvalidated input.

-- Explicit conversion: You specify the conversion yourself.
SELECT CAST("100" AS SIGNED)+50 AS result;




