.eqp on
.headers on
.expert

select distinct n_name
from customer, nation, orders
where c_nationkey=n_nationkey and c_custkey=o_custkey
    and o_orderdate>='1994-12-01' and o_orderdate<='1994-12-31'
order by n_name;
