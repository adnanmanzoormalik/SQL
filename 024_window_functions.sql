CREATE DATABASE IF NOT EXISTS nexora_analytics;
USE nexora_analytics;
/*
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    salary DECIMAL(10,2),
    joining_date DATE
);

INSERT INTO employees
    (employee_id, employee_name, department, salary, joining_date)
VALUES
    (101, 'Aarav',  'IT',      80000, '2022-01-10'),
    (102, 'Diya',   'IT',      95000, '2021-03-15'),
    (103, 'Kabir',  'IT',      95000, '2023-06-01'),
    (104, 'Meera',  'HR',      60000, '2020-08-20'),
    (105, 'Arjun',  'HR',      70000, '2022-11-05'),
    (106, 'Zoya',   'HR',      75000, '2021-09-12'),
    (107, 'Rohan',  'Finance', 90000, '2019-04-18'),
    (108, 'Isha',   'Finance', 85000, '2023-02-14'),
    (109, 'Vikram', 'Finance', 90000, '2020-12-01'),
    (110, 'Sara',   'IT',      70000, '2024-01-08');
*/
SELECT * FROM employees;


-- A window function performs a calculation across related rows without combining those rows into one result row.

SELECT employee_name, department, salary, AVG(salary) OVER (
    PARTITION BY department
) AS dept_avg
FROM employees;

-- OVER() tells MySQL that a function should operate as a window function.

SELECT employee_name, salary, SUM(salary) OVER() AS total_salary
FROM employees;


-- PARTITION BY divides the result into separate logical groups for a window calculation.
-- Think of it as calculating something separately for each department without removing any employees.
SELECT employee_name, salary, department, SUM(salary) OVER(
    PARTITION BY department
) AS dept_total_sal
FROM employees;

SELECT employee_name, salary, department, SUM(salary) OVER(
    PARTITION BY department, joining_date -- we can also use multiple columns with PARTITION BY
) AS total_sal_of_partition
FROM employees;
-- PARTITION BY creates calculation groups; it does not physically group or remove rows.



-- Inside OVER(), ORDER BY determines the order in which rows are processed by the window function.
SELECT employee_name, salary, department, SUM(salary) OVER(
    ORDER BY employee_name
) AS dept_total_sal
FROM employees;
SELECT employee_name, salary, department, SUM(salary) OVER(
    ORDER BY employee_name ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
 ) AS dept_total_sal
FROM employees;



-- Window functions vs GROUP BY
-- This is one of the most important concepts in Phase 3.
-- Feature	                                                        GROUP BY	            Window functions
-- Combines rows into groups	                                    Yes	                    No
-- Preserves individual employee rows	                            Usually no	            Yes
-- Can show employee details and department average together	    Not directly	        Yes
-- Can calculate rankings	                                        No, not by itself	    Yes
-- Can calculate running totals	                                    Not directly	        Yes



-- ROW_NUMBER() assigns a unique sequential number to every row within a window.
-- Suppose we want to number employees from highest to lowest salary within each department.
SELECT employee_id, employee_name, department, salary, ROW_NUMBER() OVER(
    PARTITION BY department
    ORDER BY salary DESC
) AS serial_number FROM employees;
-- ROW_NUMBER() always assigns different numbers to rows, even when their salaries are equal.



-- RANK() assigns the same rank to tied values, then skips subsequent rank numbers.
SELECT employee_id, employee_name, department, salary, RANK() OVER(
    ORDER BY salary DESC
) AS salary_rank FROM employees;
-- two employees share rank 1, so rank 2 is skipped.

-- DENSE_RANK() also assigns the same rank to tied values, but it does not skip rank numbers.
SELECT employee_id, employee_name, department, salary, DENSE_RANK() OVER(
    ORDER BY salary DESC
) AS salary_dense_rank FROM employees;


-- Find the salary rank of every employee within their own department.
SELECT 
    employee_id, 
    employee_name, 
    department, 
    salary, 
    ROW_NUMBER() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS serial_number,
    DENSE_RANK() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;




