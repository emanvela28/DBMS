.headers on
SELECT
    nation.n_name AS country,
    count(*) AS cnt
FROM
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    nation ON customer.c_nationkey = nation.n_nationkey,
    region ON region.r_regionkey = nation.n_regionkey
WHERE
    region.r_name = 'MIDDLE EAST'
GROUP BY
    country;