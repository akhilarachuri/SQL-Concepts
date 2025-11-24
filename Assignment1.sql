
-- Assignment 1

use sakila;

-- 1. Get all customers whose first name starts with 'J' and who are active.

select * from sakila.customer;
select * from sakila.customer where first_name like 'J%' and active =1;

-- Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.

select * from sakila.film;
select * from sakila.film where title like '%ACTION%' or description like '%WAR%';

-- 3.List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.

select * from sakila.customer;
select count(*) from sakila.customer where last_name!= 'SMITH' and first_name like '%a';

-- 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.

select * from sakila.film;
select * from sakila.film where rental_rate > 3.0 and replacement_cost is not null;

-- 5. Count how many customers exist in each store who have active status = 1

select * from sakila.customer;
select store_id, count(customer_id) as total_customers from sakila.customer where active =1 group by store_id;

-- 6. Show distinct film ratings available in the film table.

select * from sakila.film;
select distinct rating from sakila.film;

-- 7. Find the number of films for each rental duration where the average length is more than 100 minutes.

select * from sakila.film;
select rental_duration, count(film_id) as No_films, avg(length) as avg_length 
from sakila.film group by rental_duration having avg_length >100;

-- 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.

select * from sakila.payment;
select date(payment_date) as payment_date, sum(amount) as total_amount, count(payment_id) as total_payments 
from sakila.payment group by date(payment_date) having total_payments>100;

-- 9. Find customers whose email address is null or ends with '.org'.

select * from sakila.customer;
select * from sakila.customer where email is null or email like '%.org';

-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.

select * from sakila.film;
select * from sakila.film where rating = 'PG' or rating = 'G' order by rental_rate desc;

-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.

select * from sakila.film;
select length,count(*) as film_count 
from sakila.film where title like 'T%' 
group by length having count(*) >5;

-- 12. List all actors who have appeared in more than 10 films.

select a.actor_id, a.first_name, a.last_name, count(fa.film_id) as film_count 
from sakila.actor a join sakila.film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id, a.first_name, a.last_name
having film_count > 10;

-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, 
-- ordering by rental rate first and length second.

select film_id, title,rental_rate,length from sakila.film order by rental_rate desc, length desc limit 5;

-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.

select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as total_rentals 
from sakila.customer c join sakila.rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_rentals desc;

-- 15. List the film titles that have never been rented.

select f.film_id, f.title
from sakila.film f left join sakila.inventory i ON f.film_id = i.film_id
left join sakila.rental r ON i.inventory_id = r.inventory_id
where r.rental_id is null;

-- 16. Find all staff members along with the total payments they have processed, 
-- ordered by total payment amount in descending order.

select s.staff_id,s.first_name, s.last_name, sum(p.amount) as total_processed
from sakila.staff s join sakila.payment p on s.staff_id = p.staff_id
group by s.staff_id,s.first_name, s.last_name
order by total_processed desc;

-- 17. Show the category name along with the total number of films in each category.

select c.name as CategoryName, count(fc.film_id) as total_films from
sakila.category c join sakila.film_category fc on c.category_id = fc.category_id
group by c.name;

-- 18. List the top 3 customers who have spent the most money in total.

select c.customer_id, c.first_name, c.last_name, sum(p.amount) as total_spent
from sakila.customer c join sakila.payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_spent desc
limit 3;

-- 19. Find all films that were rented in the month of May (any year) and have a rental duration greater than 5 days.

select * from sakila.film;

select f.film_id, f.title,f.rental_duration
from sakila.film f join sakila.inventory i ON f.film_id = i.film_id
join sakila.rental r ON i.inventory_id = r.inventory_id
where month(r.rental_date) = 5 and
f.rental_duration >5;

-- 20. Get the average rental rate for each film category, but only include categories with more than 50 films.

select cat.category_id, cat.name, round(avg(f.rental_rate),2) as avg_rental_rate, count(fc.film_id) as film_count 
from sakila.film f 
join sakila.film_category fc on f.film_id = fc.film_id
join sakila.category cat on cat.category_id = fc.category_id
group by cat.category_id, cat.name
having film_count> 50;









--






