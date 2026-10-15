-- CTE stands for Common Table Expression.
-- A CTE is a named result set that you define at the beginning of a SQL statement using the WITH clause. You can then reference it in the main query as if it were a table.


USE nexora_advanced_sql;
/*
CREATE TABLE staff (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    manager_id INT NULL
);

INSERT INTO staff
    (employee_id, employee_name, department, salary, manager_id)
VALUES
    (1, 'Arjun Mehta', 'IT', 90000, NULL),
    (2, 'Aisha Khan', 'IT', 65000, 1),
    (3, 'Rahul Sharma', 'IT', 55000, 1),
    (4, 'Sara Ahmed', 'HR', 70000, NULL),
    (5, 'Imran Dar', 'HR', 45000, 4),
    (6, 'Zoya Mir', 'Finance', 80000, NULL),
    (7, 'Kabir Wani', 'Finance', 50000, 6),
    (8, 'Mehak Singh', 'IT', 40000, 2);
*/

SELECT * FROM staff;


WITH high_earners AS (
    SELECT * FROM staff
    WHERE salary > 60000
)
SELECT * FROM high_earners;

-- NOTE: The CTE exists only for the statement in which it is defined. It doesn't create a permanent table, and you can't refer to it in a separate SQL statement.



-- CTEs can be queried further
WITH high_earners AS (
    SELECT * FROM staff
    WHERE salary > 60000
)
SELECT * FROM high_earners
WHERE department="IT";



-- multiple CTEs
-- 1. Calculate the average salary for each department.
-- 2. Find departments whose average salary exceeds ₹60,000.
-- 3. Display their average salaries in descending order.

WITH avg_dept_sal AS (
    SELECT department, AVG(salary) AS avg_sal
    FROM staff
    GROUP BY department
),
high_avg_dept_sal AS (
    SELECT department, avg_sal
    FROM avg_dept_sal
    WHERE avg_sal > 60000
)
SELECT * FROM high_avg_dept_sal ORDER BY avg_sal DESC;

-- Separate CTE definitions with commas, not additional WITH keywords.
-- A later CTE can reference an earlier CTE.
-- The final query follows the CTE definitions.
-- A CTE is not automatically a temporary physical table. MySQL's optimizer may merge it into the surrounding query or materialize its result, depending on the query and execution plan.







-- CTEs vs subqueries
-- A subquery is a query nested inside another query. A CTE is a named query defined before the main query.




-- A recursive CTE has two main parts:
-- 1. Anchor member: supplies the starting rows.
-- 2. Recursive member: uses the previous iteration's rows to find the next rows.
-- These are joined with UNION ALL in the recursive CTE.

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1
    FROM numbers
    WHERE n<5
)
SELECT * FROM numbers;



WITH RECURSIVE hierarchy AS (
    SELECT 
    employee_id, 
    manager_id,
    0 AS hierarchy_level
    FROM staff
    WHERE employee_id =1

    UNION ALL

    SELECT 
        s.employee_id,
        s.manager_id,
        h.hierarchy_level + 1
    FROM staff AS s
    JOIN hierarchy as h
        ON s.manager_id = h.employee_id
)
SELECT * FROM hierarchy
ORDER BY hierarchy_level;






