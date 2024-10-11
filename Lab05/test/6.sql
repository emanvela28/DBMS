.headers on
SELECT
    supplier.s_name AS supplier,
    part.p_size AS part_size,
    max(partsupp.ps_supplycost) AS max_cost
FROM
    part
JOIN
    partsupp ON part.p_partkey = partsupp.ps_partkey,
    supplier ON partsupp.ps_suppkey = supplier.s_suppkey,
    nation ON nation.n_nationkey = supplier.s_nationkey,
    region ON region.r_regionkey = nation.n_regionkey
WHERE
    region.r_name = 'AFRICA' AND
    part.p_type LIKE '%NICKEL%' 
GROUP BY
    part_size;