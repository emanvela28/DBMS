.headers on
SELECT
    p_name AS part
FROM
    part,
    partsupp,
    supplier,
    nation

WHERE
    p_partkey = ps_partkey
    AND
    ps_suppkey = s_suppkey
    AND
    s_nationkey = n_nationkey
    AND
    n_name = 'AGENTINA'
ORDER BY
    ps_supplycost * ps_availqty DESC
LIMIT
    (SELECT COUNT(*) * 0.05 FROM partsupp);