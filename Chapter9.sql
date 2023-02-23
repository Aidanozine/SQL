CREATE TABLE meat_poultry_egg_inspect (
est_number varchar(50) CONSTRAINT est_number_key PRIMARY KEY,
company varchar(100),
street varchar(100),
city varchar(30),
st varchar(2),
zip varchar(5),
phone varchar(14),
grant_date date,
activities text,
dbas text
);

--C:\Users\desmo\Desktop\postgreSQL\practical-sql-main\practical-sql-main\Chapter_09\MPI_Directory_by_Establishment_Name.csv

COPY meat_poultry_egg_inspect
FROM 'C:\Users\desmo\Desktop\postgreSQL\practical-sql-main\practical-sql-main\Chapter_09\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

CREATE INDEX company_idx ON meat_poultry_egg_inspect (company);

SELECT count(*) FROM meat_poultry_egg_inspect;

SELECT company,
street,
city,
st,
count(*) AS address_count
FROM meat_poultry_egg_inspect
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

SELECT st,
count(*) AS st_count
FROM meat_poultry_egg_inspect
GROUP BY st
ORDER BY st;

SELECT est_number,
company,
city,
st,
zip
FROM meat_poultry_egg_inspect
WHERE st IS NULL;

--Check for inconsistent data
SELECT company,
count(*) AS company_count
FROM meat_poultry_egg_inspect
GROUP BY company
ORDER BY company ASC;

SELECT length(zip),
count(*) AS length_count
FROM meat_poultry_egg_inspect
GROUP BY length(zip)
ORDER BY length(zip) ASC;

SELECT st,
count(*) AS st_count
FROM meat_poultry_egg_inspect
WHERE length(zip) < 5 --All zip codes are limited to a length 5
GROUP BY st
ORDER BY st ASC;

--The code for adding a column to a table looks like this:
ALTER TABLE table ADD COLUMN column data_type;
--Similarly, we can remove a column with the following syntax:
ALTER TABLE table DROP COLUMN column;
--To change the data type of a column, we would use this code:
ALTER TABLE table ALTER COLUMN column SET DATA TYPE data_type;
--Adding a NOT NULL constraint to a column will look like the following:
ALTER TABLE table ALTER COLUMN column SET NOT NULL;
--Removing the NOT NULL constraint looks like this:
ALTER TABLE table ALTER COLUMN column DROP NOT NULL;

CREATE TABLE meat_poultry_egg_inspect_backup AS
SELECT * FROM meat_poultry_egg_inspect;

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN st_copy varchar(2);
UPDATE meat_poultry_egg_inspect
SET st_copy = st;

SELECT st,
st_copy
FROM meat_poultry_egg_inspect
ORDER BY st;

UPDATE meat_poultry_egg_inspect
SET st = 'MN'
WHERE est_number = 'V18677A';

UPDATE meat_poultry_egg_inspect
SET st = 'AL'
WHERE est_number = 'M45319+P45319';

UPDATE meat_poultry_egg_inspect
SET st = 'WI'
WHERE est_number = 'M263A+P263A+V263A';

--REFER TO SQL SOURCE

UPDATE meat_poultry_egg_inspect --Restores
SET st = st_copy;

UPDATE meat_poultry_egg_inspect original --Creates a back-up
SET st = backup.st
FROM meat_poultry_egg_inspect_backup backup
WHERE original.est_number = backup.est_number;

SELECT * FROM meat_poultry_egg_inspect original;

-- Restoring from the column backup
UPDATE meat_poultry_egg_inspect
SET st = st_copy;

-- Restoring from the table backup
UPDATE meat_poultry_egg_inspect original
SET st = backup.st
FROM meat_poultry_egg_inspect_backup backup
WHERE original.est_number = backup.est_number; 

-- Listing 9-13: Creating and filling the company_standard column

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN company_standard varchar(100);

UPDATE meat_poultry_egg_inspect
SET company_standard = company;

-- Listing 9-14: Use UPDATE to modify field values that match a string

UPDATE meat_poultry_egg_inspect
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%';

SELECT company, company_standard
FROM meat_poultry_egg_inspect
WHERE company LIKE 'Armour%';

-- Listing 9-15: Creating and filling the zip_copy column

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN zip_copy varchar(5);
UPDATE meat_poultry_egg_inspect
SET zip_copy = zip;
--We’ll use UPDATE again but this time in conjunction 
--with the double-pipe string operator (||), 
--which performs concatenation. 
--Concatenation combines two or more string or non-string values 
--into one. For example, inserting ||
--between the strings abc and 123 results in abc123.
UPDATE meat_poultry_egg_inspect
SET zip = '00' || zip
WHERE st IN('PR','VI') AND length(zip) = 3;

UPDATE meat_poultry_egg_inspect
SET zip = '0' || zip
WHERE st IN('CT','MA','ME','NH','NJ','RI','VT') AND length(zip) = 4;

CREATE TABLE state_regions (
st varchar(2) CONSTRAINT st_key PRIMARY KEY,
region varchar(20) NOT NULL
);
COPY state_regions
FROM 'C:\Users\desmo\Desktop\postgreSQL\practical-sql-main\practical-sql-main\Chapter_09\state_regions.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ',');

ALTER TABLE meat_poultry_egg_inspect ADD COLUMN inspection_date date;

UPDATE meat_poultry_egg_inspect inspect
SET inspection_date = '2019-12-01'
WHERE EXISTS (SELECT state_regions.region
FROM state_regions
WHERE inspect.st = state_regions.st
AND state_regions.region = 'New England');

select * FROM meat_poultry_egg_inspect
WHERE inspection_date = '2019-12-01';

SELECT inspection_date, count(*)
FROM meat_poultry_egg_inspect
GROUP BY inspection_date
ORDER BY inspection_date;


START TRANSACTION;

UPDATE meat_poultry_egg_inspect
SET company = 'AGRO Merchantss Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

SELECT company
FROM meat_poultry_egg_inspect
WHERE company LIKE 'AGRO%'
ORDER BY company;

ROLLBACK;
COMMIT;

DROP TABLE meat_poultry_egg_inspect_backup;

CREATE TABLE meat_poultry_egg_inspect_backup AS
SELECT *,
'2018-02-07'::date AS reviewed_date
FROM meat_poultry_egg_inspect;

ALTER TABLE meat_poultry_egg_inspect RENAME TO meat_poultry_egg_inspect_temp;

ALTER TABLE meat_poultry_egg_inspect_backup
RENAME TO meat_poultry_egg_inspect;

ALTER TABLE meat_poultry_egg_inspect_temp
RENAME TO meat_poultry_egg_inspect_backup;

SELECT * FROM meat_poultry_egg_inspect_backup;