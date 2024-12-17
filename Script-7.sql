select * from Artist a; 

select Name, case when ArtistId%2 is 0 then lag(Name) over (order by ArtistId) else 
COALESCE(lead(Name) over (order by ArtistId),Name) 
end as New_Name from Artist a 

-- lead(student_name,1,student_name) 3rd option is default value if no lead value is present

create table weather
(
  id int primary key,
  city varchar(100),
  temperature int,
  day date
)

--insert into weather values
--(1, 'London', -1, '2021-01-01'),
--(2, 'London', -2, '2021-01-02'),
--(3, 'London', 4, '2021-01-03'),
--(4, 'London', 1, '2021-01-04'),
--(5, 'London', -2, '2021-01-05'),
--(6, 'London', -5, '2021-01-06'),
--(7, 'London', -7, '2021-01-07'),
--(8, 'London', 5, '2021-01-08')

--fetch all the records when London had extremely cold temperature for 3 consecutive days

select * from weather w ;

select * from
(
select *, case when temperature < 0 and lead(temperature) over (order by id) < 0 and lead(temperature,2) over (order by id) < 0
then 'yes'
when temperature < 0 and lag(temperature) over (order by id) < 0 and lead(temperature) over (order by id) < 0
then 'yes'
when temperature < 0 and lag(temperature) over (order by id) < 0 and lag(temperature,2) over (order by id) < 0
then 'yes'end as flag
from weather w) as t where flag is not null;