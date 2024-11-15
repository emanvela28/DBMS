.eqp on
.headers on
.expert

select sum(c_acctbal) as tot_acct_bal
from customer, region, nation
where c_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name = 'AMERICA'
    and c_mktsegment = 'FURNITURE';
