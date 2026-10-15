USE nexora_analytics;
/*
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30),
    location VARCHAR(50)
);

INSERT INTO departments
    (department_id, department_name, location)
VALUES
    (1, 'IT', 'Bengaluru'),
    (2, 'HR', 'Mumbai'),
    (3, 'Finance', 'Delhi');
*/
SELECT * FROM employees;
SELECT * FROM departments;



-- >>> JOIN + AGGREGATE FUNCTIONS

-- The company wants a summary rather than individual employee records.
-- Required output:
-- - Department name
-- - Number of employees
-- - Total salary
-- - Average salary

SELECT d.department_name, COUNT(e.employee_id), SUM(e.salary), AVG(e.salary)
FROM departments AS d
JOIN employees AS e
    ON e.department = d.department_name
GROUP BY d.department_name;
/*
INSERT INTO departments
    (department_id, department_name, location)
VALUES
    (4, 'Marketing', 'Hyderabad');
*/

-- now a department has no employee and we dont want to show null in our table
SELECT d.department_name, COUNT(e.employee_id), COALESCE(SUM(e.salary), 0.00), ROUND(COALESCE(AVG(e.salary), 0.00), 2)
FROM departments AS d
LEFT JOIN employees AS e
    ON e.department = d.department_name
GROUP BY d.department_name;









-- >>> CTE with window functions

-- Imagine the company wants a report showing:
-- - Every employee's name, department, and salary.
-- - The average salary in their department.
-- - Each employee's salary rank within their department.
-- - Only employees whose salary is above their department's average.

WITH emps AS (
    SELECT
        employee_name,
        department,
        salary,
        AVG(salary) OVER(
            PARTITION BY department
        ) AS avg_sal_dept,
        DENSE_RANK() OVER(
            PARTITION BY department
            ORDER BY salary DESC
        ) AS sal_rank_dept
    FROM employees
)
SELECT * FROM emps 
WHERE salary > avg_sal_dept;



















