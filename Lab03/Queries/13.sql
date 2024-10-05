.headers on
SELECT DISTINCT
    s_name,
    COUNT(s_name) AS discounted_items
FROM
    supplier,
    lineitem
WHERE
    l_discount = .1
    AND
    l_suppkey = s_suppkey
    GROUP BY s_name;