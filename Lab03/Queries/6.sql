.headers on
SELECT 
    n.n_name AS n_name, 
    SUM(s.s_acctbal) AS total_acct_bal
FROM supplier s
JOIN nation n ON s.s_nationkey = n.n_nationkey
GROUP BY n.n_name;
