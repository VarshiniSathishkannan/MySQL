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
