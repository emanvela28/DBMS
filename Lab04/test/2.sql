.headers on
SELECT
    customer.c_name AS customer,
    count(customer.c_custkey) AS cnt
FROM  
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    nation ON customer.c_nationkey = nation.n_nationkey
WHERE
    nation.n_name = 'MOZAMBIQUE' AND
    strftime('%Y',orders.o_orderdate) = '1997'
GROUP BY
    customer;