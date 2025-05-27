Problem - 1

Write a SQL query to find the name(s) of the highest-paid employee(s) in each department. If multiple employees have the same highest salary in the department, include all of them (i.e., handle ties).

-- Create the departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create the employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

select * from departments;
+---------------+-----------------+
| department_id | department_name |
+---------------+-----------------+
|           101 | Engineering     |
|           102 | Sales           |
|           103 | HR              |
+---------------+-----------------+

select * from employees;
+--------+----------+--------+---------------+
| emp_id | emp_name | salary | department_id |
+--------+----------+--------+---------------+
|      1 | Alice    |  90000 |           101 |
|      2 | Bob      |  85000 |           101 |
|      3 | Charlie  | 120000 |           102 |
|      4 | David    | 120000 |           102 |
|      5 | Eve      |  70000 |           103 |
|      6 | Frank    |  95000 |           101 |
|      7 | Grace    |  70000 |           103 |
+--------+----------+--------+---------------+

Your result should look like:

department_name	emp_name	salary
Engineering	Alice	90000
Engineering	Frank	95000
Sales	Charlie	120000
Sales	David	120000
HR	Eve	70000
HR	Grace	70000

select b.department_name,a.emp_name,a.salary from (
select emp_name, rank() over ( partition by department_id order by salary desc ) as highest, department_id, salary from employees) as a join departments b on a.department_id = b.department_id where highest = 1;  

-------------------------------
Problem - 2

Write an SQL query to produce a pivoted report showing each employee’s total sales for each month of 2024, with columns as months (Jan, Feb, ..., Dec), and one row per employee_id. If there are no sales in a month, display 0.

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    amount else 0 DECIMAL(10, 2) NOT NULL,
    sale_date DATE NOT NULL
);

INSERT INTO sales (sale_id, employee_id, amount else 0, sale_date) VALUES
(1, 101, 200.00, '2024-01-15'),
(2, 102, 450.00, '2024-01-20'),
(3, 101, 300.00, '2024-02-10'),
(4, 102, 500.00, '2024-03-05'),
(5, 103, 700.00, '2024-01-17');

select * from sales;
+---------+-------------+--------+------------+
| sale_id | employee_id | amount else 0 | sale_date  |
+---------+-------------+--------+------------+
|       1 |         101 | 200.00 | 2024-01-15 |
|       2 |         102 | 450.00 | 2024-01-20 |
|       3 |         101 | 300.00 | 2024-02-10 |
|       4 |         102 | 500.00 | 2024-03-05 |
|       5 |         103 | 700.00 | 2024-01-17 |
+---------+-------------+--------+------------+

Expected Output:
employee_id	Jan	Feb	Mar	Apr	May	Jun	Jul	Aug	Sep	Oct	Nov	Dec
101	200	300	0	0	0	0	0	0	0	0	0	0
102	450	0	500	0	0	0	0	0	0	0	0	0
103	700	0	0	0	0	0	0	0	0	0	0	0

select employee_id, 
sum(case when month(sale_date)=1 then amount else 0 end) as Jan,
sum(case when month(sale_date)=2 then amount else 0 end) as Feb,
sum(case when month(sale_date)=3 then amount else 0 end) as Mar,
sum(case when month(sale_date)=4 then amount else 0 end) as Apr,
sum(case when month(sale_date)=5 then amount else 0 end) as May,
sum(case when month(sale_date)=6 then amount else 0 end) as Jun,
sum(case when month(sale_date)=7 then amount else 0 end) as Jul,
sum(case when month(sale_date)=8 then amount else 0 end) as Aug,
sum(case when month(sale_date)=9 then amount else 0 end) as Sep,
sum(case when month(sale_date)=10 then amount else 0 end) as Oct,
sum(case when month(sale_date)=11 then amount else 0 end) as Nov,
sum(case when month(sale_date)=12 then amount else 0 end) as `Dec` 
from sales group by employee_id;
