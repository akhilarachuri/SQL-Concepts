CREATE DATABASE practice_sql_joins;
USE practice_sql_joins;

-- Creating Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name  VARCHAR(50),
    dept_id     INT NULL
);

-- Creating Departments Table
CREATE TABLE departments (
    dept_id     INT PRIMARY KEY,
    dept_name   VARCHAR(50)
);


-- Inserting Data into Employees Table
INSERT INTO employees (employee_id, first_name, dept_id) VALUES
(10, 'John',     1),   -- HR
(11, 'Maria',    2),   -- Finance
(12, 'Karan',    NULL),-- No department assigned (LEFT JOIN practice)
(13, 'Aisha',    3),   -- Marketing
(14, 'Rohit',    99);  -- Non-existing department (for RIGHT JOIN behavior)


-- Inserting Data into Departments Table
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'Marketing'),
(4, 'IT'); -- No employees in IT

-- Checking the data
SELECT * FROM employees;
SELECT * FROM departments;

-- INNER JOIN (rows with matching dept_id)

SELECT e.employee_id, e.first_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- LEFT JOIN (All employees, with or without department)
SELECT e.employee_id, e.first_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- RIGHT JOIN (All departments even if no employee)
SELECT e.employee_id, e.first_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- FULL OUTER JOIN (LEFT join plus RIGHT join using UNION)
SELECT e.employee_id, e.first_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.employee_id, e.first_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- CROSS JOIN (Cartesian product of Employees and Department )
SELECT e.employee_id, e.first_name, d.dept_id, d.dept_name
FROM employees e
CROSS JOIN departments d;

-- SELF JOIN (Employee paired with every other employee)
SELECT e1.employee_id AS emp1, e1.first_name AS name1,
       e2.employee_id AS emp2, e2.first_name AS name2
FROM employees e1
JOIN employees e2 ON e1.employee_id != e2.employee_id;


