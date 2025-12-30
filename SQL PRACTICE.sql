CREATE DATABASE IF NOT EXISTS XYZ_COMPANY;

USE XYZ_COMPANY;

CREATE TABLE IF NOT EXISTS EMPLOYEE(ID INT PRIMARY KEY AUTO_INCREMENT, 
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
DEPARTMENT VARCHAR(50) NOT NULL,
SALARY DECIMAL(9,2),
manager_id int ); 

INSERT INTO EMPLOYEE
VALUES
(1,'ABDULLAH','KHAN','HR',47000,3),
(2,'ISMAIL','JAN','FINANCE',50000,1);

# You need to retrieve the names and
# salaries of employees from the employees
# table, but only for those working in the
# Finance department.

SELECT FIRST_NAME,LAST_NAME,SALARY
 FROM EMPLOYEE 
 WHERE DEPARTMENT="FINANCE";
 
-- You need to add a new employee named
-- Jawad aslam to the employees table with a
-- salary of 52,000 and a department of HR

INSERT INTO EMPLOYEE
VALUES 
(3,'JAWAD','ASLAM','HR',52000,null),
(4,'WAHEED','ZAHID','IT',55000,3);


-- You need to increase the salary of all
-- employees in the IT department by 10%. 

SET SQL_SAFE_UPDATES=0; 

UPDATE EMPLOYEE 
SET SALARY=SALARY*1.10
WHERE DEPARTMENT='IT'; 

-- The HR department has been closed,
-- and all employees in HR must be
-- removed from the database.

DELETE FROM EMPLOYEE
WHERE DEPARTMENT="HR"; 

-- You need to create a table that stores
-- product prices, including whole
-- numbers and decimal values.

CREATE TABLE IF NOT EXISTS PRODUCT (ID INT PRIMARY KEY AUTO_INCREMENT,
PRODUCT_NAME VARCHAR(100) NOT NULL,
PRODUCT_PRICES DECIMAL(7,2)); 

-- You need to filter employees with salaries
-- between 30,000 and 60,000.

SELECT FIRST_NAME,LAST_NAME,SALARY
 FROM EMPLOYEE
WHERE SALARY 
BETWEEN 30000 AND 60000; 

-- You want to retrieve employees whose
-- salaries are not 40,000.

SELECT FIRST_NAME,LAST_NAME, SALARY
 FROM EMPLOYEE 
 WHERE SALARY!=50000;
 
--  You need to find employees whose
-- names contain the letter 'a'. 

SELECT *
FROM EMPLOYEE
WHERE FIRST_NAME LIKE '%A%'; 

INSERT INTO EMPLOYEE
VALUES
(5,'HAFIZ','KHOSA','SALES',37000); 

-- You want to check if there are any
-- employees in the Sales department.

SELECT EXISTS (SELECT DEPARTMENT FROM EMPLOYEE );

-- You add a column in employee table that stores
-- whether employees are active or
-- inactive. 

ALTER TABLE employee
ADD COLUMN IS_ACTIVE BOOLEAN; -- TRUE IF ACTIVE ,FALSE IF INACTIVE 


-- You need to retrieve the top 3 highest-paid
-- employees from the employees table. 

SELECT FIRST_NAME,LAST_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC
LIMIT 3;

-- You want to calculate the total salary for
-- each department.

SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT; 

-- You need to display departments with a
-- total salary greater than 100,000.

SELECT DEPARTMENT, SUM(SALARY) AS TOTAL_SALARY
FROM EMPLOYEE
GROUP BY DEPARTMENT 
HAVING TOTAL_SALARY > 90000; 

-- You need to combine employees from
-- two tables: employees_2023 and
-- employees_2024 without_duplicates

SELECT FIRST_NAME ,LAST_NAME FROM EMPLOYEE_2023
UNION
SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEE_2024; 

-- You want to keep duplicates while
-- combining two datasets.

