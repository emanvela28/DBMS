.eqp on
.headers on
.expert

select min(c_acctbal) as min_acct_bal, max(c_acctbal) as max_acct_bal, sum(c_acctbal) as tot_acct_bal
from customer
where c_mktsegment = 'FURNITURE';
