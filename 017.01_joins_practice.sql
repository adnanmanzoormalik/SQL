
-- CREATE DATABASE join_practice;
USE join_practice;
/*
-- 1. Departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Research');

-- 2. Employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    manager_id INT,
    salary DECIMAL(10,2),
    employment_status VARCHAR(20),
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id),
    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);

INSERT INTO employees VALUES
(101, 'Aarav', 1, NULL, 75000, 'Active'),
(102, 'Meera', 1, 101, 55000, 'Active'),
(103, 'Kabir', 2, NULL, 60000, 'Active'),
(104, 'Sana', 3, 103, 50000, 'Active'),
(105, 'Rohan', 3, 103, 45000, 'Inactive'),
(106, 'Isha', NULL, 101, 40000, 'Active'),
(107, 'Zoya', 2, 103, 52000, 'Active');

-- 3. Projects
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    department_id INT
);

INSERT INTO projects VALUES
(201, 'Website Redesign', 1),
(202, 'Mobile App', 1),
(203, 'Recruitment Drive', 2),
(204, 'Budget Analysis', 3),
(205, 'Market Research', 4),
(206, 'AI Prototype', 5);

-- 4. Employee-project assignments
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    assigned_role VARCHAR(50),
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),
    FOREIGN KEY (project_id)
        REFERENCES projects(project_id)
);

INSERT INTO employee_projects VALUES
(101, 201, 'Lead'),
(101, 202, 'Reviewer'),
(102, 201, 'Developer'),
(102, 202, 'Developer'),
(103, 203, 'Lead'),
(104, 204, 'Analyst'),
(107, 203, 'Coordinator');

-- 5. Training sessions
CREATE TABLE training_sessions (
    session_id INT PRIMARY KEY,
    session_name VARCHAR(50)
);

INSERT INTO training_sessions VALUES
(301, 'SQL Basics'),
(302, 'Cybersecurity'),
(303, 'Communication');

-- 6. Attendance
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT,
    attendance_date DATE,
    attendance_status VARCHAR(20),
    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

INSERT INTO attendance VALUES
(401, 101, '2026-10-01', 'Present'),
(402, 101, '2026-10-02', 'Present'),
(403, 102, '2026-10-01', 'Absent'),
(404, 103, '2026-10-01', 'Present'),
(405, 104, '2026-10-01', 'Present'),
(406, 107, '2026-10-01', 'Absent');
*/
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM employee_projects;
SELECT * FROM projects;
SELECT * FROM training_sessions;
SELECT * FROM attendance;

-- 1. Display every employee's name alongside their department name. Include employees who are not assigned to any department. Required columns: - employee_name - department_name
SELECT e.employee_name, d.department_name FROM employees AS e
LEFT JOIN departments AS d
    ON e.department_id = d.department_id;

-- 2. Find all departments that have no employees assigned to them. Required column: - department_name
SELECT d.department_name FROM departments AS d
LEFT JOIN employees AS e
    ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;

-- 3. Find the names of employees and the projects they are specifically assigned to, along with their assigned roles. 
-- Required columns: - employee_name - project_name - assigned_role Only include employees who have project assignments.
SELECT e.employee_name, p.project_name, ep.assigned_role FROM employees as e
JOIN employee_projects AS ep
    ON ep.employee_id = e.employee_id
JOIN projects AS p
    ON ep.project_id = p.project_id;

-- 4. Find each employee's name alongside their manager's name. Required columns: - employee_name - manager_name 
-- Include all employees, including those who don't have a manager. For those employees, manager_name should be NULL
SELECT e.employee_name, m.employee_name FROM employees AS e
LEFT JOIN employees AS m
    ON e.manager_id = m.employee_id;

-- 5. Find every employee's name and their total number of attendance records, including employees who have no attendance records. Required columns: - employee_name - attendance_count
SELECT e.employee_name, COUNT(a.attendance_id) AS attendance_count FROM employees AS e
LEFT JOIN attendance AS a
    ON a.employee_id = e.employee_id
GROUP BY e.employee_name;


-- 6. Find all possible combinations of employee names and training session names. Required columns: - employee_name - session_name 
-- Every employee should appear once for each training session, whether or not they actually attended it.
SELECT e.employee_name, ts.session_name FROM employees AS e
CROSS JOIN training_sessions AS ts;


-- 7. Display each employee's name, department name, and project name for every project assigned to that employee.
-- Include employees who have no project assignments. For those employees, the project name should be NULL. Also display their department name when available.
-- Required columns: - employee_name - department_name - project_name
SELECT e.employee_name, d.department_name, p.project_name
FROM employees AS e
LEFT JOIN departments AS d
    ON d.department_id = e.department_id
LEFT JOIN employee_projects AS ep
    ON ep.employee_id = e.employee_id
LEFT JOIN projects AS p
    ON ep.project_id = p.project_id;


-- 8. Display each employee's name, department name, and salary for employees who earn more than ₹50,000 and belong to the IT or Finance department.
-- Include only employees who meet all the conditions. Required columns: - employee_name - department_name - salary
SELECT e.employee_name, d.department_name, e.salary FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id
WHERE e.salary > 50000 AND d.department_name IN ("IT", "Finance");


-- 9. Find every employee who has no attendance record dated 2026-10-01. 
-- Required columns: - employee_id - employee_name 
-- Include employees who have attendance records on other dates but none on this specific date, as well as employees who have no attendance records at all.
SELECT e.employee_id, e.employee_name
FROM employees AS e
LEFT JOIN attendance AS a
    ON e.employee_id = a.employee_id
    AND a.attendance_date = '2026-10-01'
WHERE a.attendance_id IS NULL;

-- alternate way
SELECT e.employee_id, e.employee_name
FROM employees AS e
WHERE NOT EXISTS(
    SELECT 1
    FROM attendance AS a
    WHERE a.employee_id = e.employee_id
    AND a.attendance_date = "2026-10-01"
)

-- 10. 
