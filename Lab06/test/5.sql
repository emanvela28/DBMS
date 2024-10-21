.headers on
SELECT
    count(customer) AS customer_cnt
FROM
(
    SELECT
        customer.c_name AS customer,
        count(orders.o_orderkey) AS orders_num
    FROM
        customer
    JOIN
        orders ON orders.o_custkey = customer.c_custkey
    WHERE
        strftime('%Y-%m',orders.o_orderdate) =  '1995-11'
    GROUP BY
        customer
)
WHERE
    orders_num <= 3;