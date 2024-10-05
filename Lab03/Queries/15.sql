.headers on
SELECT SUM(c_acctbal) as tot_acct_bal
FROM
    customer,
    nation,
    region
WHERE
    r_name = 'AMERICA'
    AND
    r_regionkey = n_regionkey
    AND
    c_nationkey = n_nationkey
    AND
    c_mktsegment = 'FURNITURE';