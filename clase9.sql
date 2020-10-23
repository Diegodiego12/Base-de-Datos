-- Get the amount of cities per country in the database. Sort them by country, country_id.
SELECT COUNT(*) as cities, c3.country
FROM city c, country c3
WHERE c.country_id = c3.country_id
GROUP BY c3.country, c.country_id;
  
-- Get amount of cities per country. Show only the countries with more than one city. Order by amount of cities
SELECT  count(*) as cities, c2.country
from city c, country c2
where c.country_id = c2.country_id 
group by c2.country_id, c.country_id 
HAVING cities >= 2
order by cities ;

-- Show customers, their addresses, the amount of films they've rented, and the total money spent

SELECT first_name, last_name, address, COUNT(*) as amount_rented, SUM(p.amount) as spent
FROM customer c, address a, rental r, payment p 
where c.address_id = a.address_id 
and c.customer_id = r.customer_id 
and p.rental_id = r.rental_id 
group by first_name, last_name, a.address 

-- Show categories ordering them descending by their average film duration
select c.name, AVG(f.`length`) as average_duration
from category c, film f, film_category fc 
where f.film_id = fc.film_id 
and c.category_id = fc.category_id 
group by c.name 
order by average_duration desc

-- Show sales per film rating

select COUNT(*) as sales, f.rating 
from film f , inventory i, rental r
where f.film_id = i.film_id 
and r.inventory_id = i.inventory_id 
group by f.rating 
