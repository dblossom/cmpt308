-- Dan Blossom
-- CMPT 308 Database
-- Queries Homework 1 (10 simple scripts)
-- Professor Labouseur
-- Marist College

-- Number 1: List all data for all customers
SELECT *
FROM customers;

-- Number 2: List the name and city of agents named smith.
SELECT name, city
FROM agents
WHERE name = 'Smith';

-- Number 3: List pid, name and quantity of products costing more than US $1.25
SELECT pid, name, quantity
FROM products
WHERE priceUSD > 1.25;

-- Number 4: List the ordno and aid of all orders
SELECT ordno,aid
FROM orders;

-- Number 5: List the names and cities of customers not in Dallas
SELECT name, city
FROM customers
WHERE city <> 'Dallas';

-- Number 6: List the names of agents in New York or Newark
SELECT name
FROM agents
Where city = 'Newark'
OR city = 'New York';

-- Number 7: List all data for products not in New York or Newark that cost
--           US $1.00 or less
SELECT *
FROM products
WHERE city <> 'Newark'
AND city <> 'New York'
AND priceUSD <= 1.00;

-- Number 8: List all data for orders in January or March
SELECT *
FROM orders
WHERE mon = 'jan'
OR mon = 'mar';

-- Number 9: List all data for orders in February less than US $100
SELECT *
FROM orders
WHERE mon = 'feb'
AND dollars < 100.00;

-- Number 10: List all orders from the customer whose cid is c005
SELECT *
FROM orders
WHERE cid = 'c005';