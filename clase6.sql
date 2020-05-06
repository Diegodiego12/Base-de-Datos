-- 1. List all the actors that share the last name. Show them in order
SELECT first_name, last_name 
FROM actor a 
WHERE EXISTS (SELECT last_name 
				FROM actor a2 
			  WHERE a.last_name = a2.last_name
			  AND a.actor_id <> a2.actor_id)
ORDER BY last_name ASC 

-- 2. Find actors that don't work in any film
SELECT first_name, last_name
FROM actor a
WHERE NOT EXISTS (SELECT *
FROM film f, film_actor fa
WHERE a.actor_id = fa.actor_id
AND fa.film_id = f.film_id)

-- 3. Find customers that rented only one film
SELECT first_name, last_name
FROM customer c
WHERE (SELECT COUNT(*) 
FROM rental r 
WHERE c.customer_id = r.customer_id) = 1

-- 4. Find customers that rented more than one film
SELECT first_name, last_name
FROM customer c
WHERE (SELECT COUNT(*) 
FROM rental r 
WHERE c.customer_id = r.customer_id) > 1

-- 5. List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
SELECT first_name, last_name
FROM actor a, film_actor fa, film f2
WHERE a.actor_id = fa.actor_id
AND fa.film_id = f2.film_id
AND (f2.title = 'BETRAYED REAR' OR f2.title = 'CATCH AMISTAD')


-- 6. List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
SELECT first_name, last_name
FROM actor a, film f, film_actor fa
WHERE a.actor_id = fa.actor_id
AND fa.film_id = f.film_id
AND f.title = 'BETRAYED REAR'
AND a.actor_id NOT IN (SELECT a2.actor_id 
FROM actor a2, film f2, film_actor fa2 
WHERE a2.actor_id = fa2.actor_id 
AND fa2.film_id = f2.film_id 
AND f2.title = 'CATCH AMISTAD')

-- 7. List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
SELECT first_name, last_name
FROM actor a, film f, film_actor fa
WHERE a.actor_id = fa.actor_id
AND fa.film_id = f.film_id
AND f.title = 'BETRAYED REAR'
AND a.actor_id IN (SELECT a2.actor_id 
FROM actor a2, film f2, film_actor fa2 
WHERE a2.actor_id = fa2.actor_id 
AND fa2.film_id = f2.film_id 
AND f2.title = 'CATCH AMISTAD')

-- 8. List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
SELECT first_name, last_name
FROM actor a, film f, film_actor fa
WHERE a.actor_id = fa.actor_id
AND fa.film_id = f.film_id
AND f.title <> 'BETRAYED REAR'
AND a.actor_id NOT IN (SELECT a2.actor_id 
FROM actor a2, film f2, film_actor fa2 
WHERE a2.actor_id = fa2.actor_id 
AND fa2.film_id = f2.film_id 
AND f2.title = 'CATCH AMISTAD')