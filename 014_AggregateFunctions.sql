CREATE DATABASE IF NOT EXISTS aggregate_func;
USE aggregate_func;
/*
CREATE TABLE IF NOT EXISTS employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    age INT,
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2)
);

INSERT INTO employees(id, name, department, age, salary, bonus)
VALUES
(1, 'Adnan', 'IT', 22, 50000, 5000),
(2, 'Rahul', 'IT', 25, 60000, 7000),
(3, 'Sara', 'HR', 28, 45000, 4000),
(4, 'Aisha', 'HR', 24, 48000, NULL),
(5, 'John', 'Finance', 30, 70000, 10000),
(6, 'Mike', 'Finance', 27, 65000, NULL),
(7, 'Zara', 'IT', 23, 55000, 6000),
(8, 'Ali', 'Finance', 32, 75000, 12000);
*/
SELECT * FROM employees;


-- >>> AGGREGATE FUNCTIONS: An aggregate function takes multiple rows and produces one result.

-- >>> COUNT(): counts rows/values.
SELECT COUNT(*) FROM employees;
SELECT COUNT(bonus) FROM employees; -- >>> COUNT(column) does not count NULL values.
-- COUNT(*)       → counts row
-- COUNT(column)  → counts non-NULL values


-- >>> SUM(): adds numeric values
SELECT SUM(salary) FROM employees;
SELECT SUM(bonus) FROM employees; -- NULL values are ingored in SUM()


-- >>> AVG(): calculates the average.
SELECT AVG(salary) FROM employees;
SELECT AVG(bonus) FROM employees; -- >>> since AVG() ignores null values, this will be 44000 / 6 = 7333.33... and not 44000/8


-- >>> MIN(): finds the smallest value
SELECT MIN(salary) FROM employees;
SELECT MIN(bonus) FROM employees; -- >>> NULL is ignored


-- >>> MAX(): finds the largest VALUES
SELECT MAX(salary) FROM employees;


-- practice

SELECT COUNT(*) AS num_of_emps FROM employees; -- The total number of employees.
SELECT COUNT(bonus) AS num_of_employees_with_bonus FROM employees; -- How many employees have a recorded bonus?
SELECT SUM(salary) AS total_salary FROM employees; -- The total salary paid to all employees.
SELECT AVG(salary) AS avg_salary FROM employees; -- The average employee salary.
SELECT MIN(salary) AS lowest_salary, MAX(salary) AS highest_salary FROM employees; -- The lowest and highest salary.






