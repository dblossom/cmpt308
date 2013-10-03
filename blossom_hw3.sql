-- Dan Blossom
-- CMPT 308 Database
-- Professor Labouseur
-- Homework 3

--1 Get the cities of agents booking an order for customer c002. Use a
--  subquery. (Yes, this is the same question as on ho
SELECT city
FROM agents
WHERE aid in
	(SELECT aid
	FROM orders
	WHERE cid = 'c002');

--2 Get the cities of agents booking an order for customer 2.  This time
--  use joins; no subqueries.
SELECT city
FROM agents, orders
WHERE agents.aid = orders.aid
  AND cid = 'c002';

--3 Get the pids of products ordered through any agent who makes at least
--  one order for a customer in Kyoto.  Use subqueries.
SELECT pid
FROM products
WHERE pid in
	(SELECT pid
	FROM orders
	WHERE aid in
	(SELECT aid
	FROM orders
	WHERE cid in
	(SELECT cid
	FROM customers
	WHERE city = 'Kyoto')))

--4 Get the pids of products ordered through any agent who makes at least
--  one order for a customer in Kyoto.  Use joins. (1,3,4,5,7)
SELECT DISTINCT o1.pid		
FROM orders o,
     orders o1,
     customers c
WHERE o.cid = c.cid
AND o1.aid = o.aid
AND c.city = 'Kyoto'
ORDER BY o1.pid ASC

--5 Get the names of customers who have never placed an oder. Use a subquery.
SELECT name
FROM customers
WHERE cid NOT IN
	(SELECT cid
	FROM orders);

--6 Get the names of customers who have never placed an order. Use an outer join.
SELECT DISTINCT name
FROM orders RIGHT OUTER JOIN customers
ON orders.cid = customers.cid
WHERE orders.cid IS NULL;

--7 Get the names of customers who placed at least one order through an agent in
--  their city, along with those agent(s) names.
SELECT distinct customers.name AS Customer_Name, 
		agents.name AS Agent_Name
FROM customers, agents, orders
WHERE customers.cid = orders.cid
  AND agents.aid = orders.aid
  AND customers.city = agents.city;

--8 Get the names of customers and agents in the same city, along with the name
--  of the city, regardless of whether or not the customer has ever placed an
--  order with that agent.
SELECT customers.name AS Customer_Name,
       agents.name AS Agent_Name, 
       customers.city AS City -- either tables city should do here
FROM customers, agents
WHERE customers.city = agents.city

--9 Get the name and city of customers who live in the city where the least
--  number of products are made.
SELECT name, city
FROM customers
WHERE city IN(
		SELECT city
		FROM(SELECT distinct p.city, count(p.city) AS "city_count"
		     FROM products p
		     GROUP BY p.city
		     ORDER BY count(p.city) ASC)subquery1
		GROUP BY city
		LIMIT 1
);

--10 Get the name and city of customers who live in a city where the most 
--   number of products are made.
SELECT c.name, c.city
FROM customers c
WHERE city IN(
		SELECT city
		FROM(SELECT DISTINCT p.city, count(p.city) AS "city_count"
			FROM products p
			GROUP BY p.city) sub1
		ORDER BY city DESC
)
ORDER BY c.city ASC
LIMIT 1;

--11 Get the name and city of customers who live in any city where the most
--   number of products are made

--12 List the products whose priceUSD is above the average priceUSD
SELECT p.name
FROM products p
WHERE priceUSD > (SELECT avg(priceUSD)
		 FROM products)

--13 Show the customer name, pid ordered, and the dollars for all customer
--   orders, sorted by dollars from high to low
SELECT c.name, o.pid, o.dollars
FROM orders o, customers c
WHERE o.cid = c.cid
ORDER BY dollars DESC

--14 Show all customers names (in order) and their total ordered, and 
--   nothing more. Use coalesce to avoid showing NULLs.
SELECT c.name,
       CASE WHEN sum(o.dollars) IS NULL THEN 0.00
            ELSE sum(o.dollars)
       END
FROM customers c LEFT OUTER JOIN orders o
ON c.cid = o.cid
GROUP BY c.cid
ORDER BY sum(o.dollars) ASC

