.headers on
SELECT
    region.r_name as region,
    max(supplier.s_acctbal) as max_bal
FROM
    supplier
JOIN
    nation ON nation.n_nationkey = supplier.s_nationkey,
    region ON region.r_regionkey = nation.n_regionkey
GROUP BY
    region
HAVING
    max_bal > 9000;