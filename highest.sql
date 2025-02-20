select * from orders order by amount desc;
+-------------+---------------+------------+--------+
| customer_id | customer_name | date       | amount |
+-------------+---------------+------------+--------+
|           3 | C             | 2021-10-15 |    300 |
|           3 | C             | 2019-10-15 |    250 |
|           2 | B             | 2021-10-15 |    200 |
|           1 | A             | 2020-10-15 |    150 |
|           1 | A             | 2021-10-15 |    150 |
|           2 | B             | 2020-10-15 |    150 |
|           1 | A             | 2020-10-10 |    100 |
|           2 | B             | 2019-10-15 |    100 |
|           3 | C             | 2018-10-15 |    100 |
+-------------+---------------+------------+--------+

-- Highest
select max(amount) from orders;
+-------------+
| max(amount) |
+-------------+
|         300 |
+-------------+

--Second highest
 select max(amount) from orders where amount < (select max(amount) from orders);
+-------------+
| max(amount) |
+-------------+
|         250 |
+-------------+

-- Second highest using offset -- but we may have many records with same value
select * from orders order by amount desc limit 2,1;
+-------------+---------------+------------+--------+
| customer_id | customer_name | date       | amount |
+-------------+---------------+------------+--------+
|           2 | B             | 2021-10-15 |    200 |
+-------------+---------------+------------+--------+

select * from orders order by amount desc limit 3,1;
+-------------+---------------+------------+--------+
| customer_id | customer_name | date       | amount |
+-------------+---------------+------------+--------+
|           1 | A             | 2020-10-15 |    150 |
+-------------+---------------+------------+--------+

-- This is the right approach

-- Better approach is by using rank function

select * from orders where amount = (select amount from orders order by amount desc limit 3,1);
+-------------+---------------+------------+--------+
| customer_id | customer_name | date       | amount |
+-------------+---------------+------------+--------+
|           1 | A             | 2020-10-15 |    150 |
|           1 | A             | 2021-10-15 |    150 |
|           2 | B             | 2020-10-15 |    150 |
+-------------+---------------+------------+--------+

select distinct amount from orders order by amount desc;
+--------+
| amount |
+--------+
|    300 |
|    250 |
|    200 |
|    150 |
|    100 |
+--------+

select amount, DENSE_RANK() over (order by amount desc) as denserank from orders; /* Without gap ranking*/
+--------+-----------+
| amount | denserank |
+--------+-----------+
|    300 |         1 |
|    250 |         2 |
|    200 |         3 |
|    150 |         4 |
|    150 |         4 |
|    150 |         4 |
|    100 |         5 |
|    100 |         5 |
|    100 |         5 |
+--------+-----------+

select amount, RANK() over (order by amount desc) from orders; /* With gap ranking*/
+--------+------------------------------------+
| amount | RANK() over (order by amount desc) |
+--------+------------------------------------+
|    300 |                                  1 |
|    250 |                                  2 |
|    200 |                                  3 |
|    150 |                                  4 |
|    150 |                                  4 |
|    150 |                                  4 |
|    100 |                                  7 |
|    100 |                                  7 |
|    100 |                                  7 |
+--------+------------------------------------+

select year(date), customer_name, amount, DENSE_RANK() over (partition by year(date) order by amount desc) from orders;   
+------------+---------------+--------+------------------------------------------------------------------+
| year(date) | customer_name | amount | DENSE_RANK() over (partition by year(date) order by amount desc) |
+------------+---------------+--------+------------------------------------------------------------------+
|       2018 | C             |    100 |                                                                1 |
|       2019 | C             |    250 |                                                                1 |
|       2019 | B             |    100 |                                                                2 |
|       2020 | A             |    150 |                                                                1 |
|       2020 | B             |    150 |                                                                1 |
|       2020 | A             |    100 |                                                                2 |
|       2021 | C             |    300 |                                                                1 |
|       2021 | B             |    200 |                                                                2 |
|       2021 | A             |    150 |                                                                3 |
+------------+---------------+--------+------------------------------------------------------------------+

-- Query 2:

Write a SQL query to fetch the second last record from a employee table.

--Tables Structure:

drop table employee;
create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;

-- Solution:
select emp_id, emp_name, dept_name, salary
from (
select *,
row_number() over (order by emp_id desc) as rn
from employee e) x
where x.rn = 2;