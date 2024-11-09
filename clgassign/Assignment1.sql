CREATE DATABASE assignment1;
USE assignment1;

-- Q1: Create Tables with Proper Primary and Foreign Keys
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

-- Q2: Insert Records into Each Table
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

-- Q3: Add Birthdate Column to Employee Table
ALTER TABLE employee ADD COLUMN birthdate DATE;

-- Q4: Update Birthdate of All Employees
UPDATE employee SET birthdate = '1980-01-01' WHERE employee_name = 'Raj Shukla';
UPDATE employee SET birthdate = '1982-02-15' WHERE employee_name = 'Sandeep Patil';
UPDATE employee SET birthdate = '1985-03-20' WHERE employee_name = 'Shital Sonje';
UPDATE employee SET birthdate = '1990-04-10' WHERE employee_name = 'Anita Sharma';
UPDATE employee SET birthdate = '1983-05-25' WHERE employee_name = 'Ravi Verma';
UPDATE employee SET birthdate = '1988-06-30' WHERE employee_name = 'Pooja Singh';
UPDATE employee SET birthdate = '1979-07-18' WHERE employee_name = 'Vikas Gupta';
UPDATE employee SET birthdate = '1984-08-12' WHERE employee_name = 'Amit Kumar';
UPDATE employee SET birthdate = '1987-09-22' WHERE employee_name = 'Sunita Desai';
UPDATE employee SET birthdate = '1992-10-05' WHERE employee_name = 'Manoj Mehta';

-- Q5: Delete Specified Employees
DELETE FROM works WHERE employee_name IN ('Raj Shukla', 'Sandeep Patil', 'Shital Sonje');
DELETE FROM manages WHERE employee_name IN ('Raj Shukla', 'Sandeep Patil', 'Shital Sonje');
DELETE FROM employee WHERE employee_name IN ('Raj Shukla', 'Sandeep Patil', 'Shital Sonje');
-- Ensure the employees to be deleted do not have foreign key dependencies in other tables

-- Q6: Rename Salary to Monthly Salary
ALTER TABLE works CHANGE COLUMN salary monthly_salary DECIMAL(10, 2);

-- Q7: Create Dependants Table
CREATE TABLE dependant (
    employee_name VARCHAR(50),
    dependant_name VARCHAR(50),
    relation VARCHAR(50),
    PRIMARY KEY (employee_name, dependant_name),
    FOREIGN KEY (employee_name) REFERENCES employee(employee_name)
);

-- Q8: Add Rows to Dependants Table
INSERT INTO dependant (employee_name, dependant_name, relation) VALUES
('Anita Sharma', 'Amit Sharma', 'Spouse'),
('Ravi Verma', 'Rekha Verma', 'Spouse'),
('Pooja Singh', 'Anil Singh', 'Spouse'),
('Vikas Gupta', 'Vandana Gupta', 'Spouse'),
('Amit Kumar', 'Neha Kumar', 'Spouse');

-- Q9: Difference Between TRUNCATE and DELETE
-- No SQL code, just explanation:
-- TRUNCATE: Removes all rows from a table without logging individual row deletions. It's faster and uses fewer system resources.
-- DELETE: Removes rows one at a time and logs each row deletion. It can be used with a WHERE clause to delete specific rows.

-- Q10: Single-Select Queries
-- a. Find the names of employees starting with "S"
SELECT employee_name FROM employee WHERE employee_name LIKE 'S%';

-- b. Find the names of employees who work for First Bank Corporation
SELECT employee_name FROM works WHERE company_name = 'First Bank Corporation';

-- c. Find the names of the companies located in "Pune"
SELECT company_name FROM company WHERE city = 'Pune';

-- d. Find the age of employees
SELECT employee_name, YEAR(CURDATE()) - YEAR(birthdate) AS age FROM employee;

-- e. Find the names and cities of residence of all employees who work for First Bank Corporation
SELECT e.employee_name, e.city FROM employee e JOIN works w ON e.employee_name = w.employee_name WHERE w.company_name = 'First Bank Corporation';

-- f. Find the salaries of the employees whose salary is greater than 50000
SELECT employee_name, monthly_salary FROM works WHERE monthly_salary > 50000;

-- g. Find the employee names, street addresses, cities of residence, and company names of all employees
SELECT e.employee_name, e.street, e.city, w.company_name FROM employee e JOIN works w ON e.employee_name = w.employee_name;

-- h. Find the manager of "Sandeep Patil"
SELECT manager_name FROM manages WHERE employee_name = 'Sandeep Patil';

-- i. Find the age of all employees
SELECT employee_name, YEAR(CURDATE()) - YEAR(birthdate) AS age FROM employee;

-- j. Find the names of the employees having their birthday in January
SELECT employee_name FROM employee WHERE MONTH(birthdate) = 1;

-- Q11: Five More Queries with Date, String, and Other Functions
-- a. Find employees whose names contain 'a'
SELECT employee_name FROM employee WHERE employee_name LIKE '%a%';

-- b. Calculate the average salary of employees
SELECT AVG(monthly_salary) AS avg_salary FROM works;

-- c. Count the number of employees in each company
SELECT company_name, COUNT(employee_name) AS num_employees FROM works GROUP BY company_name;

-- d. Find the length of each employee's name
SELECT employee_name, LENGTH(employee_name) AS name_length FROM employee;

-- e. Find employees hired before a specific date
-- Assuming there is a hire_date column in the works table
ALTER TABLE works ADD COLUMN hire_date DATE;

UPDATE works SET hire_date = '2020-01-01' WHERE employee_name = 'Anita Sharma';
-- Repeat the update for other employees as needed

SELECT employee_name FROM works WHERE hire_date < '2021-01-01';
