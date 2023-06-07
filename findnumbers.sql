select * from test1;
+-------+
| value |
+-------+
| 123   |
| ABC   |
| DEF   |
| 901   |
| JKL   |
+-------+

select value from test1 where value regexp '[0-9]';
+-------+
| value |
+-------+
| 123   |
| 901   |
+-------+

select value*1 from test1;
+---------+
| value*1 |
+---------+
|     123 |
|       0 |
|       0 |
|     901 |
|       0 |
+---------+

select value*1 from test1 where value*1 != 0;
+---------+
| value*1 |
+---------+
|     123 |
|     901 |
+---------+

