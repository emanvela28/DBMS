.headers on
SELECT 
    n.n_name AS country
FROM 
    nation n
JOIN 
    customer c ON n.n_nationkey = c.c_nationkey
JOIN 
    orders o ON c.c_custkey = o.o_custkey
GROUP BY 
    n.n_name
ORDER BY 
    SUM(o.o_totalprice) DESC
LIMIT 1;