SELECT FIRST_NAME ,LAST_NAME FROM EMPLOYEE_2023
UNION ALL
SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEE_2024;

-- You need to create a list of employees who
-- belong to either the Finance or IT
-- department.

SELECT FIRST_NAME,DEPARTMENT FROM EMPLOYEE
WHERE DEPARTMENT IN ("FINANCE","IT");

-- You need to calculate the average salary
-- across all employees.

SELECT AVG(SALARY) FROM EMPLOYEE;

-- You need to find employees who don’t
-- belong to the HR department.

SELECT FIRST_NAME,LAST_NAME,DEPARTMENT,SALARY FROM EMPLOYEE
WHERE DEPARTMENT NOT IN ("HR"); # WE CAN ALSO USE != OPERATOR

-- You need to retrieve only the first three
-- employees in alphabetical order by
-- their first names.

SELECT * FROM EMPLOYEE
ORDER BY FIRST_NAME ASC LIMIT 3;

-- You want to join the employees table
-- with the departments table to display
-- employee names along with their
-- department names. 

SELECT E.NAME,D.NAME
FROM EMPLOYEE AS E
INNER JOIN DEPARTMENT AS D
ON E.DEPT_ID=D.DEPT_ID;

-- You need to retrieve employees who joined
-- within the last six months.

SELECT FIRST_NAME ,JIONED_DATE 
FROM EMPLOYEE 
WHERE JOINED_DATE >= CURRENT_DATE - INTERVAL 6 MONTH; 

-- You want to generate a list of employees
-- with their total annual bonuses. Bonuses
-- are 10% of their salary.

SELECT FIRST_NAME,SALARY ,SALARY*0.10 AS BOUNS 
FROM EMPLOYEE; 

-- You want to list employees with their
-- managers. Managers are also stored in
-- the employees table.

select a.first_name as manager,b.first_name as employee from employee as a
join employee as b 
on a.ID=b.manager_id;

-- "How can you assign unique row numbers to employees in each department using the ROW_NUMBER() function?"

select first_name,department,row_number() over (partition by department order by salary) as row_numbers from employee;

-- You need to delete duplicate rows from
-- a table, keeping only one instance of
-- each duplicate.

set  SQL_SAFE_UPDATES=0;

with duplicates as (select *,row_number() over (partition by ID,first_name order by id) as row_num from employee)
delete from employee 
where ID in (select ID from duplicates where row_num>1 );

CREATE TABLE PROJECT(ID INT PRIMARY KEY,IS_SUBMIT BOOLEAN);

INSERT INTO PROJECT(ID,IS_SUBMIT)
VALUES 
(2,TRUE),
(4,TRUE);

-- You need to find all employees who have
-- not submitted their projects.

SELECT  E.FIRST_NAME FROM EMPLOYEE AS E 
LEFT JOIN PROJECT AS P 
ON E.ID=P.ID 
WHERE P.ID IS NULL; 

-- You want to display the total number of
-- employees in each department,
-- including departments with no
-- employees.

SELECT d.deeparment_name, COUNT(e.ID) FROM EMPLOYEE AS E 
LEFT JOIN department as d 
on d.ID=e.ID;

-- You need to create a table that records
-- the current timestamp when a row is
-- inserted.

create table sale(DATES timestamp default current_timestamp,ID int primary key,sales int);

insert into sale(id,sales) 
values 
(1,200),(2,400),(3,700);

-- You want to ensure that each
-- employee email is unique.

CREATE TABLE IF NOT EXISTS EMPLOYEE(ID INT PRIMARY KEY ,NAME VARCHAR(50),EMAIL VARCHAR(50) UNIQUE);

-- You need to find the second highest salary
-- from the employees table.

SELECT FIRST_NAME,SALARY FROM EMPLOYEE 
ORDER BY SALARY DESC LIMIT 1 OFFSET 1 ;

-- You need to compare two columns in the
-- same table to find discrepancies.

