.headers on
SELECT
    count(*) as items
FROM
    lineitem
JOIN   
    supplier ON supplier.s_suppkey = lineitem.l_suppkey,
    nation AS sup_nation ON sup_nation.n_nationkey = supplier.s_nationkey,
    orders ON orders.o_orderkey = lineitem.l_orderkey,
    customer ON customer.c_custkey = orders.o_custkey,
    nation AS cus_nation ON cus_nation.n_nationkey = customer.c_nationkey,
    region ON region.r_regionkey = sup_nation.n_regionkey
WHERE
    cus_nation.n_name = 'INDIA' AND
    region.r_name = 'EUROPE';