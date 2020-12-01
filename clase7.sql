-- 1.Find the films with less duration, show the title and rating.

select title, rating
from film 
where `length` <= all (select `length` 
						from film f)	

-- 2.Write a query that returns the tiltle of the film which duration is the lowest. 

select title 
from film f
where `length` < ALL(select `length` from film f2)

-- 3.Generate a report with list of customers showing the lowest payments done by each of them.
-- ALL
select CONCAT(first_name, " ", last_name) as "name", address, amount
from customer c, payment p, address a
where p.amount <= all (select p1.amount  from payment p1  where p1.customer_id = c.customer_id)
and p.customer_id = c.customer_id 
and a.address_id = c.address_id 

-- MIN
select CONCAT(first_name," ", last_name) as "name", address, amount
from customer c, payment p, address a
where amount in (select MIN(p2.amount) from payment p2 where p2.customer_id = c.customer_id )
and p.customer_id = c.customer_id
and c.address_id = a.address


-- 4.Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.
SELECT DISTINCT c.customer_id, CONCAT(c.first_name, " ", c.last_name) as "name" , a.address, p.amount AS 'min_amount', p3.amount AS "max_amount"
FROM customer c, address a, payment p, payment p3
WHERE c.address_id = a.address_id
AND p.customer_id = c.customer_id
AND p3.customer_id = c.customer_id
AND p.amount <= ALL (
	SELECT p2.amount
	FROM payment p2
	WHERE p2.customer_id = c.customer_id)
AND p3.amount >= ALL (
	SELECT p2.amount
	FROM payment p2
	WHERE p2.customer_id = c.customer_id)
ORDER BY min_amount;
