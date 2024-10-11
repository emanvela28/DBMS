.headers on
SELECT
    part.p_mfgr AS manufacturer
FROM
    part
JOIN
    partsupp ON part.p_partkey = partsupp.ps_partkey
WHERE
    partsupp.ps_suppkey = '000000084'
ORDER BY
    partsupp.ps_availqty ASC
LIMIT
    1;