.headers on
SELECT
    count(DISTINCT supkey) AS suppliers_cnt
FROM
(
    SELECT
        partsupp.ps_suppkey AS supkey,
        count(DISTINCT partsupp.ps_partkey) AS supplied_part_num
    FROM
        partsupp
    JOIN
        supplier ON supplier.s_suppkey = partsupp.ps_suppkey,
        nation ON supplier.s_nationkey = nation.n_nationkey
    WHERE
        nation.n_name = 'PERU'
    GROUP BY
        partsupp.ps_suppkey
)
WHERE
    supplied_part_num > 40;