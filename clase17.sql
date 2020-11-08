-- 1.Create two or three queries using address table in sakila db.
select *
from address a
inner join city c using (city_id)
inner join country c2 using (country_id)
where postal_code in ('1027','99865', '57828'); -- 4ms

select * from address a; -- 7ms

create index postalCode on address(postal_code); -- Mejoro el tiempo de ejecuccion.

-- 2.Run queries using actor table, searching for first and last name columns independently. Explain the differences and why is that happening?

select first_name from actor; -- 6ms

select last_name from actor; -- 2ms

-- last_name tiene un indice, por eso es mas rapido que first_name

-- 3.Compare results finding text in the description on table film with LIKE and in the film_text using MATCH ... AGAINST. Explain the results.

select description 
	from film f 
	where description like '%Epic%'; -- 8ms
	
select description 
	from film_text ft 
	where match(description ) against ('%Epic%');
select description from film_text where match(description) against("%Epic%"); -- Can't find FULLTEXT index matching the column list

-- la tabla no tiene un indice de texto completo, por eso no puede buscarla, caso contrario que si la tuviera supongo que sería mas rapido que usar like