-- LAG() lets you access a value from a previous row without joining the table to itself.
SELECT employee_name, salary, LAG(salary, 1) OVER(
    ORDER BY salary DESC
) AS prev_higher_sal
FROM employees;
-- To retrieve the salary from two rows earlier:
-- LAG(salary, 2) OVER (
--     ORDER BY salary DESC, employee_id
-- )
SELECT employee_name, salary, LAG(salary) OVER(
    ORDER BY salary DESC
) AS prev_higher_sal
FROM employees;
SELECT employee_name, salary, LAG(salary, 1, 0) OVER(
    ORDER BY salary DESC, employee_id
) AS prev_higher_sal
FROM employees;



-- LEAD() is the opposite of LAG(). It retrieves a value from a subsequent row.
SELECT employee_id, salary, LEAD(salary) OVER(
    ORDER BY salary DESC
) AS next_low_sal
FROM employees;




-- FIRST_VALUE() returns the first value in the ordered window frame.
SELECT employee_name, salary,department, FIRST_VALUE(salary) OVER(
    PARTITION BY department
    ORDER BY salary DESC
) AS highest_sal_in_dept
FROM employees;



-- LAST_VALUE() returns the last value in the current window frame. 
-- There is an important detail: the default frame often ends at the current row or its peers, rather than at the end of the entire partition.
SELECT employee_name, department, salary, LAST_VALUE(salary) OVER(
    PARTITION BY department
    ORDER BY salary DESC, employee_id
    ROWS BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING
) AS lowest_dept_sal
FROM employees;


