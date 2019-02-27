/*
Assignment 2 : Ryan Salem
*/

/*
Question 1
*/
select c.customer_id, c.first_name, c.last_name, sum(p.amount) as 'TOTAL SPENT'
from customer c
join payment p
using (customer_id)
group by customer_id
order by c.last_name, sum(p.amount);
/*
Question 2
*/
select distinct a.district, c.city
from address a
join city c
using (city_id)
where a.postal_code is null
or a.postal_code = '';
/*
Question 3
*/
select f.title
from film f
where f.title like '%DOCTOR%'
or f.title like '%FIRE%';
/*
Question 4
*/
select distinct a.actor_id, a.last_name, a.first_name, count(f.film_id) as 'NUMBER OF MOVIES'
from actor a
join film_actor fa
using (actor_id)
join film f
using (film_id)
group by a.actor_id
order by a.last_name, count(film_id);
/*
Question 5
*/
select c.name, avg(f.length) as 'AVERAGE RUN TIME'
from category c
join film_category fc
using (category_id)
join film f
using (film_id)
group by c.name
order by avg(f.length);
/*
Question 6
*/
select distinct s.store_id, sum(p.amount) as 'BUSINESS TOTAL'
from store s
join staff st
using (store_id)
join payment p
using (staff_id)
group by s.store_id
order by sum(p.amount) desc;
/*
Question 7
*/
select c.first_name, c.last_name, c.email, sum(p.amount) as 'TOTAL AMOUNT SPENT'
from customer c
join payment p
using (customer_id)
join address a
using (address_id)
join city ci
using (city_id)
join country co
using (country_id) 
where country_id = 20
group by c.first_name
order by c.last_name;
/*
Question 8
*/
select * from customer where last_name = 'BOLIN'; #539
select * from film where title = 'HUNGER ROOF'; #440
select * from staff where last_name = 'STEPHENS'; #2
select * from inventory where film_id = 440; #2026

start transaction;

insert into rental(rental_date, inventory_id, customer_id, staff_id, last_update)
values(now(), 2026, 539, 2, now());

set @rent_id = (select rental_id from rental where customer_id = 539 and staff_id = 2 and inventory_id = 2026);

insert into payment(customer_id, staff_id, rental_id, amount, payment_date, last_update)
values(539, 2, @rent_id, 2.99, NOW(), NOW());

rollback;
/*
Question 9
*/
select * from customer where last_name = 'COLE'; #108
select * from film where title = 'ALI FOREVER'; #13
select inventory_id from inventory where film_id = 13; #70
select * from rental where inventory_id = 70 and customer_id = 108; #15294

start transaction;

update rental set return_date = now(), last_update = now()
where rental_id = 15294;

rollback;
/*
Question 10
*/
select * from language where name = 'JAPANESE'; #3

start transaction;

update film f
join film_category fc
using (film_id)
join category c
using (category_id)
set f.original_language_id = 3
where c.name = 'ANIMATION';

rollback;