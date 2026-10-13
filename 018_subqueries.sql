USE JOINS;
SELECT * FROM employees1;

-- >>> Subquery is a SQL query written inside another SQL query.
SELECT name, salary
FROM employees1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees1
);

-- >>> Non-Correlated Subquery: when inner query doesnt depend on outer query, like above example


-- >>> Scalar subquery returns exactly one value.
SELECT * FROM employees1
WHERE salary = (
    SELECT MAX(salary) -- >>> SCALAR SUBQUERY must return only one value. You can't normally use a multi-row result where SQL expects one scalar value.
    FROM employees1
);


-- A single-row subquery (row query) is specifically defined by the fact that it returns exactly one row of data. 
-- it may have a single column or multiple columns
SELECT *
FROM employees1
WHERE employee_id = (
    SELECT employee_id
    FROM employees1
    WHERE name = 'Zoya'
);


-- Multiple-Row Subquery: return multiple rows
SELECT * FROM employees1
WHERE department_id IN (
    SELECT department_id FROM employees
    WHERE department_id IN (1,2)
);

-- with single values we use comparison operators like =, >, <, <=, >=
-- with multiple values we use IN, NOT IN, ANY, ALL


-- Subqueries in WHERE......This is the most common place you'll initially use subqueries.
-- Example 1 — Above average salary
SELECT name, salary
FROM employees1 
WHERE salary > (
    SELECT AVG(salary) FROM employees1
);

-- Example 2 — Highest salary
SELECT name, salary FROM employees1
WHERE salary = (
    SELECT MAX(salary) 
    FROM employees1
);



-- Subqueries in SELECT
SELECT 
    name, 
    salary,
    (SELECT CAST(AVG(salary) AS DECIMAL(10,2)) FROM employees) AS avg_sal
FROM employees1; 



-- Subqueries in FROM: A subquery can also act like a temporary table.
SELECT * 
FROM (
    SELECT * 
    FROM employees
    WHERE salary >= 50000) AS high_earners;



-- Correlated subquery depends on the current row of the outer query.
SELECT e.name, e.salary, e.department_id FROM employees1 as e
WHERE salary >= (
    SELECT AVG(e2.salary) FROM employees1 AS e2
    WHERE e.department_id = e2.department_id 
);



-- IN with a subquery ... lets say we want to compare department_name but thts nt present in the employees1 table
SELECT name, salary, department_id FROM employees1
WHERE department_id IN (
    SELECT department_id FROM departments1 WHERE location IN ("Delhi", "Mumbai") 
);

SELECT name, salary, department_id FROM employees1
WHERE department_id IN (
    SELECT department_id FROM departments1 WHERE location NOT IN ("Delhi", "Mumbai") -- BEWARE OF NULL DATA HERE
);



-- EXISTS checks whether a subquery returns at least one row.
-- SELECT 1: Inside EXISTS, we're checking whether a row exists, not retrieving its column values. Therefore, this is conventional:
SELECT d.department_name, d.department_id
FROM departments1 AS d WHERE EXISTS (
    SELECT 1 FROM employees AS e WHERE
        e.department_id = d.department_id
);

-- NOT EXISTS
SELECT d.department_name, d.department_id FROM departments1 AS d
WHERE NOT EXISTS (
    SELECT 1 FROM employees1 AS e WHERE
    e.department_id = d.department_id
);

-- NOTE: For finding missing relationships, NOT EXISTS is often a reliable choice, especially when nullable columns are involved.


-- EXISTS vs IN 
-- REAL LIFE ANALOGY
-- Using IN (The "Print a List" approach):
-- The guard prints out a sheet of paper with all approved department IDs (e.g., [1, 2, 3]).
-- When an employee walks up, the guard checks:
-- "Is your department ID written anywhere on this paper?"
-- Using EXISTS (The "Look up a record" approach):
-- The guard has no printed list. Instead, when an employee walks up, the guard looks into the computer database and asks:
-- "Can I find at least one valid department in Delhi or Mumbai with your department ID?"
-- As soon as the computer finds one match, it stops looking and lets the person in.




-- ANY: compares a value against the results of a subquery.
-- The comparison succeeds if it is true for at least one value returned by the subquery.
-- In MySQL, SOME is a synonym for ANY.

SELECT name, salary FROM employees1
WHERE salary > ANY(
    SELECT salary FROM employees1 WHERE department_id=2 
);



-- ALL: also compares a value against a subquery, but the comparison must be true for every value returned.
SELECT name, salary FROM employees1
WHERE salary > ALL(
    SELECT salary FROM employees1 WHERE department_id = 2
);




-- Subqueries vs JOINs
-- A subquery and a JOIN can sometimes solve the same problem, but they aren't interchangeable in every situation.
-- Let's find employees who belong to IT.
SELECT e.name AS IT_emps FROM employees1 AS e
INNER JOIN departments1 AS d
    ON e.department_id = d.department_id
WHERE d.department_name = "IT"; -- LEARN DIFF BETWEEN WHERE and AND here

SELECT e.name AS IT_emps FROM employees1 AS e
WHERE department_id = (
    SELECT department_id FROM departments1
    WHERE department_name = "IT"
);


-- Find second max salary
SELECT MAX(salary) FROM employees1
WHERE salary < (
    SELECT MAX(salary) FROM employees1
); -- this return one value only


SELECT name, salary FROM employees1
WHERE salary = (
    SELECT MAX(salary) FROM employees1
    WHERE salary < (
        SELECT MAX(salary) FROM employees1
    )
); -- this can return multiple rows with various columns



-- Find values above company's average
SELECT name, salary FROM employees1
WHERE salary > (
    SELECT AVG(salary) FROM employees1
);


-- Find values above department's average
SELECT e.name, e.salary FROM employees1 AS e
WHERE e.department_id IS NOT NULL
    AND salary > (
    SELECT AVG(e1.salary) 
    FROM employees1 AS e1
    WHERE e.department_id = e1.department_id
);



-- Finding records with missing relationships
SELECT e.name, e.salary FROM employees1 AS e
WHERE EXISTS(
    SELECT 1 FROM departments1 AS d
    WHERE d.department_id = e.department_id
);

SELECT 
    d.department_id, 
    d.department_name 
FROM departments1 as d
WHERE NOT EXISTS(
    SELECT 1
    FROM employees1 AS e
    WHERE d.department_id = e.department_id
);










