.headers on
SELECT 
    n.n_name AS country
FROM 
    nation n
JOIN 
    supplier s ON n.n_nationkey = s.s_nationkey
JOIN 
    partsupp ps ON s.s_suppkey = ps.ps_suppkey
JOIN 
    lineitem l ON ps.ps_partkey = l.l_partkey AND ps.ps_suppkey = l.l_suppkey
WHERE 
    strftime('%Y', l.l_shipdate) = '1994'
GROUP BY 
    n.n_name
ORDER BY 
    SUM(l.l_extendedprice) ASC
LIMIT 1;