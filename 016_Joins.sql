USE joins;
/*
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments (department_id, department_name, location)
VALUES
(1, 'IT', 'Srinagar'),
(2, 'HR', 'Delhi'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Bangalore');

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department_id INT,
    salary DECIMAL(10,2)
);

INSERT INTO employees
(employee_id, name, age, department_id, salary)
VALUES
(101, 'Adnan', 22, 1, 60000),
(102, 'Rahul', 25, 2, 50000),
(103, 'Aisha', 24, 1, 65000),
(104, 'Zoya', 27, 3, 70000),
(105, 'Arjun', 23, 2, 52000),
(106, 'Sara', 26, NULL, 48000);
*/

SELECT * FROM departments;
SELECT * FROM employees; 
-- JOIN: is an operation used to combine rows from two or more tables based on a related column between them (typically a foreign key referencing a primary key).

SELECT *
FROM employees
JOIN departments
ON employees.department_id = departments.department_id;  -- Match employees with departments where their department IDs are equal.


-- >>> 1. INNER JOIN: returns only rows where a match exists in both tables.
SELECT * FROM employees
JOIN departments
ON employees.department_id = departments.department_id;
-- NOTE: INNER JOIN and JOIN keywords work the same

-- Selecting specific columns
SELECT 
    employees.employee_id as EMP_ID, 
    employees.name AS NAME, 
    departments.department_name as DEPT_NAME
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

-- Qualified column name is a column name that explicitly includes its table name (or table alias) before it, using dot notation: table_name.column_name

-- Table Alias
SELECT e.employee_id, d.department_id
FROM employees AS e -- >>> "AS" here is totally optional
INNER JOIN departments d
ON e.department_id = d.department_id;


-- >>> 2. LEFT JOIN: ALL rows from the left table + matching rows from the right table.
-- Keeps every employee, even if that employee doesn't have a matching department.
SELECT e.employee_id, e.name, d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

-- PRACTICE: Find Employees Without a Department
SELECT e.employee_id, e.name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IS NULL;



-- >>> 3. RIGHT JOIN: is essentially the opposite perspective of LEFT JOIN
SELECT e.employee_id AS e_id, e.name AS e_name, d.department_name AS d_name
FROM employees AS e
RIGHT JOIN departments AS d
ON e.department_id = d.department_id; -- Marketing has no employee, so the employee columns become NULL.

-- NOTE: RIGHT JOIN Can Usually Be Rewritten as LEFT JOIN


-- JOIN + WHERE + ORDER BY: 
SELECT e.employee_id, e.name, d.department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.department_name = "IT"
ORDER BY e.employee_id ASC;


-- JOIN + GROUP BY
SELECT 
d.department_name AS Deptt_Name, 
COUNT(e.employee_id) AS No_of_Emps
FROM departments AS d
LEFT JOIN employees AS e
ON e.department_id = d.department_id
GROUP BY d.department_name;





-- PRACTICE >>> 
/*
CREATE TABLE departments1 (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO departments1
(department_id, department_name, location)
VALUES
(1, 'IT', 'Srinagar'),
(2, 'HR', 'Delhi'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Bangalore');

CREATE TABLE employees1 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department_id INT,
    salary DECIMAL(10,2)
);

INSERT INTO employees1
(employee_id, name, age, department_id, salary)
VALUES
(101, 'Adnan', 22, 1, 60000),
(102, 'Rahul', 25, 2, 50000),
(103, 'Aisha', 24, 1, 65000),
(104, 'Zoya', 27, 3, 70000),
(105, 'Arjun', 23, 2, 52000),
(106, 'Sara', 26, NULL, 48000);

*/

SELECT * FROM employees1;
SELECT * FROM departments1;

-- 1. Display the employee name and department name for all employees who have a matching department.
SELECT e.name, d.department_name
FROM employees1 AS e
INNER JOIN departments1 AS d
ON e.department_id = d.department_id;

-- 2. Display employee_id, name, salary, department_name for all employees with a matching department.
SELECT e.employee_id, e.name, e.salary, d.department_name
FROM employees1 AS e
INNER JOIN departments1 AS d
ON e.department_id = d.department_id;

-- 3. Display all employees, including employees who don't have a department. Show: name, department_name
SELECT e.name, d.department_name
FROM employees1 AS e
LEFT JOIN departments1 AS d
ON e.department_id = d.department_id;


-- 4. Display all departments, including departments that currently have no employees. Show: department_name, employee_name
SELECT d.department_name, e.name
FROM employees1 AS e
RIGHT JOIN departments1 AS d
ON e.department_id = d.department_id;

-- 5. Find all employees who do not belong to any department. Show: employee_id, name
SELECT e.employee_id, e.name
FROM employees1 AS e
WHERE e.department_id IS NULL;

-- or we can do
SELECT e.employee_id, e.name
FROM employees1 AS e
LEFT JOIN departments1 AS d
ON e.department_id = e.department_id
WHERE e.department_id IS NULL;

-- 6. Find all departments that currently have no employees. Show: department_id, department_name
SELECT d.department_id, d.department_name
FROM departments1 AS d
LEFT JOIN employees1 AS e
ON d.department_id = e.department_id
WHERE e.department_id IS NULL;


-- 7. Display employees working in the IT department. Show: name, salary, department_name
SELECT e.name, e.salary, d.department_name
FROM employees1 AS e
INNER JOIN departments1 AS d
ON e.department_id = d.department_id
WHERE d.department_name = "IT";


-- 8. Display all employees and their department locations, sorted by salary from highest to lowest.
SELECT e.employee_id, e.name, d.location
FROM employees1 AS e
INNER JOIN departments1 AS d
ON e.department_id = d.department_id
ORDER BY e.salary DESC;


-- 9. Using table aliases, display: employee name, department name, location for every employee with a matching department.
SELECT e.name, d.department_name, d.location
FROM employees1 AS e
INNER JOIN departments1 AS d
ON e.department_id = d.department_id;


-- 10. Find the number of employees in each department, including departments with zero employees. Show: department_name, employee_count
SELECT d.department_name, COUNT(e.employee_id) AS num_of_emps
FROM departments1 AS d
LEFT JOIN employees1 AS e
ON e.department_id = d.department_id
GROUP BY d.department_name;
