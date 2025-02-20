create table dupemployees( id int,  name varchar(255), gender varchar(50), salary int);

insert into dupemployees values (1,'Sara','F',2000),(2,'Manoj','M',5000),(3,'Gopal','M',5500),(1,'Sara','F',2000),(2,'Manoj','M',5000);

select * from dupemployees;
+------+-------+--------+--------+
| id   | name  | gender | salary |
+------+-------+--------+--------+
|    1 | Sara  | F      |   2000 |
|    2 | Manoj | M      |   5000 |
|    3 | Gopal | M      |   5500 |
|    1 | Sara  | F      |   2000 |
|    2 | Manoj | M      |   5000 |
+------+-------+--------+--------+

1. remove duplicates and show only unique records

select distinct * from dupemployees;
+------+-------+--------+--------+
| id   | name  | gender | salary |
+------+-------+--------+--------+
|    1 | Sara  | F      |   2000 |
|    2 | Manoj | M      |   5000 |
|    3 | Gopal | M      |   5500 |
+------+-------+--------+--------+

2. Show only records which appeared only once

select id, name, gender, salary from dupemployees group by id,name,gender,salary having count(*) = 1;
+------+-------+--------+--------+
| id   | name  | gender | salary |
+------+-------+--------+--------+
|    3 | Gopal | M      |   5500 |
+------+-------+--------+--------+

3. Using row_number() function

select id, name, gender, salary, row_number() over (partition by id order by id) from dupemployees;
+------+-------+--------+--------+-------------------------------------------------+
| id   | name  | gender | salary | row_number() over (partition by id order by id) |
+------+-------+--------+--------+-------------------------------------------------+
|    1 | Sara  | F      |   2000 |                                               1 |
|    1 | Sara  | F      |   2000 |                                               2 |
|    2 | Manoj | M      |   5000 |                                               1 |
|    2 | Manoj | M      |   5000 |                                               2 |
|    3 | Gopal | M      |   5500 |                                               1 |
+------+-------+--------+--------+-------------------------------------------------+

with t as (select id, name, gender, salary, row_number() over (partition by id order by id) as i from dupemployees) select
 id, name, gender, salary from t where i = 1;
+------+-------+--------+--------+
| id   | name  | gender | salary |
+------+-------+--------+--------+
|    1 | Sara  | F      |   2000 |
|    2 | Manoj | M      |   5000 |
|    3 | Gopal | M      |   5500 |
+------+-------+--------+--------+

create table withoutdupemployees like dupemployees; /*Creates empty table with schema like dupemployees*/

create table withoutdupemployees_1 as (select id, name, gender, salary from dupemployees group by id,name,gender,salary having count(*) >= 1);

select * from withoutdupemployees_1;
+------+-------+--------+--------+
| id   | name  | gender | salary |
+------+-------+--------+--------+
|    1 | Sara  | F      |   2000 |
|    2 | Manoj | M      |   5000 |
|    3 | Gopal | M      |   5500 |
+------+-------+--------+--------+

insert into withoutdupemployees select id, name, gender, salary from dupemployees group by id,name,gender,salary having count(*) >= 1;

select * from withoutdupemployees;
+------+-------+--------+--------+
| id   | name  | gender | salary |
+------+-------+--------+--------+
|    1 | Sara  | F      |   2000 |
|    2 | Manoj | M      |   5000 |
|    3 | Gopal | M      |   5500 |
+------+-------+--------+--------+

4 . Delete duplicate records

WITH CTE AS (
SELECT column_name,
ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY
column_name) AS row_num FROM table_name
)
DELETE FROM CTE WHERE row_num > 1;

5. Print same salary people details

select * from dupemployees where salary in (select salary from dupemployees group by 1 having count(*)>1) order by salary;

-- Query 1:

Write a SQL query to fetch all the duplicate records from a table.

--Tables Structure:

drop table users;
create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

insert into users values
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');

select * from users;

Using window function.

select user_id, user_name, email
from (
select *,
row_number() over (partition by user_name order by user_id) as rn
from users u
order by user_id) x
where x.rn <> 1;
