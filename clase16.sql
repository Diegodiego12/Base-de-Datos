CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 

(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),

(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),

(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DELIMITER $$
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
     employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedat = NOW(); 
END$$
DELIMITER ;

UPDATE employees 
SET 
    lastName = 'Phan'
WHERE
    employeeNumber = 1056;

-- 1- Insert a new employee to , but with an null email. Explain what happens.
insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 

(1010,'Murphy','Diane','x5810',NULL,'1',NULL,'President');

-- "Column 'email' cannot be null" . No te deja actualizar la tabla porque hay un constraint NOT NULL declarado en el email.

-- 2. Run the first the query
select * from employees e2 
UPDATE employees SET employeeNumber = employeeNumber - 20 -- Resta -20 a todos los employeeNumber de la tabla
UPDATE employees SET employeeNumber = employeeNumber + 20 -- "Duplicate entry '1056' for key 'employees.PRIMARY" No puede ejecutarse porque employeeNumber es una primary key

-- 3- Add a age column to the table employee where and it can only accept values from 16 up to 70 years old.

Alter table employees 
	add age INT NOT NULL CHECK (age between 16 and 70);
-- 4.  Describe the referential integrity between tables film, actor and film_actor in sakila db.

-- La integridad de estas tablas son a causa de las primary key y las foreign key. 
-- La tabla film_actor tiene campos que hacen referencia a las tablas film y actor. 
-- Estas tienen primary keys, que la tabla film_actor las guarda a traves de una foreign key

-- 5- Create a new column called lastUpdate to table employee and use trigger(s) to keep the date-time updated on inserts and updates operations. Bonus: add a column lastUpdateUser and the respective trigger(s) to specify who was the last MySQL user that changed the row (assume multiple users, other than root, can connect to MySQL and change this table).

alter table employees 
  add lastUpdateUser varchar(45);

DELIMITER $$
CREATE TRIGGER before_employees_update
    BEFORE UPDATE ON employees
    FOR EACH ROW
BEGIN    
    SET NEW.lastUpdate = NOW(),
    NEW.lastUpdateUser = USER();
END$$
DELIMITER ;


