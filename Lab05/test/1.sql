.headers on
SELECT
    nation.n_name as country,
    count(DISTINCT customer.c_custkey) as cust_cnt,
    count(DISTINCT supplier.s_suppkey) as supp_cnt
FROM
    region
JOIN
    nation ON nation.n_regionkey = region.r_regionkey,
    customer ON nation.n_nationkey = customer.c_nationkey,
    supplier ON nation.n_nationkey = supplier.s_nationkey
WHERE
    region.r_name = 'ASIA'
GROUP BY
    country;