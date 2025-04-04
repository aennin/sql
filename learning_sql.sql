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

--CHAPTER 4
--Importing and Exporting Data
--create the us_counties_2010 Table
CREATE TABLE us_counties_2010 (
    geo_name varchar(90),                    -- Name of the geography
    state_us_abbreviation varchar(2),        -- State/U.S. abbreviation
    summary_level varchar(3),                -- Summary Level
    region smallint,                         -- Region
    division smallint,                       -- Division
    state_fips varchar(2),                   -- State FIPS code
    county_fips varchar(3),                  -- County code
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                        -- Area (Water) in square meters
    population_count_100_percent integer,    -- Population count (100%)
    housing_unit_count_100_percent integer,  -- Housing Unit count (100%)
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)

    -- This section is referred to as P1. Race:
    p0010001 integer,   -- Total population
    p0010002 integer,   -- Population of one race:
    p0010003 integer,       -- White Alone
    p0010004 integer,       -- Black or African American alone
    p0010005 integer,       -- American Indian and Alaska Native alone
    p0010006 integer,       -- Asian alone
    p0010007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0010008 integer,       -- Some Other Race alone
    p0010009 integer,   -- Population of two or more races
    p0010010 integer,   -- Population of two races:
    p0010011 integer,       -- White; Black or African American
    p0010012 integer,       -- White; American Indian and Alaska Native
    p0010013 integer,       -- White; Asian
    p0010014 integer,       -- White; Native Hawaiian and Other Pacific Islander
    p0010015 integer,       -- White; Some Other Race
    p0010016 integer,       -- Black or African American; American Indian and Alaska Native
    p0010017 integer,       -- Black or African American; Asian
    p0010018 integer,       -- Black or African American; Native Hawaiian and Other Pacific Islander
    p0010019 integer,       -- Black or African American; Some Other Race
    p0010020 integer,       -- American Indian and Alaska Native; Asian
    p0010021 integer,       -- American Indian and Alaska Native; Native Hawaiian and Other Pacific Islander
    p0010022 integer,       -- American Indian and Alaska Native; Some Other Race
    p0010023 integer,       -- Asian; Native Hawaiian and Other Pacific Islander
    p0010024 integer,       -- Asian; Some Other Race
    p0010025 integer,       -- Native Hawaiian and Other Pacific Islander; Some Other Race
    p0010026 integer,   -- Population of three races
    p0010047 integer,   -- Population of four races
    p0010063 integer,   -- Population of five races
    p0010070 integer,   -- Population of six races

    -- This section is referred to as P2. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    p0020001 integer,   -- Total
    p0020002 integer,   -- Hispanic or Latino
    p0020003 integer,   -- Not Hispanic or Latino:
    p0020004 integer,   -- Population of one race:
    p0020005 integer,       -- White Alone
    p0020006 integer,       -- Black or African American alone
    p0020007 integer,       -- American Indian and Alaska Native alone
    p0020008 integer,       -- Asian alone
    p0020009 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0020010 integer,       -- Some Other Race alone
    p0020011 integer,   -- Two or More Races
    p0020012 integer,   -- Population of two races
    p0020028 integer,   -- Population of three races
    p0020049 integer,   -- Population of four races
    p0020065 integer,   -- Population of five races
    p0020072 integer,   -- Population of six races

    -- This section is referred to as P3. RACE FOR THE POPULATION 18 YEARS AND OVER
    p0030001 integer,   -- Total
    p0030002 integer,   -- Population of one race:
    p0030003 integer,       -- White alone
    p0030004 integer,       -- Black or African American alone
    p0030005 integer,       -- American Indian and Alaska Native alone
    p0030006 integer,       -- Asian alone
    p0030007 integer,       -- Native Hawaiian and Other Pacific Islander alone
    p0030008 integer,       -- Some Other Race alone
    p0030009 integer,   -- Two or More Races
    p0030010 integer,   -- Population of two races
    p0030026 integer,   -- Population of three races
    p0030047 integer,   -- Population of four races
    p0030063 integer,   -- Population of five races
    p0030070 integer,   -- Population of six races

    -- This section is referred to as P4. HISPANIC OR LATINO, AND NOT HISPANIC OR LATINO BY RACE
    -- FOR THE POPULATION 18 YEARS AND OVER
    p0040001 integer,   -- Total
    p0040002 integer,   -- Hispanic or Latino
    p0040003 integer,   -- Not Hispanic or Latino:
    p0040004 integer,   -- Population of one race:
    p0040005 integer,   -- White alone
    p0040006 integer,   -- Black or African American alone
    p0040007 integer,   -- American Indian and Alaska Native alone
    p0040008 integer,   -- Asian alone
    p0040009 integer,   -- Native Hawaiian and Other Pacific Islander alone
    p0040010 integer,   -- Some Other Race alone
    p0040011 integer,   -- Two or More Races
    p0040012 integer,   -- Population of two races
    p0040028 integer,   -- Population of three races
    p0040049 integer,   -- Population of four races
    p0040065 integer,   -- Population of five races
    p0040072 integer,   -- Population of six races

    -- This section is referred to as H1. OCCUPANCY STATUS
    h0010001 integer,   -- Total housing units
    h0010002 integer,   -- Occupied
    h0010003 integer    -- Vacant
);

