
-- Assignment 3

-- 1. display all customer details who have made more than 5 payments.

select * from sakila.customer c where c.customer_id in
(select p.customer_id from sakila.payment p group by p.customer_id having count(p.payment_id)>5);

-- 2. Find the names of actors who have acted in more than 10 films.

select a.actor_id, concat(a.first_name, a.last_name) as actor_name from sakila.actor a where a.actor_id in
(select fa.actor_id from sakila.film_actor fa group by fa.actor_id having count(fa.film_id)>10);

-- 3. Find the names of customers who never made a payment.

select customer_id, first_name, last_name from sakila.customer where customer_id not in
(select distinct customer_id from sakila.payment);

-- 4. List all films whose rental rate is higher than the average rental rate of all films.

select film_id, title, rental_rate from sakila.film where rental_rate >
(select avg(rental_rate) from sakila.film);

select * from sakila.film;

-- 5. List the titles of films that were never rented.

select film_id, title from sakila.film where film_id not in
(select film_id from sakila.inventory where inventory_id in (select inventory_id from sakila.rental));

-- 6. Display the customers who rented films in the same month as customer with ID 5.

select customer_id, first_name, last_name from sakila.customer where customer_id in
(select distinct customer_id from sakila.rental where month(rental_date) in
(select distinct month(rental_date) from sakila.rental where customer_id =5));

-- 7. Find all staff members who handled a payment greater than the average payment amount.

select * from sakila.staff 
where staff_id in (
    select staff_id 
    from sakila.payment 
    where amount > (select avg(amount) from sakila.payment)
);

-- 8. Show the title and rental duration of films whose rental duration is greater than the average.

select title, rental_duration from sakila.film where rental_duration >(select avg(rental_duration) from sakila.film);

-- 9. Find all customers who have the same address as customer with ID 1.

select customer_id, first_name, last_name from sakila.customer where address_id = 
(select address_id from sakila.customer where customer_id =1);

-- 10. List all payments that are greater than the average of all payments.

select payment_id 
    from sakila.payment 
    where amount > (select avg(amount) from sakila.payment);
    









