.headers on
SELECT 
    region.r_name AS region,
    count(DISTINCT customer.c_custkey) AS cust_cnt
FROM
    orders
JOIN
    customer ON orders.o_custkey = customer.c_custkey,
    nation ON nation.n_nationkey = customer.c_nationkey,
    region ON region.r_regionkey = nation.n_regionkey
WHERE
    customer.c_acctbal > (SELECT avg(customer.c_acctbal) FROM customer)
GROUP BY
    region;