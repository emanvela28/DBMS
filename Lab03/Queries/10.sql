.headers on
SELECT
    s_name,
    s_acctbal
FROM 
    supplier,
    region,
    nation
WHERE
    s_acctbal > 5000
    AND
    s_nationkey = n_nationkey
    AND
    n_regionkey = r_regionkey
    AND
    r_name = 'ASIA';