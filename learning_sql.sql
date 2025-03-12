--CHAPTER 2

--Basic SELECT Syntax
SELECT * FROM teachers; 

--Quering a Subset of Colums
SELECT last_name, first_name, salary FROM teachers;

--Using DISTINCT to Find Unique Values
SELECT DISTINCT school, salary FROM teachers;

--SORTING DATA with ORDER BY
SELECT first_name, last_name, salary FROM teachers ORDER BY salary DESC; --order by salary in descending order

SELECT last_name, school, hire_date FROM teachers ORDER BY school ASC, hire_date DESC;

--Filtering Rows with WHERE
SELECT last_name, school, hire_date FROM teachers WHERE school = 'Myers Middle School'; -- filtering by Myers Middle School

SELECT school FROM teachers WHERE school != 'F.D. Roosevelt HS'; -- All schools except F.D. Roosevelt

SELECT first_name, last_name, hire_date FROM teachers WHERE hire_date < '2000-01-01'; --teachers hired before Jan 1, 2000

SELECT first_name, last_name, salary FROM teachers WHERE salary >= 43500; --teachers that earn $43500 or higher

SELECT first_name, last_name, school, salary FROM teachers WHERE salary BETWEEN 40000 AND 65000; --teachers who earn between $40000 and $65000

--Using LIKE and ILIKE with WHERE (NB LIKE is case sensitive while ILIKE is case insensitive)
SELECT first_name from teachers WHERE first_name ILIKE 'sam%';

--Combining Operators with AND and OR
SELECT * FROM teachers WHERE school = 'Myers Middle School' AND salary < 40000; --teacher from MMS with salary less than $40000 

SELECT * FROM teachers WHERE school = 'F.D. Roosevelt HS' AND (salary < 38000 OR salary > 40000); --teachers from F.D.R HS with salary less than  38000 or more than 40000
