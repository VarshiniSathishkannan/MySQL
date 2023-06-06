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


