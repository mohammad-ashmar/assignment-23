CREATE DATABASE company_db;


USE company_db;



CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    manager_id INT,
    city VARCHAR(50)
);



INSERT INTO employees (emp_name, department, salary, manager_id, city)
VALUES
('Noor', 'HR', 50000, 3, 'Beirut'),
('Hassan', 'IT', 60000, 4, 'Baalback'),
('Hady', 'HR', 70000, NULL, 'Beirut'),
('Ali', 'IT', 80000, NULL, 'Tripoli'),
('Mouhammad', 'Sales', 45000, 6, 'Saida'),
('Zayn', 'Sales', 65000, NULL, 'Beqaa');



SELECT DISTINCT department
FROM employees;



SELECT emp_name, salary
FROM employees
WHERE salary > 50000
AND department IN ('IT', 'HR');



SELECT emp_name
FROM employees
WHERE emp_name LIKE 'H%';



SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 3;



SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department;



SELECT 
    IFNULL(department, 'Grand Total') AS department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department WITH ROLLUP;



SELECT *
FROM employees
WHERE city = 'Beirut'

UNION

SELECT *
FROM employees
WHERE city = 'Beqaa';



SELECT 
    e.emp_name AS employee,
    m.emp_name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.emp_id;


SELECT emp_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);



CREATE VIEW IT_Employees AS
SELECT emp_name, department, salary
FROM employees
WHERE department = 'IT';



SELECT *
FROM IT_Employees;



DELIMITER //

CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT *
    FROM employees;
END //

DELIMITER ;



CALL GetAllEmployees();



DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(
    IN dept_name VARCHAR(50)
)
BEGIN
    SELECT *
    FROM employees
    WHERE department = dept_name;
END //

DELIMITER ;




DELIMITER //

CREATE PROCEDURE GetEmployeesBySalary(
    IN min_salary DECIMAL(10,2)
)
BEGIN
    SELECT *
    FROM employees
    WHERE salary > min_salary;
END //

DELIMITER ;


-- Example
CALL GetEmployeesBySalary(60000);