SELECT FIRST_NAME,SALARY ,EXPECTED_SALARY FROM EMPLOYEE
WHERE SALARY!= EXPECTED_SALARY;

-- You need to identify duplicate employee
-- names in the employees table.

SELECT FIRST_NAME ,COUNT(*) AS COUNT FROM EMPLOYEE
GROUP BY FIRST_NAME 
HAVING COUNT > 1;

-- You need to insert data into one table
-- by selecting it from another.

INSERT INTO EMPLOYEE (ID,FIRST_NAME,LAST_NAME,SALARY)
select ID,FIRST_NAME,LAST_NAME,SALARY FROM EMPLOYEE_2023;

-- You want to calculate the cumulative
-- salary for employees ordered by
-- department.

SELECT FIRST_NAME,DEPARTMENT,SALARY,SUM(SALARY) OVER (PARTITION BY DEPARTMENT) AS COMULATIVE_SALARY FROM EMPLOYEE;

-- You want to delete employees who don’t
-- belong to a specified list of departments.

DELETE FROM EMPLOYEE
WHERE DEPARTMENT NOT IN ("IT","FINANCE","HR");

-- You need to count employees in each
-- department but only display
-- departments with more than TWO
-- employees.

SELECT DEPARTMENT,COUNT(*) COUNT FROM EMPLOYEE 
GROUP BY DEPARTMENT 
HAVING COUNT >= 2;

-- You want to check if there are
-- employees earning more than 60000.

SELECT EXISTS (SELECT FIRST_NAME FROM EMPLOYEE WHERE SALARY >= 60000);

-- You want to rank employees within
-- each department based on their salary
-- note: we can not use row_number() becouse 
-- it cannot handle same entries.

SELECT FIRST_NAME,DEPARTMENT, rank() OVER (partition by department order by salary desc) as rank_num from employee; 

-- Updating employee salaries based on
-- performance

UPDATE EMPLOYEE 
SET SALARY=SALARY*1.10
WHERE ID=1;

-- Deleting records of employees who left
-- the company

DELETE FROM EMPLOYEE
WHERE ID BETWEEN 10 AND 20;

ALTER TABLE EMPLOYEE
DROP COLUMN LAST_NAME;

-- Inserting multiple rows at once 

INSERT INTO EMPLOYEE(ID,FIRST_NAME,DEPARTMENT,SALARY,MANAGER_ID)
VALUES 
(5,"MUSA","HR",50000,1),
(6,"AZIZ","IT",47000,1);
 
-- Scenario: Managing failed transactions
-- with ROLLBACK

begin transaction;
update  employee set salary = 70000 where ID=1;

-- Imagine an error happens here (e.g., setting a ID to NULL is not allowed)
UPDATE EMPLOYEE SET SALARY=51000 WHERE ID=6;
ROLLBACK;

-- Scenario: Grouping employee records by
-- department 

select department,avg(salary) from employee
group by department;


INSERT INTO EMPLOYEE(ID,FIRST_NAME,DEPARTMENT,SALARY,MANAGER_ID)
VALUES
(7,"ASLAM","IT",55000,2);

UPDATE EMPLOYEE
SET DEPARTMENT="HR" WHERE ID =7 ;

-- Scenario: Ensuring data consistency
-- with a foreign key constraint

CREATE TABLE DEPARTMENT(DEPARTMENT_ID INT ,
DEPARTMENT_NAME VARCHAR(50),
FOREIGN KEY(DEPARTMENT_ID) REFERENCES EMPLOYEE(ID));

-- Scenario: Creating a view to show
-- high-earning employees

CREATE VIEW HIGH_EARNING_EMPLOYEE AS
SELECT FIRST_NAME,SALARY FROM EMPLOYEE WHERE SALARY > 50000; 

-- Scenario: Adding a new column to an
-- existing table

ALTER TABLE EMPLOYEE
ADD COLUMN EMAIL VARCHAR(100); 

