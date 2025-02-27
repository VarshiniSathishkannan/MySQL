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

%D	Day of the month as a numeric value, followed by suffix (1st, 2nd, 3rd, ...)
%d	Day of the month as a numeric value (01 to 31)
%H	Hour (00 to 23)
%h	Hour (00 to 12)
%i	Minutes (00 to 59)
%M	Month name in full (January to December)
%m	Month name as a numeric value (00 to 12)
%p	AM or PM
%r	Time in 12 hour AM or PM format (hh:mm:ss AM/PM)
%S	Seconds (00 to 59)
%s	Seconds (00 to 59)
%T	Time in 24 hour format (hh:mm:ss)
%w	Day of the week where Sunday=0 and Saturday=6
%Y	Year as a numeric, 4-digit value
%y	Year as a numeric, 2-digit value