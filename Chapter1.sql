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
--SELECT first_name, last_name FROM teachers;

--TRY IT YOURSELF 1
CREATE TABLE animal_type (
id bigserial,
type varchar(25),
dietary_habits varchar(25),
reproduction varchar(25),
walking_posture varchar(25),
CONSTRAINT type_key PRIMARY KEY (id)
);

CREATE TABLE zoo_animals (
id bigserial,
animal_name varchar(25),
date_of_birth date,
colour varchar(25),
gender varchar(25),
type_id bigint REFERENCES animal_type (id),
CONSTRAINT animal_key PRIMARY KEY (id)
);

--TRY IT YOURSELF 2
INSERT INTO animal_type (type, dietary_habits, reproduction, walking_posture)
VALUES ('Lion', 'Carnivorous', 'Viviparous', 'Quadropedal'),
('Penguin', 'Carnivorous', 'Oviparous', 'Bipedal'),
('Giraffe', 'Herbivorous', 'Viviparous', 'Quadropedal'),
('Panda', 'Omnivorous', 'Viviparous', 'Quadropedal');

INSERT INTO zoo_animals (type_id, animal_name, date_of_birth, colour, gender)
VALUES (1, 'Simba', '1997-10-01', 'Beige', 'M'),
(1, 'Shiva', '1998-10-01', 'Beige', 'F'),
(2, 'Kiki', '2002-10-01', 'Black/White', 'F'),
(3, 'Sam', '2010-10-01', 'Brown', 'M'),
(4, 'Marcy', '1995-10-01', 'Black/White', 'F');

SELECT * FROM animal_type;
SELECT * FROM zoo_animals;
DROP TABLE animal_type;