-- Scenario: Removing a column from a table
ALTER TABLE EMPLOYEE
DROP COLUMN EMAIL;

-- Scenario: Renaming a column in a table
ALTER TABLE EMPLOYEE 
RENAME COLUMN FIRST_NAME TO NAME ;

-- Scenario: Changing the data type of a
-- column

ALTER TABLE EMPLOYEE
MODIFY SALARY INT ;

-- Scenario: Setting a default value for a
-- column

ALTER TABLE EMPLOYEE 
ALTER COLUMN MANAGER_ID SET DEFAULT 0;

-- Scenario: Dropping a default value from a
-- column 

ALTER TABLE EMPLOYEE
ALTER COLUMN MANAGER_ID DROP DEFAULT;

-- Scenario: Adding a CONSTRAINT to a table

ALTER TABLE EMPLOYEE 
ADD CONSTRAINT POSITIVE_SALARY CHECK (SALARY > 0);

-- Scenario: Adding a foreign key constraint
-- to a table

ALTER TABLE PROJECNT
ADD CONSTRAINT PK_DEPARTMENT_ID foreign key(ID) REFERENCES EMPLOYEE(ID);

-- Scenario: Creating an index on the
-- salary column

CREATE INDEX IDX_SALARY ON EMPLOYEE(SALARY); 

-- Scenario: Dropping an index from a table

DROP INDEX IDX_SALARY ON EMPLOYEE;

-- Scenario: Handling duplicate rows in a
-- table 
-- Question: How can you remove duplicate rows from a table,
-- keeping only the first occurrence?

WITH CTE AS 
( SELECT *,ROW_NUMBER() OVER (PARTITION BY ID,NAME,DEPARTMENT,SALARY,MANAGER_ID) AS ROW_NUM FROM EMPLOYEE)
DELETE FROM EMPLOYEE WHERE ID IN (SELECT ID FROM CTE WHERE ROW_NUM > 1);

-- Scenario: Combining multiple result sets
-- with UNION

SELECT ID NAME, DEPARTMENT FROM EMPLOYEE 
UNION 
SELECT ID ,NAME , DEPARTMENT FROM CONTRACTOR ;

-- Scenario: Fetching the top N salaries

-- Question: How would you retrieve the top 2 highest salaries from
-- the employees table?

SELECT NAME ,SALARY FROM EMPLOYEE 
ORDER BY SALARY DESC LIMIT 2;

-- Scenario: Using a self-join to find
-- employees reporting to the same
-- manager

select * from employee;
select a.name,b.name from employee a
join employee b on a.manager_id=b.manager_id 
where a.id< b.id;

-- Scenario: Recursive query to find the
-- hierarchy of employees

-- "First, find the CEO. Then, find everyone who reports to the CEO. Then, find 
-- everyone who reports to those people. Keep going until there is no one left.

with recursive employeeheirarcy as (
-- ANCHOR: FIND STARTING POINT OF HEIRARCY 
select id,name,manager_id 
from employee
where manager_id is null
union all
-- RECURSION 
SELECT e.id,e.name,e.manager_id from employee e 
inner join employeeheirarcy h on e.manager_id=h.id)
select * from employeeheirarcy;

-- Scenario: Calculating COMULATIVE SUM using a
-- window function

SELECT NAME ,SALARY,SUM(SALARY) OVER (ORDER BY SALARY) AS RUNNING_TOTAL
 FROM EMPLOYEE;
 
--  Scenario: Identifying employees with the
-- same salary 

SELECT ID,NAME,SALARY FROM EMPLOYEE 
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEE GROUP BY SALARY HAVING COUNT(*) > 1) ORDER BY SALARY DESC;

CREATE TABLE Customer_Leads (
    lead_id INT,
    first_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    estimated_budget INT,
    last_contacted_date DATE
);

