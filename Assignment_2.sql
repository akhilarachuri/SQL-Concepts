
-- Assignment 2

-- 1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates

select c.first_name, c.last_name, c.email, count(*) as total_duplicates from sakila.customer c
group by c.first_name, c.last_name, c.email
having count(*)>1;

-- 2. Number of times letter 'a' is repeated in film descriptions

select f.title, f.description, length(f.description) - length(replace(f.description, 'a', '')) as no_of_a from
sakila.film f;

-- 3. Number of times each vowel is repeated in film descriptions

select f.title, f.description, 
length(f.description) - length(replace(f.description, 'a', '')) as no_of_a,
length(f.description) - length(replace(f.description, 'e', '')) as no_of_e,
length(f.description) - length(replace(f.description, 'i', '')) as no_of_i,
length(f.description) - length(replace(f.description, 'o', '')) as no_of_o,
length(f.description) - length(replace(f.description, 'u', '')) as no_of_u
from
sakila.film f;

-- 4. Display the payments made by each customer
-- 1. Month wise
select p.customer_id, month(p.payment_date) as month, sum(amount) as total_amount 
from sakila.payment p 
group by p.customer_id, month(p.payment_date)
order by p.customer_id;

-- 2. Year wise
select p.customer_id, year(p.payment_date) as year, sum(amount) as total_amount 
from sakila.payment p 
group by p.customer_id, year(p.payment_date)
order by p.customer_id;

-- 3. Week wise
select p.customer_id, year(p.payment_date) as payment_year, 
week(p.payment_date, 1) as payment_week, sum(amount) as total_amount 
from sakila.payment p 
group by p.customer_id, year(p.payment_date),week(p.payment_date, 1);

-- 5. Check if any given year is a leap year or not. 
-- You need not consider any table from sakila database. Write within the select query with hardcoded date

select 
	case 
		when (year('2024-01-01') % 400 = 0) or
        (year('2024-01-01') % 4 = 0 and year('2024-01-01') % 100 !=0)
        then 'yes' else 'no' 
	end as leap_year;
    
--  6. Display number of days remaining in the current year from today.    
select datediff('2025-12-31', current_date()) as no_of_days_remaining;
    
-- 7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.

select payment_id, payment_date, concat('Q', quarter(payment_date)) as which_quarter from 
sakila.payment;
        