COPY us_counties_2010
FROM '/Users/augustineennin/Desktop/us_counties_2010.csv'
WITH (FORMAT CSV, HEADER);

SELECT geo_name, state_us_abbreviation, area_land
FROM us_counties_2010
ORDER BY area_land DESC
LIMIT 3;	--select the first three largest geo_name by area of land

--Importing a Subset of Columns with COPY
CREATE TABLE supervisor_salaries(
town varchar(30),
county varchar(30),
supervisor varchar(30),
start_date date,
salary money,
benefits money
);

COPY supervisor_salaries (town, supervisor, salary)
FROM '/Users/augustineennin/Desktop/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM supervisor_salaries
LIMIT 2

DELETE FROM supervisor_salaries;	--delete the data importrd into the table


--temporary tables
CREATE TEMPORARY TABLE supervisor_salaries_temp (LIKE supervisor_salaries);
COPY supervisor_salaries_temp (town, supervisor, salary)
FROM '/Users/augustineennin/Desktop/supervisor_salaries.csv'
WITH(FORMAT CSV, HEADER);

INSERT INTO supervisor_salaries (town, county, supervisor, salary)
SELECT town, 'Some County', supervisor, salary
FROM supervisor_salaries_temp;

DROP TABLE supervisor_salaries_temp;

--EXPORTING DATA

--Export all data
COPY us_counties_2010
TO '/Users/augustineennin/Desktop/us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|'); \

--Export particular columns of a data
COPY us_counties_2010 (geo_name, internal_point_lat, internal_point_lon)
TO '/Users/augustineennin/Desktop/us_counties_latlon_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');

--Exporting Query Results
COPY(
SELECT geo_name, state_us_abbreviation
FROM us_counties_2010
WHERE geo_name ILIKE '%mill%'
)
TO '/Users/augustineennin/Desktop/us_counties_mill_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');


--CHAPTER 5 BASIC MATH AND STATISTICS

--Adding and Subtracting Columns

SELECT geo_name,
state_us_abbreviation AS "st",
p0010003 AS "Whilte Alone",
p0010004 AS "Black Alone",
p0010003 + p0010004 AS "Total White and Black"
FROM us_counties_2010;


SELECT geo_name,	state_us_abbreviation AS "st",
p0010001 AS "Total",
p0010003 + p0010004 + p0010005 + p0010006 + p0010007 + p0010008 + p0010009 AS "All Races",
(p0010003 + p0010004 + p0010005 + p0010006 + p0010007 + p0010008 + p0010009) - p0010001 AS "Difference" FROM us_counties_2010
ORDER BY "Difference" DESC;

--Finding Percentage of the Whole
SELECT geo_name, state_us_abbreviation AS "st", (CAST (p0010006 AS numeric(8,1))/p0010001)*100 AS "pct_asian"
FROM us_counties_2010
ORDER BY "pct_asian" DESC;

CREATE TABLE percent_change(
department varchar(20),
spend_2014 numeric(10,2),
spend_2017 numeric(10,2)
);

INSERT INTO percent_change
VALUES 
('Building', 250000, 289000),
('Assessor', 178556, 179500),
('Library', 87777, 90001),
('Clerk', 451980, 650000),
('Police', 250000, 223000),
('Recreation', 199000, 195000);

SELECT department, 
spend_2014,
spend_2017,
round((spend_2017 - spend_2014) / spend_2014 * 100, 1) AS "pc_change" FROM percent_change;

--Aggregate functions for Average and Sums
SELECT sum(p0010001) AS "County Sum", round(avg(p0010001), 0) AS "County AVerage" FROM us_counties_2010;

--Finding the median
CREATE TABLE percentile_test(
numbers integer
);

INSERT INTO percentile_test (numbers) VALUES (1), (2), (3), (4), (5), (6);

SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY numbers) FROM percentile_test;

--1st, 2nd and 3rd quatile from the us_counties_2010 data
SELECT unnest(
percentile_cont(array[.25, .5, .75])
WITHIN GROUP (ORDER BY p0010001)) AS "quartiles" FROM us_counties_2010;

--Finding the mode
SELECT mode() WITHIN GROUP (ORDER BY p0010001) FROM us_counties_2010;
