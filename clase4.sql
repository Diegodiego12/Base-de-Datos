USE sakila;

-- 1. Show title and special_features of films that are PG-13
SELECT title, special_features
	FROM film f
	WHERE rating="PG-13";

-- 2. Get a list of all the different films duration.
SELECT DISTINCT `length`
	FROM film f;

-- 3. Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
SELECT title, rental_rate, replacement_cost
	FROM film WHERE replacement_cost BETWEEN 20.00 AND 24.00


-- 5. Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
SELECT first_name, last_name FROM actor a, film_actor fa , film f
	WHERE a.actor_id = fa.actor_id
	AND fa.film_id = f.film_id
	AND f.title = "ZOOLANDER FICTION";

-- 6. Show the address, city and country of the store with id 1
SELECT a.address, c2.country, c.city FROM store s, address a, city c, country c2
	WHERE s.address_id = a.address_id
	AND a.address_id = 1
	AND c.city_id = a.city_id
	AND c2.country_id = c.country_id;

-- 8. Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
SELECT f.title, s.first_name FROM inventory i ,film f ,staff s, store s2
	WHERE s2.manager_staff_id = s.staff_id
	AND s2.store_id = 2
	AND i.store_id = i.film_id
	AND i.film_id = f.film_id