INSERT INTO Customer_Leads (lead_id, first_name, email, phone_number, estimated_budget, last_contacted_date) VALUES
(1, 'Alice', 'alice@example.com', '555-0100', 5000, '2025-01-10'),
(2, 'Bob', NULL, '555-0101', 10000, '2025-01-12'),            -- Missing Email
(3, NULL, 'charlie@example.com', NULL, 7500, NULL),          -- Missing Name, Phone, and Date
(4, 'David', 'david@test.com', '555-0103', NULL, '2025-01-14'), -- Missing Budget (Numeric)
(5, 'Eve', NULL, NULL, 3000, '2025-01-15'),                  -- Missing Email and Phone
(6, 'Frank', 'frank@co.uk', '555-0105', NULL, NULL);         -- Missing Budget and Date

-- Scenario: Handling NULL values in SQL 
SELECT FIRST_NAME,COALESCE(EMAIL,"NO EMAIL") AS CLEAN_EMAIL,COALESCE(FIRST_NAME,"NO NAME") AS CLEANE_NAME FROM CUSTOMER_LEADS;

-- Scenario: Creating a materialized view for
-- performance optimization

-- How would you create a materialized view to store high
-- salary employees?

create materialized view high_pay_salaries as 
select name,salary from employee where salary > 50000; 

-- How do you manually refresh a materialized view to
-- reflect the latest data? 

refresh materialize view high_pay_salaries;

-- Question: How can you ensure that employee salaries cannot be
-- less than 20,000?

alter table employee 
add constraint check_salary check (salary>20000);

select * from employee ;

insert into employee (id ,name,department,salary,MANAGER_ID)
values 
(8,"ahmad","IT",10000,6); -- THIS WILL FAIL DUE TO CHECK CONSTARAIN 


-- Scenario: Implementing soft deletes using
-- a status column

ALTER TABLE EMPLOYEE
ADD COLUMN IS_ACTIVE BOOLEAN DEFAULT TRUE;

-- MARK AN EMPLOYE AS INACTIVE (SOFT DELETE)
UPDATE EMPLOYEE 
SET IS_ACTIVE = FALSE WHERE ID =6;
SELECT * FROM EMPLOYEE;

-- How would you lock a table to ensure that only your
-- transaction can make changes to it?

-- It is like entering a changing room and locking the door. Until you unlock it and leave , no one else can enter or use the room.

LOCK TABLES EMPLOYEE WRITE ;
 UPDATE EMPLOYEE 
 SET SALARY = SALARY*1.10;

-- AFTER YOU DONE OPERATION ON TABLE YOU MUST UNLOCK TABLE SO THAT OTHER CAN ACCESS TO IT 

UNLOCK TABLES;

-- Scenario: Using a partitioned table for
-- performance optimization

-- Question: How would you partition a table by department_id ?

-- RULE:Any column used as a partition key must be part of every Unique Key and Primary Key in the table

create table partitioned_employee (
ID INT,NAME VARCHAR(50),SALARY DECIMAL(10,2),dept_id int,PRIMARY KEY (DEPT_ID,ID))
partition by range (dept_id) (
partition p1 values less than (11),
partition p2 values less than (21));

INSERT INTO partitioned_employee (ID, NAME, SALARY, dept_id) 
VALUES 
(1, 'Ali', 5000, 5),
(2, 'Sara', 7000, 15),
(3, 'John', 4500, 10);

SELECT * FROM PARTITIONED_EMPLOYEE PARTITION (P1) ;  

-- Scenario: Creating an updatable view

CREATE VIEW ACTIVE_EMPLOYEE AS 
SELECT * FROM EMPLOYEE 
WHERE IS_ACTIVE=TRUE
WITH CHECK OPTION;
-- WITH CHECK OPTION MEAN ALWAYS CHECK IS_ACTIVE MUST BE TRUE 
UPDATE ACTIVE_EMPLOYEE 
SET SALARY=75000 WHERE ID =1;


-- Scenario: Using temporary tables for
-- intermediate calculations 

