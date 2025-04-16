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

What happens when you subtract two DATETIME columns in MySQL?


SELECT datetime_column1 - datetime_column2 AS result
FROM your_table;

-- 👇 Here's the twist:
-- MySQL treats this as a numeric subtraction (not a true time interval).

-- It converts each DATETIME to a numeric value in the format:
-- YYYYMMDDHHMMSS

-- Then it just subtracts those numbers.

🔍 Example:


SELECT '2023-09-25 14:30:00' - '2023-09-25 12:00:00' AS result;

-- 🧮 Internally becomes:

-- 
-- 20230925143000 - 20230925120000 = 230000
-- ✅ Output: 230000
-- 🧠 Which looks like 2 hours, 30 minutes, but it's really just math — not an actual time interval.

✅ Correct Way to Get Time Difference

1. Use TIMEDIFF() for TIME or DATETIME difference:

SELECT TIMEDIFF('2023-09-25 14:30:00', '2023-09-25 12:00:00') AS diff;
➡️ Output: '02:30:00' (as a TIME value)

2. Use TIMESTAMPDIFF() to get difference in units (like minutes, hours, days):

SELECT TIMESTAMPDIFF(MINUTE, start_time, end_time) AS minutes_diff
FROM your_table;

✅ Returns: number of minutes (integer)

Can You Pass Only Dates to TIMEDIFF() and TIMESTAMPDIFF()?

Function	    Accepts Only DATE?    Notes
TIMEDIFF()	    ❌ No	            Expects DATETIME or TIME, not just DATE
TIMESTAMPDIFF()	✅ Yes	            Works perfectly with DATE, DATETIME, or TIMESTAMP