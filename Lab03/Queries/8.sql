.headers on
SELECT DISTINCT n_name
FROM 
    orders, 
    customer, 
    nation 
WHERE 
    c_custkey = o_custkey 
    AND 
    strftime('%Y-%m', o_orderdate) = '1995-12' 
    AND 
    n_nationkey = c_nationkey 
GROUP BY n_name;