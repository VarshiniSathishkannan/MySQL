select * from visits;
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
|        1 |          23 |
|        2 |           9 |
|        3 |          30 |
|        4 |          54 |
|        5 |          96 |
|        6 |          54 |
|        7 |          54 |
|       10 |          54 |
+----------+-------------+

select * from transactions;
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
|              1 |        5 |    310 |
|              2 |        5 |    300 |
|              3 |        5 |    200 |
|              4 |        1 |    910 |
|              5 |        2 |    970 |
|              6 |       10 |    200 |
+----------------+----------+--------+

the output should be only 30 customer_id

select distinct customer_id from visits v left join transactions t on v.visit_id = t.visit_id where transaction_id is null and customer_id not in (select distinct customer_id from visits v left join transactions t on v.visit_id = t.visit_id where 
transaction_id is not null);
+-------------+
| customer_id |
+-------------+
|          30 |
+-------------+



