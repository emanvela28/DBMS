.headers on
SELECT 
    MIN(c_acctbal) AS min_acct_bal,
    MAX(c_acctbal) AS max_acct_bal,
    SUM(c_acctbal) AS tot_acct_bal
FROM customer
WHERE c_mktsegment = 'FURNITURE';
