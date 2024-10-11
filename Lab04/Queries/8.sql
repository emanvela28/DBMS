.headers on
SELECT
    count(DISTINCT orders.o_clerk) as clerks
FROM
    orders
JOIN
    lineitem ON lineitem.l_orderkey = orders.o_orderkey,
    supplier ON supplier.s_suppkey = lineitem.l_suppkey,
    nation ON nation.n_nationkey = supplier.s_nationkey
WHERE
    nation.n_name = 'IRAQ';