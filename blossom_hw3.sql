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
SELECT distinct o1.pid		
FROM orders o,
     orders o1,
     customers c
where o.cid = c.cid
and o1.aid = o.aid
and c.city = 'Kyoto'
order by o1.pid asc

--5 Get the names of customers who have never placed an oder. Use a subquery.
SELECT name
FROM customers
WHERE cid not in
	(SELECT cid
	FROM orders);

--6 Get the names of customers who have never placed an order. Use an outer join.
SELECT distinct name
FROM orders right outer join customers
on orders.cid = customers.cid
where orders.cid is null;

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
where city in(
		SELECT city
		FROM(SELECT distinct p.city, count(p.city) as "city_count"
			FROM products p
		group by p.city
		order by count(p.city) asc)subquery1
		group by city
		limit 1
);

--10 Get the name and city of customers who live in a city where the most 
--   number of products are made.
SELECT c.name, c.city
FROM customers c
where city in(
		SELECT city
		FROM(SELECT distinct p.city, count(p.city) as "city_count"
			FROM products p
			group by p.city) sub1
		order by city desc
)
order by c.city asc
limit 1;