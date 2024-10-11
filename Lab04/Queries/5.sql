.headers on
SELECT nation.n_name as country, COUNT (*) as cnt
FROM supplier
JOIN nation on supplier.s_nationkey = nation.n_nationkey
WHERE country  = 'JAPAN' or country = 'CHINA'
GROUP BY country