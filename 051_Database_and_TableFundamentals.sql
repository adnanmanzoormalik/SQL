-- Q1. Create a Database and Table
-- Write the MySQL statements to complete these tasks:
-- 1. Create a database named `sql_practice`.
-- 2. Select `sql_practice` as your active database.
-- 3. Create a table named `students` with the following columns:

-- | Column Name | Data Type |
-- | student_id | INT |
-- | student_name | VARCHAR(50) |
-- | age | INT |
-- | admission_date | DATE |

-- **Requirements:**
-- - Use correct MySQL syntax.
-- - Choose appropriate data types.
-- - Do not add any constraints.

CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

CREATE TABLE IF NOT EXISTS students(
    student_id INT,
    student_name VARCHAR(50),
    age INT,
    admission_date DATE
);


--  Q2. Insert Data into a Table
-- Write a MySQL query to insert the following three records into the `students` table:

-- | student_id | student_name | age | admission_date |
-- |---:|---|---:|---|
-- | 1 | Ayaan | 20 | 2026-01-15 |
-- | 2 | Sara | 19 | 2026-02-10 |
-- | 3 | Rohan | 21 | 2026-03-05 |

-- **Requirements:**
-- - Insert all three records using a single INSERT statement.
-- - Specify the column names explicitly.
-- - Use the correct format for DATE values.

INSERT INTO students(
    student_id, 
    student_name, 
    age, 
    admission_date
    ) 
VALUES
    (1, "Aryan", 20, '2026-01-15'),
    (2, "Sara", 19, '2026-02-10'),
    (3, "Rohan", 21, '2026-03-05');


-- ## Q3. Retrieve Student Data
-- The `students` table contains the three records inserted in Q2.
-- Write SQL queries to complete these tasks:
-- 1. Display all columns and rows from `students`.
-- 2. Display only `student_name` and `age`.
-- 3. Display `student_name` with the column heading `Name`, and `age` with the heading `Student_Age`.
-- 4. Display only the unique ages in the table.

-- **Requirements:**
-- - Write four separate SELECT statements.
-- - Use column aliases where required.
-- - Use DISTINCT for the last query.

SELECT * FROM students;
SELECT student_name, age FROM students;
SELECT student_name AS Name, age AS Student_Age FROM students;
SELECT DISTINCT age FROM students;



-- Q4. Manage and Retrieve Student Records

-- Assume the `sql_practice` database and `students` table already exist.

-- Write SQL statements to complete the following tasks:
-- 1. Display students whose age is greater than 19.
SELECT * FROM students WHERE age>19;

-- 2. Display all students sorted by age in descending order.
SELECT * FROM students ORDER BY age DESC;

-- 3. Display the two youngest students.
SELECT * FROM students ORDER BY age LIMIT 2;

-- 4. Skip the first student and display the next two students, sorted by `student_id` in ascending order.
SELECT * FROM students ORDER BY student_id LIMIT 2 OFFSET 1;

-- 5. Update Sara's age to 20 using her `student_id`.
UPDATE students
SET age=20
WHERE student_id = 2;

-- 6. Delete the student whose `student_id` is 3.
DELETE FROM students WHERE student_id = 3;

-- 7. Add a column named `email` of type `VARCHAR(100)` to the existing table.
ALTER TABLE students
ADD COLUMN email VARCHAR(100);

-- 8. Rename the column `student_name` to `full_name`, keeping its data type as `VARCHAR(50)`.
ALTER TABLE students
RENAME COLUMN student_name TO full_name;

-- 9. Write the statement that removes all records from `students` while keeping the table structure.
TRUNCATE TABLE students;

-- 10. Write the statement that removes the `students` table entirely.
DROP TABLE students;

-- **Requirements:**
-- - Write a separate SQL statement for each task.
-- - Use `WHERE` appropriately for UPDATE and DELETE.
-- - Use MySQL syntax.
-- - For tasks 9 and 10, write the statements only; do not execute them on your actual database.







