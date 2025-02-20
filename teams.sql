CREATE TABLE Teams(
	Name VARCHAR(255)
);

INSERT into Teams(Name) values ('A'),('B'),('C'),('D'),('E'),('F'),('F'),('G'),('H'),('I');

-- Teams should not play with each other twice

select * from Teams a join Teams b on a.Name != b.Name;


with matches as
(
  select ROW_NUMBER() over (order by Name) as Id, Name from Teams t 
)
select * from matches a join matches b on a.Id < b.Id;






