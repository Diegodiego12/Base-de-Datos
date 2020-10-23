-- 1. Add a new customer

INSERT INTO sakila.customer
(store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES(1, 'Dieguito', 'Maradona', 'diego@gmail.com', (
	select MAX(address_id) from address a 
		inner JOIN city c 
			using (city_id)
		inner join country cy
			using (country_id)
			where cy.country = "United States") ,1, CURRENT_TIMESTAMP);
-- 2.Add a rental
	
INSERT INTO sakila.rental
(rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES('01/01/01', (select MAX(inventory_id) 
	from inventory i
	inner join film f
		using (film_id)
		where f.title = 'ACADEMY DINOSAUR'), 1, '01/01/01', (
	select staff_id 
		from staff st
		inner join store s
			using (store_id)
			where store_id = 2
			LIMIT 1), CURRENT_TIMESTAMP);

-- 3. Update film year based on the rating

UPDATE film set 
	release_year = 2001
where rating = "G";


-- 4.Return a film

select f.title, f.film_id, r.return_date 
	from film f 
		inner join inventory i 
			using(film_id)
		inner join rental r 
			using(inventory_id)
			where r.return_date is NULL 
			order by r.rental_date desc;

-- 5.Try to delete a film

DELETE FROM sakila.film
WHERE film_id=10;
		
-- Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`film_actor`, CONSTRAINT `fk_film_actor_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE RESTRICT ON UPDATE CASCADE)

DELETE FROM sakila.film_actor
WHERE film_id=10;

-- 6. Rent a film

-- No me salió