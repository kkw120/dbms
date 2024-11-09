CREATE DATABASE assignment3;
USE assignment3;

CREATE TABLE employee (
    employee_name VARCHAR(50) PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE company (
    company_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

CREATE TABLE works (
    employee_name VARCHAR(50),
    company_name VARCHAR(50),
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_name, company_name),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES company(company_name) 
);

CREATE TABLE manages (
    employee_name VARCHAR(50),
    manager_name VARCHAR(50),
    PRIMARY KEY (employee_name, manager_name),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name),
    FOREIGN KEY (manager_name) REFERENCES employee(employee_name)
);

INSERT INTO employee (employee_name, street, city) VALUES
('Raj Shukla', 'Street A', 'Pune'),
('Sandeep Patil', 'Street B', 'Mumbai'),
('Shital Sonje', 'Street C', 'Nashik'),
('Anita Sharma', 'Street D', 'Delhi'),
('Ravi Verma', 'Street E', 'Kolkata'),
('Pooja Singh', 'Street F', 'Pune'),
('Vikas Gupta', 'Street G', 'Mumbai'),
('Amit Kumar', 'Street H', 'Nashik'),
('Sunita Desai', 'Street I', 'Delhi'),
('Manoj Mehta', 'Street J', 'Kolkata');

INSERT INTO company (company_name, city) VALUES
('First Bank Corporation', 'Pune'),
('Small Bank Corporation', 'Mumbai'),
('Special Bank Corporation', 'Nashik');

INSERT INTO works (employee_name, company_name, salary) VALUES
('Raj Shukla', 'First Bank Corporation', 60000),
('Sandeep Patil', 'Small Bank Corporation', 45000),
('Shital Sonje', 'Special Bank Corporation', 50000),
('Anita Sharma', 'First Bank Corporation', 55000),
('Ravi Verma', 'First Bank Corporation', 65000),
('Pooja Singh', 'Small Bank Corporation', 48000),
('Vikas Gupta', 'Special Bank Corporation', 52000),
('Amit Kumar', 'First Bank Corporation', 58000),
('Sunita Desai', 'Small Bank Corporation', 47000),
('Manoj Mehta', 'Special Bank Corporation', 53000);

INSERT INTO manages (employee_name, manager_name) VALUES
('Raj Shukla', 'Anita Sharma'),
('Sandeep Patil', 'Ravi Verma'),
('Shital Sonje', 'Pooja Singh'),
('Anita Sharma', 'Ravi Verma'),
('Ravi Verma', 'Anita Sharma');

-- Write SQL queries for the following

-- 1. Find the names of all employees who work for First Bank Corporation.
SELECT employee_name 
FROM works 
WHERE company_name = 'First Bank Corporation';

-- 2. Find the names and cities of residence of all employees who work for First Bank Corporation.
SELECT e.employee_name, e.city 
FROM employee e 
JOIN works w ON e.employee_name = w.employee_name 
WHERE w.company_name = 'First Bank Corporation';

-- 3. Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than Rs.10,000.
SELECT e.employee_name, e.street, e.city 
FROM employee e 
JOIN works w ON e.employee_name = w.employee_name 
WHERE w.company_name = 'First Bank Corporation' AND w.salary > 10000;

-- 4. Find all employees in the database who live in the same cities as the companies for which they work.
SELECT e.employee_name 
FROM employee e 
JOIN works w ON e.employee_name = w.employee_name 
JOIN company c ON w.company_name = c.company_name 
WHERE e.city = c.city;

-- 5. Find all employees in the database who live in the same cities and on the same streets as do their managers.
SELECT e1.employee_name 
FROM manages m 
JOIN employee e1 ON m.employee_name = e1.employee_name 
JOIN employee e2 ON m.manager_name = e2.employee_name 
WHERE e1.city = e2.city AND e1.street = e2.street;

-- 6. Find all employees in the database who do not work for First Bank Corporation.
SELECT e.employee_name 
FROM employee e 
LEFT JOIN works w ON e.employee_name = w.employee_name AND w.company_name = 'First Bank Corporation' 
WHERE w.company_name IS NULL;

-- 7. Find all employees in the database who earn more than each employee of Small Bank Corporation.
SELECT e.employee_name 
FROM employee e 
WHERE EXISTS (
    SELECT * 
    FROM works w 
    WHERE w.company_name = 'Small Bank Corporation' 
    AND e.employee_name != w.employee_name 
    AND e.employee_name IN (
        SELECT w2.employee_name 
        FROM works w2 
        WHERE w2.salary > (SELECT MAX(w3.salary) FROM works w3 WHERE w3.company_name = 'Small Bank Corporation')
    )
);

-- 8. Find all companies located in every city in which Small Bank Corporation is located.
SELECT c.company_name 
FROM company c 
WHERE NOT EXISTS (
    SELECT * 
    FROM company s 
    WHERE s.company_name = 'Small Bank Corporation' 
    AND s.city NOT IN (SELECT city FROM company WHERE company_name = c.company_name)
);

-- 9. Find all employees who earn more than the average salary of all employees of their company.
SELECT e.employee_name 
FROM employee e 
JOIN works w ON e.employee_name = w.employee_name 
WHERE w.salary > (
    SELECT AVG(w2.salary) 
    FROM works w2 
    WHERE w2.company_name = w.company_name
);

-- 10. Find the company that has the most employees.
SELECT company_name 
FROM works 
GROUP BY company_name 
ORDER BY COUNT(employee_name) DESC 
LIMIT 1;

-- 11. Find the company that has the smallest payroll.
SELECT company_name 
FROM works 
GROUP BY company_name 
ORDER BY SUM(salary) ASC 
LIMIT 1;

-- 12. Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.
SELECT c.company_name 
FROM company c 
JOIN works w ON c.company_name = w.company_name 
GROUP BY c.company_name 
HAVING AVG(w.salary) > (SELECT AVG(salary) FROM works WHERE company_name = 'First Bank Corporation');
