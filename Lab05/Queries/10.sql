.headers on
SELECT
    count(DISTINCT customer.c_custkey) AS cust_cnt
FROM
    customer,nation,region
WHERE
    c_nationkey = n_nationkey AND r_regionkey = n_regionkey AND
    r_name NOT IN ('AMERICA','EUROPE');