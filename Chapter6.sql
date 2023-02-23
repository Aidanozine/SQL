SELECT *
FROM table_a JOIN table_b
ON table_a.key_column = table_b.foreign_key_column


CREATE TABLE departments (
dept_id bigserial,
dept varchar(100),
city varchar(100),
Constraint dept_key PRIMARY KEY (dept_id),
CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
emp_id bigserial,
first_name varchar(100),
last_name varchar(100),
salary integer,
dept_id integer REFERENCES departments (dept_id),
CONSTRAINT emp_key PRIMARY KEY (emp_id),
CONSTRAINT emp_dept_unique UNIQUE (emp_id, dept_id)
);

INSERT INTO departments (dept, city)
VALUES
('Tax', 'Atlanta'),
('IT', 'Boston');

INSERT INTO employees (first_name, last_name, salary, dept_id)
VALUES
('Nancy', 'Jones', 62500, 1),
('Lee', 'Smith', 59300, 1),
('Soo', 'Nguyen', 83000, 2),
('Janet', 'King', 95000, 2);

SELECT * FROM departments;
SELECT * FROM employees;

SELECT *
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id;

SELECT employees.last_name, employees.first_name, departments.dept
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id;


CREATE TABLE schools_left (
id integer CONSTRAINT left_key PRIMARY KEY,
	left_school varchar(30)
);

CREATE TABLE schools_right (
id integer CONSTRAINT right_key PRIMARY KEY,
	right_school varchar(30)
);

SELECT * FROM schools_left;

SELECT * FROM schools_right;

INSERT INTO schools_left (id, left_school) VALUES
(1, 'Oak Street School'),
(2, 'Roosevelt High School'),
(5, 'Washington Middle School'),
(6, 'Jefferson High School');

INSERT INTO schools_right (id, right_school) VALUES
(1, 'Oak Street School'),
(2, 'Roosevelt High School'),
(3, 'Morrison Elementary'),
(4, 'Chase Magnet Academy'),
(6, 'Jefferson High School');

SELECT *
FROM schools_left JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT *
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT *
FROM schools_left RIGHT JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT *
FROM schools_left FULL OUTER JOIN schools_right
ON schools_left.id = schools_right.id;

SELECT *
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id
WHERE schools_right.id IS NULL; --shows where the data has no match

SELECT id --Need to say either "schools_left.id" or "schools_right.id"
FROM schools_left LEFT JOIN schools_right
ON schools_left.id = schools_right.id;


CREATE TABLE schools_enrollment (
id integer,
enrollment integer
);
CREATE TABLE schools_grades (
id integer,
grades varchar(10)
);
INSERT INTO schools_enrollment (id, enrollment)
VALUES
(1, 360),
(2, 1001),
(5, 450),
(6, 927);
INSERT INTO schools_grades (id, grades)
VALUES
(1, 'K-3'),
(2, '9-12'),
(5, '6-8'),
(6, '9-12');

SELECT lt.id, lt.left_school, en.enrollment, gr.grades
FROM schools_left AS lt LEFT JOIN schools_enrollment AS en
ON lt.id = en.id
LEFT JOIN schools_grades AS gr
ON lt.id = gr.id;


CREATE TABLE us_counties_2000 (
geo_name varchar(90),
state_us_abbreviation varchar(2),
state_fips varchar(2),
county_fips varchar(3),
p0010001 integer,
p0010002 integer,
p0010003 integer,
p0010004 integer,
p0010005 integer,
p0010006 integer,
p0010007 integer,
p0010008 integer,
p0010009 integer,
p0010010 integer,
p0020002 integer,
p0020003 integer
);

COPY us_counties_2000
FROM 'C:\Users\desmo\Desktop\postgreSQL\practical-sql-main\practical-sql-main\Chapter_06\us_counties_2000.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM us_counties_2000;

SELECT c2010.geo_name,
c2010.state_us_abbreviation AS state,
c2010.p0010001 AS pop_2010,
c2000.p0010001 AS pop_2000,
c2010.p0010001 - c2000.p0010001 AS raw_change,
round( (CAST(c2010.p0010001 AS numeric(8,1)) - c2000.p0010001)
/ c2000.p0010001 * 100, 1 ) AS pct_change
FROM us_counties_2010 c2010 INNER JOIN us_counties_2000 c2000 --INNER JOIN is the same as JOIN
ON c2010.state_fips = c2000.state_fips
AND c2010.county_fips = c2000.county_fips
AND c2010.p0010001 <> c2000.p0010001
ORDER BY pct_change DESC;

-- Try it Yourself #1 --
SELECT c2000.geo_name AS county_name_2000, c2010.geo_name AS county_name_2010
FROM us_counties_2000 AS c2000
FULL OUTER JOIN us_counties_2010 AS c2010
    ON c2000.state_fips = c2010.state_fips
    AND c2000.county_fips = c2010.county_fips
WHERE (c2000.geo_name IS NULL) OR (c2010.geo_name IS NULL)
ORDER BY county_name_2000;

--TRY IT YOURSELF 2
SELECT population_count_100_percent FROM us_counties_2010;
SELECT p0010003 FROM us_counties_2000;

SELECT sum(p0010003) AS "population_percent_2000"
FROM us_counties_2000;

SELECT sum(population_count_100_percent) AS "population_percent_2010"
FROM us_counties_2010;

SELECT (population_percent_2010 + population_percent_2000) / 2;

--TRY IT YOURSELF 3
SELECT *
FROM us_counties_2010 JOIN us_counties_2000
ON us_counties_2010.key_column = us_counties_2000.foreign_key_column