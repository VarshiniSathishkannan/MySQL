show databases;

use information_schema;

show tables;

create database customer;

use customer;

create table orders (
    -> customer_id int,
    -> customer_name varchar(255),
    -> date date,
    -> amount int )
    -> ;

insert into orders values (1,'A','2020-10-10',100); ...

select * from orders;
+-------------+---------------+------------+--------+
| customer_id | customer_name | date       | amount |
+-------------+---------------+------------+--------+
|           1 | A             | 2020-10-10 |    100 |
|           1 | A             | 2020-10-15 |    150 |
|           1 | A             | 2021-10-15 |    150 |
|           2 | B             | 2019-10-15 |    100 |
|           2 | B             | 2020-10-15 |    150 |
|           2 | B             | 2021-10-15 |    200 |
|           3 | C             | 2018-10-15 |    100 |
|           3 | C             | 2019-10-15 |    250 |
|           3 | C             | 2021-10-15 |    300 |
+-------------+---------------+------------+--------+

Problem statement:

1. For each customer_id, There should be atleast 1 record for each year, if no record is present, add a dummy date as null and amount as 0 and find the avg

insert into years values (2019),(2020),(2021);

select distinct customer_name from orders;
+---------------+
| customer_name |
+---------------+
| A             |
| B             |
| C             |
+---------------+

with t as (select distinct customer_name from orders) select t.customer_name, y.yr from t cross join years y order by t.customer_name, y.yr;
+---------------+------+
| customer_name | yr   |
+---------------+------+
| A             | 2019 |
| A             | 2020 |
| A             | 2021 |
| B             | 2019 |
| B             | 2020 |
| B             | 2021 |
| C             | 2019 |
| C             | 2020 |
| C             | 2021 |
+---------------+------+

with t as (select distinct customer_name from orders) select t.customer_name, y.yr, o.amount  from t cross join years y left join orders_1 o on t.customer_name = o.customer_name and o.yr = y.yr;
+---------------+------+--------+
| customer_name | yr   | amount |
+---------------+------+--------+
| A             | 2021 |    150 |
| A             | 2020 |    150 |
| A             | 2020 |    100 |
| A             | 2019 |   NULL |
| B             | 2021 |    200 |
| B             | 2020 |    150 |
| B             | 2019 |    100 |
| C             | 2021 |    300 |
| C             | 2020 |   NULL |
| C             | 2019 |    250 |
+---------------+------+--------+

create or replace view orders_1 as select customer_id, customer_name, year(date) as yr, amount from orders order by customer_id, year(date);

select * from orders_1;
+-------------+---------------+------+--------+
| customer_id | customer_name | yr   | amount |
+-------------+---------------+------+--------+
|           1 | A             | 2020 |    100 |
|           1 | A             | 2020 |    150 |
|           1 | A             | 2021 |    150 |
|           2 | B             | 2019 |    100 |
|           2 | B             | 2020 |    150 |
|           2 | B             | 2021 |    200 |
|           3 | C             | 2018 |    100 |
|           3 | C             | 2019 |    250 |
|           3 | C             | 2021 |    300 |
+-------------+---------------+------+--------+

select customer_id, customer_name, yr, count(yr), sum(amount) from orders_2 group by customer_id, customer_name, yr;      
+-------------+---------------+------+-----------+-------------+
| customer_id | customer_name | yr   | count(yr) | sum(amount) |
+-------------+---------------+------+-----------+-------------+
|           1 | A             | 2020 |         2 |         250 |
|           1 | A             | 2021 |         1 |         150 |
|           2 | B             | 2019 |         1 |         100 |
|           2 | B             | 2020 |         1 |         150 |
|           2 | B             | 2021 |         1 |         200 |
|           3 | C             | 2019 |         1 |         250 |
|           3 | C             | 2021 |         1 |         300 |
+-------------+---------------+------+-----------+-------------+

select customer_id, count(customer_id) as c, case when count(customer_id) = 3 then 0 else 3-count(customer_id) end as b from (select customer_id, customer_name, yr, count(yr), sum(amount) as a from orders_2 group by customer_id, customer_name, yr) as 
v group by customer_id;
+-------------+---+---+
| customer_id | c | b |
+-------------+---+---+
|           1 | 2 | 1 |
|           2 | 3 | 0 |
|           3 | 2 | 1 |
+-------------+---+---+

select o2.customer_id, customer_name, amount, b from orders_2 o2 join orders_3 o3 on o2.customer_id = o3.customer_id;     
+-------------+---------------+--------+---+
| customer_id | customer_name | amount | b |
+-------------+---------------+--------+---+
|           1 | A             |    100 | 1 |
|           1 | A             |    150 | 1 |
|           1 | A             |    150 | 1 |
|           2 | B             |    100 | 0 |
|           2 | B             |    150 | 0 |
|           2 | B             |    200 | 0 |
|           3 | C             |    250 | 1 |
|           3 | C             |    300 | 1 |
+-------------+---------------+--------+---+

select o2.customer_id, customer_name, sum(amount)/(count(customer_name)+b) from orders_2 o2 join orders_3 o3 on o2.custome
r_id = o3.customer_id group by o2.customer_id, customer_name ;
+-------------+---------------+--------------------------------------+
| customer_id | customer_name | sum(amount)/(count(customer_name)+b) |
+-------------+---------------+--------------------------------------+
|           1 | A             |                             100.0000 |
|           2 | B             |                             150.0000 |
|           3 | C             |                             183.3333 |
+-------------+---------------+--------------------------------------+

