.headers on
SELECT
    count(DISTINCT partkey) AS part_cnt
FROM
(
    SELECT
        partsupp.ps_partkey AS partkey,
        count(DISTINCT partsupp.ps_suppkey) AS supplier_num
    FROM
        partsupp
    JOIN
        supplier ON supplier.s_suppkey = partsupp.ps_suppkey,
        nation ON supplier.s_nationkey = nation.n_nationkey
    WHERE
        nation.n_name = 'UNITED STATES'
    GROUP BY
        partsupp.ps_partkey
)
WHERE
    supplier_num = 1;