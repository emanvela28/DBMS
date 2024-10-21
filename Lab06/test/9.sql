.headers on
SELECT
    count(DISTINCT partsupp.ps_suppkey) AS supplier_cnt
FROM
    partsupp
JOIN
    part ON partsupp.ps_partkey = part.p_partkey
WHERE
    part.p_retailprice = (SELECT min(p_retailprice) FROM part);