create table products
(
    name varchar(255),
    price int
);

insert into products(name,price) values ('table',50),('chair',40),('table',50),('table',40),('stool',20),('chair',30);

1. Find products with the same name but different prices:

select distinct * from products where name in (select name from products group by name having count(distinct price)>1);
