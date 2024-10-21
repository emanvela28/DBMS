.headers on
WITH supplier_tb AS(
    SELECT
        sup_nation.n_name AS supp_nation,
        count(*) AS items_sold
    FROM
        lineitem
    JOIN
        orders ON orders.o_orderkey = lineitem.l_orderkey,
        customer ON customer.c_custkey = orders.o_custkey,
        nation AS cus_nation ON cus_nation.n_nationkey = customer.c_nationkey,
        partsupp ON lineitem.l_partkey = partsupp.ps_partkey AND partsupp.ps_suppkey = lineitem.l_suppkey,
        supplier ON supplier.s_suppkey = partsupp.ps_suppkey,
        nation AS sup_nation ON sup_nation.n_nationkey = supplier.s_nationkey
    WHERE
        strftime('%Y',lineitem.l_shipdate) = '1997' AND
        cus_nation.n_nationkey != sup_nation.n_nationkey
    GROUP BY
        supp_nation
),
customer_tb AS(
    SELECT
        cus_nation.n_name AS cust_nation,
        count(*) AS items_bought
    FROM
        lineitem
    JOIN
        orders ON orders.o_orderkey = lineitem.l_orderkey,
        customer ON customer.c_custkey = orders.o_custkey,
        nation AS cus_nation ON cus_nation.n_nationkey = customer.c_nationkey,
        partsupp ON lineitem.l_partkey = partsupp.ps_partkey AND partsupp.ps_suppkey = lineitem.l_suppkey,
        supplier ON supplier.s_suppkey = partsupp.ps_suppkey,
        nation AS sup_nation ON sup_nation.n_nationkey = supplier.s_nationkey
    WHERE
        strftime('%Y',lineitem.l_shipdate) = '1997' AND
        cus_nation.n_nationkey != sup_nation.n_nationkey
    GROUP BY
        cust_nation
)

SELECT
    supp_nation AS country,
    items_sold - items_bought AS economic_exchange
FROM
    customer_tb,supplier_tb
WHERE
    cust_nation = supp_nation;