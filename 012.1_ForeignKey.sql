CREATE DATABASE IF NOT EXISTS practice;
USE practice;
CREATE TABLE departments(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);

INSERT INTO departments(department_id, department_name) VALUES
(1, "IT"),
(2, "HR"),
(3, "Sales");


INSERT INTO employees(id, name, department_id) VALUES(1, "Adnan", 2),(2,"Asrar",1);
INSERT INTO employees(id, name, department_id) VALUES(3,"Saad", 3);
-- >>> we wont be able to insert (1, "Saad", 5) into employees becoz we dont have department_id 5 in the departments table. 
-- >>>This is to prevent accidentally making an employee with a department that doesnt exists
SELECT * FROM departments;
SELECT * FROM employees;


-- >>> Referential integrity means that relationships between related tables remain valid. The FOREIGN KEY helps enforce referential integrity.
-- it means that we cnt have am employee with department_id that doesnt exists and FK ensures that


-- >>> ON DELETE tells MySQL: "What should happen to the child rows when their referenced parent row is deleted?"
-- CASCADE, SET NULL, RESTRICT

-- >>> ON DELETE CASCADE: If the parent is deleted, automatically delete the related child rows.
CREATE TABLE IF NOT EXISTS depts(
    id INT PRIMARY KEY,
    dept_id INT
);
CREATE TABLE IF NOT EXISTS emps1(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id)
        REFERENCES depts(id)
        ON DELETE CASCADE
);
INSERT INTO depts(id, dept_id) VALUES(1,1),(2,2),(3,3);
INSERT INTO emps1(id, name, dept_id) VALUES(1, "Adnan", 1),(2, "Asrar", 2),(3, "Saad", 3);
SELECT * FROM depts;
SELECT * FROM emps1;
DELETE FROM depts WHERE dept_id=1;
SELECT * FROM depts;
SELECT * FROM emps1;



-- ON DELETE SET NULL >>> If the parent disappears, keep the child row but remove its reference to the parent.

-- ON DELETE RESTRICT >>> Don't allow the parent to be deleted if child rows are still referencing it.




-- >>> ON UPDATE : Now we have the same problem, but with changing the parent's key.
CREATE TABLE depts2(
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
INSERT INTO depts2(dept_id, dept_name) VALUES(1, "IT"),(2, "HR"),(3,"Sales"),(4,"XYZ");
CREATE TABLE emps2(
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id)
        REFERENCES depts2(dept_id)
        ON UPDATE CASCADE
);
INSERT INTO emps2(id, name, dept_id) VALUES(1, "Adnan", 1),(2, "Asrar", 2),(3, "Saad", 3),(4, "Malik", 4);
SELECT * FROM depts2;
SELECT * FROM emps2;
UPDATE depts2
SET dept_id = 10
WHERE dept_id = 1;
SELECT * FROM depts2;
SELECT * FROM emps2;

-- >>> ON UPDATE RESTRICT: You can also prevent the parent key from being changed if children reference it.

