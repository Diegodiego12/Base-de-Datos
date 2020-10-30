-- 1. Create a view named list_of_customers 
  
create view list_of_customers as 
	select c.customer_id, CONCAT (c.first_name, ' ', c.last_name) as 'full_name', a.address, a.postal_code as 'zip code', a.phone, ct.city, cy.country, CASE 
		when c.active = 1 then 'Activate' 
		else 'Inactivate' 
		end as 'Status', c.store_id
			from customer c 
				inner join address a
					using (address_id)
				inner join city ct
					using (city_id)
				inner join country cy
					using (country_id);
	
select * from list_of_customers;

-- 2.Create a view0 named film_details


create view film_details as
	select film_id, title, c.name as "category", rental_rate as "price", GROUP_CONCAT(concat(a.first_name, " ", a.last_name)) as "actors", description 
from film f
		join film_category fc using (film_id)
		join category c using (category_id)
		join film_actor fa using (film_id)
		join actor a using (actor_id)
GROUP BY f.film_id, c.name;
 
select * from film_details;

-- 3. Create view sales_by_film_category

drop view sales_by_film_category; 
create view sales_by_film_category as
	select c.name, SUM(p.amount) as "total_rental"
		from category c
		join film_category using (category_id)
		join film using (film_id)
		join inventory using (film_id)
		join rental using (inventory_id)
		join payment p using (rental_id)
		group by c.name;

select * from sales_by_film_category sbfc 

-- 4.Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.

drop view if exists actor_information;
create view actor_information as 
	select a.actor_id, CONCAT(a.first_name, " ", a.last_name) as "Name", COUNT(fa.film_id) as "Films acted"
	from actor a
	join film_actor fa using (actor_id)
	group by a.actor_id;
	
select * from actor_information;

-- 5. Analyze view actor_info

select * from actor_info;
-- Es una view que trae el id del actor, su primer y segundo nombre y hace un group_concat creada con el nombre de "film_info" que trae el nombre de la categoria y el titulo del film

-- 6. Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.

-- Una view es una tabla virtual creada apartir de consultas que unen varias tablas para facilitar la obtencion de datos y no tener que hacer querys a cada rato, un ejemplo practico es el de actor_info.