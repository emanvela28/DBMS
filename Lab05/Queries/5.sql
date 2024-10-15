.headers on

SELECT
    part.p_name as part
FROM
    lineitem
JOIN
    part ON part.p_partkey = lineitem.l_partkey
WHERE
    lineitem.l_extendedprice*(1-lineitem.l_discount) = 
(
    SELECT
        max(lineitem.l_extendedprice*(1-lineitem.l_discount))
    FROM
        lineitem
    WHERE
        lineitem.l_shipdate > '1994-10-6'
)   AND
    lineitem.l_shipdate > '1994-10-6';