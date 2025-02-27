String functions

select LEFT('Hello',2);
+-----------------+
| LEFT('Hello',2) |
+-----------------+
| He              |
+-----------------+

select RIGHT('Hello',2);
+------------------+
| RIGHT('Hello',2) |
+------------------+
| lo               |
+------------------+

select CONCAT('HELLO',' ','ALL');
+---------------------------+
| CONCAT('HELLO',' ','ALL') |
+---------------------------+
| HELLO ALL                 |
+---------------------------+

select ABS('-70');
+------------+
| ABS('-70') |
+------------+
|         70 |
+------------+

select SUBSTRING('HELLO ALL',1,5);
+----------------------------+
| SUBSTRING('HELLO ALL',1,5) |
+----------------------------+
| HELLO                      |
+----------------------------+

SELECT LENGTH('HELLO ALL');
+---------------------+
| LENGTH('HELLO ALL') |
+---------------------+
|                   9 |
+---------------------+

SELECT TRIM('   HELLO ALL   '); -- Removes trailing and leading white spaces
+-------------------------+
| TRIM('   HELLO ALL   ') |
+-------------------------+
| HELLO ALL               |
+-------------------------+

SELECT REPLACE('HI','I','ELLO');
+--------------------------+
| REPLACE('HI','I','ELLO') |
+--------------------------+
| HELLO                    |
+--------------------------+

SELECT CONCAT_WS("-", "SQL", "Tutorial", "is", "fun!") AS ConcatenatedString;
+----------------------+
| ConcatenatedString   |
+----------------------+
| SQL-Tutorial-is-fun! |
+----------------------+

SELECT LCASE("SQL Tutorial is FUN!");
+-------------------------------+
| LCASE("SQL Tutorial is FUN!") |
+-------------------------------+
| sql tutorial is fun!          |
+-------------------------------+

SELECT LOWER("HELLO");
+----------------+
| LOWER("HELLO") |
+----------------+
| hello          |
+----------------+