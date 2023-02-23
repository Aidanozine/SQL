CREATE TABLE teachers (
id bigserial,
first_name varchar(25),
last_name varchar(50),
school varchar(50),
hire_date date,
salary numeric
);
DROP TABLE teachers;

INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);

SELECT * FROM teachers;
SELECT first_name, last_name FROM teachers;

SELECT last_name, first_name, salary FROM teachers;

SELECT school FROM teachers;

SELECT DISTINCT school FROM teachers;

SELECT hire_date FROM teachers;

SELECT DISTINCT hire_date FROM teachers;

SELECT first_name, last_name, salary FROM teachers ORDER BY salary DESC;
--default "ORDER BY" is ascending

SELECT last_name, school, hire_date FROM teachers ORDER BY school ASC, hire_date DESC;

SELECT last_name, school, hire_date, salary FROM teachers WHERE school = 'Myers Middle School';

SELECT last_name, school, hire_date, salary FROM teachers WHERE school <> 'F.D. Roosevelt HS';

SELECT first_name, last_name, school FROM teachers WHERE last_name ILIKE 'B%';

--"SELECT *" shows all columns

SELECT * FROM teachers WHERE last_name = 'Cole' OR last_name = 'Bush';

SELECT * FROM teachers WHERE school ILIKE '%Roosevelt%' OR salary BETWEEN 40000 AND 45000;

--TRY IT YOURSELF 1
SELECT first_name, last_name, school FROM teachers ORDER BY school ASC;

--TRY IT YOURSELF 2
SELECT * FROM teachers WHERE first_name  LIKE 'S%' AND salary > 40000;

--TRY IT YOURSELF 3
SELECT * FROM teachers WHERE hire_date BETWEEN '2010-01-01'AND '2011-10-30' ORDER BY salary DESC;