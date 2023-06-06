create table employees(
    empid int,
    empname varchar(255),
    managerid int
);

show tables;
+--------------------+
| Tables_in_employee |
+--------------------+
| employees          |
+--------------------+

alter table employees add constraint empid primary key(empid);

describe employees;
+-----------+--------------+------+-----+---------+-------+
| Field     | Type         | Null | Key | Default | Extra |
+-----------+--------------+------+-----+---------+-------+
| empid     | int          | NO   | PRI | NULL    |       |
| empname   | varchar(255) | YES  |     | NULL    |       |
| managerid | int          | YES  |     | NULL    |       |
+-----------+--------------+------+-----+---------+-------+

show create table employees;
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table     | Create Table                                                                                                       
                                                                                                  |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| employees | CREATE TABLE `employees` (
  `empid` int NOT NULL,
  `empname` varchar(255) DEFAULT NULL,
  `managerid` int DEFAULT NULL,
  PRIMARY KEY (`empid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

alter table employees modify column empid int auto_increment;

describe table employees;
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------+
| id | select_type | table     | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------+
|  1 | SIMPLE      | employees | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    1 |   100.00 | NULL  |
+----+-------------+-----------+------------+------+---------------+------+---------+------+------+----------+-------+

describe employees;
+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| empid     | int          | NO   | PRI | NULL    | auto_increment |
| empname   | varchar(255) | YES  |     | NULL    |                |
| managerid | int          | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+

create table managers(
    -> managerid int auto_increment primary key not null,
    -> managername varchar(255)
    -> );

insert into managers(managername) values ('Ben'),('Mark'),('Lara'),('Steve'),('Tom');

select * from managers;
+-----------+-------------+
| managerid | managername |
+-----------+-------------+
|         1 | Ben         |
|         2 | Mark        |
|         3 | Lara        |
|         4 | Steve       |
|         5 | Tom         |
+-----------+-------------+

select * from employees;
+-------+---------+-----------+
| empid | empname | managerid |
+-------+---------+-----------+
|     1 | Ben     |      NULL |
|     2 | Mark    |         1 |
|     3 | Steve   |         1 |
|     4 | Lara    |         1 |
|     5 | Stacy   |         2 |
|     6 | Simon   |         2 |
|     7 | John    |         3 |
|     8 | Sam     |         3 |
|     9 | Tom     |         4 |
|    10 | David   |         5 |
+-------+---------+-----------+

alter table employees add constraint managerid foreign key(managerid) references managers(managerid);

show create table employees;
+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+     
| Table     | Create Table                                                                                                                                                                                                                                                                                                                                                                   |     
+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+     
| employees | CREATE TABLE `employees` (
  `empid` int NOT NULL AUTO_INCREMENT,
  `empname` varchar(255) DEFAULT NULL,
  `managerid` int DEFAULT NULL,
  PRIMARY KEY (`empid`),
  KEY `managerid` (`managerid`),
  CONSTRAINT `managerid` FOREIGN KEY (`managerid`) REFERENCES `managers` (`managerid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+     
1 row in set (0.00 sec)

DECLARE is permitted only inside a BEGIN ... END compound statement and must be at its start, before any other statements.

with recursive recursiveCTE as ( select empid, empname, managerid from employees where empid = 10 union all select e.empid, e.empname, e.managerid from employees e join recursiveCTE on e.empid = recursiveCTE.managerid) select * from recursiveCTE;    
+-------+---------+-----------+
| empid | empname | managerid |
+-------+---------+-----------+
|    10 | David   |         5 |
|     5 | Stacy   |         2 |
|     2 | Mark    |         1 |
|     1 | Ben     |      NULL |
+-------+---------+-----------+

