-- CREATE DATABASE nexora_advanced_sql;
USE nexora_advanced_sql;
/*
CREATE TABLE current_employees (
    employee_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50)
);
INSERT INTO current_employees
    (employee_id, full_name, department)
VALUES
    (1, 'Adnan Malik', 'IT'),
    (2, 'Aisha Khan', 'HR'),
    (3, 'Rahul Sharma', 'Finance'),
    (4, 'Sara Ahmed', 'IT'),
    (5, 'Zoya Mir', 'Marketing');

CREATE TABLE job_applicants (
    applicant_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50)
);
INSERT INTO job_applicants
    (applicant_id, full_name, department)
VALUES
    (101, 'Rahul Sharma', 'Finance'),
    (102, 'Imran Dar', 'IT'),
    (103, 'Mehak Singh', 'HR'),
    (104, 'Aisha Khan', 'HR'),
    (105, 'Kabir Wani', 'Sales');
*/

SELECT * FROM current_employees;
SELECT * FROM job_applicants;



-- UNION — combine results and remove duplicates
SELECT full_name, department 
FROM current_employees
UNION
SELECT full_name, department
FROM job_applicants; 


-- UNION ALL - combine results and keep duplicates(union all is faster as it doesnt need any processing to find and remove duplicates)
SELECT full_name, department 
FROM current_employees
UNION ALL
SELECT full_name, department
FROM job_applicants; 


-- For a set operation to work, the SELECT statements must have compatible result structures.
-- Rule 1: Same number of columns
-- Rule 2: Corresponding columns must have compatible data types
-- Rule 3: Column positions matter
-- Rule 4: The output column names come from the first query
-- Rule 5: Put ORDER BY at the end. To sort the combined results

SELECT full_name, department
FROM current_employees
UNION
SELECT full_name, department
FROM job_applicants
ORDER BY full_name;



-- INTERSECT — returns only the rows present in both query results.
SELECT full_name, department 
FROM current_employees
INTERSECT
SELECT full_name, department
FROM job_applicants;


-- EXCEPT - returns rows from the first query that don't appear in the second.
SELECT full_name, department 
FROM current_employees
EXCEPT
SELECT full_name, department
FROM job_applicants;


-- When combining multiple different set operators, be mindful of operator precedence. 
-- In MySQL, INTERSECT has higher precedence than UNION and EXCEPT; 
-- UNION and EXCEPT have equal precedence and are evaluated left to right. 
-- Use parentheses where supported and appropriate to make your intended grouping clear.



-- PRACTICE
-- Write two queries to find applicants' name-and-department combinations that aren't present among current employees, using EXCEPT and a suitable alternative approach.
SELECT a.full_name, a.department FROM job_applicants as a
LEFT JOIN current_employees AS c
    ON a.full_name = c.full_name
WHERE c.employee_id IS NULL



