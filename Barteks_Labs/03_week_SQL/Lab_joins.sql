USE sakila;

# Write SQL queries to perform the following tasks using the Sakila database:
# List the number of films per category.

SELECT category_id AS category, COUNT(film_id) AS number_of_films
FROM film
JOIN film_category
USING(film_id)
GROUP BY category_id;

# Retrieve the store ID, city, and country for each store.

SELECT store_id, city, country
FROM store
JOIN city
ON store.store_id = city.city_id
JOIN country
USING(country_id)
GROUP BY store_id;

# Calculate the total revenue generated by each store in dollars.
SELECT store_id AS Store, SUM(amount) AS Revenue
FROM store 
JOIN customer 
USING(store_id)
JOIN payment
USING(customer_id)
GROUP BY Store;

# Determine the average running time of films for each category.
SELECT name AS Category_Name, AVG(length) AS average_running_time
FROM film 
JOIN film_category
USING(film_id)
JOIN category
USING(category_id)
GROUP BY name;


# -------------- Bonus:---------------------

# 5. Identify the film categories with the longest average running time.

SELECT category_id, AVG(length) AS Avarage_length 
FROM film_category
JOIN film
USING(film_id)
GROUP BY category_id
ORDER BY category_id DESC;

# 6. Display the top 10 most frequently rented movies in descending order.

SELECT 
FROM 



# 7. Determine if "Academy Dinosaur" can be rented from Store 1.

# 8. Provide a list of all distinct film titles, along with their availability status in the inventory. 
	# Include a column indicating whether each title is 'Available' or 'NOT available.' 
	# Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE 
    # statement combined with IFNULL."

