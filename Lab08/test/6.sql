.eqp on
.headers on
.expert

select n_name, sum(s_acctbal) as total_acct_bal
from supplier, nation 
where s_nationkey = n_nationkey
group by n_name;
