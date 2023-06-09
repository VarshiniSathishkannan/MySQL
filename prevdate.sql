-- Write an SQL query to find all dates' Id with higher temperatures compared to its previous dates (yesterday).

Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+

select b.id from Weather a join Weather b on a.recordDate = date_sub(b.recordDate, interval 1 day) where b.temperature > a.temperature;