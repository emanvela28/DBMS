.headers on
SELECT
    count(DISTINCT customer.c_custkey) AS customer_cnt
FROM
    (
    SELECT
        orders.o_orderkey
    FROM
        orders
    EXCEPT
    SELECT
        orders.o_orderkey
    FROM
        orders 
    JOIN
        lineitem ON orders.o_orderkey = lineitem.l_orderkey,
        supplier ON supplier.s_suppkey = lineitem.l_suppkey,
        nation ON nation.n_nationkey = supplier.s_nationkey,
        region ON region.r_regionkey = nation.n_regionkey
    WHERE
        region.r_name != 'AFRICA'
    ) AS qualified_orders
JOIN
    orders ON qualified_orders.o_orderkey = orders.o_orderkey,
    customer ON customer.c_custkey = orders.o_custkey;