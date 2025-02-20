select * from Artist a; 

select Name, case when ArtistId%2 is 0 then lag(Name) over (order by ArtistId) else 
COALESCE(lead(Name) over (order by ArtistId),Name) 
end as New_Name from Artist a 

lead(student_name,1,student_name) 3rd option is default value if no lead value is present

select * from athlete_events ae ;

1. How many olympics games have been held?

select count(*) from (select games from athlete_events ae group by games order by games)

2. List down all Olympics games held so far.

select games, year, city from athlete_events ae group by games, year,city order by games

3. Mention the total no of nations who participated in each olympics game?

    with all_countries as
        (select games, nr.region
        from athlete_events oh
        join noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region)
    select games, count(1) as total_countries
    from all_countries
    group by games
    order by games;

4. Which year saw the highest and lowest no of countries participating in olympics

select distinct concat(first_value(games) over(order by total_countries),'-',first_value(total_countries) over (order by total_countries))
,concat(first_value(games) over(order by total_countries desc),'-',first_value(total_countries) over (order by total_countries desc)) 
from (select games, count(*) as total_countries from (select games, nr.region
        from athlete_events oh
        join noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region) group by games)
        
 5. Which nation has participated in all of the olympic games

select country, count(1) from (select nr.region as country, games
        from athlete_events oh
        join noc_regions nr ON nr.noc = oh.noc
        group by nr.region, games) group by country 
        having count(1) = (select count(*) from (select games from athlete_events ae group by games order by games))
    
-- another way
        
      with tot_games as
              (select count(distinct games) as total_games
              from olympics_history),
          countries as
              (select games, nr.region as country
              from olympics_history oh
              join olympics_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
          countries_participated as
              (select country, count(1) as total_participated_games
              from countries
              group by country)
      select cp.*
      from countries_participated cp
      join tot_games tg on tg.total_games = cp.total_participated_games
      order by 1;
     
6. Identify the sport which was played in all summer olympics.

select sport, count(*) 
from (select sport, games from athlete_events ae group by sport, games having season = 'Summer') 
group by sport
having count(*) = (select count(*) from (select games, season from athlete_events ae group by games having season = 'Summer'))

7. Which Sports were just played only once in the olympics.

select sport, games, count(*) 
from (select sport, games from athlete_events ae group by sport, games having season = 'Summer') 
group by sport
having count(*) = 1

8. Fetch the total no of sports played in each olympic games.


