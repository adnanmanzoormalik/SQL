USE aggregate_func;
SELECT * FROM employees;

-- >>> GROUP BY
/*
SELECT column, aggregate_function(column)
FROM table
GROUP BY column;
*/
SELECT department, COUNT(*) FROM employees GROUP BY department;
SELECT department, SUM(salary) FROM employees GROUP BY department;
SELECT department, AVG(salary) FROM employees GROUP BY department;

-- using GROUP BY with multiple columns
SELECT department, age, COUNT(*) FROM employees GROUP BY department, age;


-- >>> HAVING 
SELECT 
    department, 
    AVG(salary) AS avg_salary 
FROM employees 
GROUP BY department 
HAVING AVG(salary)>50000;


-- >>> WHERE vs HAVING

-- >>> WHERE: filters individual rows before grouping.
SELECT department, AVG(salary)
FROM employees
WHERE salary > 50000
GROUP BY department;


-- >>> HAVING: filters groups after grouping/aggregation.
SELECT department, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;


-- >>> CASE
SELECT 
    name,
    salary,
    CASE
        WHEN salary>=45000 THEN "High Salary"
        WHEN salary>=35000 THEN "Mid Salary"
        ELSE "Low Salary"
    END AS salary_category
FROM employees;

SELECT
    department,
    SUM(
        CASE
            WHEN salary >= 50000 THEN 1
            ELSE 0
        END
    ) AS no_of_high_sal
FROM employees
GROUP BY department;

SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(
        CASE
            WHEN salary >= 60000 THEN 1
            ELSE 0
        END
    ) AS high_salary_emps
FROM employees
GROUP BY department;

-- when we want avg sal of only IT
SELECT
    AVG(
        CASE 
            WHEN department="IT" THEN salary
        END
    ) as av_it_sal
FROM employees;




-- practice 
-- Q1: Find the number of employees in each department.
SELECT department, COUNT(*) AS Num_of_emps FROM employees GROUP BY department;

-- Q2: Find the average salary for each department.
SELECT department, CAST(AVG(salary) AS DECIMAL(10,2)) AS dept_avg_sal FROM employees GROUP BY department;

-- Q3: Show only departments where the average salary is greater than 55,000.
SELECT department AS dept_with_highSal FROM employees GROUP BY department HAVING AVG(salary)>55000;

-- Q4: Find the total salary for each department, but only consider employees whose salary is at least 50,000.
SELECT department, SUM(salary) FROM employees WHERE salary >= 50000 GROUP BY department;

-- Q5: For each department, show: - total employees - number of employees earning >= 60,000 Use conditional aggregation with CASE WHEN.
SELECT 
    department, 
    COUNT(*) as total_emps,
    SUM(
    CASE
        WHEN salary >= 60000 THEN 1
        ELSE 0
    END
) as high_sal_emps
FROM employees
GROUP BY department;

-- Q6: Show each employee's name, salary, and a salary category: >= 70000 → High. >= 50000 → Medium. < 50000  → Low
SELECT
    name,
    salary,
    CASE
        WHEN salary >= 70000 THEN "High"
        WHEN salary >= 50000 THEN "Medium"
        ELSE "Low"
    END as salary_category
FROM employees;




