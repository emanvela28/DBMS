.headers on
SELECT sum(orders.o_totalprice) AS total_price
FROM orders
JOIN
    customer ON orders.o_custkey = customer.c_custkey,
    nation ON customer.c_nationkey = nation.n_nationkey,
    region ON nation.n_regionkey = region.r_regionkey
WHERE
    strftime('%Y', orders.o_orderdate) = '1995' AND
    region.r_name = 'AMERICA';