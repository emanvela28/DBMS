.headers on
SELECT
    count(DISTINCT orders.o_orderkey) as order_cnt
FROM
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    lineitem ON orders.o_orderkey = lineitem.l_orderkey,
    supplier ON lineitem.l_suppkey = supplier.s_suppkey
WHERE
    supplier.s_acctbal >= 0 AND
    customer.c_acctbal <0;