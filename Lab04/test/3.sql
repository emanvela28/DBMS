.headers on
.headers on
SELECT
    customer.c_name AS customer,
    sum(orders.o_totalprice) AS total_price
FROM  
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    nation ON customer.c_nationkey = nation.n_nationkey
WHERE
    nation.n_name = 'GERMANY' AND
    strftime('%Y',orders.o_orderdate) = '1992'
GROUP BY
    customer;