
-- Assignment 4

-- 1. List all customers along with the films they have rented.

use sakila;

select c.customer_id, c.first_name, c.last_name, f.film_id, f.title from sakila.customer c 
join sakila.rental r on c.customer_id = r.customer_id
join sakila.inventory i on i.inventory_id = r.inventory_id
join sakila.film f on f.film_id = i.film_id
order by c.customer_id;

-- 2. List all customers and show their rental count, including those who haven't rented any films.

select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as rental_count from sakila.customer c 
left join sakila.rental r on c.customer_id = r.customer_id
group by c.customer_id,c.first_name, c.last_name
order by rental_count desc;

-- 3. Show all films along with their category. Include films that don't have a category assigned.

select f.film_id, f.title, fc.category_id, cat.name as category_name from sakila.film f 
left join sakila.film_category fc on fc.film_id = f.film_id
left join sakila.category cat on cat.category_id = fc.category_id;
-- where cat.name is null;

-- 4. Show all customers and staff emails from both customer and staff 
-- tables using a full outer join (simulate using LEFT + RIGHT + UNION).

select c.customer_id,c.email AS customer_email, s.staff_id, s.email as staff_email
from sakila.customer c
left join sakila.staff s on c.email = s.email   -- join condition (can be anything)
UNION
select c.customer_id,c.email AS customer_email, s.staff_id, s.email as staff_email
from sakila.customer c
right join sakila.staff s on c.email = s.email;

-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR".

select a.actor_id, a.first_name, a.last_name from sakila.actor a
join sakila.film_actor fa on fa.actor_id = a.actor_id
join sakila.film f on f.film_id = fa.film_id
where f.title ='ACADEMY DINOSAUR';

-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.

select s.store_id, count(stf.staff_id) as total_staff from sakila.store s 
left join sakila.staff stf on s.store_id = stf.store_id
group by s.store_id;

-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.

select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as total_rent_count 
from sakila.customer c join sakila.rental r on c.customer_id = r.customer_id
group by c.customer_id, c.first_name, c.last_name
having count(r.rental_id)>5
order by total_rent_count desc;





