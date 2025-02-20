select count(*) from fruits;

select EXISTS(select 1 from fruits); -- Efficient returns 1 if exists

select * from fruits limit 1; -- Fastest returns no rows if empty