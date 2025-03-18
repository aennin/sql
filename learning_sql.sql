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


--CHAPTER 3 -Data Types

--Character data types
CREATE TABLE char_data_types (
varchar_column varchar(10),						 char_column char(10),
text_column text
); --create a table for the 3 types of character data type 

INSERT INTO char_data_types	VALUES ('abc', 'abc', 'abc'), ('defghi', 'defghi', 'defghi'); --insert values into the table

COPY char_data_types TO '/Users/augustineennin/Desktop/typetest.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|'); --copy the table to a desktop in a csv format

--Number data types
CREATE TABLE number_data_types (
numeric_column numeric(20,5), real_column real, double_column double precision
);

INSERT INTO number_data_types VALUES (.7, .7, .7), (2.13579, 2.13579, 2.13579), (2.1357987654, 2.1357987654, 2.1357987654);

SELECT * FROM number_data_types;

--Date and Time
CREATE TABLE date_time_types(
timestamp_column timestamp with time zone,
interval_column interval
);
INSERT INTO date_time_types 
VALUES
('2018-12-31 01:00 EST', '2 days'),
('2018-12-31 01:00 -8', '1 month'),
('2018-12-31 01:00 Australia/Melbourne', '1 century'),
(now(), '1 week');
SELECT * FROM date_time_types;

--Using the interval Data Type in Calculations
SELECT 
timestamp_column,
interval_column,
timestamp_column - interval_column AS new_date
FROM date_time_types

--Transforming Values from One Type to Another with CAST
SELECT timestamp_column, CAST(timestamp_column AS varchar(10)) FROM date_time_types;

SELECT timestamp_column:: varchar(10) FROM date_time_types; --shortcut for CAST in PostgresSQL

SELECT numeric_column,
CAST(numeric_column AS integer),
CAST(numeric_column AS varchar(6))
FROM number_data_types;

SELECT CAST(char_column AS integer) FROM char_data_types;-- Intentional error.Numbers can't become integers

