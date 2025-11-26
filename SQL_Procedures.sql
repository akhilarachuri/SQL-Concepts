-- Stored Procedure

-- Get films longer than a given length - with only input parameter

use sakila;

DROP PROCEDURE IF EXISTS sakila.getLongFilms

DELIMITER //

CREATE PROCEDURE sakila.getLongFilms(IN min_length INT)
BEGIN
    SELECT film_id, title, length
    FROM film
    WHERE length > min_length;
END;
//

CALL sakila.getLongFilms(120);

-- Return total amount paid by a customer ( IN AND OUT PARAMETERS)

DROP PROCEDURE IF EXISTS sakila.getCustomerPayments

DELIMITER //

CREATE PROCEDURE sakila.getCustomerPayments(IN p_customer_id INT,OUT total_amount DECIMAL(10,2))
BEGIN
    SELECT SUM(p.amount)
    INTO total_amount
    FROM sakila.payment p
    JOIN sakila.customer c ON p.customer_id = c.customer_id
    WHERE c.customer_id = p_customer_id;
END;

//

SET @total = 0;
CALL sakila.getCustomerPayments(5, @total);
SELECT @total AS total_payment_by_customer_5;



-- Dynamic Stored Procedure

use sakila;

DROP PROCEDURE IF EXISTS sakila.dynamicSearch

DELIMITER //

CREATE PROCEDURE sakila.dynamicSearch(
    IN tbl_name VARCHAR(50),
    IN tbl_column VARCHAR(50),
    IN tbl_value VARCHAR(50)
)
BEGIN
    SET @q = CONCAT(
        'SELECT * FROM ', tbl_name,
        ' WHERE ', tbl_column, ' = ''', tbl_value, ''''
    );

    PREPARE stmt FROM @q;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END;


// 

CALL dynamicSearch('customer', 'first_name', 'MARY');

-- Natural and Surrogate Keys

-- A natural key is a key that already exists in real life.
-- Eg : SSN, Passport number

USE practice_sql_joins;

DROP TABLE IF EXISTS persons_natural

CREATE TABLE persons_natural (
    ssn CHAR(11) PRIMARY KEY,  -- Natural Key      
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    birth_date DATE
);

INSERT INTO persons_natural VALUES
('123-45-6789', 'Ronda', 'Smith', '1990-01-15'),
('987-65-4321', 'Linda',   'Johnson', '1985-03-20'),
('555-12-3456', 'Charlie','Brown', '1998-07-09');

-- This will fail because a person has unique ssn 
INSERT INTO persons_natural VALUES('123-45-6789', 'John', 'Smith', '1990-01-15');

DROP TABLE IF EXISTS persons_surrogate

CREATE TABLE persons_surrogate (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,   -- Surrogate key
    ssn CHAR(11) ,                          
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    birth_date DATE
);

INSERT INTO persons_surrogate (ssn, first_name, last_name, birth_date) VALUES
('123-45-6789', 'Ronda', 'Smith', '1990-01-15'),
('987-65-4321', 'Linda',   'Johnson', '1985-03-20'),
('555-12-3456', 'Charlie','Brown', '1998-07-09');

-- This will pass because surrogate key is the primary key and there is no constraint on ssn 
INSERT INTO persons_surrogate (ssn, first_name, last_name, birth_date) VALUES
('123-45-6789', 'John', 'Smith', '1990-01-15');