CREATE TEMPORARY TABLE HIGH_PAYING_EMPLOYEE AS 
SELECT * FROM EMPLOYEE  WHERE SALARY > 70000 ORDER BY SALARY DESC; 

-- Scenario: Altering an existing table to add
-- a new column

ALTER TABLE EMPLOYEE 
ADD COLUMN EMAIL VARCHAR(100) UNIQUE;

-- Scenario: Creating a table with a
-- composite primary key

CREATE TABLE STUDENT(ID INT,NAME VARCHAR(50),SUBJECT VARCHAR(50),COURSE_ID INT,PRIMARY KEY (ID,SUBJECT)); 


-- Scenario: Creating a foreign key
-- relationship between two tables

CREATE TABLE DEPARTMENTS (DPT_ID INT PRIMARY KEY,DPT_NAME VARCHAR(50)) ;
CREATE TABLE EMPLOYEES (EMPLOYEE_ID INT ,NAME VARCHAR(50),DPT_ID INT,FOREIGN KEY(DPT_ID) REFERENCES DEPARTMENTS(DPT_ID));


-- Scenario: Dropping an unwanted column
-- from a table

ALTER TABLE EMPLOYEE
DROP COLUMN EMAIL;

-- Question: How can you ensure that when a department is deleted,
-- all employees in that department are also deleted?

CREATE TABLE EMPLOYEES (
EMPLOYEE_ID INT,
NAME VARCHAR(50),
DPT_ID INT,
FOREIGN KEY(DPT_ID) REFERENCES DEPARTMENTS(DPT_ID)
ON DELETE CASCADE);

-- Scenario: Preventing duplicate values in a
-- column

ALTER TABLE EMPLOYEE
ADD COLUMN EMAIL VARCHAR(50) UNIQUE;

-- Scenario: Ensuring a column cannot have
-- NULL values

ALTER TABLE EMPLOYEE 
MODIFY SALARY DECIMAL(10,2) NOT NULL;

-- Scenario: Renaming a table in the
-- database  

ALTER TABLE EMPLOYEESS RENAME TO EMPLOYEE;

-- Scenario: Assigning a default value to a
-- column  

ALTER TABLE EMPLOYEE 
ALTER COLUMN HIRE_DATE SET DEFAULT (CURRENT_DATE) ; 

--  How would you ensure that the combination of
-- first_name and last_name in the employees table is unique? 

ALTER TABLE EMPLOYEE 
ADD CONSTRAINT UNIQUE_NAMES UNIQUE(FIRST_NAME,LAST_NAME);

-- TOPIC: CONDITIONAL LOGIC (CASE STATEMENTS)

-- You need to categorize employees based on their salary levels.
-- If salary is > 80000, they are 'High Earner', otherwise 'Standard'.

select name, salary ,
case
when salary >80000 then "high level"
when salary > 70000 then "mid level" 
when salary > 60000 then "standard level"
else "basic level"
end as salary_category from employee ;

-- You want to label employees based on their department with specific
-- custom labels (e.g., IT is 'Technical', HR is 'Administrative').

select name ,department,
case 
when department="IT" THEN "technical"
when  department ="HR" then "administrative"
when department ="finance" then "financial"
else "other" end as dept_type from employee ;


-- Scenario: Conditional Aggregation (Very important for Data Science)
-- You need to count the number of employees in IT and HR separately
-- but display them in a single row.

 SELECT DEPARTMENT ,COUNT(*) FROM EMPLOYEE GROUP BY DEPARTMENT HAVING DEPARTMENT="IT" OR DEPARTMENT ="HR";
 
-- OR
  
SELECT 
SUM(CASE WHEN DEPARTMENT ="IT" THEN 1 ELSE 0 END) AS IT_COUNT,
SUM(CASE WHEN DEPARTMENT="HR" THEN 1 ELSE 0 END ) AS HR_COUNT
FROM EMPLOYEE;

-- You want to sort employees, but you want "IT" department to always
-- appear first, regardless of alphabetical order.

