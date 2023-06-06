with recursive sequence as (select 1 as i union all select i+1 from sequence where i+1 < 10) select * from sequence;      
+------+
| i    |
+------+
|    1 |
|    2 |
|    3 |
|    4 |
|    5 |
|    6 |
|    7 |
|    8 |
|    9 |
+------+

