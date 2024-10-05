.headers on
SELECT
    region.r_name as region,
    supplier.s_name as supplier,
    max(supplier.s_acctbal) as acct_bal
FROM
    supplier
JOIN
    nation ON nation.n_nationkey = supplier.s_nationkey,
    region ON region.r_regionkey = nation.n_regionkey
GROUP BY
    region.r_name;