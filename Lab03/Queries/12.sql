.headers on
SELECT  
    strftime('%Y', o_orderdate) as year,
    COUNT(o_orderpriority) as item_cnt
FROM orders, lineitem, supplier
WHERE
    o_orderpriority = '3-MEDIUM'
    AND
    o_orderkey = l_orderkey
    AND
    l_suppkey = s_suppkey
    AND
    s_nationkey IN
        (SELECT n_nationkey
        FROM nation
        WHERE n_name IN ('ARGENTINA', 'BRAZIL'))
GROUP BY strftime('%Y', o_orderdate);