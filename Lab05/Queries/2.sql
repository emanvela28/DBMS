.headers on
SELECT
    orders.o_orderpriority AS priority,
    count(*) AS item_cnt
FROM
    lineitem
JOIN
    orders ON orders.o_orderkey = lineitem.l_orderkey
WHERE
    strftime('%Y',orders.o_orderdate) = '1998' AND
    lineitem.l_receiptdate < lineitem.l_commitdate
GROUP BY
    orders.o_orderpriority;