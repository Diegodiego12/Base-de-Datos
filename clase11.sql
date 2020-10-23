-- 4. Find all the film titles that are not in the inventory.
select title 
	from film f
		left join inventory i
			using (film_id)
			where i.film_id is NULL 

-- 5. Find all the films that are in the inventory but were never rented.
select f.title, inventory_id 
	from inventory i 
		inner join film f
			using (film_id)
		left join rental r
			using (inventory_id)
			where r.inventory_id is NULL

-- 6. Generate a report with:
select c.first_name, c.last_name, s.store_id, f.title, r.rental_date,
	r.return_date 
	from customer c
		inner join rental r
			on r.customer_id = c.customer_id 
		inner join store s
			using (store_id)
		inner join inventory i
			on i.store_id = s.store_id 
		inner join film f
			on i.film_id = f.film_id 
		order by s.store_id, c.last_name 

-- 7.Show sales per store (money of rented films)
select s.store_id, SUM(p.amount), CONCAT(st.first_name , ' ' ,st.last_name) as name, CONCAT(ct.city, ' ' , cy.country ) as location
	from store s
		inner join staff st
			using (store_id)
		inner join address a
			on a.address_id = s.address_id 
		inner join city ct
			on ct.city_id = a.city_id 
		inner join country cy
			on cy.country_id = ct.country_id 
		inner join customer c
			using (store_id)
		inner join payment p
			on p.customer_id = c.customer_id 
		group by name, location, s.store_id 
		
-- 8. Which actor has appeared in the most films?
select CONCAT(a.first_name, ' ', a.last_name) as name, COUNT(f.film_id) as films
	from film_actor fa 
		inner join actor a
			using(actor_id)
		inner join film f
			using (film_id)
		group by actor_id
		order by films desc