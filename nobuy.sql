create table visits
(
    visit_id int primary key auto_increment,
    customer_id int

);

insert into visits(customer_id) values (23),(9),(30),(54),(96),(54),(54),(54);
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

create table transactions(
    transaction_id int primary key auto_increment,
    visit_id int,
    amount int
);

insert into transactions(visit_id,amount) values (5,310),(5,300),(5,200),(1,910),(2,970),(10,200);

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

the output should be the customer_id, who did not buy anything in any of their visits

select distinct customer_id from visits v left join transactions t on v.visit_id = t.visit_id where transaction_id is null and customer_id not in (select distinct customer_id from visits v left join transactions t on v.visit_id = t.visit_id where 
transaction_id is not null);
+-------------+
| customer_id |
+-------------+
|          30 |
+-------------+



