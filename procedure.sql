 select * from student;
+----+---------+
| id | name    |
+----+---------+
|  1 | anusha  |
|  2 | deepika |
|  3 | manoj   |
|  4 | mayils  |
|  5 | Magesh  |
+----+---------+

 delimiter @

 create procedure insert_student(in name varchar(255))
    -> begin 
    -> insert into student(name) values (name);
    -> end 
    -> @

delimiter ;

call insert_student('Paul');

select * from student;
+----+---------+
| id | name    |
+----+---------+
|  1 | anusha  |
|  2 | deepika |
|  3 | manoj   |
|  4 | mayils  |
|  5 | Magesh  |
|  6 | Paul    |
+----+---------+

select * from student;
+----+---------+
| id | name    |
+----+---------+
|  1 | anusha  |
|  2 | deepika |
|  3 | manoj   |
|  4 | mayils  |
+----+---------+

select * from course;
+----+-----------+
| id | name      |
+----+-----------+
|  1 | English   |
|  2 | Tamil     |
|  3 | Hindi     |
|  4 | Malayalam |
+----+-----------+

select * from student_course;
+------+------+
| s_id | c_id |
+------+------+
|    1 |    1 |
|    1 |    2 |
|    2 |    2 |
|    3 |    3 |
+------+------+

/*We have to get the student name and course name and enroll him to the course which is tracked in student_course table */

set @student_name = 'anusha';
set @course_name = 'Malayalam';

delimiter @@

create procedure sets(in s_name varchar(255), in c_name varchar(255)) 
begin 
set @s_id = (select id from student where name = s_name);
set @c_id = (select id from course where name = c_name);
if @s_id is NULL then 
insert into student(name) values (s_name); 
end if;  
if @c_id is NULL then 
insert into course values (c_name); 
end if; 
set @s_id = (select id from student where name = s_name);
set @c_id = (select id from course where name = c_name);
set @result = (select count(*) from student_course where s_id = @s_id and c_id = @c_id);
if @result = 0 then
insert into student_course values (@s_id,@c_id);
end if;
end@@

call sets('Varshini','English')@@