.headers on
SELECT COUNT(o_orderkey) as "order_cnt"
FROM orders
WHERE
    o_orderpriority = '1-URGENT'
    AND
    strftime('%Y', o_orderdate) BETWEEN '1993' AND '1997'
    AND
    o_custkey IN
        (SELECT c_custkey
        FROM customer
        WHERE c_nationkey IN
            (SELECT n_nationkey
            FROM nation
            WHERE n_name='ROMANIA'));