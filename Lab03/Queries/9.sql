.headers on
SELECT 
    strftime('%Y-%m', l_receiptdate) as year_month,
    COUNT(l_receiptdate) as items
FROM 
    lineitem, 
    orders,
    customer
WHERE 
    l_orderkey = o_orderkey
    AND
    o_custkey = c_custkey
    AND
    c_name = 'Customer#000000227'
GROUP BY strftime('%Y-%m', l_receiptdate);