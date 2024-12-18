.headers on
SELECT
    sup_region.r_name AS supp_region,
    cus_region.r_name AS cust_region,
    strftime('%Y',lineitem.l_shipdate) AS year,
    sum(lineitem.l_extendedprice*(1-lineitem.l_discount)) AS revenue
FROM
    lineitem
JOIN
    orders ON orders.o_orderkey = lineitem.l_orderkey,
    customer ON customer.c_custkey = orders.o_custkey,
    nation AS cus_nation ON cus_nation.n_nationkey = customer.c_nationkey,
    region AS cus_region ON cus_region.r_regionkey = cus_nation.n_regionkey,
    partsupp ON lineitem.l_partkey = partsupp.ps_partkey AND partsupp.ps_suppkey = lineitem.l_suppkey,
    supplier ON supplier.s_suppkey = partsupp.ps_suppkey,
    nation AS sup_nation ON sup_nation.n_nationkey = supplier.s_nationkey,
    region AS sup_region ON sup_region.r_regionkey = sup_nation.n_regionkey
WHERE
    strftime('%Y',lineitem.l_shipdate) = '1996' OR 
    strftime('%Y',lineitem.l_shipdate) = '1997'
GROUP BY
    supp_region,cust_region,year;