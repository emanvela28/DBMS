.headers on
SELECT
    nation.n_name AS country,
    orders.o_orderstatus AS status,
    COUNT (orders.o_orderkey) AS orders
FROM
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    nation ON nation.n_nationkey = customer.c_nationkey,
    region ON nation.n_regionkey = region.r_regionkey
WHERE
    region.r_name = 'ASIA'
GROUP BY
    country,
    status;
