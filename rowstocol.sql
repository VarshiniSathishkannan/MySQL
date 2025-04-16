CREATE TABLE country_city (
    country VARCHAR(50),
    city VARCHAR(100)
);

INSERT INTO country_city (country, city) VALUES
('USA', 'New York'),
('USA', 'Houston'),
('USA', 'Dallas'),
('India', 'Hyderabad'),
('India', 'Bangalore'),
('India', 'New Delhi'),
('UK', 'London'),
('UK', 'Birmingham'),
('UK', 'Manchester');

select * from country_city;
+---------+------------+
| country | city       |
+---------+------------+
| USA     | New York   |
| USA     | Houston    |
| USA     | Dallas     |
| India   | Hyderabad  |
| India   | Bangalore  |
| India   | New Delhi  |
| UK      | London     |
| UK      | Birmingham |
| UK      | Manchester |
+---------+------------+

select country, group_concat(city) from country_city group by country;
+---------+-------------------------------+
| country | group_concat(city)            |
+---------+-------------------------------+
| India   | Hyderabad,Bangalore,New Delhi |
| UK      | London,Birmingham,Manchester  |
| USA     | New York,Houston,Dallas       |
+---------+-------------------------------+

with temp as (select country, group_concat(city) as c from country_city group by country) select country, substring_index(c,',',1) a, substring_index(substring_index(c,',',2),',',-1) b, substring_index(c,',',-1) c from temp;
+---------+-----------+------------+------------+
| country | a         | b          | c          |
+---------+-----------+------------+------------+
| India   | Hyderabad | Bangalore  | New Delhi  |
| UK      | London    | Birmingham | Manchester |
| USA     | New York  | Houston    | Dallas     |
+---------+-----------+------------+------------+

create table rowtocol as with temp as (select country, group_concat(city) as c from country_city group by country) select country, substring_index(c,',',1) a, substring_index(substring_index(c,',',2),',',-1) b, substring_index(c,',',-1) c from temp; 

Now convert this again to row format

select country, a as city from rowtocol union select country, b from rowtocol union select country, c from rowtocol order by country;

-- union is taking the 1st col value as default column name
+---------+------------+
| country | city       |
+---------+------------+
| India   | Hyderabad  |
| India   | Bangalore  |
| India   | New Delhi  |
| UK      | London     |
| UK      | Birmingham |
| UK      | Manchester |
| USA     | New York   |
| USA     | Houston    |
| USA     | Dallas     |
+---------+------------+

