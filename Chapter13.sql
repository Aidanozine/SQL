SELECT upper('hello');

SELECT initcap('Aidan');

SELECT position(', ' in 'Tan,
Bella');

ltrim('socks', 's'); --left 's' removed
rtrim('socks', 's'); --right 's' removed

right('703-555-1212', 8) --returns last 8 digits
left('703-555-1212', 8) --returns first 8 digits

replace('cat', 'c', 'b') --replaces letters (all c's for b's)

Expression Description
. A dot is a wildcard that finds any character except a newline.
[FGz] Any character in the square brackets. Here, F, G, or z.
[a-z] A range of characters. Here, lowercase a to z.
[^a-z] The caret negates the match. Here, not lowercase a to z.
\w Any word character or underscore. Same as [A-Za-z0-9_].
\d Any digit.
\s A space.
\t Tab character.
\n Newline character.
\r Carriage return character.
^ Match at the start of a string.
$ Match at the end of a string.
? Get the preceding match zero or one time.
* Get the preceding match zero or more times.
+ Get the preceding match one or more times.
{m} Get the preceding match exactly m times.
{m,n} Get the preceding match between m and n times.
a|b The pipe denotes alternation. Find either a or b.
( ) Create and report a capture group or set precedence.
(?: ) Negate the reporting of a capture group.

SELECT substring('The game starts at 7 p.m. on May 2, 2019.' from '.+');

.+ Any character one or more times The game starts at 7 p.m. on
May 2, 2019.

\d{1,2} (?:a.m.|p.m.) One or two digits followed by a space and
a.m. or p.m. in a noncapture group
7 p.m.

^\w+ One or more word characters at the start 
The

\w+.$ One or more word characters followed by
any character at the end
2019.

May|June Either of the words May or June 
May

\d{4} Four digits 
2019

May \d, \d{4} May followed by a space, digit, comma,
space, and four digits
May 2, 2019


CREATE TABLE crime_reports (
crime_id bigserial PRIMARY KEY,
date_1 timestamp with time zone,
date_2 timestamp with time zone,
street varchar(250),
city varchar(100),
crime_type varchar(100),
description text,
case_number varchar(50),
original_text text NOT NULL
);
COPY crime_reports (original_text)
FROM 'C:\Users\desmo\Desktop\postgreSQL\practical-sql-main\practical-sql-main\Chapter_13\crime_reports.csv'
WITH (FORMAT CSV, HEADER OFF, QUOTE '"');

SELECT crime_id,
regexp_matches(original_text, '\d{1,2}\/\d{1,2}\/\d{2}', 'g')
FROM crime_reports;

SELECT
regexp_match(original_text, '(?:C0|SO)[0-9]+') AS case_number,
regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}') AS date_1,
regexp_match(original_text, '\n(?:\w+ \w+|\w+)\n(.*):') AS crime_type,
regexp_match(original_text, '(?:Sq.|Plz.|Dr.|Ter.|Rd.)\n(\w+ \w+|\w+)\n')
AS city
FROM crime_reports;


SELECT
(regexp_match(original_text, '(?:C0|SO)[0-9]+'))[1] AS case_number,
(regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1] AS date_1,
(regexp_match(original_text, '\n(?:\w+ \w+|\w+)\n(.*):'))[1] AS crime_type,
(regexp_match(original_text, '(?:Sq.|Plz.|Dr.|Ter.|Rd.)\n(\w+ \w+|\w+)\n'))[1]
AS city
FROM crime_reports;

UPDATE crime_reports
SET date_1 =
(
(regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1]
|| ' ' ||
(regexp_match(original_text, '\/\d{2}\n(\d{4})'))[1]
||' US/Eastern'
)::timestamptz;
SELECT crime_id,
date_1,
original_text
FROM crime_reports;

SHOW datestyle;
set datestyle to 'ISO, MDY';

