.headers on
SELECT
    nation.n_name as country,
    count(DISTINCT orders.o_orderkey) as cnt
FROM
    orders
JOIN
    lineitem ON orders.o_orderkey = lineitem.l_orderkey,
    supplier ON supplier.s_suppkey = lineitem.l_suppkey,
    nation ON nation.n_nationkey = supplier.s_nationkey,
    region ON nation.n_regionkey = region.r_regionkey
WHERE
    strftime('%Y',orders.o_orderdate) = '1994' AND
    region.r_name = 'AMERICA' AND
    orders.o_orderstatus = 'F'
GROUP BY
    country
HAVING
    cnt >= 250;
