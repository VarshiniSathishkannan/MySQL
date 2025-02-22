1. How to list all employees hired in the last 6 months?

SELECT *
FROM employees
WHERE hire_date > ADDDATE(CURDATE(), INTERVAL -6 MONTH);

select CURDATE(),ADDDATE(CURDATE(),INTERVAL -6 MONTH);
+------------+--------------------------------------+
| CURDATE()  | ADDDATE(CURDATE(),INTERVAL -6 MONTH) |
+------------+--------------------------------------+
| 2025-02-17 | 2024-08-17                           |
+------------+--------------------------------------+

select CURRENT_TIMESTAMP();
+---------------------+
| CURRENT_TIMESTAMP() |
+---------------------+
| 2025-02-17 02:00:51 |
+---------------------+

select CURRENT_DATE();
+----------------+
| CURRENT_DATE() |
+----------------+
| 2025-02-18     |
+----------------+


select CURDATE();
+------------+
| CURDATE()  |
+------------+
| 2025-02-17 |
+------------+

select MONTH(CURDATE());
+------------------+
| MONTH(CURDATE()) |
+------------------+
|                2 |
+------------------+

select MONTHNAME(CURDATE());
+----------------------+
| MONTHNAME(CURDATE()) |
+----------------------+
| February             |
+----------------------+

select DATEDIFF(CURDATE(),'2024-08-17'); -- returns the days between
+----------------------------------+
| DATEDIFF(CURDATE(),'2024-08-17') |
+----------------------------------+
|                              184 |
+----------------------------------+

select DATEDIFF('2024-08-17',CURDATE());
+----------------------------------+
| DATEDIFF('2024-08-17',CURDATE()) |
+----------------------------------+
|                             -184 |
+----------------------------------+

select NOW();
+---------------------+
| NOW()               |
+---------------------+
| 2025-02-17 07:56:12 |
+---------------------+

select CURTIME();
+-----------+
| CURTIME() |
+-----------+
| 07:56:58  |
+-----------+

select DATE_FORMAT(NOW(),'%Y-%m-%d %H');
+----------------------------------+
| DATE_FORMAT(NOW(),'%Y-%m-%d %H') |
+----------------------------------+
| 2025-02-17 07                    |
+----------------------------------+

select TIMESTAMPDIFF(HOUR,'2025-02-17 02:00:51',NOW());
+-------------------------------------------------+
| TIMESTAMPDIFF(HOUR,'2025-02-17 02:00:51',NOW()) |
+-------------------------------------------------+
|                                               5 |
+-------------------------------------------------+

select DAY(CURDATE());
+----------------+
| DAY(CURDATE()) |
+----------------+
|             17 |
+----------------+

select DAYNAME(CURDATE());
+--------------------+
| DAYNAME(CURDATE()) |
+--------------------+
| Monday             |
+--------------------+
