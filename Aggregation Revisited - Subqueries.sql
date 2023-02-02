use sakila;

#1 - Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT first_name, last_name, email 
FROM customer 
WHERE customer_id IN (SELECT customer_id FROM rental);

#2 - What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT A.customer_id, CONCAT(A.first_name, ' ', A.last_name) AS customer_name, ROUND(AVG(C.amount),2) AS average_payment
FROM customer A
JOIN rental B ON A.customer_id = B.customer_id
JOIN payment C ON B.rental_id = C.rental_id
GROUP BY A.customer_id;

#3. - Select the name and email address of all the customers who have rented the "Action" movies.

#3.1  - Write the query using multiple join statements
SELECT CONCAT(A.first_name, ' ', A.last_name) AS customer_name, address_id
FROM customer A
JOIN rental B ON A.customer_id = B.customer_id
JOIN inventory C ON B.inventory_id = C.inventory_id
JOIN film_category D ON C.film_id = D.film_id
JOIN category E ON D.category_id = E.category_id
WHERE E.name = 'Action';

#3.2 - Write the query using sub queries with multiple WHERE clause and IN condition

SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name, address_id
FROM customer
WHERE customer.customer_id IN (
  SELECT rental.customer_id
  FROM rental
  WHERE rental.inventory_id IN (
    SELECT inventory.inventory_id
    FROM inventory
    WHERE inventory.film_id IN (
      SELECT film_category.film_id
      FROM film_category
      WHERE film_category.category_id IN (
		  SELECT category.category_id
		  FROM category
		  WHERE category.name = 'Action'
		)
    )
  )
);

#3.3 - Verify if the above two queries produce the same results or not

-- Yes, but The first query return 1112 rows and the second returns 510, so No.

#4
SELECT payment.payment_id, payment.amount, 
CASE
  WHEN payment.amount BETWEEN 0 AND 2 THEN 'Low'
  WHEN payment.amount BETWEEN 2 AND 4 THEN 'Medium'
  ELSE 'High'
END AS class
FROM payment;











