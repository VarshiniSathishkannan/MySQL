-- Query 9:

Find the top 2 accounts with the maximum number of unique patients on a monthly basis.

Note: Prefer the account if with the least value in case of same number of unique patients

--Table Structure:

drop table patient_logs;
create table patient_logs
(
  account_id int,
  date date,
  patient_id int
);

insert into patient_logs values (1, DATE('2020-01-02'), 100);
insert into patient_logs values (1, DATE('2020-01-27'), 200);
insert into patient_logs values (2, DATE('2020-01-01'), 300);
insert into patient_logs values (2, DATE('2020-01-21'), 400);
insert into patient_logs values (2, DATE('2020-01-21'), 300);
insert into patient_logs values (2, DATE('2020-01-01'), 500);
insert into patient_logs values (3, DATE('2020-01-20'), 400);
insert into patient_logs values (1, DATE('2020-03-04'), 500);
insert into patient_logs values (3, DATE('2020-01-20'), 450);

select * from patient_logs;


-- Solution:
select a.month, a.account_id, a.no_of_unique_patients from ( select x.month, x.account_id,no_of_unique_patients,row_number() over (partition by x.month order by x.no_of_unique_patients desc) as rn from ( select pl.month, pl.account_id, count(1) as no_of_unique_patients from (select distinct month(date) as month, account_id, patient_id from patient_logs) pl group by pl.month, pl.account_id) x ) a where a.rn < 3;

step by step:

1. remove duplicate records

select distinct month(date) as month, account_id, patient_id from patient_logs;
+-------+------------+------------+
| month | account_id | patient_id |
+-------+------------+------------+
|     1 |          1 |        100 |
|     1 |          1 |        200 |
|     1 |          2 |        300 |
|     1 |          2 |        400 |
|     1 |          2 |        500 |
|     1 |          3 |        400 |
|     3 |          1 |        500 |
|     1 |          3 |        450 |
+-------+------------+------------+

2. 
select pl.month, pl.account_id, count(1) as no_of_unique_patients from (select distinct month(date) as month, account_id, patient_id from patient_logs) pl group by pl.month, pl.account_id;
+-------+------------+-----------------------+
| month | account_id | no_of_unique_patients |
+-------+------------+-----------------------+
|     1 |          1 |                     2 |
|     1 |          2 |                     3 |
|     1 |          3 |                     2 |
|     3 |          1 |                     1 |
+-------+------------+-----------------------+

3.
select x.month, x.account_id,no_of_unique_patients,row_number() over (partition by x.month order by x.no_of_unique_patients desc) as rn from ( select pl.month, pl.account_id, count(1) as no_of_unique_patients from (select distinct month(date) as month, account_id, patient_id from patient_logs) pl group by pl.month, pl.account_id) x;
+-------+------------+-----------------------+----+
| month | account_id | no_of_unique_patients | rn |
+-------+------------+-----------------------+----+
|     1 |          2 |                     3 |  1 |
|     1 |          1 |                     2 |  2 |
|     1 |          3 |                     2 |  3 |
|     3 |          1 |                     1 |  1 |
+-------+------------+-----------------------+----+

4. 
select a.month, a.account_id, a.no_of_unique_patients from ( select x.month, x.account_id,no_of_unique_patients,row_number() over (partition by x.month order by x.no_of_unique_patients desc) as rn from ( select pl.month, pl.account_id, count(1) as no_of_unique_patients from (select distinct month(date) as month, account_id, patient_id from patient_logs) pl group by pl.month, pl.account_id) x ) a where a.rn < 3;

+-------+------------+-----------------------+
| month | account_id | no_of_unique_patients |
+-------+------------+-----------------------+
|     1 |          2 |                     3 |
|     1 |          1 |                     2 |
|     3 |          1 |                     1 |
+-------+------------+-----------------------+

My solution:

select month, account_id, r as patients from (select *,row_number() over (partition by month order by r desc) as top from (select account_id, month(date) as month, patient_id, row_number() over (partition by account_id, month(date)) as r from patient_logs group by account_id, month, patient_id order by month, account_id) as temp) as temp2 where top < 3;

+-------+------------+----------+
| month | account_id | patients |
+-------+------------+----------+
|     1 |          2 |        3 |
|     1 |          1 |        2 |
|     3 |          1 |        1 |
+-------+------------+----------+