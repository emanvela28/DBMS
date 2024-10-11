.headers on
SELECT
    sup_region.r_name AS supp_region,
    cus_region.r_name AS cust_region,
    min(orders.o_totalprice) AS min_price
FROM
    orders
JOIN
    customer ON orders.o_custkey = customer.c_custkey,
    nation AS cus_nation ON customer.c_nationkey = cus_nation.n_nationkey,
    region AS cus_region ON cus_nation.n_regionkey = cus_region.r_regionkey,
    lineitem ON lineitem.l_orderkey = orders.o_orderkey,
    supplier ON supplier.s_suppkey = lineitem.l_suppkey,
    nation AS sup_nation ON supplier.s_nationkey = sup_nation.n_nationkey,
    region AS sup_region ON sup_region.r_regionkey = sup_nation.n_regionkey
GROUP BY
    supp_region,
    cust_region
HAVING
    supp_region != cust_region;