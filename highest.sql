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