.headers on
SELECT
    count(supkey) AS supplier_cnt
FROM
( 
    SELECT
        partsupp.ps_suppkey AS supkey,
        count(DISTINCT orders.o_orderkey) AS order_cnt
    FROM
        orders
    JOIN
        lineitem ON orders.o_orderkey = lineitem.l_orderkey,
        partsupp ON partsupp.ps_partkey = lineitem.l_partkey AND 
                    partsupp.ps_suppkey = lineitem.l_suppkey,
        customer ON customer.c_custkey = orders.o_custkey,
        nation ON customer.c_nationkey = nation.n_nationkey
    WHERE
        nation.n_name IN ('EGYPT','JORDAN')
    GROUP BY
        supkey
)
WHERE
    order_cnt < 50;