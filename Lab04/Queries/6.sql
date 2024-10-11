.headers on
SELECT
    supplier.s_name as supplier,
    orders.o_orderpriority as priority,
    COUNT (DISTINCT part.p_partkey) as parts
FROM
    orders
JOIN
    lineitem ON orders.o_orderkey = lineitem.l_orderkey,
    supplier ON lineitem.l_suppkey = supplier.s_suppkey,
    part ON lineitem.l_partkey = part.p_partkey,
    nation ON nation.n_nationkey = supplier.s_nationkey
WHERE
    nation.n_name = 'ARGENTINA'
GROUP BY
    supplier,
    priority;
