CREATE TABLE my_contacts (
contact_id BIGSERIAL CONSTRAINT contact_id_key PRIMARY KEY,
	last_name varchar(30) NOT NULL,
	first_name varchar(30) NOT NULL,
	gender_id BIGINT REFERENCES gender (gender_id) ON DELETE CASCADE,
	phone varchar(10) NOT NULL,
	email varchar(30) NOT NULL,
	zip_code_id BIGINT REFERENCES zip_codes (zip_code_id) ON DELETE CASCADE,
	status_id BIGINT REFERENCES status (status_id) ON DELETE CASCADE,
	profession_id BIGINT REFERENCES profession (profession_id) ON DELETE CASCADE
);

SELECT * FROM my_contacts;

DROP TABLE my_contacts;
DROP TABLE zip_codes;
DROP TABLE profession;
DROP TABLE gender;
DROP TABLE status;

INSERT INTO my_contacts
(
	last_name,
	first_name,
	gender_id,
	phone,
	email,
	zip_code_id,
	status_id,
	profession_id
)
VALUES
    --('Tom', 'Smith', 'male', '8953572156', 'tom@gmail.com', '36013-36191', 'Mongomery', 'Alabama', 'Al', 'single', 'doctor', 'single lady', 'similar profession', 'around 50', 'hiking', 'reading', 'biking'),
	--('Bethany', 'Storm', 'female', '8953572156', 'beth@gmail.com', '99703-99781', 'Fairbanks', 'Alaska', 'Ak', 'divorced', 'teacher', 'single lady', 'similar profession', 'around 35', 'hiking', 'cooking', 'running'),
	--('Rider', 'McBeth', 'male', '8953572156', 'rider@gmail.com', '36013-36191', 'Mongomery', 'Alabama', 'Al', 'single', 'software developer', 'single lady', 'same profession', 'around 50', 'hiking', 'diving', 'biking'),
	--('Juliet', 'Stone', 'female', '8953572156', 'mary@gmail.com', '36013-36191', 'Mongomery', 'Alabama', 'Al', 'divorced', 'student', 'single guy', 'student', 'around 25', 'hiking', 'reading', 'biking'),
	--('Romeo', 'Wood', 'male', '8953572156', 'romeo@gmail.com', '99703-99781', 'Fairbanks', 'Alaska', 'Ak', 'single', 'screen writer', 'single lady', 'similar profession', 'around 35', 'drawing', 'reading', 'cooking'),
	--('Trixie', 'Smith', 'female', '8953572156', 'trix@gmail.com', '36013-36191', 'Mongomery', 'Alabama', 'Al', 'single', 'zoologist', 'single guy', 'similar profession', 'around 50', 'swimming', 'reading', 'sky-diving'),
	--('Carl', 'Johnson', 'male', '8953572156', 'carl@gmail.com', '85641-85705', 'Tuicson', 'Arizona', 'Ar', 'single', 'digital content designer', 'single lady', 'same profession', 'around 25', 'singing', 'reading', 'biking'),
	--('Kristine', 'Smith', 'female', '8953572156', 'Kristy@gmail.com', '85641-85705', 'Tuicson', 'Arizona', 'Ar', 'single', 'nurse', 'single guy', 'similar profession', 'around 35', 'hiking', 'reading', 'diving');
	
	('Tom','Smith',2,'0780615009','tom@gmail.com',1,1,1),
    ('Gugu','Ndaba',2,'0780615012','gugu@gmail.com',2,2,2),
    ('Jo','Nala',1,'0780615078','jo@gmail.com',1,1,3),
    ('Mary','Smith',2,'0610615009','mary@gmail.com',2,2,4),
    ('Kyle','Koo',1,'0710615009','kyle@gmail.com',1,2,1),
    ('Sizwe','Nchabe',1,'0840615099','sizwe@gmail.com',3,1,3),
    ('Liz','Sun',2,'0830777009','liz@gmail.com',3,1,2);
	
CREATE TABLE zip_codes
(
    zip_code_id BIGSERIAL CONSTRAINT zip_code_id_key PRIMARY KEY,
	zip_code char(11),
	city varchar(30) NOT NULL,
	state_name varchar(30) NOT NULL,
	state_abbreviation char(2) NOT NULL
)

INSERT INTO zip_codes
(
  zip_code,
	city,
	state_name,
	state_abbreviation
)
VALUES
    ('36013-36191', 'Mongomery', 'Alabama', 'Al'),
	('99703-99781', 'Fairbanks', 'Alaska', 'Ak'),
	('85641-85705', 'Tuicson', 'Arizona', 'Ar');
	
	SELECT * FROM zip_codes;
	
	SELECT * FROM my_contacts cont
	JOIN zip_codes zip
	ON cont.zip_code_id = zip.zip_code_id;
	
