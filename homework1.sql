--Dan Blossom

--CMPT 308 Database

--Professor Labouseur

--1
﻿SELECT *
FROM customers;

--2
﻿SELECT name, city
FROM agents
WHERE name = 'Smith';

--3
﻿SELECT pid, name, quantity
FROM products
WHERE priceUSD > 1.25;

--4
﻿SELECT ordno, aid
FROM orders;

--5
﻿SELECT name, city
FROM customers
WHERE city <> 'Dallas';

--6
﻿SELECT name
FROM agents
WHERE city = 'Newark'
OR city = 'New York';

--7
﻿SELECT *
FROM products
WHERE city <> 'Newark'
AND city <> 'New York'
AND priceUSD <= 1.00;

--8
﻿SELECT *
FROM orders
WHERE mon = 'jan'
OR mon = 'mar';

--9
﻿SELECT *
FROM orders
WHERE mon = 'feb'
AND dollars < 100.00;

--10
﻿SELECT *
FROM orders
WHERE cid = 'c005'
