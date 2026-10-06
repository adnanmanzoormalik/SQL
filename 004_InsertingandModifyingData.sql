USE college;
-- >>> INSERT INTO statement adds new records (rows) to a table.
INSERT INTO students(id, name, age, email) VALUES (1, 'Adnan', 21, 'adnan@gmail.com');
INSERT INTO students(id, name, age, email, admission_date) VALUES(2, 'Asrar', 30, 'asrar@gmail.com', '2020-12-29');
INSERT INTO students(id, name, age) VALUES(3,'Saad',3);
-- NOTE: We should use column names while entering values >>> This is safer and clearer than relying on the table's column order. Columns omitted from the insert receive their default value, or NULL if permitted and no default is defined.

INSERT INTO students(id, name, age, email) VALUES 
(3, 'Zaira', 22, 'zaira@gmail.com'),
(4, 'Omais', 24, 'omais@gmail.com');

-- >>> UPDATE statement modifies existing records.
UPDATE students 
SET age = 22
WHERE name='Saad';

UPDATE students
SET age = 31, name ='Asrar Manzoor'
WHERE id=2; -- >>> without using where here all the values in age column will change to 31


-- >>> DELETE statement removes rows from a table.
DELETE FROM students WHERE id=3;
DELETE FROM students WHERE email IS NULL;

-- >>> ALTER TABLE modifies the structure of an existing table rather than the records themselves.

-- >>> 1. ADD COLUMN: adding columns to the table
ALTER TABLE students ADD COLUMN country VARCHAR(20);
ALTER TABLE students ADD COLUMN city VARCHAR(50) DEFAULT 'Srinagar';


-- >>> 2. MODIFY COLUMN to change a column's definition, such as its data type or permitted length.
ALTER TABLE students MODIFY COLUMN name VARCHAR(100);

-- >>> 3. RENAME COLUMN: rename a column
ALTER TABLE students
RENAME COLUMN name TO fullname;


-- >>> 4. CHANGE COLUMN: can change the definition and the column name.
-- With CHANGE COLUMN, you must specify the column's data type and other required definition details. 
-- Don't accidentally omit existing attributes such as NOT NULL or DEFAULT
ALTER TABLE students
CHANGE COLUMN fullname name VARCHAR(255);


-- >>> 5. DROP COLUMN: removes the column and its stored values. it is change in the table not just hiding it
ALTER TABLE students
DROP COLUMN country;

-- >>> DROP TABLE: removes an entire table, including its structure and data. Afterward, the students table no longer exists.
DROP TABLE students;
DROP TABLE IF EXISTS students; >>> to avoid an error 

-- TRUNCATE TABLE: removes all records from a table while retaining its structure.
TRUNCATE TABLE students; -- >>> resets AUTO_INCREMENT counter in typical MySQL use.


/*
Preview first: Run a SELECT query with your target condition to verify the exact rows that will be affected.
Specify conditions: Always use a precise WHERE clause to avoid modifying the entire table by accident.
Back up data: Take a reliable backup before executing destructive changes.
Use transactions: Wrap modifications in START TRANSACTION, COMMIT, and ROLLBACK where supported to revert errors safely.
Verify after execution: Inspect the table with a follow-up query to confirm only the intended changes were made.
*/

SELECT * FROM students;
