.headers on
WITH nation_cust AS (
SELECT
    nation.n_name AS country,
    count(customer.c_custkey) AS customer_num
FROM
    customer
JOIN
    nation ON nation.n_nationkey = customer.c_nationkey
GROUP BY
    country
)
SELECT
    country
FROM
    nation_cust
WHERE
    customer_num = (SELECT max(customer_num) FROM nation_cust);