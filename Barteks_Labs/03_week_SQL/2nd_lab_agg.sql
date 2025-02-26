#You need to use SQL built-in functions to gain insights relating to the duration of movies:
#Hint: Look for floor and round functions.

USE sakila;
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
	MAX(length) AS `max_duration`,  
    MIN(length) AS `max_duration`
FROM film;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals. 
# Doesnt need title as we agg here! 
SELECT
  ROUND(AVG(length) / 60) as avg_hours,
  ROUND(AVG(length) % 60) as avg_minutes
FROM film;

## 2 You need to gain insights related to rental dates:

#2.1 Calculate the number of days that the company has been operating.
# Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date 
# in the rental_date column from the latest date.

# SELECT DATEDIFF(day, MAX(rental_date), MIN(rental_date)) as operarting_days
# FROM rental;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) as operating_days
FROM rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *, # rental information is basically everything plus the two new columns 
  MONTH(rental_date) as rental_month,
  DAYNAME(rental_date) as rental_weekday
FROM rental
LIMIT 20;

# 3. You need to ensure that customers can easily access information about the movie collection. 
	# To achieve this, retrieve the film titles and their rental duration. 
	# If any rental duration value is NULL, replace it with the string 'Not Available'. 
	# Sort the results of the film title in ascending order.

	# hint: we can you the IFNULL function for this

SELECT title,
IFNULL(length,`Not available`) AS length
FROM film
ORDER BY title;

# Please note that even if there are currently no null values in the rental duration column, 
# the query should still be written to handle such cases in the future.
# Hint: Look for the IFNULL() function.

#  ----- CHALLENGE 2 ---------------

# Next, you need to analyze the films in the collection to gain some more insights. 
# Using the film table, determine: 

# 1.1 The total number of films that have been released. 
SELECT COUNT(film_id)
FROM film;

# 1.2 The number of films for each rating.
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating;

# 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;

# This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

# -------- 2. Using the film table, determine: --------------
# 2.1 The mean(average) film duration for each rating, and sort the results in descending order of the mean duration. 
# Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, ROUND(AVG(length),2)
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

# 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, ROUND(AVG(length),2)
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

