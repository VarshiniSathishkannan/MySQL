--create table login_details(
--login_id int primary key,
--user_name varchar(50) not null,
--login_date date);
--

--delete from login_details 
--insert into login_details values
--(101, 'Michael', date('now')),
--(102, 'James', date('now')),
--(103, 'Stewart', date('now','+1 day')),
--(104, 'Stewart', date('now','+1 day')),
--(105, 'Stewart', date('now','+1 day')),
--(106, 'Michael', date('now','+2 day')),
--(107, 'Michael', date('now','+2 day')),
--(108, 'Stewart', date('now','+3 day')),
--(109, 'Stewart', date('now','+3 day')),
--(110, 'James', date('now','+4 day')),
--(111, 'James', date('now','+4 day')),
--(112, 'James', date('now','+5 day')),
--(113, 'James', date('now','+6 day'));

select * from login_details ld ;

select distinct repeated_names
from (
select *,
case when user_name = lead(user_name) over(order by login_id)
and  user_name = lead(user_name,2) over(order by login_id)
then user_name else null end as repeated_names
from login_details) x
where x.repeated_names is not null;


