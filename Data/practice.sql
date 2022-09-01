-- determine the count of actor first name ordered in descending order
select first_name, count first_name
from actor
group by first_name
order by first_name desc;
-- select the average duration of movies by rating
select rating, avg (length)
from film
group by rating
order by rating;

--select top ten replace costs for the length of the movie
select sum(replacement_cost), length
from film
group by length
order by sum(replacement_cost) desc
limit 10;
-- select the count of countries
select ct.country, count (c.city)
from city as c
left join country as ct
on c.country_id=ct.country_id
group by ct.country
order by count desc;