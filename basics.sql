declare a int 0; /* Local scope */

set @a = 0 /* Global scope */

create view names_with_m as select * from student where name like '%m%';

select * from names_with_m;
+----+--------+
| id | name   |
+----+--------+
|  3 | manoj  |
|  4 | mayils |
|  5 | Magesh |
+----+--------+

select tweet_id from Tweets where length(content) > 15;

explain select * from agents;
explain analyze select * from agents;
create index on agents using btree(location);
create index on agents using hash(amount);

set enable_nestloop=false
set enable_hashjoin=false
set enable_mergejoin=true

create table tbl1
(
    col1 int
);

INSERT INTO tbl1 (col1) VALUES ('1');
INSERT INTO tbl1 (col1) VALUES ('1');
INSERT INTO tbl1 (col1) VALUES ('2');
INSERT INTO tbl1 (col1) VALUES ('3');
INSERT INTO tbl1 (col1) VALUES ('4');
INSERT INTO tbl1 (col1) VALUES ('4');
INSERT INTO tbl1 (col1) VALUES (null);

create table tbl2
(
    col1 int
);

INSERT INTO tbl2 (col1) VALUES ('1');
INSERT INTO tbl2 (col1) VALUES ('3');
INSERT INTO tbl2 (col1) VALUES ('3');
INSERT INTO tbl2 (col1) VALUES ('5');
INSERT INTO tbl2 (col1) VALUES ('5');
INSERT INTO tbl2 (col1) VALUES ('6');

tabA
col1
1
1
2
3
4
4
null
 
tabB
col1
1
3
3
5
5
6

mysql> select a.col1,b.col1 from tbl1 a left join tbl2 b on a.col1 = b.col1;

+------+------+
| col1 | col1 |
+------+------+
|    1 |    1 |
|    1 |    1 |
|    2 | NULL |
|    3 |    3 |
|    3 |    3 |
|    4 | NULL |
|    4 | NULL |
+------+------+

mysql> select a.col1,b.col1 from tbl1 a right join tbl2 b on a.col1 = b.col1;
+------+------+
| col1 | col1 |
+------+------+
|    1 |    1 |
|    1 |    1 |
|    3 |    3 |
|    3 |    3 |
| NULL |    5 |
| NULL |    5 |
| NULL |    6 |
+------+------+


select distinct a.col1 from tbl1 a join tbl2 b on a.col1 = b.col1;

select a.col1,b.col1 from tbl1 a left join tbl2 b on a.col1 = b.col1 where b.col1 is null
union
select a.col1,b.col1 from tbl1 a right join tbl2 b on a.col1 = b.col1 where a.col1 is null;

explain format=TREE