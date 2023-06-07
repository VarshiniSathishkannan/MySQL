select * from countries;
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

select country, group_concat(city) from countries group by country;
+---------+-------------------------------+
| country | group_concat(city)            |
+---------+-------------------------------+
| India   | Hyderabad,Bangalore,New Delhi |
| UK      | London,Birmingham,Manchester  |
| USA     | New York,Houston,Dallas       |
+---------+-------------------------------+

with temp as (select country, group_concat(city) as c from countries group by country) select country, substring_index(c,',',1) a, substring_index(substring_index(c,',',2),',',-1) b, substring_index(c,',',-1) c from temp;
+---------+-----------+------------+------------+
| country | a         | b          | c          |
+---------+-----------+------------+------------+
| India   | Hyderabad | Bangalore  | New Delhi  |
| UK      | London    | Birmingham | Manchester |
| USA     | New York  | Houston    | Dallas     |
+---------+-----------+------------+------------+

create table rowtocol as with temp as (select country, group_concat(city) as c from countries group by country) select cou
ntry, substring_index(c,',',1) a, substring_index(substring_index(c,',',2),',',-1) b, substring_index(c,',',-1) c from temp; 

Now convert this again to row format

select country, a from rowtocol union select country, b from rowtocol union select country, c from rowtocol order by country;
+---------+------------+
| country | a          |
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

