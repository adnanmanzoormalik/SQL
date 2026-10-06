USE joins;
-- >>> CROSS JOIN: combines every row from the first table with every row from the second table. There is no ON condition.
-- It is useful when we actually want every possible combination. like table_sizes: S, M, L, XL, XXL table_colours: Red, White, Yellow
SELECT e.name, d.department_name
FROM employees1 AS e
CROSS JOIN departments AS d;
/*
CREATE TABLE employees2 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT,
    salary DECIMAL(10,2)
);

INSERT INTO employees2
(employee_id, name, manager_id, salary)
VALUES
(101, 'Adnan', NULL, 90000),
(102, 'Rahul', 101, 60000),
(103, 'Aisha', 101, 65000),
(104, 'Zoya', 102, 55000),
(105, 'Arjun', 102, 52000),
(106, 'Sara', 103, 50000);
*/

SELECT
    e.name AS emp,
    m.name AS mng
FROM employees2 AS e
INNER JOIN employees2 AS m
ON e.manager_id = m.employee_id;

-- we wont see Adnan in the above codes result becoz he doesnt have a manager

-- LEFT SELF JOIN
SELECT e.name AS emp_name, m.name AS mng_name
FROM employees2 AS e
LEFT JOIN employees2 AS m
ON m.employee_id = e.manager_id;

/*
CREATE TABLE projects1 (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT
);
INSERT INTO projects1
(project_id, project_name, department_id)
VALUES
(201, 'Website Redesign', 1),
(202, 'Recruitment Drive', 2),
(203, 'Budget Analysis', 3),
(204, 'Mobile App', 1);
*/


SELECT e.name, d.department_name, p.project_name
FROM employees1 AS e
INNER JOIN departments1 AS d
    ON e.department_id = d.department_id
INNER JOIN projects1 AS p
    ON d.department_id = p.department_id;
 -- A JOIN doesn't necessarily mean one row in → one row out.


SELECT * FROM employees1;
SELECT * FROM departments1;
SELECT * FROM projects1;
SELECT * FROM employee_projects;

/*
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT
);

INSERT INTO employee_projects
(employee_id, project_id)
VALUES
(101, 201),
(101, 204),
(103, 201),
(104, 203),
(105, 202);
*/


SELECT
    e.name,
    p.project_name
FROM employees1 AS e
INNER JOIN employee_projects AS ep
    ON e.employee_id = ep.employee_id
INNER JOIN projects1 AS p
    ON ep.project_id = p.project_id;



-- >>> Multiple JOIN Conditions
/*
CREATE TABLE attendance1 (
    employee_id INT,
    attendance_date DATE,
    status VARCHAR(20)
);
INSERT INTO attendance1
(employee_id, attendance_date, status)
VALUES
(101, '2026-10-01', 'Present'),
(102, '2026-10-01', 'Present'),
(103, '2026-10-01', 'Absent'),
(101, '2026-10-02', 'Present'),
(102, '2026-10-02', 'Absent');
*/

SELECT e.employee_id, e.name, a.status
FROM employees1 AS e
INNER JOIN attendance1 AS a
    ON e.employee_id = a.employee_id
    and a.attendance_date = "2026-10-01";

SELECT e.employee_id, e.name, a.status
FROM employees1 AS e
INNER JOIN attendance1 AS a
    ON e.employee_id = a.employee_id
    AND a.attendance_date = "2026-10-01"
    AND a.status = "Present";


-- >>> WHERE vs AND
SELECT e.name, d.department_name
FROM employees1 AS e
LEFT JOIN departments1 as d
    ON e.department_id = d.department_id
WHERE d.department_name = "IT" ; -- only gives the employees which are in IT

SELECT e.name, d.department_name
FROM employees1 AS e
LEFT JOIN departments1 as d
    ON e.department_id = d.department_id
    AND d.department_name = "IT" ; -- keeps all employees, but only attaches the department if it is IT.


-- >>> JOIN duplicates Repeated rows can be legitimate because of one-to-many or many-to-many relationships. Don't blindly use DISTINCT.