UPDATE crime_reports
SET date_1 =
(
(regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1]
|| ' ' ||
(regexp_match(original_text, '\/\d{2}\n(\d{4})'))[1]
||' US/Eastern'
)::timestamptz,
date_2 =
CASE
WHEN (SELECT regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{1,2})') IS NULL)
AND (SELECT regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})') IS NOT NULL)
THEN
((regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1]
|| ' ' ||
(regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})'))[1]
||' US/Eastern'
)::timestamptz
WHEN (SELECT regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{1,2})') IS NOT NULL)
AND (SELECT regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})') IS NOT NULL)
THEN
((regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{1,2})'))[1]
|| ' ' ||
(regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})'))[1]
||' US/Eastern'
)::timestamptz
ELSE NULL
END,
street = (regexp_match(original_text, 'hrs.\n(\d+ .+(?:Sq.|Plz.|Dr.|Ter.|Rd.))'))[1],
city = (regexp_match(original_text,
'(?:Sq.|Plz.|Dr.|Ter.|Rd.)\n(\w+ \w+|\w+)\n'))[1],
crime_type = (regexp_match(original_text, '\n(?:\w+ \w+|\w+)\n(.*):'))[1],
description = (regexp_match(original_text, ':\s(.+)(?:C0|SO)'))[1],
case_number = (regexp_match(original_text, '(?:C0|SO)[0-9]+'))[1];

SELECT * FROM crime_reports;

SELECT regexp_replace('05/12/2018', '\d{4}', '2017');
SELECT regexp_split_to_table('Four,score,and,seven,years,ago', ',');
SELECT regexp_split_to_array('Phil Mike Tony Steve', ',');

SELECT array_length(regexp_split_to_array('Phil Mike Tony Steve', ' '), 1);

SELECT to_tsvector('I am walking across the sitting room to sit with you.');

SELECT to_tsvector('I am walking across the sitting room') @@ to_tsquery('walking & sitting');

SELECT to_tsvector('I am walking across the sitting room') @@ to_tsquery('walking & running');

CREATE TABLE president_speeches (
sotu_id serial PRIMARY KEY,
president varchar(100) NOT NULL,
title varchar(250) NOT NULL,
speech_date date NOT NULL,
speech_text text NOT NULL,
search_speech_text tsvector
);
COPY president_speeches (president, title, speech_date, speech_text)
FROM 'C:\Users\desmo\Desktop\postgreSQL\practical-sql-main\practical-sql-main\Chapter_13\sotu-1946-1977.csv'
WITH (FORMAT CSV, DELIMITER '|', HEADER OFF, QUOTE '@');

SELECT speech_date
FROM president_speeches;

UPDATE president_speeches
SET search_speech_text = to_tsvector('english', speech_text);

SELECT president, speech_date
FROM president_speeches
WHERE search_speech_text @@ to_tsquery('Vietnam')
ORDER BY speech_date;

SELECT president,
speech_date,
ts_headline(speech_text, to_tsquery('Vietnam'),
'StartSel = <,
StopSel = >,
MinWords=5,
MaxWords=7,
MaxFragments=1')
FROM president_speeches
WHERE search_speech_text @@ to_tsquery('Vietnam');

SELECT president,
speech_date,
ts_headline(speech_text, to_tsquery('transportation & !roads'),
'StartSel = <,
StopSel = >,
MinWords=5,
MaxWords=7,
MaxFragments=1')
FROM president_speeches
WHERE search_speech_text @@ to_tsquery('transportation & !roads');

SELECT president,
speech_date,
ts_headline(speech_text, to_tsquery('military <-> defense'),
'StartSel = <,
StopSel = >,
MinWords=5,
MaxWords=7,
MaxFragments=1')
FROM president_speeches
WHERE search_speech_text @@ to_tsquery('military <-> defense');

SELECT president,
speech_date,
ts_rank(search_speech_text,
to_tsquery('war & security & threat & enemy')) AS score
FROM president_speeches
WHERE search_speech_text @@ to_tsquery('war & security & threat & enemy')
ORDER BY score DESC
LIMIT 5

SELECT president,
speech_date,
ts_rank(search_speech_text,
to_tsquery('war & security & threat & enemy'), 2)::numeric
AS score
FROM president_speeches
WHERE search_speech_text @@ to_tsquery('war & security & threat & enemy')
ORDER BY score DESC
LIMIT 5;