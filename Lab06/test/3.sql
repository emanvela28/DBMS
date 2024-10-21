.headers on
WITH qualified_parts_supp AS (
SELECT
    p_partkey AS qualified_part_key
FROM
(    
    SELECT
        part.p_partkey AS p_partkey,
        count(DISTINCT partsupp.ps_suppkey) AS africa_supplier_num
    FROM
        part
    JOIN
        partsupp ON part.p_partkey = partsupp.ps_partkey,
        supplier ON supplier.s_suppkey = partsupp.ps_suppkey,
        nation ON nation.n_nationkey = supplier.s_nationkey,
        region ON region.r_regionkey = nation.n_regionkey
    WHERE
        region.r_name = 'AFRICA'
    GROUP BY
        part.p_partkey
)
WHERE
    africa_supplier_num = 3
),
qualified_part_cust as(
SELECT
    DISTINCT part.p_partkey AS p_partkey
FROM
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    nation AS cus_nation ON cus_nation.n_nationkey = customer.c_nationkey,
    region AS cus_region ON cus_region.r_regionkey = cus_nation.n_regionkey,
    lineitem ON lineitem.l_orderkey = orders.o_orderkey,
    part ON lineitem.l_partkey = part.p_partkey
WHERE
    cus_region.r_name = 'ASIA'
)

SELECT DISTINCT part.p_name
FROM lineitem
JOIN part ON lineitem.l_partkey = part.p_partkey
WHERE part.p_partkey IN (SELECT qualified_part_key FROM qualified_parts_supp) AND
        part.p_partkey IN (SELECT p_partkey FROM qualified_part_cust);