SELECT mc.last_name, mc.first_name,zc.zip_code_id, zc.city, zc.state_name FROM my_contacts AS mc 
	JOIN zip_codes zc
	ON mc.zip_code_id = zc.zip_code_id
	
CREATE TABLE profession
(
    profession_id BIGSERIAL CONSTRAINT profession_id_key PRIMARY KEY,
	profession varchar(30) NOT NULL 
)

INSERT INTO profession
(
   profession 
)
VALUES
    ('doctor'),
	('teacher'),
	('software developer'),
	('student');
	
SELECT * FROM profession;

SELECT * FROM profession;
	
	SELECT cont.first_name, cont.last_name, prof.profession FROM my_contacts cont
	JOIN profession prof
	ON cont.profession_id = prof.profession_id;
	
CREATE TABLE gender
(
    gender_id BIGSERIAL CONSTRAINT gender_id_key PRIMARY KEY,
	gender varchar(30) NOT NULL
)

INSERT INTO gender
(
    gender
)
VALUES
    ('M'),
	('F');
	
SELECT * FROM gender;

    SELECT cont.first_name, cont.last_name, sex.gender FROM my_contacts cont
	JOIN gender sex
	ON cont.gender_id = sex.gender_id;
    
CREATE TABLE status
(
    status_id BIGSERIAL CONSTRAINT status_id_key PRIMARY KEY,
	status varchar(30) NOT NULL
)

INSERT INTO status
(
    status
)
VALUES
    ('single'),
	('divorced');
	
SELECT * FROM status;

    SELECT cont.first_name, cont.last_name, stat.status FROM my_contacts cont
	JOIN status stat
	ON cont.status_id = stat.status_id;

CREATE TABLE seekings
(
    seeking_id BIGSERIAL CONSTRAINT seeking_id_key PRIMARY KEY,
	seeking varchar(50) NOT NULL UNIQUE
)

INSERT INTO seekings
(
    seeking
)
VALUES
	('single male'),
	('single female'),
	('same profession'),
	('under 25'),
	('under 50'),
	('over 50'),
	('student'),
	('employed'),
	('retired');
	
SELECT * FROM seekings;

CREATE TABLE contact_seeking
(
    contact_id BIGINT NOT NULL REFERENCES my_contacts (contact_id),
	seeking_id BIGINT NOT NULL REFERENCES seekings (seeking_id)
)

INSERT INTO contact_seeking
(
    contact_id,
	seeking_id
)
VALUES
    (1,1),
	(1,3),
	(1,6),
	(2,1),
	(2,8),
	(2,4),
	(3,2),
	(3,3),
	(3,6),
	(4,1),
	(5,2),
	(6,1),
	(6,4),
	(7,2);--------------Random numbers

SELECT * FROM contact_seeking;
DROP TABLE contact_seeking;

SELECT c.first_name, c.last_name, s.seeking
FROM my_contacts c
JOIN contact_seeking cs
ON c.contact_id = cs.contact_id
JOIN seekings s
ON s.seeking_id = cs.seeking_id;

CREATE TABLE interests
(
    interest_id BIGSERIAL CONSTRAINT interest_id_key PRIMARY KEY,
	interest varchar(50) NOT NULL UNIQUE
)

INSERT INTO interests
(
    interest
)
VALUES
    ('hiking'),
	('reading'),
	('biking'),
	('cooking'),
	('running'),
	('diving'),
	('studying'),
	('cycling'),
	('art'),
	('walking');

SELECT * FROM interests;

CREATE TABLE contact_interest
(
    contact_id BIGINT NOT NULL REFERENCES my_contacts (contact_id),
	interest_id BIGINT NOT NULL REFERENCES interests (interest_id)
)

INSERT INTO contact_interest
(
    contact_id,
	interest_id
)
VALUES
    (1,1),
	(1,3),
	(1,6),
	(2,1),
	(2,8),
	(2,4),
	(3,2),
	(3,7),
	(3,6),
	(4,1),
	(5,2),
	(6,9),
	(6,4),
	(7,10);--------------Random numbers
	
SELECT * FROM contact_interest;
DROP TABLE contact_interests;

SELECT c.first_name, c.last_name, i.interest
FROM my_contacts c
JOIN contact_interest ci
ON c.contact_id = ci.contact_id
JOIN interests i
ON i.interest_id = ci.interest_id;
