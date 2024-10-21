.headers on
SELECT
    strftime('%m',lineitem.l_shipdate) AS month,
    sum(lineitem.l_quantity) AS tot_month
FROM
    lineitem
WHERE
    strftime('%Y',lineitem.l_shipdate) = '1997'
GROUP BY
    month;