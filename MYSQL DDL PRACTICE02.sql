#database creation
CREATE DATABASE IF NOT EXISTS employee;
USE employee;
#department Table 
CREATE TABLE departments (
department_id INT,department_name VARCHAR(100)
);
# Location tabble
CREATE TABLE location (
location_id INT,
location VARCHAR(50)
);
#Employees Table
CREATE TABLE employees (
employee_id INT,
employee_name VARCHAR(100),
gender ENUM('M', 'F'),
age INT,
hire_date DATE,
designation VARCHAR(100),
department_id INT,
location_id INT,
salary DECIMAL(10,2)
);
#TABLE ALTERATION(ALTER)
#add a new column "email"to employees table
ALTER TABLE employees
ADD email VARCHAR(100);
#Mmodify data type of "designation"column to support wider values
ALTER TABLE employees  
MODIFY designation VARCHAR(150);
#Drop "age" column from employees table
ALTER TABLE employees 
DROP COLUMN age;
#Rename "hire_date" column to "date_of_joining"
ALTER TABLE employees
RENAME COLUMN hire_date TO date_of_joining;
#Table renaming(RENAME)
#Rename "departments" table to "departments_info"
RENAME TABLE departments TO Departments_Info;
#Rename "location" table to "Locations"
RENAME TABLE location TO Locations;
#Table Truncation (TRUNCATE)
TRUNCATE TABLE 		employees;
#DROP employees table
DROP TABLE employees;
#DATABASE & Table Dropping (DROP)
#DROP employees table 
DROP TABLE employees;
#drop employee table 
DROP DATABASE employee;
#2.CONSTRAINTS
#A)DROP existing database if exists and recreate 
DROP DATABASE IF EXISTS employees;
CREATE DATABASE employee;
USE employee;
#B)Departments table with constaints 
CREATE TABLE departments (
department_id INT PRIMARY KEY ,
department_name VARCHAR(100)
NOT NULL UNIQUE
);
#C)Location table with constaints 
CREATE TABLE location(
location_id INT AUTO_INCREMENT PRIMARY KEY,
location VARCHAR(25)
NOT NULL UNIQUE
);
#D)employees table with constrains 
CREATE TABLE employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(50)
NOT NULL,
gender ENUM('M', 'F'),
age INT CHECK(age >= 18),
hire_date DATE DEFAULT
(CURRENT_DATE),
designation VARCHAR(100),
department_id INT,
location_id INT,
salary DECIMAL(10,2),
#FOREIGN KEY CONSTRAINTS LINKING TO MAIN TABLES
FOREIGN KEY (department_id) 
REFERENCES departments(department_id),
FOREIGN KEY (location_id)
REFERENCES location(location_id)
);

INSERT INTO departments
(department_id,department_name)
VALUES
(101,'HR'),(102,'IT'),(103,'FINANCE'),(104,'CA');
INSERT INTO location(location)
VALUES
('HYD'),
('BANGLOOR'),
('AP'),
('MUMBAI');

INSERT INTO employees
(employee_id, employee_name,gender,date_of_joining,designation,department_id,location_id,email,salary)
VALUES
(1,'vijay', 'M','2015-03-15','Data Analysis',101,1,'viajaysanupa@gmail.com',150000.00),
(2,'vinay','M','2023-02-20','HR',102,2,'vinnnu@.com',250000.00),
(3,'Gouthami','F','2025-12-21','Software engineer',103,3,'g@.com',75000.00),
(4,'swetha','F','1999-03-09','Financial Analyst',104,4,'swetha@369',185000.00);
TRUNCATE TABLE employees;   
INSERT INTO employees
(employee_id, employee_name, gender, date_of_joining, designation, department_id, location_id, email, salary)
VALUES
(1, 'vijay',  'M', '2015-03-15',' Data Analysis', 101, 1, 'viajaysanupa@gmail.com', 150000.00),
(2, 'vinay', 'M', '2023-02-20', 'HR', 102, 2, 'vinnnu@.com', 250000.00),
(3, 'Gouthami', 'F', '2025-12-21', 'Software engineer', 103, 3, 'g@.com', 75000.00),
(4, 'swetha', 'F', '1999-03-09', 'Financial Analyst', 104, 4, 'swetha@369', 185000.00);
SELECT * FROM employees;

