USE college;
/*
CREATE TABLE IF NOT EXISTS employees(
    id INT,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    salary INT
);
INSERT INTO employees(id, name, age, department, salary) VALUES
(1, 'Adnan', 22, 'IT', 40000),
(2, 'Aisha', 25, 'HR', 35000),
(3, 'Rahul', 30, 'IT', 60000),
(4, 'Sara', 28, 'Sales', 45000),
(5, 'Zoya', 24, 'HR', 30000);
*/
SELECT * FROM employees;

-- >>> WHERE clause filters records based on a condition. 
-- WHERE can be used with SELECT, UPDATE, and DELETE. Be especially careful when using it with UPDATE and DELETE
SELECT * FROM employees 
WHERE salary>=40000; 


-- >>> Comparison operators compare two values and produce a true, false, or unknown result.
-- =, != or <>, >, <, <=, >=
SELECT * FROM employees WHERE department != "IT";
SELECT * FROM employees WHERE age >= 25;


-- >>> Logical operators: AND, OR, NOT. Logical operators let you combine or reverse conditions.
SELECT * FROM employees WHERE department="IT" AND salary>45000;
SELECT * FROM employees WHERE department="HR" OR salary<45000;
SELECT * FROM employees WHERE NOT department="IT";

-- >>> When SQL evaluates multiple operators in one condition, it follows a precedence order.
-- Parentheses () > NOT > AND > OR
SELECT * FROM employees WHERE salary>35000 OR department="HR" AND age>20; -- >>> this will mean SELECT * FROM employees WHERE salary>35000 OR (department="HR" AND age>20);
-- Best practice: Use parentheses whenever combining AND and OR in a non-trivial condition.


-- >>> BETWEEN checks whether a value falls within a range. Both endpoints are included.
SELECT * FROM employees WHERE salary BETWEEN 30000 AND 40000; -- >>> 30000 and 40000 are inclusive here
SELECT * FROM employees WHERE salary NOT BETWEEN 30000 AND 40000;

-- >>> IN checks whether a value matches any value in a specified list.
SELECT * FROM employees WHERE department IN ("IT", "HR");
-- this is the same as SELECT * FROM employees WHERE department="HR" OR department="IT"
SELECT * FROM employees WHERE department NOT IN("IT", "HR");
-- If the list used with NOT IN contains NULL, the condition can evaluate to unknown for otherwise nonmatching values, causing rows to be excluded unexpectedly.

-- >>> LIKE searches for a text pattern rather than requiring an exact match.
SELECT * FROM employees WHERE name LIKE "A%";
-- this will return employees whose name starts with A or a (In MySQL), in PostgreSQL it will return only employees with starting with ALTER
SELECT * FROM employees WHERE name NOT LIKE "%a";


-- Wildcards: "%" >>> matches 0 or more characters ....... "_" >>> Matches exactly one character.
SELECT * FROM employees WHERE name LIKE "%a%"; -- >>> will return emps whose name has a in it
SELECT * FROM employees WHERE name LIKE "A%n"; -- >>
SELECT * FROM employees WHERE department LIKE "_T"; -- >>> will return emps whose dept has 2 letters and ends with T
/*
Pattern         Meaning
'A%'            Starts with A
'%a'            Ends with a
'%ad%'          Contains ad
'A%n'           Starts with A and ends with n
'A_'            Two-character value beginning with A
'A__'           Three-character value beginning with A
'_a%'           Second character is a
'___'           Exactly three characters
*/

-- >>> IS NULL to find missing values. we cant use "=" with NULL values so we use IS and IS NOT
SELECT * FROM employees WHERE department IS NULL;
SELECT * FROM employees WHERE department IS NOT NULL;





