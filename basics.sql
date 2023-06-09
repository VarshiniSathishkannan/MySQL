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

