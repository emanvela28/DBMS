.headers on
SELECT
    count(DISTINCT partsupp.ps_suppkey) AS supp_cnt
FROM
    part
JOIN
    partsupp ON part.p_partkey = partsupp.ps_partkey
WHERE
    part.p_type LIKE '%BRUSHED%' AND
    part.p_size IN (10,20,30,40);