SELECT NAME ,DEPARTMENT,SALARY 
FROM EMPLOYEE
ORDER BY (CASE WHEN DEPARTMENT="IT" THEN 1 ELSE 2 END ),DEPARTMENT; 

-- TOPIC: ANALYTICAL FUNCTIONS (LEAD & LAG)
-- Used for comparing current row with previous or next row


CREATE TABLE MONTHLY_SALES (MONTH DATE, REVENUE INT);

INSERT INTO MONTHLY_SALES (MONTH, REVENUE)
VALUES 
('2025-01-01', 10000),
('2025-02-01', 12000),
('2025-03-01', 15000),
('2025-04-01', 11000);


-- Scenario: Comparing growth month-over-month
-- You need to retrieve the current month's revenue and the 
-- previous month's revenue in the same row.


SELECT MONTH ,REVENUE ,
LAG(REVENUE) OVER (ORDER BY MONTH) AS PREVIUS_MONTH_REVENUE FROM MONTHLY_SALES;

-- You want to calculate the difference (Growth/Loss) compared 
-- to the previous month

SELECT MONTH,REVENUE 
,REVENUE-LAG(REVENUE) OVER (ORDER BY MONTH) AS MONTHLY_CHANGE FROM MONTHLY_SALES;

-- You need to see the NEXT month's revenue to forecast 
-- or compare ahead.

SELECT MONTH,REVENUE,
LEAD(REVENUE) OVER (ORDER BY MONTH) FROM MONTHLY_SALES;

-- TOPIC: STRING FUNCTIONS (DATA CLEANING)

-- You have dirty data where names have extra spaces.
-- You need to remove whitespace from the name 

SELECT TRIM(NAME) FROM EMPLOYEE AS CLEAN_NAME;

-- You need to combine First Name and Last Name into one column 
-- called 'FULL_NAME' 

SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME FROM EMPLOYEE; 

-- TOPIC: EXTRACTING SUBSTRINGS (POSITION BASED)

-- Scenario: You have product codes like 'ABC-100-2025'.
-- You want to extract just the middle part (position 5, length 3).

 select 'ABC-100-2025' as full_code
 ,substring('ABC-100-2025',5,3) middle_code;
 
 -- SQL: EXTRACTING SUBSTRINGS (delimiter BASED)

select substring_index("ABC-100-2025","-",1) as part1, -- cutt the string (start from left) start to 1st accurance of "-"
substring_index(substring_index('ABC-100-2025',"-",2),"-",-1) as part2 ,
-- first  SUBSTRING_INDEX('ABC-100-2025', '-', 2) mean cutt the sttring (count from left) start to 2nd accurance of "-" (ABC-100)
-- then cutt this (ABC-100) substring (count from right) start to 1st accurance of "-"
substring_index("ABC-100-2025" , "-",-1) as part3; -- cutt the string (count from right) start to 1st accurance of "-"


-- SELECT SUBSTRING_INDEX(string_column, "delimiter", count);

-- BEHAVIOR:
-- 1. IF COUNT IS POSITIVE (+):
--    Scans from the LEFT. Finds the Nth occurrence of the delimiter.
--    Returns everything to the LEFT of that delimiter.

-- 2. IF COUNT IS NEGATIVE (-):
--    Scans from the RIGHT. Finds the Nth occurrence of the delimiter.
--    Returns everything to the RIGHT of that delimiter.

-- TOPIC: STRING MANIPULATION (UPPER, REPLACE, LOCATE)

-- Scenario: Clean messy product names to create a standard SKU.
-- Input: 
-- Goal: 'IPHONE-13-PRO-MAX'

select 
upper(replace(trim('  iphone 13 pro max  ')," ","-"));



CREATE TABLE ORDER_LOG (
    ORDER_ID INT PRIMARY KEY AUTO_INCREMENT,
    CUSTOMER_NAME VARCHAR(50),
    ORDER_DATE DATETIME,       -- Includes TIME (Good for EXTRACT)
    DELIVERY_DATE DATE,        -- Just DATE (Good for DATEDIFF)
    SUBSCRIPTION_TYPE VARCHAR(20) -- (Good for determining intervals)
);

