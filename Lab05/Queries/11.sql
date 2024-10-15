.headers on
SELECT
    SUM(ps_supplycost) AS total_supply_cost
FROM
    partsupp,
    supplier,
    part,
    lineitem
WHERE
    ps_suppkey = s_suppkey
    AND 
    ps_partkey = p_partkey
    AND
    p_retailprice < 2000
    AND
    l_partkey = p_partkey
    AND
    strftime('%Y', l_shipdate) = '1994'
    AND
    l_extendedprice >= 1000
    AND
    strftime('%Y', l_receiptdate) <> '1997';