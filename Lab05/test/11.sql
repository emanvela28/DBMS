.headers on
SELECT 
    sum(ps_supplycost) AS total_supply_cost
FROM
(
    SELECT
        DISTINCT partsupp.*
    FROM
        partsupp
    JOIN
        part ON part.p_partkey = partsupp.ps_partkey,
        (
        SELECT supplier.s_suppkey FROM supplier
        EXCEPT
        SELECT partsupp.ps_suppkey FROM partsupp,lineitem
        WHERE  partsupp.ps_partkey = lineitem.l_partkey AND 
                partsupp.ps_suppkey = lineitem.l_suppkey AND
                lineitem.l_extendedprice < 1800 AND
                strftime('%Y',lineitem.l_shipdate) = '1998'
        ) AS supplier ON partsupp.ps_suppkey = supplier.s_suppkey
    JOIN
        lineitem ON lineitem.l_partkey = partsupp.ps_partkey AND lineitem.l_suppkey = partsupp.ps_suppkey
    WHERE
        part.p_retailprice < 1500 AND
        strftime('%Y',lineitem.l_shipdate) = '1996'
);


WITH qualified_supplier AS(
SELECT supplier.s_suppkey FROM supplier
EXCEPT
SELECT lineitem.l_suppkey 
FROM lineitem
WHERE lineitem.l_extendedprice < 1800 AND strftime('%Y',lineitem.l_shipdate) = '1998'
),
qualified_parts AS(
SELECT  DISTINCT part.p_partkey
FROM    lineitem
JOIN    part ON part.p_partkey = lineitem.l_partkey
WHERE   part.p_retailprice < 1500 AND
        strftime('%Y',lineitem.l_shipdate) = '1996' AND
        lineitem.l_suppkey IN qualified_supplier
)

SELECT sum(ps_supplycost) AS total_supply_cost
FROM lineitem
JOIN partsupp ON partsupp.ps_partkey = lineitem.l_partkey AND partsupp.ps_suppkey = lineitem.l_suppkey
JOIN qualified_supplier ON partsupp.ps_suppkey = qualified_supplier.s_suppkey
JOIN qualified_parts ON partsupp.ps_partkey = qualified_parts.p_partkey;