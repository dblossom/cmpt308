-- Dan Blossom
-- CMPT 308 Database
-- Marist College
-- Professor Labouseur
-- Homework 2: Sub Queries

-- 1) Get the cities of agents booking an order for customer c002
SELECT city
FROM agents
WHERE aid in
	(SELECT aid
	FROM orders
	WHERE cid in
	(SELECT cid
	FROM customers
	WHERE cid = 'c002'))

-- 2) Get the pids of products ordered through any agent who makes
--    at least one order for a custmer in Kyoto. (This is not the
--    same as asking for pids of products ordered by a customer in Kyoto

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

-- 3) Find the cids and names of customers who never placed an order
--    through agent a03.
SELECT cid, name
FROM customers
WHERE cid not in
	(SELECT cid
	FROM orders
	WHERE aid in
	(SELECT aid
	FROM agents
	WHERE aid = 'a03'))

-- 4) Get the cids and names of customers who ordered both product
--    p01 and p07 (c001 and c006)
SELECT cid, name
FROM customers
WHERE cid in
	(SELECT cid
	FROM orders
	WHERE pid = 'p07'
	AND cid in
	(SELECT cid
	FROM orders
	WHERE pid = 'p01'))

-- 5) Get the pids of products ordered by any customers who ever placed an
--    order through agent a03
SELECT pid
FROM products
WHERE pid in
	(SELECT pid
	FROM orders
	WHERE aid in
	(SELECT aid
	FROM agents
	WHERE aid = 'a03'))

-- 6) Get the names and discounts of all customers who place orders through
--    agents in Dallas or Duluth
SELECT name, discount
FROM customers
WHERE cid in
	(SELECT cid
	FROM orders
	WHERE aid in
	(SELECT aid
	FROM agents
	WHERE city = 'Dallas'
	OR city = 'Duluth'))

-- 7) Find all customers who have the same discount as that of any customers
--   in Dallas or Kyoto. Answer is: 4,5
SELECT *
FROM customers
WHERE city != 'Dallas' 
AND  city != 'Kyoto'
AND discount in
	(SELECT discount
	FROM customers
	WHERE city = 'Dallas' 
	OR city = 'Kyoto')
	
-- 8) Get the IDs of customers who did not place an order any orders through
--    agent a03
SELECT cid
FROM customers
WHERE cid not in
	(SELECT cid
	FROM orders
	WHERE aid in
	(SELECT aid
	FROM agents
	WHERE aid = 'a03'))
