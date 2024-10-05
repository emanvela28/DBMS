.headers on
SELECT DISTINCT 
    r_name, 
    COUNT(o_orderkey) as order_cnt
FROM
    region,
    orders,
    customer,
    nation
WHERE
    r_regionkey = n_regionkey
    AND
    c_nationkey = n_nationkey
    AND
    o_custkey = c_custkey
    AND
    o_orderstatus = 'F'
GROUP BY
   r_name;