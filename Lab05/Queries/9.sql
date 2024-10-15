.headers on
SELECT
    region.r_name AS region,
    count(DISTINCT supplier.s_suppkey) AS supp_cnt
FROM
    supplier,
    (SELECT region.r_name,avg(supplier.s_acctbal) AS avgbal FROM supplier,region,nation WHERE s_nationkey= n_nationkey AND n_regionkey = r_regionkey GROUP BY region.r_name) AS region_avg
JOIN
    nation ON nation.n_nationkey = supplier.s_nationkey,
    region ON region.r_regionkey = nation.n_regionkey
WHERE
    supplier.s_acctbal > region_avg.avgbal AND
    region.r_name = region_avg.r_name
GROUP BY
    region;