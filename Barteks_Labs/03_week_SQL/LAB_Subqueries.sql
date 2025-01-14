# -------------LAB | SQL Subqueries---------------------

# Write SQL queries to perform the following tasks using the Sakila database:
USE sakila;
# Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
# for this query you the tables: Film(title), Iventory(inventory_id)

SELECT COUNT(film_id) AS `Hunchback Impossible`
FROM inventory
WHERE film_id = (
				SELECT film_id
				FROM film
				WHERE title = "Hunchback Impossible");

# List all films whose length is longer than the average length of all the films in the Sakila database.
# for this query you the tables: FILM(length, title), Inventory(film_id)
# crweate a subquer to average lengt and use this child in the paretn to filter 

SELECT title AS `MOVIE LONGER THAN THE AVG`, length 
FROM film 
WHERE film_id > (SELECT AVG(film_id)
				FROM film)
ORDER BY title;

# Use a subquery to display all actors who appear in the film "Alone Trip".
# for this query you the tables: Actor(first_name, last_name), Film_actor (), Film(Title)

SELECT last_name, first_name 
FROM actor
WHERE actor_id IN   (SELECT actor_id
					FROM film_actor 
					WHERE film_id IN 	(SELECT film_id
										FROM Film
										WHERE Title = "Alone Trip"));
                                        
# --------------- BONUS -------------------

#1. Sales have been lagging among young families, and you want to target family movies for a promotion. 
	#Identify all movies categorized as family films.

# for this query you the tables: FILM(title), Film_category (category_id), category(name)

#SELECT name
#FROM Category; name of the category is family

SELECT title AS 'Familiy movies'
FROM film
WHERE film_id IN (SELECT film_id
				  FROM Film_category
				  WHERE category_id IN (
										SELECT category_id
										FROM category
										WHERE name = "family"));

#2. Retrieve the name and email of customers from Canada using both subqueries and joins. 
	#To use joins, you will need to identify the relevant tables and their primary and foreign keys.                                       
    
# for this query you the tables: Customers (), Address (), City(), Country(Canada)

SELECT email, first_name, last_name
FROM customer
WHERE address_id IN (SELECT address_id
					FROM address 
					WHERE city_id IN 	(SELECT city_id
										FROM city
										WHERE country_id IN (SELECT Country_id
															 FROM country
															 WHERE country = "Canada")));
   
#6. Determine which films were starred by the most prolific actor in the Sakila database. 
	# A prolific actor is defined as the actor who has acted in the most number of films. 
	# First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.

    
    
#7. Find the films rented by the most profitable customer in the Sakila database. 
	# You can use the customer and payment tables to find the most profitable customer, 
	# i.e., the customer who has made the largest sum of payments.
    
    
    


# use avarge as a value 
#

# this is not the task. it the total average per customer
SELECT customer_id, SUM(amount)
FROM payment    
GROUP BY customer_id
HAVING SUM(amount) > 100;
                
              
# 7.Find the films rented by the most profitable customer in the Sakila database. 
# You can use the customer and payment tables to find the most profitable customer, i.e., 
# the customer who has made the largest sum of payments.              
     
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
				 FROM inventory 
				 WHERE inventory_id IN (SELECT inventory_id
									   FROM rental
									   WHERE customer_id = (SELECT customer_id								
															FROM payment									
															GROUP BY customer_id
															ORDER BY SUM(amount) DESC
															LIMIT 1)));
	
SELECT title
FROM film     
JOIN inventory 
USING(film_id)
JOIN rental
USING(inventory_id)
JOIN payment 
USING(customer_id) 
WHERE customer_id = (SELECT customer_id								
					FROM payment									
					GROUP BY customer_id
					ORDER BY SUM(amount) DESC
					LIMIT 1)
GROUP BY title;
#ORDER BY title
              
# 8. Retrieve the client_id and the total_amount_spent of 
	# those clients who spent more than the average of the total_amount spent by each client. 
	# You can use subqueries to accomplish this.             
              
SELECT customer_id, SUM(amount) AS total_spend_p_c
FROM payment    
GROUP BY customer_id
HAVING total_spend_p_c >  
	(SELECT ROUND(AVG(total_spend),2)						
	FROM 	(SELECT ROUND(SUM(amount),2) AS "total_spend"									
			FROM payment									
			GROUP BY customer_id) AS t); # when using in from we need to name this subquerey

#people who have spent more then aver spend by person 
#the people who spend more 