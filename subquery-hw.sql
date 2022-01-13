--1. List all customers who live in Texas (use JOINs)
SELECT  first_name, last_name, address, district
FROM address a
JOIN customer c 
ON a.city_id = c.customer_id
WHERE district = 'Texas'
ORDER BY c.first_name, c.last_name;


--2. Get all payments above $6.99 with the Customer’s full name
SELECT first_name, last_name, amount
FROM payment p 
JOIN customer c 
ON p.customer_id = c.customer_id
WHERE amount IN (
	SELECT amount 
	FROM payment
	GROUP BY payment.amount 
	HAVING amount >= 6.99
);


--3. Show all customer names who have made payments over $175 (use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id 
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) desc
);

--4. List all customers that live in Nepal (use the city table)
SELECT c.customer_id, c.first_name, c.last_name, c2.city_id, c2.country_id,
FROM customer c 
JOIN city c2 
--coudln't figure this one out


--5. Which staff member had the most transactions?
SELECT staff_id , COUNT(payment_id) AS transactions
FROM payment
GROUP BY staff_id 
ORDER BY transactions DESC 
-- 2, 7304


--6. What film had the most actors in it?
SELECT film_id, COUNT(actor_id) AS total_actors
FROM film_actor fa 
GROUP BY film_id 
ORDER BY total_actors DESC
LIMIT 1;

--7. Which actor has been in the least movies?
SELECT first_name, last_name, a.actor_id, COUNT(*) AS films_acted_in
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, last_name, a.actor_id
ORDER BY COUNT(*)
LIMIT 1;


--8. How many districts have more than 5 customers in it?
SELECT a.district
FROM address a
JOIN city c
ON a.address_id = c.city_id 
JOIN customer c2 
ON c.city_id = c2.address_id
GROUP BY a.district
HAVING COUNT(*) > 5
ORDER BY COUNT(a.district);