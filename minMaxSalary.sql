-- Query 3:

Write a SQL query to display only the details of employees who either earn the highest salary
or the lowest salary in each department from the employee table.

--Tables Structure:

drop table employee;
create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

select * from employee;

-- Solution:
select x.*
from employee e
join (select *,
max(salary) over (partition by dept_name) as max_salary,
min(salary) over (partition by dept_name) as min_salary
from employee) x
on e.emp_id = x.emp_id
and (e.salary = x.max_salary or e.salary = x.min_salary)
order by x.dept_name, x.salary;

+--------+----------+-----------+--------+------------+------------+
| emp_ID | emp_NAME | DEPT_NAME | SALARY | max_salary | min_salary |
+--------+----------+-----------+--------+------------+------------+
|    113 | Gautham  | Admin     |   2000 |       5000 |       2000 |
|    120 | Monica   | Admin     |   5000 |       5000 |       2000 |
|    106 | Rajesh   | Finance   |   5000 |       6500 |       5000 |
|    104 | Dorvin   | Finance   |   6500 |       6500 |       5000 |
|    116 | Satya    | Finance   |   6500 |       6500 |       5000 |
|    102 | Rajkumar | HR        |   3000 |       8000 |       3000 |
|    105 | Rohit    | HR        |   3000 |       8000 |       3000 |
|    114 | Manisha  | HR        |   3000 |       8000 |       3000 |
|    119 | Cory     | HR        |   8000 |       8000 |       3000 |
|    103 | Akbar    | IT        |   4000 |      11000 |       4000 |
|    124 | Dheeraj  | IT        |  11000 |      11000 |       4000 |
+--------+----------+-----------+--------+------------+------------+

select e.*,temp.h,temp.l from employee e join (select DEPT_NAME, max(SALARY) as h, MIN(SALARY) 
as l from employee group by DEPT_NAME) temp on e.DEPT_NAME = temp.DEPT_NAME where e.salary = l or e.sa
lary = h order by e.DEPT_NAME, e.SALARY;
+--------+----------+-----------+--------+-------+------+
| emp_ID | emp_NAME | DEPT_NAME | SALARY | h     | l    |
+--------+----------+-----------+--------+-------+------+
|    113 | Gautham  | Admin     |   2000 |  5000 | 2000 |
|    120 | Monica   | Admin     |   5000 |  5000 | 2000 |
|    106 | Rajesh   | Finance   |   5000 |  6500 | 5000 |
|    104 | Dorvin   | Finance   |   6500 |  6500 | 5000 |
|    116 | Satya    | Finance   |   6500 |  6500 | 5000 |
|    102 | Rajkumar | HR        |   3000 |  8000 | 3000 |
|    114 | Manisha  | HR        |   3000 |  8000 | 3000 |
|    105 | Rohit    | HR        |   3000 |  8000 | 3000 |
|    119 | Cory     | HR        |   8000 |  8000 | 3000 |
|    103 | Akbar    | IT        |   4000 | 11000 | 4000 |
|    124 | Dheeraj  | IT        |  11000 | 11000 | 4000 |
+--------+----------+-----------+--------+-------+------+

Min or Max salary from each department

select e.*,min,max from employee_2 e join 
(select DEPT_NAME,MIN(SALARY) as min,MAX(SALARY) as max from employee_2 e group by DEPT_NAME)as t 
on e.DEPT_NAME = t.DEPT_NAME where SALARY = min or SALARY = max;

select DEPT_NAME,MIN(SALARY) as min,MAX(SALARY) as max from employee_2 e group by DEPT_NAME ;