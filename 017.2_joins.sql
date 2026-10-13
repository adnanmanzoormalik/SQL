-- FULL JOIN : all left with right null + common + all right with left NULL
-- it combines the result of both left join and right join

-- CREATE DATABASE friends_db;
USE friends_db;
/*
-- Create tables for our demonstration
CREATE TABLE characters (
    character_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    occupation VARCHAR(100)
);

CREATE TABLE apartments (
    apartment_id INT PRIMARY KEY,
    building_address VARCHAR(100) NOT NULL,
    apartment_number VARCHAR(10) NOT NULL,
    monthly_rent DECIMAL(8, 2),
    current_tenant_id INT
);

-- Sample Data
-- ====================================================================
-- Insert data into characters
INSERT INTO characters (character_id, first_name, last_name, occupation) VALUES
(1, 'Ross', 'Geller', 'Paleontologist'),
(2, 'Rachel', 'Green', 'Fashion Executive'),
(3, 'Chandler', 'Bing', 'IT Procurement Manager'),
(4, 'Monica', 'Geller', 'Chef'),
(5, 'Joey', 'Tribbiani', 'Actor'),
(6, 'Phoebe', 'Buffay', 'Massage Therapist'),
(7, 'Gunther', 'Smith', 'Coffee Shop Manager'),
(8, 'Janice', 'Hosenstein', 'Unknown');

-- Insert data into apartments
INSERT INTO apartments (apartment_id, building_address, apartment_number, monthly_rent, current_tenant_id) VALUES
(101, '90 Bedford Street', '20', 3500.00, 3),
(102, '90 Bedford Street', '19', 3500.00, 4),
(103, '5 Morton Street', '14', 2800.00, 6),
(104, '17 Grove Street', '3B', 2200.00, NULL),
(105, '15 Yemen Road', 'Yemen', 900.00, NULL),
(106, '495 Grove Street', '7', 2400.00, 1);
*/

-- View table data
SELECT * FROM characters;
SELECT * FROM apartments; 


SELECT * FROM characters AS c
LEFT JOIN apartments AS a
    ON c.character_id = a.current_tenant_id
UNION
SELECT * FROM characters AS c
RIGHT JOIN apartments AS a
    ON c.character_id = a.current_tenant_id;

-- PostgreSQL supports FULL JOIN




 
-- CROSS JOIN
-- Cartesian product of two tables
-- It combines each row from the first table with every row from the second table
-- resulting in all possible combinations of rows
/*
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);
CREATE TABLE colors (
    color_id INT PRIMARY KEY,
    color_name VARCHAR(30) NOT NULL
);
INSERT INTO products (product_id, product_name) VALUES
(1, 'T-shirt'),
(2, 'Jeans'),
(3, 'Sweater'),
(4, 'Jacket');
INSERT INTO colors (color_id, color_name) VALUES
(1, 'Red'),
(2, 'Blue'),
(3, 'Green'),
(4, 'Black'),
(5, 'White');
select p.product_name, c.color_name from products p cross join colors c;
CREATE TABLE sizes (
    size_id INT PRIMARY KEY,
    size_name VARCHAR(10) NOT NULL
);
INSERT INTO sizes (size_id, size_name) VALUES
(1, 'S'),
(2, 'M'),
(3, 'L'),
(4, 'XL');
*/
SELECT p.product_name, c.color_name FROM products p
CROSS JOIN colors c;

SELECT CONCAT(p.product_name, ", ", s.size_name, ", ",c.color_name ) AS variants FROM products p
CROSS JOIN sizes AS s
CROSS JOIN colors AS c
WHERE p.product_name = "T-shirt";







-- Self JOIN in SQL Demonstration
-- This script demonstrates how to use Self JOINs to query hierarchical and relational data
-- within the same table, using an employee management system example.

/*
-- Create employees table with manager_id referencing the same table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_title VARCHAR(100),
    salary DECIMAL(10, 2),
    department VARCHAR(50),
    manager_id INT,
    hire_date DATE
);

-- Insert sample employee data with hierarchical management structure
INSERT INTO employees VALUES
(1, 'James', 'Smith', 'CEO', 150000.00, 'Executive', NULL, '2010-01-15'),
(2, 'Sarah', 'Johnson', 'CTO', 140000.00, 'Technology', 1, '2011-03-10'),
(3, 'Michael', 'Williams', 'CFO', 140000.00, 'Finance', 1, '2012-07-22'),
(4, 'Jessica', 'Brown', 'HR Director', 110000.00, 'Human Resources', 1, '2013-05-18'),
(5, 'David', 'Miller', 'Senior Developer', 95000.00, 'Technology', 2, '2014-11-05'),
(6, 'Emily', 'Davis', 'Developer', 80000.00, 'Technology', 5, '2016-08-12'),
(7, 'Robert', 'Wilson', 'Junior Developer', 65000.00, 'Technology', 5, '2019-02-28'),
(8, 'Jennifer', 'Taylor', 'Accountant', 75000.00, 'Finance', 3, '2015-09-17'),
(9, 'Thomas', 'Anderson', 'Accountant', 72000.00, 'Finance', 3, '2017-06-24'),
(10, 'Lisa', 'Martinez', 'HR Specialist', 68000.00, 'Human Resources', 4, '2018-04-30');
*/

SELECT * FROM employees;

SELECT emp.first_name AS emp_name,  mng.first_name AS mng_name FROM employees AS emp
JOIN employees AS mng
    ON mng.employee_id = emp.manager_id;


-- Find employees who work in the same department
SELECT department, COUNT(*), GROUP_CONCAT(first_name SEPARATOR ', ')
FROM employees
GROUP BY department;


SELECT * FROM employees e1 JOIN employees e2 ON e1.department = e2.department AND e1.employee_id < e2.employee_id; 

 
-- find employees who earn more than their manager
SELECT e.first_name, e.salary, m.first_name, m.salary FROM employees AS e
JOIN employees AS m ON m.employee_id = e.manager_id AND m.salary < e.salary;


-- calculate avg_salary diff between employees and managers by department


