--CREATE TABLE Teams(
--	Name VARCHAR
--);
--
--INSERT into Teams('Name') values
--('A'),('B'),('C'),('D'),('E'),('F'),('F'),('G'),('H'),('I');


select * from Teams a join Teams b on a.Name != b.Name;

--Teams should not play with each other twice

with matches as
(
  select ROW_NUMBER() over (order by Name) as Id, Name from Teams t 
)
select * from matches a join matches b on a.Id < b.Id;

--create table employee_2
--( emp_ID int primary key
--, emp_NAME varchar(50) not null
--, DEPT_NAME varchar(50)
--, SALARY int);
--
--insert into employee_2 values(101, 'Mohan', 'Admin', 4000);
--insert into employee_2 values(102, 'Rajkumar', 'HR', 3000);
--insert into employee_2 values(103, 'Akbar', 'IT', 4000);
--insert into employee_2 values(104, 'Dorvin', 'Finance', 6500);
--insert into employee_2 values(105, 'Rohit', 'HR', 3000);
--insert into employee_2 values(106, 'Rajesh',  'Finance', 5000);
--insert into employee_2 values(107, 'Preet', 'HR', 7000);
--insert into employee_2 values(108, 'Maryam', 'Admin', 4000);
--insert into employee_2 values(109, 'Sanjay', 'IT', 6500);
--insert into employee_2 values(110, 'Vasudha', 'IT', 7000);
--insert into employee_2 values(111, 'Melinda', 'IT', 8000);
--insert into employee_2 values(112, 'Komal', 'IT', 10000);
--insert into employee_2 values(113, 'Gautham', 'Admin', 2000);
--insert into employee_2 values(114, 'Manisha', 'HR', 3000);
--insert into employee_2 values(115, 'Chandni', 'IT', 4500);
--insert into employee_2 values(116, 'Satya', 'Finance', 6500);
--insert into employee_2 values(117, 'Adarsh', 'HR', 3500);
--insert into employee_2 values(118, 'Tejaswi', 'Finance', 5500);
--insert into employee_2 values(119, 'Cory', 'HR', 8000);
--insert into employee_2 values(120, 'Monica', 'Admin', 5000);
--insert into employee_2 values(121, 'Rosalin', 'IT', 6000);
--insert into employee_2 values(122, 'Ibrahim', 'IT', 8000);
--insert into employee_2 values(123, 'Vikram', 'IT', 8000);
--insert into employee_2 values(124, 'Dheeraj', 'IT', 11000);

--Min or Max salary from each department

select e.*,min,max from employee_2 e join 
(select DEPT_NAME,MIN(SALARY) as min,MAX(SALARY) as max from employee_2 e group by DEPT_NAME)as t 
on e.DEPT_NAME = t.DEPT_NAME where SALARY = min or SALARY = max;

select DEPT_NAME,MIN(SALARY) as min,MAX(SALARY) as max from employee_2 e group by DEPT_NAME ;


