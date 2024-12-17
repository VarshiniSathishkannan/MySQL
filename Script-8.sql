--drop table event_category;
--create table event_category
--(
--  event_name varchar(50),
--  category varchar(100)
--);
--
--drop table physician_speciality;
--create table physician_speciality
--(
--  physician_id int,
--  speciality varchar(50)
--);
--
--drop table patient_treatment;
--create table patient_treatment
--(
--  patient_id int,
--  event_name varchar(50),
--  physician_id int
--);
--
--
--insert into event_category values ('Chemotherapy','Procedure';
--insert into event_category values ('Radiation','Procedure';
--insert into event_category values ('Immunosuppressants','Prescription';
--insert into event_category values ('BTKI','Prescription';
--insert into event_category values ('Biopsy','Test';
--
--
--insert into physician_speciality values (1000,'Radiologist';
--insert into physician_speciality values (2000,'Oncologist';
--insert into physician_speciality values (3000,'Hermatologist';
--insert into physician_speciality values (4000,'Oncologist';
--insert into physician_speciality values (5000,'Pathologist';
--insert into physician_speciality values (6000,'Oncologist';
--
--
--insert into patient_treatment values (1,'Radiation', 1000);
--insert into patient_treatment values (2,'Chemotherapy', 2000);
--insert into patient_treatment values (1,'Biopsy', 1000);
--insert into patient_treatment values (3,'Immunosuppressants', 2000);
--insert into patient_treatment values (4,'BTKI', 3000);
--insert into patient_treatment values (5,'Radiation', 4000);
--insert into patient_treatment values (4,'Chemotherapy', 2000);
--insert into patient_treatment values (1,'Biopsy', 5000);
--insert into patient_treatment values (6,'Chemotherapy', 6000);


select * from patient_treatment;
select * from event_category;
select * from physician_speciality;

--write a SQL query to get the histogram of specialties of the unique physicians 
--who have done the procedures but never did prescribe anything.

select ps.speciality, count(1) as speciality_count
from patient_treatment pt
join event_category ec on ec.event_name = pt.event_name
join physician_speciality ps on ps.physician_id = pt.physician_id
where ec.category = 'Procedure'
and pt.physician_id not in (select pt2.physician_id
							from patient_treatment pt2
							join event_category ec on ec.event_name = pt2.event_name
							where ec.category in ('Prescription')
group by ps.speciality;

drop table patient_logs ;
create table patient_logs
(
  account_id int,
  date date,
  patient_id int
);

insert into patient_logs values (1, '02-01-2020', 100);
insert into patient_logs values (1, '27-01-2020', 200);
insert into patient_logs values (2, '01-01-2020', 300);
insert into patient_logs values (2, '21-01-2020', 400);
insert into patient_logs values (2, '21-01-2020', 300);
insert into patient_logs values (2, '01-01-2020', 500);
insert into patient_logs values (3, '20-01-2020', 400);
insert into patient_logs values (1, '04-03-2020', 500);
insert into patient_logs values (3, '20-01-2020', 450);

select substr(date,4,2) from patient_logs pl 

--top 2 accounts with the maximum number of unique patients on a monthly basis.

select * from
(
select month,account_id, patient_id, rank, rank() over (partition by month order by rank desc, account_id desc) as r from 
(
select substr(date,4,2) as month,account_id ,patient_id, 
rank() over (partition by substr(date,4,2),account_id order by patient_id) as rank
from patient_logs pl 
group by month,account_id,patient_id 
)
) where r in (1,2)

--Another Approach - Only 1 rank fucntion

select a.month, a.account_id, a.no_of_unique_patients
from (
		select x.month, x.account_id, no_of_unique_patients,
			row_number() over (partition by x.month order by x.no_of_unique_patients DESC, x.account_id ) as rn
		from (
				select pl.month, pl.account_id, count(1) as no_of_unique_patients
				from (select distinct substr(date,4,2) as month, account_id, patient_id
						from patient_logs) pl
				group by pl.month, pl.account_id) x
     ) a
where a.rn in (1,2);

