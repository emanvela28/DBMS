.headers on
WITH 
AverageDiscount AS (
    SELECT AVG(l.l_discount) AS avg_discount
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
)
SELECT 
    MAX(l.l_discount) AS max_small_disc
FROM 
    lineitem l
JOIN 
    orders o ON l.l_orderkey = o.o_orderkey
WHERE 
    strftime('%Y-%m', o.o_orderdate) = '1996-02'
    AND l.l_discount < (SELECT avg_discount FROM AverageDiscount);