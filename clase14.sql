-- 1.Write a query that gets all the customers that live in Argentina.
select concat_ws(" ", first_name, last_name) as "Name", a.address, c.city
from customer
join address a using(address_id)
join city c using(city_id)
join country cy using(country_id)
where cy.country like "%Argentina%"

-- 2.Write a query that shows the film title, language and rating.
select title, lang.name, rating, CASE 
	when rating = 'G' then "(General Audiences) – All ages admitted."	
	when rating = 'PG' then "(Parental Guidance Suggested) – Some material may not be suitable for children."
	when rating = 'PG-13' then "(Parents Strongly Cautioned) – Some material may be inappropriate for children under 13."
	when rating = 'R' then "(Restricted) – Under 17 requires accompanying parent or adult guardian."
	when rating = 'NC-17' then "(Adults Only) – No one 17 and under admitted."
	else "No rating" end as rating_description
from film
	join `language` as lang using(language_id)

-- 3.Write a search query that shows all the films (title and release year) an actor was part of.
select CONCAT(first_name, " ", last_name) as "Name", CONCAT(title, " - ", release_year) as "Info_Peli" 
from film f
join film_actor fa using(film_id)
join actor a using(actor_id)
where CONCAT(first_name, " ", last_name) like upper("%joe%")

-- 4. Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not. 
select concat_ws(" ", c.first_name, c.last_name) as "Cliente", f.title, 
(case 
when return_date is null then "No" else "Yes" end) as "Devuelto"
from rental r
join inventory i using(inventory_id)
join film f using(film_id)
join customer c using(customer_id)
where month(rental_date) in (5,6) 

-- 5. Cast y Convert
-- Estas funciones convierten una expresión de un tipo de datos en otro.
-- CAST es puramente un estándar ANSI-SQL. Pero, CONVERT es función específica de SQL Server 
-- No habrá una diferencia importante en términos de ejecución de consultas entre las funciones SQL Cast y SQL Convert.
-- Como puede ver existe una ligera diferencia en los tiempos de ejecución, esto se debe a la conversión interna de SQL CAST y a su función nativa de CONVERTIR SQL, 
-- pero la función CONVERTIR viene con una opción “Código de estilo” para derivar varias combinaciones de fecha y hora, decimales y valores monetarios. 
-- En cualquier caso, la función CONVERT de SQL se ejecuta ligeramente mejor que la función CAST de SQL

-- 6.
-- La función ISNULL () se usa para especificar cómo queremos tratar los valores NULL.
-- Las funciones NVL (), IFNULL () y COALESCE () también se pueden utilizar para lograr el mismo resultado.
-- NVL() es de Oracle server