INSERT INTO ORDER_LOG (CUSTOMER_NAME, ORDER_DATE, DELIVERY_DATE, SUBSCRIPTION_TYPE)
VALUES 
('Alice', '2023-12-25 09:30:00', '2023-12-28', 'Monthly'),  -- Standard delivery
('Bob',   '2024-01-01 14:15:00', '2024-01-10', 'Yearly'),   -- Long delivery
('Charlie','2024-02-14 18:45:00', '2024-02-15', 'Monthly'), -- Fast delivery
('David', '2024-03-10 10:00:00', NULL, 'Weekly'),           -- Not delivered yet (NULL)
('Eve',   '2025-05-20 11:30:00', '2025-05-22', 'Yearly');   -- Future date (Hypothetical)

-- We need to know which hour of the day is busiest for orders.

-- Definition: The EXTRACT() function returns a single part of a date/time, such as the year, month, day, hour, or minute.

SELECT 
    ORDER_ID, 
    ORDER_DATE, 
    EXTRACT(HOUR FROM ORDER_DATE) AS ORDER_HOUR,
    EXTRACT(YEAR FROM ORDER_DATE) AS ORDER_YEAR
FROM ORDER_LOG;

-- Calculate exactly how many days it took to deliver each order.

-- Definition: DATEDIFF() calculates the number of days between two date value

-- DATEDIFF(End_Date, Start_Date).

SELECT 
    CUSTOMER_NAME,
    ORDER_DATE,
    DELIVERY_DATE,
    DATEDIFF(DELIVERY_DATE, ORDER_DATE) AS DAYS_TAKEN
FROM ORDER_LOG;
-- Notice what happens to 'David'. The result is NULL because he hasn't received it yet!

-- Calculate the subscription expiration date.

-- If they are 'Monthly', the expiration is 30 days after the Order Date.

-- Definition: DATE_ADD() adds a specified time interval to a date, while DATE_SUB() subtracts it.

SELECT 
    CUSTOMER_NAME, 
    SUBSCRIPTION_TYPE,
    ORDER_DATE,
    DATE_ADD(ORDER_DATE, INTERVAL 30 DAY) AS EXPIRATION_DATE
FROM ORDER_LOG
WHERE SUBSCRIPTION_TYPE = 'Monthly';

-- Make a readable report for the CEO. Format the ORDER_DATE to look like "Monday, December 25, 2023".

-- Definition: DATE_FORMAT() displays date/time data in different string formats.

SELECT 
    CUSTOMER_NAME, 
    DATE_FORMAT(ORDER_DATE, '%W, %M %e, %Y') AS FANCY_REPORT_DATE
FROM ORDER_LOG;

-- Definition: CAST() converts a value (expression) from one data type to another
--  specified data type (e.g., String to Integer, or Integer to Date).

select cast("100" as unsigned) + 50 as total;

CREATE TABLE BAD_DATA (
    ID INT,
    PRODUCT_NAME VARCHAR(50),
    PRICE_TEXT VARCHAR(50),   -- Storing price as text! Bad!
    QUANTITY_TEXT VARCHAR(50) -- Storing quantity as text! Bad!
);

INSERT INTO BAD_DATA VALUES 
(1, 'Laptop', '1000', '2'),
(2, 'Mouse',  '20',   '10'),
(3, 'Keyboard', '50', '5'),
(4, 'Monitor', '150', '2');

-- Sort products by price (Cheap to Expensive) correctly as numbers

select cast(price_text as unsigned) from bad_data order by price_text desc;

-- Calculate Total Revenue (Price * Quantity). Since these are text, we should cast them to be safe.

select cast(price_text as unsigned) * cast(quantity_text as unsigned) as total_revenue from bad_data;










