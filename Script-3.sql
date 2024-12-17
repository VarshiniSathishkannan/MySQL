
select * from Album a ;

select case when Column1 is null then Title else Column1 end as T from Album a;

select COALESCE(Column1,Title) as output from Album a;

--CREATE TABLE Target(
--	Id INTEGER NOT NULL,
--	Name VARCHAR
--)
--
--INSERT into Target('ID','Name') values
--(1,'A'),(2,'B'),(4,'X'),(5,'F');

select COALESCE(sid,tid),result from 
(select sid, tid, case when tid is null then 'New in source' when sid is null then 'New in Target' 
when sname != tname then 'Not equal' end as result from 
(select s.Id as sid, s.Name as sname, t.Id as tid, t.Name as tname 
from Source s full join Target t on s.Id=t.Id) as temp) as temp2
where result is not null

--we can also use union instead of subqueries

--Get the dulplicates

select city, count(*) as co from Customer c group by city having co > 1;

select city from (
select city, ROW_NUMBER () over (partition by city) as n from Customer c
) as subq where n > 1;

--create table doctors
--(
--id int primary key,
--name varchar(50) not null,
--speciality varchar(100),
--hospital varchar(50),
--city varchar(50),
--consultation_fee int
--);
--
--insert into doctors values
--(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
--(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
--(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
--(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
--(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
--(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

select * from doctors d ;

--Expected Output: Same hospital different speciality


select d1.name, d1.speciality,d1.hospital
from doctors d1
join doctors d2
on d1.hospital = d2.hospital and d1.speciality <> d2.speciality
and d1.id <> d2.id;

--Expected Output: Same hospital irrespective of speciality

select d1.name, d1.speciality,d1.hospital
from doctors d1
join doctors d2
on d1.hospital = d2.hospital and d1.id <> d2.id;

