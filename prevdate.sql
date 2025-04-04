-- Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
create table weather
(
    id int primary key auto_increment,
    date date,
    temperature int
);

insert into weather(date,temperature) values ('2015-01-01',10),('2015-01-02',25),('2015-01-03',20),('2015-01-04',30);

select * from weather;
+----+------------+-------------+
| id | date       | temperature |
+----+------------+-------------+
|  1 | 2015-01-01 |          10 |
|  2 | 2015-01-02 |          25 |
|  3 | 2015-01-03 |          20 |
|  4 | 2015-01-04 |          30 |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+

select b.id from weather a join weather b on a.date = date_sub(b.date, interval 1 day) where b.temperature > a.temperature;