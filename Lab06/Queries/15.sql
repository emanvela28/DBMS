.headers on
WITH supplier_tb AS(
    SELECT
        sup_nation.n_name AS supp_nation,
        strftime('%Y',lineitem.l_shipdate) AS supp_year,
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
        strftime('%Y',lineitem.l_shipdate) in ('1996','1997','1998') AND
        cus_nation.n_nationkey != sup_nation.n_nationkey
    GROUP BY
        supp_nation,supp_year
),
customer_tb AS(
    SELECT
        cus_nation.n_name AS cust_nation,
        strftime('%Y',lineitem.l_shipdate) AS cust_year,
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
        strftime('%Y',lineitem.l_shipdate) in ('1996','1997','1998') AND
        cus_nation.n_nationkey != sup_nation.n_nationkey
    GROUP BY
        cust_nation,cust_year
),
final AS(
SELECT
    supp_nation AS country,
    SUM(CASE WHEN supp_year = '1996' THEN items_sold - items_bought ELSE 0 END) AS year1,
    SUM(CASE WHEN supp_year = '1997' THEN items_sold - items_bought ELSE 0 END) AS year2,
    SUM(CASE WHEN supp_year = '1998' THEN items_sold - items_bought ELSE 0 END) AS year3
FROM
    customer_tb,supplier_tb
WHERE
    cust_nation = supp_nation AND
    cust_year = supp_year
GROUP BY
    country
)
SELECT country,year2-year1 AS '1997',year3-year2 AS '1998'
FROM final;