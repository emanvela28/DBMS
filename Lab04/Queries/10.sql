.headers on
SELECT
    part.p_type as part_type,
    min(lineitem.l_discount) AS min_disc,
    max(lineitem.l_discount) AS max_disc
FROM
    lineitem
JOIN
    part ON lineitem.l_partkey = part.p_partkey
WHERE
    part.p_type LIKE '%MEDIUM%' OR 
    part.p_type LIKE '%TIN%'
GROUP BY
    part_type;