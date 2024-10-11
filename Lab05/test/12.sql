.headers on
SELECT
    orders.o_orderpriority AS priority,
    count(DISTINCT orders.o_orderkey) AS order_cnt
FROM
    orders
JOIN
    lineitem ON orders.o_orderkey = lineitem.l_orderkey
WHERE
    strftime('%Y',orders.o_orderdate) = '1995' AND
    lineitem.l_commitdate < lineitem.l_receiptdate
GROUP BY
    priority;