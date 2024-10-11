.headers on
SELECT
    part
FROM
(
    SELECT
        part.p_name AS part,
        partsupp.ps_supplycost*partsupp.ps_availqty AS total_value,
        nation.n_name AS country
    FROM
        part
    JOIN
        partsupp ON part.p_partkey = partsupp.ps_partkey,
        supplier ON partsupp.ps_suppkey = supplier.s_suppkey,
        nation ON nation.n_nationkey = supplier.s_nationkey
    WHERE
        nation.n_name = 'ARGENTINA'
    ORDER BY
        total_value DESC
    LIMIT
        (SELECT COUNT(*) * 0.05 FROM part JOIN partsupp ON part.p_partkey = partsupp.ps_partkey
        JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
        JOIN nation ON nation.n_nationkey = supplier.s_nationkey
        WHERE nation.n_name = 'ARGENTINA')
)
ORDER BY part;