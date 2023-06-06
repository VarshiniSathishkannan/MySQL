 select * from hires;
+----+-----------+----------+--------+--------+------------+
| id | firstname | lastname | gender | salary | hiredate   |
+----+-----------+----------+--------+--------+------------+
|  1 | Philip    | Hastings | Male   |  45000 | 2014-11-03 |
|  2 | Mary      | Lambeth  | Female |  30000 | 2014-10-03 |
|  3 | Valarie   | Vikings  | Female |  35000 | 2014-09-02 |
|  4 | Jd        | Nosin    | Male   |   6000 | 2013-10-01 |
|  5 | Philip    | Hastings | Male   |  45000 | 2014-11-03 |
|  6 | Mary      | Lambeth  | Female |  30000 | 2014-10-03 |
|  7 | Valarie   | Vikings  | Female |  35000 | 2014-02-09 |
|  8 | John      | Stanmore | Male   |  80000 | 2014-02-22 |
|  9 | Able      | Edward   | Male   |   5000 | 2014-01-22 |
| 10 | Emma      | Nan      | Female |   5000 | 2014-01-14 |
| 11 | Jd        | Nosin    | Male   |   6000 | 2013-01-10 |
| 12 | San       | Hughes   | Male   |   7000 | 2013-03-15 |
| 13 | Nico      | Night    | Male   |   6500 | 2013-04-19 |
| 14 | Martin    | Jany     | Male   |   5500 | 2013-05-23 |
| 15 | Mathew    | Mann     | Male   |   4500 | 2013-06-23 |
| 16 | Baker     | Barn     | Male   |   3500 | 2013-07-23 |
| 17 | Mosin     | Barn     | Male   |   8500 | 2013-08-21 |
| 18 | Rachel    | Aril     | Female |   6500 | 2013-09-14 |
+----+-----------+----------+--------+--------+------------+

Find the recent hires from last 6 month

select *, datediff(current_date(),hiredate) from hires ; /* datediff gives no of days difference */
+----+-----------+----------+--------+--------+------------+-----------------------------------+
| id | firstname | lastname | gender | salary | hiredate   | datediff(current_date(),hiredate) |
+----+-----------+----------+--------+--------+------------+-----------------------------------+
|  1 | Philip    | Hastings | Male   |  45000 | 2014-11-03 |                              3137 |
|  2 | Mary      | Lambeth  | Female |  30000 | 2014-10-03 |                              3168 |
|  3 | Valarie   | Vikings  | Female |  35000 | 2014-09-02 |                              3199 |
|  4 | Jd        | Nosin    | Male   |   6000 | 2013-10-01 |                              3535 |
|  5 | Philip    | Hastings | Male   |  45000 | 2014-11-03 |                              3137 |
|  6 | Mary      | Lambeth  | Female |  30000 | 2014-10-03 |                              3168 |
|  7 | Valarie   | Vikings  | Female |  35000 | 2014-02-09 |                              3404 |
|  8 | John      | Stanmore | Male   |  80000 | 2014-02-22 |                              3391 |
|  9 | Able      | Edward   | Male   |   5000 | 2014-01-22 |                              3422 |
| 10 | Emma      | Nan      | Female |   5000 | 2014-01-14 |                              3430 |
| 11 | Jd        | Nosin    | Male   |   6000 | 2013-01-10 |                              3799 |
| 12 | San       | Hughes   | Male   |   7000 | 2013-03-15 |                              3735 |
| 13 | Nico      | Night    | Male   |   6500 | 2013-04-19 |                              3700 |
| 14 | Martin    | Jany     | Male   |   5500 | 2013-05-23 |                              3666 |
| 15 | Mathew    | Mann     | Male   |   4500 | 2013-06-23 |                              3635 |
| 16 | Baker     | Barn     | Male   |   3500 | 2013-07-23 |                              3605 |
| 17 | Mosin     | Barn     | Male   |   8500 | 2013-08-21 |                              3576 |
| 18 | Rachel    | Aril     | Female |   6500 | 2013-09-14 |                              3552 |
+----+-----------+----------+--------+--------+------------+-----------------------------------+