-- Running totals
-- A running total accumulates values as you move through an ordered set of rows.
-- Real-world uses:
-- - Cumulative sales by date.
-- - Total spending over time.
-- - Cumulative salary amounts in a ranking.
-- - Tracking progress toward a target.
SELECT employee_name, department, salary, SUM(salary) OVER(
    PARTITION BY department
    ORDER BY salary, employee_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_sal
FROM employees;

-- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING







-- Moving averages: A moving average calculates the average across a rolling group of rows.
SELECT employee_name, salary, AVG(salary) OVER(
    ORDER BY salary DESC, employee_id
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
) AS running_avg
FROM employees;

SELECT employee_name, salary, AVG(salary) OVER(
    ORDER BY salary DESC, employee_id
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) AS running_avg
FROM employees;



-- DENSE_RANK(), RANK(), ROW_NUMBER()

SELECT employee_name, salary, department, RANK() OVER(
    PARTITION BY department
    ORDER BY salary DESC, employee_name DESC
) AS sal_rank
FROM employees;



-- Find the top two highest-paid employees in every department.
-- A normal WHERE clause cannot directly filter a window-function result at the same query level. Instead, calculate the ranking in a CTE and filter it in the outer query.
WITH emps AS (
    SELECT 
        employee_id, 
        employee_name, 
        salary, 
        department, 
        ROW_NUMBER() OVER(
            PARTITION BY department
            ORDER BY salary DESC, employee_id
        ) AS rn
    FROM employees
)
SELECT * FROM emps WHERE rn<=2;


-- Percentage of total
-- Window functions can calculate each employee's contribution to the overall salary total.
-- Problem: What percentage of the company's total salary does each employee represent?
SELECT employee_name, salary, ROUND(salary*100 / SUM(salary) OVER(), 2) as sal_prcntg FROM employees;


/*
10. Window frames and frame clauses
A window frame determines which rows are included in the calculation for the current row.

The three most important boundaries are:
Frame boundary	                    Meaning
UNBOUNDED PRECEDING	                Start at the first row in the partition
n PRECEDING	                        Start a specified number of rows before the current row
CURRENT ROW	                        The current row
n FOLLOWING	                        A specified number of rows after the current row
UNBOUNDED FOLLOWING	                End at the last row in the partition


Common frame patterns...

A. Running total
ROWS BETWEEN UNBOUNDED PRECEDING
         AND CURRENT ROW
Everything from the first row through the current row.

B. Three-row moving average
ROWS BETWEEN 2 PRECEDING
         AND CURRENT ROW
The current row and the two rows before it.

C. Entire partition
ROWS BETWEEN UNBOUNDED PRECEDING
         AND UNBOUNDED FOLLOWING
Every row in the partition, regardless of the current row.

D. Centered three-row window
ROWS BETWEEN 1 PRECEDING
         AND 1 FOLLOWING
The previous row, current row, and next row when available.

ROWS versus RANGE
- ROWS defines the frame by physical row positions.
- RANGE defines the frame by ordering values and their peers, so tied ordering values may be included together.
*/




-- 1. Display every employee's name, department, salary, department's average salary, department's total salary, and salary rank within their department.
-- Requirements: - Include all employees. - Rank the highest salary as 1. - Employees with equal salaries must receive the same rank, without gaps.
SELECT 
    employee_name, 
    department, 
    salary, 
    AVG(salary) OVER(
        PARTITION BY department
    ) AS dept_avg_salary,
    SUM(salary) OVER(
        PARTITION BY department
    ) AS dept_total_sal,
    DENSE_RANK() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS sal_rank
FROM employees;



-- 2. Display every employee's name, salary, previous salary, next salary, and the difference between their salary and the previous employee's salary.
-- Requirements: - Order employees from highest to lowest salary. - Use employee_id to break salary ties. - Keep employees who have no previous or next row.

WITH emps AS (
    SELECT 
    employee_name, 
    employee_id,
    salary,
    LAG(salary, 1) OVER(
        ORDER BY salary DESC, employee_id
    ) AS prev_sal,
    LEAD(salary, 1) OVER(
        ORDER BY salary DESC, employee_id
    ) AS nex_sal
    FROM employees
) 
SELECT 
    employee_name, 
    salary,
    prev_sal,
    nex_sal,
    ABS(salary - prev_sal) AS sal_diff
FROM emps;
    
    
-- 3. Display every employee's name, department, salary, running total of salaries, and percentage contribution to the company's total salary.
-- Requirements:
-- - Calculate the running total from lowest to highest salary.
-- - Ensure tied salaries are processed one employee at a time.
-- - Round the percentage contribution to two decimal places.
SELECT 
    employee_name, 
    department, 
    salary, 
    SUM(salary) OVER(
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW 
    ) AS running_sal,
    ROUND(
        salary*100 / SUM(salary) OVER(), 2
        ) AS percnt_contrib
FROM employees; 


-- 4. Return the two highest-paid employees from each department, displaying employee name, department, salary, and rank.
-- Requirements:
-- - Return no more than two employees per department.
-- - Resolve salary ties deterministically.
-- - Use a CTE to produce the final result.

WITH emps AS (
    SELECT 
        employee_id,
        employee_name, 
        department, 
        salary, 
        ROW_NUMBER() OVER(
            PARTITION BY department
            ORDER BY salary DESC, employee_id
        ) AS rn,
        RANK() OVER(
            PARTITION BY department
            ORDER BY salary DESC
        ) AS r
    FROM employees
)
SELECT 
    employee_name, 
    department, 
    salary, 
    r
FROM emps
WHERE rn <= 2;




-- 5. Display every employee's name, salary, three-row moving average of salary, highest salary in the company, and lowest salary in the company.
-- Requirements:
-- - Order employees by salary from lowest to highest, using employee_id to break ties.
-- - Calculate the moving average using the current employee and the two preceding employees.
-- - Ensure the highest and lowest salary columns show the company-wide values on every row.
-- - Round the moving average to two decimal places.

SELECT 
    employee_name, 
    salary, 
    ROUND(AVG(salary) OVER(
        ORDER BY salary, employee_id 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS three_row_moving_avg,
    MAX(salary) OVER() AS highest_sal,
    MIN(salary) OVER() AS lowest_sal
FROM employees;





