#QUERYING DATA
#BASIC FILTERING & ALIASING 
#1.DISTINCT VALUES 
SELECT DISTINCT salary 
FROM employee;
#2.ALIAS(AS)
SELECT age AS Employee_age,
salary AS Employee_salary
FROM employees,
#3. WHERE Clause & Operators
#Retrive employees with salary > 50000 and hired before 2016-01-01
SELECT  *
FROM employees 
WHERE salary > 50000 AND hire_date < '2016-01-01';
# find employee whose designation  is missing and update/fill with "DATA Scientist"
SELECT * FROM employees
WHERE designation IS NULL;
#SQL statement to update missing entries
UPADTE employees
SET designation = 'Data Scientist'
WHERE designation IS NULL;

#SORTING & GROUPING DATA 
#A)ORDER BY
SELECT * 
FROM empolyees 
ORDER BY department_id ASC,
salary DESC;

#B) LIMIT 
SELECT * 
FROM empolees 
WHERE  YEAR(hire_date) =2018
ORDER BY hire_date ASC
LIMIT 5;

#AGGREGATE FUNCTIONS
#calculate sum of all salaries in the finance department
SELECT 
SUM(e.salary) AS
total_finance_salary
FROM employee e
JOIN departments d
ON e.department_id = d.department-id
WHERE d.department_name = 'Finance';

# find minimum age among all employees
SELECT MIN(age) AS 
minimum_age 
FROM employees;
 #d) GROIUP BY
 #LIST maximum salary for each location
 SELECT
 location_id,
 MAX(salary) AS MAX_salary 
 FROM employees
 GROUP BY location_id;
 
 #calculate avg salry for each designation containing 'analyst'
 SELECT designation,
 AVG(salary) AS avg_salary
 FROM employees
 WHERE designation LIKE 
 '%Analyst%'
 GROUP BY designation;
 
 #E) HAVING
 #find departments with less than 3 employees 
 SELECT deparment_id,
 COUNT(employee_id) AS 
 total_employees
 GROUP BY department_id
 HAVING COUNT(employee_id) <3;
 
 # find locations with female employees whose avg age is below 30
 SELECT location_id, AVG(age) AS 
 avg_female_age
 FROM employees 
 WHERE gender = 'F'
 GROUP BY location_id
 HAVING AVG(age)<30;
 
 #joins(common schema queries)
 #inner Join(Employee with department& location names)
 SELECT 
 e.employee_id,
 e.employee_name,
 d.department_name,
 l.location,
 e.salary
 FROM employees e  
 JOIN departments d
 ON e.employee_id = 
 d.department_id
 JOIN location l ON
 e.location_id = l.location_id;
 #LEFT JOIN(ALL department and their assigned employees)
 SELECT
 d.department_name,
 e.employee_name
 FROM departments d 
 LEFT JOIN employees e
 ON d.department_id = 
 e.department_id;
 
 #RIGHT JOIN (IT RETURNS ALL RECORDS from the right table  and the matched records from the  left table .
 #if there is no match in the left table ,the result will contain NULL values for all column of that left table
 SELECT 
 d.department_name,
 e.employee_name
 FROM departments d
 RIGHT JOIN  employees e
 ON d.department_id = 
 e.department_id;
 USE employee;
 SHOW TABLES;
 SHOW DATABASES;
 CREATE TABLE IF NOT EXISTS 
 empl0oyees (
 employee_id INT PRIMARY KEY,
 employee_name VARCHAR(100),
 department_id int);
 SELECT 
 d.department_name,
 e.employee_name
 FROM departments d
 RIGHT JOIN  employees e
 ON d.department_id = 
 e.department_id;
 
 
