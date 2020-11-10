-- 1.Create a user data_analyst

create user data_analyst@'%' identified by 'data_analyst';

-- 2.Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.

GRANT select, update, delete on sakila.* TO 'data_analyst'@'%';

-- 3.Login with this user and try to create a table. Show the result of that operation.

-- -- Error: CREATE command denied to user 'data_analyst'@'localhost' fot table 'tablaPrueba'

-- 4.Try to update a title of a film. Write the update script.

update film 
set title = "2020"
where title = "ACADEMY DINOSAUR";

-- 5.With root or any admin user revoke the UPDATE permission. Write the command

revoke update on sakila.* from data_analyst;

-- 6.Login again with data_analyst and try again the update done in step 4. Show the result.

-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'