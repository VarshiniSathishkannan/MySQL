select IF(100>50,'Yes','No'); -- 2 options
+-----------------------+
| IF(100>50,'Yes','No') |
+-----------------------+
| Yes                   |
+-----------------------+

select name, CASE -- Multiple options
WHEN age < 18 
THEN 'Minor'
WHEN age > 18
THEN 'Major'
ELSE 'Old'
END AS category
FROM users

select COALESCE(null,null,'not a null'); -- returns first not null value, can pass multiple values
+----------------------------------+
| COALESCE(null,null,'not a null') |
+----------------------------------+
| not a null                       |
+----------------------------------+

select IFNULL(null,'default'); -- similar to coalesce but we can pass only 2 values
+------------------------+
| IFNULL(null,'default') |
+------------------------+
| default                |
+------------------------+